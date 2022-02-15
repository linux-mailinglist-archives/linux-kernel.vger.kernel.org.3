Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE544B708B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiBOQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:15:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiBOQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:15:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F07E02C2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:14:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EF6D61F37B;
        Tue, 15 Feb 2022 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644941691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SaXcE79dRZ6Ng191xTZANZXDdk+8ijOQmyw/JCEu968=;
        b=A72EGJckAD9IQiKBWNMl19Hm3yZNyp3ovt5/lGzS3YLzew2hnSFf+IthFxpiMQVoM1Ycsj
        QeEMHyRGUhS65jMDEvBg36MatqJ04f2VI5+XGJfruBoi9KKaeC/sGBBoW6ZMjRGqg/JZW8
        8crRqoaEOXUgTjbEjkiSapwjzBvGqyo=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C26AA3B84;
        Tue, 15 Feb 2022 16:14:51 +0000 (UTC)
Date:   Tue, 15 Feb 2022 17:14:51 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YgvRe92hEvj5mEUS@alley>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214141308.841525-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 11:13:09, Guilherme G. Piccoli wrote:
> The panic_print setting allows users to collect more information in a
> panic event, like memory stats, tasks, CPUs backtraces, etc.
> This is an interesting debug mechanism, but currently the print event
> happens *after* kmsg_dump(), meaning that pstore, for example, cannot
> collect a dmesg with the panic_print extra information.
> 
> This patch changes that in 2 steps:
> 
> (a) The panic_print setting allows to replay the existing kernel log
> buffer to the console (bit 5), besides the extra information dump.
> This functionality makes sense only at the end of the panic() function.
> So, we hereby allow to distinguish the two situations by a new boolean
> parameter in the function panic_print_sys_info().
> 
> (b) With the above change, we can safely call panic_print_sys_info()
> before kmsg_dump(), allowing to dump the extra information when using
> pstore or other kmsg dumpers.
> 
> The additional messages from panic_print could overwrite the oldest
> messages when the buffer is full. The only reasonable solution is to
> use a large enough log buffer, hence we added an advice into the kernel
> parameters documentation about that.
> 
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Makes sense and looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
