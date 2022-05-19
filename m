Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2549D52DE34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbiESUTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiESUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:19:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A597954B3;
        Thu, 19 May 2022 13:19:31 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v6so2602029qtx.12;
        Thu, 19 May 2022 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vrocu9P7m0eP07lmIFwaJ4GXNW5+B1syeYcYNa6K9Sg=;
        b=D2opBd2h8sIzIQoa5BXLjsLDcRmihnTeaMxh3BMouTJS1m9gKkWS5dIGrkbdmUJ/hr
         ORzHya290fcZXP42F2k7ApDCrUKUpj9ZMiYDPdbpUewOA5iQ9sbI2QB+KxTQs/M2EL1B
         t9Xk2EtEK2q7PK0VhQMBuzd+j8ZFCdR8O8jNEaoLx/5Ca7V/eQuIIcj8fLAFVRgf48lw
         OVsrJ5ZOiU7zxAY7Vsaecq8/rVLQMl4I2iuD7SXik9WJWgy5eXGXMJiDRVfbPTk9vI39
         THCqLmqVeC2uPrITimN8ra+pHdumCuhyokvz4de2nwQGu5RNm4iDAPdqA5nSXT/J0in+
         IGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vrocu9P7m0eP07lmIFwaJ4GXNW5+B1syeYcYNa6K9Sg=;
        b=KXRNF5b+k3ypCll+oYGL/YxtkUB+M9GZ6y8iRGXUT2K4shcQ5ZdCru/EF55EmUm39i
         5SnBILWshbUUrbcAxIYL4LlJOefuYS+6PT2GeVAEeLI6WJ65f26O2tcf+fUZqFbh5tDy
         TyMhSDPzFSN9zB9wy7MpPT4T6R9qQgqWopGBYxYYe3Bl9aiSYo3l3FWNV33m2RfDSVpr
         ftkNTOdhhv7OcslpqLKZfYOWmnuR3tkTtJk+KUS+Md8t8GgkeOlmW+M3BKZhgdWBSdbt
         X/zvqFsvPreHU92lbpA+uUmehs1saVVKUZGy8hqK2rbzN2QU/Wjujyr6NqjdgsN91C3M
         MQvw==
X-Gm-Message-State: AOAM5338kVcT59boY6hMeUckkosx5ZQEjhj0iw3t0eseT5VpFG3sUMWZ
        EKuGwbw6lAUxCrpVaYeGSg==
X-Google-Smtp-Source: ABdhPJxVp/EAhgKAzXi5AsEw842F/ItsWm8XlghuIdi9sNeSIP4icqkh/trYVgnLEx5lBhbRyXoi6g==
X-Received: by 2002:ac8:5dcf:0:b0:2f9:15de:2e40 with SMTP id e15-20020ac85dcf000000b002f915de2e40mr3024593qtx.526.1652991570660;
        Thu, 19 May 2022 13:19:30 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id hh2-20020a05622a618200b002f90c73ad8csm1797347qtb.7.2022.05.19.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:19:29 -0700 (PDT)
Date:   Thu, 19 May 2022 16:19:27 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 22/28] Input/joystick/analog: Convert from seq_buf ->
 printbuf
Message-ID: <20220519201927.keuztpaa7q6nqcol@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-23-kent.overstreet@gmail.com>
 <Yoaiy1lc+MCMZFTQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoaiy1lc+MCMZFTQ@smile.fi.intel.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:04:27PM +0300, Andy Shevchenko wrote:
> On Thu, May 19, 2022 at 01:24:15PM -0400, Kent Overstreet wrote:
> > seq_buf is being deprecated, this converts to printbuf which is similar
> > but heap allocates the string buffer.
> > 
> > This means we have to consider memory allocation context & failure: Here
> > we're in device initialization so GFP_KERNEL should be fine, and also as
> > we're in device initialization returning -ENOMEM is fine.
> 
> ...
> 
> > +       int ret = 0;
> 
> Redundant assignment.
> 
> ...
> 
> > -		seq_buf_printf(&s, " %d-hat",
> > -			       hweight16(analog->mask & ANALOG_HATS_ALL));
> > +		pr_buf(&buf, " %d-hat",
> > +		       hweight16(analog->mask & ANALOG_HATS_ALL));
> 
> Now you may put it on one line here and in similar cases.
> 
> ...
> 
> > +	ret = buf.allocation_failure ? -ENOMEM : 0;
> > +	if (!ret)
> > +		strlcpy(analog->name, buf.buf, sizeof(analog->name));
> > +	printbuf_exit(&buf);
> > +	return ret;
> 
> Looks like anti-pattern. On top a bit twisted error code manipulation before
> checking for error codes, but what about

This conversion predated my adding external buffers to printbufs - now the patch
is more of a direct conversion:

-- >8 --
Subject: [PATCH] Input/joystick/analog: Convert from seq_buf -> printbuf

seq_buf is being deprecated, this converts to printbuf.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/input/joystick/analog.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3088c5b829..1dde969b29 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -19,7 +19,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/jiffies.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/timex.h>
 #include <linux/timekeeping.h>
 
@@ -339,24 +339,21 @@ static void analog_calibrate_timer(struct analog_port *port)
 
 static void analog_name(struct analog *analog)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF_EXTERN(analog->name, sizeof(analog->name));
 
-	seq_buf_init(&s, analog->name, sizeof(analog->name));
-	seq_buf_printf(&s, "Analog %d-axis %d-button",
-		 hweight8(analog->mask & ANALOG_AXES_STD),
-		 hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
-		 hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
+	pr_buf(&buf, "Analog %d-axis %d-button",
+	       hweight8(analog->mask & ANALOG_AXES_STD),
+	       hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
+	       hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
 
 	if (analog->mask & ANALOG_HATS_ALL)
-		seq_buf_printf(&s, " %d-hat",
-			       hweight16(analog->mask & ANALOG_HATS_ALL));
-
+		pr_buf(&buf, " %d-hat", hweight16(analog->mask & ANALOG_HATS_ALL));
 	if (analog->mask & ANALOG_HAT_FCS)
-		seq_buf_printf(&s, " FCS");
+		pr_buf(&buf, " FCS");
 	if (analog->mask & ANALOG_ANY_CHF)
-		seq_buf_printf(&s, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
+		pr_buf(&buf, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
 
-	seq_buf_printf(&s, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+	pr_buf(&buf, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
 }
 
 /*
-- 
2.36.0

