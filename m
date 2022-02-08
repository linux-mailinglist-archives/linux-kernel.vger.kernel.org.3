Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011684ADDBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381154AbiBHPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiBHPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:55:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB4C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:55:27 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D9B4E1F387;
        Tue,  8 Feb 2022 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644335725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WijHXTObJseuOiFvlli9+l6jvFN1GY3799lbVAl5WkE=;
        b=Q/oTXjVzIERW9PT1/jqOi+5kUSo+JlJzQAki6xLupLsmyEFPvg+sF0ejxlPPXB4DmZBVDB
        AEgyHruOJN/0q12D3uaXghhnWeUV2B87jCmWhVLFetFM+G1xhIg4/7UJQI9VlXbJUqu2ZV
        VYiAjqrWFIelN1tUNEwmpM6blOPQ7z8=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9E7D3A3B83;
        Tue,  8 Feb 2022 15:55:25 +0000 (UTC)
Date:   Tue, 8 Feb 2022 16:55:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andre Kalb <andre.kalb@sma.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Set console_set_on_cmdline=1 when using
 console="" or console=null
Message-ID: <YgKSbe9d3haHKMid@alley>
References: <YfMkJKUuGBwyT611@pc6682>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfMkJKUuGBwyT611@pc6682>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-28 00:00:52, Andre Kalb wrote:
> In case of using console="" or console=null set console_set_on_cmdline=1
> to disable chosen{ "stdout-path" } node from devicetree.
> 
> To jump out from drivers/of/base.c, line 2087 of_console_check function
> with false.

It makes sense. I would just fix it slightly different way, see below.

> Signed-off-by: Andre Kalb <andre.kalb@sma.de>
> ---
>  kernel/printk/printk.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 82abfaf3c2aa..df5ab35b8af2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2385,6 +2385,7 @@ static int __init console_setup(char *str)
>  	 */
>  	if (str[0] == 0 || strcmp(str, "null") == 0) {
>  		__add_preferred_console("ttynull", 0, NULL, NULL,
> true); 
> +		console_set_on_cmdline = 1;

We basically always need to set it when __add_preferred_console() is
called with user_specified == true.

Therefore, we should move the assigment into
__add_preferred_console(). We should do something like:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf3c2aa..3654695ca5d2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2324,6 +2324,15 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 }
 #endif
 
+static void set_user_specified(struct console_cmdline *c, bool user_specified)
+{
+	if (!user_specified)
+		return;
+
+	c->user_specified = true;
+	console_set_on_cmdline = 1;
+}
+
 static int __add_preferred_console(char *name, int idx, char *options,
 				   char *brl_options, bool user_specified)
 {
@@ -2340,8 +2349,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		if (strcmp(c->name, name) == 0 && c->index == idx) {
 			if (!brl_options)
 				preferred_console = i;
-			if (user_specified)
-				c->user_specified = true;
+			set_user_specified(c, user_specified);
 			return 0;
 		}
 	}
@@ -2351,7 +2359,7 @@ static int __add_preferred_console(char *name, int idx, char *options,
 		preferred_console = i;
 	strlcpy(c->name, name, sizeof(c->name));
 	c->options = options;
-	c->user_specified = user_specified;
+	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
 
 	c->index = idx;
@@ -2417,7 +2425,6 @@ static int __init console_setup(char *str)
 	*s = 0;
 
 	__add_preferred_console(buf, idx, options, brl_options, true);
-	console_set_on_cmdline = 1;
 	return 1;
 }
 __setup("console=", console_setup);


Best Regards,
Petr
