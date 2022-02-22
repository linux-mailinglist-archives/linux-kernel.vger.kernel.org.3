Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78654BEF52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiBVCHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:07:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiBVCHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:07:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7DF18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:06:51 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y11so10447731pfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WpheS558QebQmAzCqdnB2qwELzokfGBgEVFRE8fJ3OU=;
        b=HstUXHaaGOFOwZp7qatCSERoH2HZ/h8eUJPfiv/15pdXJCfyt7a5t+mthYg7vGe//I
         N6wD5z6KhzSkPPt32sSyZVM0GuorITATsIt2MLsi59flQqFGhyjqT14hIz39kciaVnnC
         rGg7Of8TAfijYfh3UVhgDaymWDa9dR/w5NnaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpheS558QebQmAzCqdnB2qwELzokfGBgEVFRE8fJ3OU=;
        b=n+A+N6MTLyFCEJQd2WBf7kVvo6WbTCKHCMTJ7BUCyRhSs6/1vH6jCSRlzKWtT38YMN
         BT/St88f7O1JkogV45UEXLS/+oq5UBUa+8uB1InFjCxMG739PboQrmx/0/WtrtBGiub6
         waBC10ZmHDuZrH9zQ+p6UCl+k89WJPT8btPFX4eF2IICXROUrcYD3JXO02yDKvW/34WL
         lgPyr9H1B/+nY0pONMNtstfVbxyljdVSDsCQQUcq6KyVZMYYIZ17x+P87sV0+Vv2IbkG
         7Jk0I8aLfCFoMXoTJbGiPLKktZnmP5Uor4m5bEXPCq19XG6YvE+9pDcCk6JOYXl3NKxR
         QzCw==
X-Gm-Message-State: AOAM530gTMdj1tQvlswDlHW1Fh5S1WHMb8OkqQDoaRqsqAp4Dh4jgldf
        QxeDBDbSQva0UmA+cbI9JfQfhQ==
X-Google-Smtp-Source: ABdhPJzWDpCEnhLjgpdTTPYlMMYnwEswpRkmPnFllusyYMBaszFpAEw0jj2bXr0HFnezIsU/0JA3Cg==
X-Received: by 2002:a62:e917:0:b0:4e0:1646:3b82 with SMTP id j23-20020a62e917000000b004e016463b82mr22736008pfh.57.1645495611127;
        Mon, 21 Feb 2022 18:06:51 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3f16:2239:960e:24f])
        by smtp.gmail.com with ESMTPSA id h9sm14317305pfv.135.2022.02.21.18.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 18:06:50 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:06:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhRFNKtxSE8Xrbfw@google.com>
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
> 
> The additional messages from panic_print could overwrite the oldest
> messages when the buffer is full. The only reasonable solution is to
> use a large enough log buffer, hence we added an advice into the kernel
> parameters documentation about that.

By additional panic_print messages you mean that panic_print_sys_info()
will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?

Do we really need to dump everything twice? show_mem(), show_state(),
ftrace_dump(DUMP_ALL). That's quite a bit of extra data.

Can instead this be something like (?):

@@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);


+	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);


 	kmsg_dump(KMSG_DUMP_PANIC);
  
 	/*
@@ -316,7 +321,7 @@ void panic(const char *fmt, ...)
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);


+	panic_print_sys_info(PANIC_PRINT_ALL_PRINTK_MSG);


 	if (!panic_blink)
 		panic_blink = no_blink;
