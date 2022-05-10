Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1015211A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiEJKG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiEJKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:05:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92294FC47;
        Tue, 10 May 2022 03:01:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1A3DD2189B;
        Tue, 10 May 2022 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652176918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ng1gjFMRRzUs+vuWaCnvlB9iqmrxKNbub8Jd2LzeOqw=;
        b=uSYFiBmga/xU+3ozDfbwSTbP7EXKko/PyJOiDgz4WmRVLHLfaOQ2CavrrwE/WBr8oIKCIL
        lpm4boXNzPdW9CNWHQqwutGQJ3+rFjSy6ifH/DYAopIER18OGb8FF6yARlcEy8Q5YAP6Av
        DaXcFVZ/Tw7aQdxSsBvRD3ll0ZBE4iM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B2CE2C142;
        Tue, 10 May 2022 10:01:57 +0000 (UTC)
Date:   Tue, 10 May 2022 12:01:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH next v1] serial: msm_serial: disable interrupts in
 __msm_console_write()
Message-ID: <Yno4Eo6ZcmQRqs1B@alley>
References: <20220506213324.470461-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506213324.470461-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-05-06 23:39:24, John Ogness wrote:
> __msm_console_write() assumes that interrupts are disabled, but
> with threaded console printers it is possible that the write()
> callback of the console is called with interrupts enabled.

IMHO, it would be nice to include the lockdep splat from
https://lore.kernel.org/r/bb5cadc3-0940-7f5c-7a1b-8120ddac9039@samsung.com


> Explicitly disable interrupts using local_irq_save() to preserve
> the assumed context.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Otherwise, it looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>


>  Note: I checked the other serial drivers and this was the only
>        one that assumed interrupts off for write().

Great.

Best Regards,
Petr




>  drivers/tty/serial/msm_serial.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 23c94b927776..e676ec761f18 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1599,6 +1599,7 @@ static inline struct uart_port *msm_get_port_from_line(unsigned int line)
>  static void __msm_console_write(struct uart_port *port, const char *s,
>  				unsigned int count, bool is_uartdm)
>  {
> +	unsigned long flags;
>  	int i;
>  	int num_newlines = 0;
>  	bool replaced = false;
> @@ -1616,6 +1617,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>  			num_newlines++;
>  	count += num_newlines;
>  
> +	local_irq_save(flags);
> +
>  	if (port->sysrq)
>  		locked = 0;
>  	else if (oops_in_progress)
> @@ -1661,6 +1664,8 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>  
>  	if (locked)
>  		spin_unlock(&port->lock);
> +
> +	local_irq_restore(flags);
>  }
>  
>  static void msm_console_write(struct console *co, const char *s,
> 
> base-commit: 38a288f5941ef03752887ad86f2d85442358c99a
> -- 
> 2.30.2
