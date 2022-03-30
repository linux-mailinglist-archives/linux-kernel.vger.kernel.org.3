Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3464EC903
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348494AbiC3QCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiC3QCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:02:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146C84A91B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X8vuOEtqWSaptxuQ7CBgqKQVZ7tPQluBFV2owyI5yMM=; b=dXZhuRZDnQ1op9njQ9/fCC+OQm
        OOCsY08lzIo8CZgzEG/6HA3SqIVorTl+maICM+3ksMrGoZ5d85gwy47wSv0g7GUFrFwGZ/Uu3Tp8B
        44CyGqCmBlvFwjYYJZhedlzbZFetx0JlIMdgXQ47x6oMhF8xia6gg9wzwMRRoWw8mdvxwR8oZKSmR
        3VQ037H2EIOxXfZDwV8vrR5rS/Umla2MACki7nAINOaGHm1x912bJ5QsGil9FKhC0DyF/SCFSiBZg
        x19QHR1VVME4AwK9K6P3sLitQ97ZnCjYqm4lJ6lrWiLvdAhuzSxLIKgAvuYJzISW1HkZXDMED2NGe
        qCR5cf2g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58010)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nZakU-0003Pi-Vr; Wed, 30 Mar 2022 17:00:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nZakO-0006jh-SK; Wed, 30 Mar 2022 17:00:36 +0100
Date:   Wed, 30 Mar 2022 17:00:36 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lin Yujun <linyujun809@huawei.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, ardb@kernel.org,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm/stacktrace, kasan: Silence KASAN warnings in
 unwind_frame()
Message-ID: <YkR+pL+aQ7M/s3U5@shell.armlinux.org.uk>
References: <20220317090751.80831-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317090751.80831-1-linyujun809@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 05:07:51PM +0800, Lin Yujun wrote:
> The following KASAN warning is detected by QEMU.
> 
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in unwind_frame+0x508/0x870
> Read of size 4 at addr c36bba90 by task cat/163
> 
> CPU: 1 PID: 163 Comm: cat Not tainted 5.10.0-rc1 #40
> Hardware name: ARM-Versatile Express
> [<c0113fac>] (unwind_backtrace) from [<c010e71c>] (show_stack+0x10/0x14)
> [<c010e71c>] (show_stack) from [<c0b805b4>] (dump_stack+0x98/0xb0)
> [<c0b805b4>] (dump_stack) from [<c0b7d658>] (print_address_description.constprop.0+0x58/0x4bc)
> [<c0b7d658>] (print_address_description.constprop.0) from [<c031435c>] (kasan_report+0x154/0x170)
> [<c031435c>] (kasan_report) from [<c0113c44>] (unwind_frame+0x508/0x870)
> [<c0113c44>] (unwind_frame) from [<c010e298>] (__save_stack_trace+0x110/0x134)
> [<c010e298>] (__save_stack_trace) from [<c01ce0d8>] (stack_trace_save+0x8c/0xb4)
> [<c01ce0d8>] (stack_trace_save) from [<c0313520>] (kasan_set_track+0x38/0x60)
> [<c0313520>] (kasan_set_track) from [<c0314cb8>] (kasan_set_free_info+0x20/0x2c)
> [<c0314cb8>] (kasan_set_free_info) from [<c0313474>] (__kasan_slab_free+0xec/0x120)
> [<c0313474>] (__kasan_slab_free) from [<c0311e20>] (kmem_cache_free+0x7c/0x334)
> [<c0311e20>] (kmem_cache_free) from [<c01c35dc>] (rcu_core+0x390/0xccc)
> [<c01c35dc>] (rcu_core) from [<c01013a8>] (__do_softirq+0x180/0x518)
> [<c01013a8>] (__do_softirq) from [<c0135214>] (irq_exit+0x9c/0xe0)
> [<c0135214>] (irq_exit) from [<c01a40e4>] (__handle_domain_irq+0xb0/0x110)
> [<c01a40e4>] (__handle_domain_irq) from [<c0691248>] (gic_handle_irq+0xa0/0xb8)
> [<c0691248>] (gic_handle_irq) from [<c0100b0c>] (__irq_svc+0x6c/0x94)
> Exception stack(0xc36bb928 to 0xc36bb970)
> b920:                   c36bb9c0 00000000 c0126919 c0101228 c36bb9c0 b76d7730
> b940: c36b8000 c36bb9a0 c3335b00 c01ce0d8 00000003 c36bba3c c36bb940 c36bb978
> b960: c010e298 c011373c 60000013 ffffffff
> [<c0100b0c>] (__irq_svc) from [<c011373c>] (unwind_frame+0x0/0x870)
> [<c011373c>] (unwind_frame) from [<00000000>] (0x0)
> 
> The buggy address belongs to the page:
> page:(ptrval) refcount:0 mapcount:0 mapping:00000000 index:0x0 pfn:0x636bb
> flags: 0x0()
> raw: 00000000 00000000 ef867764 00000000 00000000 00000000 ffffffff 00000000
> page dumped because: kasan: bad access detected
> 
> addr c36bba90 is located in stack of task cat/163 at offset 48 in frame:
>  stack_trace_save+0x0/0xb4
> 
> this frame has 1 object:
>  [32, 48) 'trace'
> 
> Memory state around the buggy address:
>  c36bb980: f1 f1 f1 f1 00 04 f2 f2 00 00 f3 f3 00 00 00 00
>  c36bba00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
> >c36bba80: 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
>                  ^
>  c36bbb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  c36bbb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> There is a same issue on x86 and has been resolved by the commit f7d27c35ddff
> ("x86/mm, kasan: Silence KASAN warnings in get_wchan()").
> The solution could be applied to arm architecture too.
> 
> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
> Reported-by: He Ying <heying24@huawei.com>

Hi,

Please drop this in the patch system if not already done so. Pointer to
it in my signature below. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
