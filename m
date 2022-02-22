Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14E4BEF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiBVBqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:46:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiBVBqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:46:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3B255A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:45:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so613117pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1Vmg9geJUvkkr9vdEXT/M0VnEhDcN9/eHfzsNAoZww=;
        b=RhGGnX1AkAv1ZwvWc/NgM4n6Ai6f2DuxScaoym0MejR8uWwR3gHXYskzsVRIujNV2p
         MwuAwyVLGW/lSBovdXFrlSsPay74XAlqHxmgLiLDhDinTMYT6w2XFqAe8VLwNf6Tv8r1
         fmmskuMltCBwyF55w3ljfuxQvn7bPRAYdxn4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1Vmg9geJUvkkr9vdEXT/M0VnEhDcN9/eHfzsNAoZww=;
        b=mz4XGOv4sk6SXZsdP1O9uSvdcVdKtOREzJZuO3WSlfdnPtQMfdCoLV12ALL6bIfn1K
         2ZlQz4URW3wZXsZYKaA1MOHWbnAQNgm9271JlzkYfnkxZtTeoHiDxhC8ItB0J2Dpf81x
         pYBY3Sar1LCmCvPP+1AIzInTO2IJRNVaaXlwJ94yNE2raOHYvdBiplZCgFJAJJlxAv3P
         aUdKlFad2Z9l4xIWzfHo3UIleWcF3r5wF5ThdhMYvj0frTJ/B+5r8KV3lT1HbuR+Pqt4
         q7VXOKsrhoyTN+Ft35ufQlrOpzMzwg2KRrNdydCymod8dYexiL+jMrcFo8FQIBKwflwm
         bviA==
X-Gm-Message-State: AOAM532lWbS4wU2lFwvRoAnKgPNRfoJvA3OpbmYHsG7N7ISGIpKBRTpE
        BYkPKLlhUqOfiAn+HjGYEstxtA==
X-Google-Smtp-Source: ABdhPJwm9LQ1FNurXCcGExm0wnPOWhUfxrfWa1r2fVHOJHJlJBjf2QjNaDOTJv70iBWmHSh5AVulFA==
X-Received: by 2002:a17:90b:390d:b0:1b9:c042:3b30 with SMTP id ob13-20020a17090b390d00b001b9c0423b30mr1660650pjb.195.1645494335387;
        Mon, 21 Feb 2022 17:45:35 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3f16:2239:960e:24f])
        by smtp.gmail.com with ESMTPSA id c4sm1111478pfl.39.2022.02.21.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 17:45:34 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:45:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhRAOQbH15E7y9s8@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214141308.841525-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> -static void panic_print_sys_info(void)
> +static void panic_print_sys_info(bool console_flush)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> -		console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +	if (console_flush) {
> +		if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
> +			console_flush_on_panic(CONSOLE_REPLAY_ALL);
> +		return;
> +	}

Yeah, if Petr is fine with that then I'm OK. But at the same time,
we have `panic_print' which is a bit mask of what panic_print_sys_info()
should do. And now we also have a boolean `console_flush` flag that tells
panic_print_sys_info() to ignore some (one as of now) bits of `panic_print'.

So _maybe_ panic_print_sys_info() can just accept panic_print as
its parameter and then we can do something like this (as an example)

	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);


>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>  		trigger_all_cpu_backtrace();
> @@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

[..]

> +	panic_print_sys_info(false);

Merely because `panic_print_sys_info(false);` doesn't tell much to a reader.
Like what is print sys info false?

Or did you already discuss this?
