Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E22C4C06D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiBWB2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBWB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:28:09 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682122B04
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:27:43 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 139so18520700pge.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z2BI41+moHLqPxYye2IJzRPB1aVADH7WFMUHE1bkSIg=;
        b=A0iseiH33OikZhbY+MY2r3xCS1rV/nUjB7sgKJCRW9RIlTl3b2Cqa9hD940e0Ktk3G
         PsE65b5jhY1C4NImzuubK5f+T34jmiHvkH9Vsu7f3dK/yQfGoq516nDb0g49dbw3bnMC
         tc0n9La8yoQfrKTWbEhJndrb+XFLD5Wc5sbmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z2BI41+moHLqPxYye2IJzRPB1aVADH7WFMUHE1bkSIg=;
        b=pu86XbTxQftdK5i/AML0oqBGNsKMkzmbAD0hVm0sKYI+mXEPyBq38aPx6NOqRGIeXI
         xu18TcnqmKb8iBW+Et6U013FcUPYKyMNsiURfJxQd8c0bYntxh3uU3th67YqsGflmxn1
         Xob8UcRjEjedYjPCjlq/9n2/ofxxsd1e9R72ywSgubuj0p7uwBrTgjSSITfoA4n1ONQo
         dB0vj+btMMeUhz4k6/coTWourIM7d0uo92odhx+UZMQmikUPfpyKPPFB9smsVZIhf01P
         1ZfcjJQtRjICLD6FyoRcoNYOgzhFZf5matzrsFCMTnsmpuWfY6GHn9FLroonjcGFfLhr
         aIXQ==
X-Gm-Message-State: AOAM533e92Y3HFxBZCbnXlr3ME9PYmbJuw9MmDo9i6aCkOuE7bPceuUK
        XMVYx/sskUz0M9lQ8qX+A1DgUg==
X-Google-Smtp-Source: ABdhPJyqp/rlr5xxZHgn3ZIxCdMsiOWCS0xpNad16llxE39IBc2Q4ud59TVWIWkuntmFrtCA5RAEUA==
X-Received: by 2002:a63:ec0f:0:b0:373:a3e9:10a7 with SMTP id j15-20020a63ec0f000000b00373a3e910a7mr21658149pgh.149.1645579662820;
        Tue, 22 Feb 2022 17:27:42 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d2bd:9913:3c85:9aca])
        by smtp.gmail.com with ESMTPSA id u27sm1159400pfg.171.2022.02.22.17.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:27:42 -0800 (PST)
Date:   Wed, 23 Feb 2022 01:27:35 +0000
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhWNhzacAVDuFtwB@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/22 11:10), Guilherme G. Piccoli wrote:
> On 21/02/2022 23:06, Sergey Senozhatsky wrote:
> > On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> > [...]
> > By additional panic_print messages you mean that panic_print_sys_info()
> > will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?
> > 
> > Do we really need to dump everything twice? show_mem(), show_state(),
> > ftrace_dump(DUMP_ALL). That's quite a bit of extra data.
> > 
> 
> Oh no, we don't print everything twice, that'd be insane heh

My bad! I did not spot the `return` at the end of the new branch.

+       if (console_flush) {
+               if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
+                       console_flush_on_panic(CONSOLE_REPLAY_ALL);
+               return;
+       }

Hmm. Yeah, well, that's a bit of a tricky interface now

	panic()
		// everything (if corresponding bits set), no console flush
		panic_print_sys_info(false)
		...
		// console flush only if corresponding bit set
		panic_print_sys_info(true)



If everyone is fine then OK.

But I _personally_ would look into changing this to something like this:

	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
	panic()
		panic_print_sys_info(panic_print & EARLY_PANIC_MASK)
		...
		panic_print_sys_info(panic_print & LATE_PANIC_MASK)
