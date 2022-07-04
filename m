Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA4565270
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiGDKeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiGDKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF81DFF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F096861592
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3425C341CA;
        Mon,  4 Jul 2022 10:34:05 +0000 (UTC)
Date:   Mon, 4 Jul 2022 11:34:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= 
        <haibinzhang@tencent.com>
Cc:     Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>
Subject: Re: [PATCH V2] arm64: fix oops in concurrently setting
 insn_emulation sysctls
Message-ID: <YsLCGsagWulawWIl@arm.com>
References: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 05:43:19AM +0000, haibinzhang(张海斌) wrote:
> How to reproduce:
>     launch two shell executions:
>        #!/bin/bash
>        while [ 1 ];
>        do
>            echo 1 > /proc/sys/abi/swp
>        done
> 
> Oops info:
>     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
>     Internal error: Oops: 96000006 [#1] SMP
>     Call trace:
>     update_insn_emulation_mode+0xc0/0x148
>     emulation_proc_handler+0x64/0xb8
>     proc_sys_call_handler+0x9c/0xf8
>     proc_sys_write+0x18/0x20
>     __vfs_write+0x20/0x48
>     vfs_write+0xe4/0x1d0
>     ksys_write+0x70/0xf8
>     __arm64_sys_write+0x20/0x28
>     el0_svc_common.constprop.0+0x7c/0x1c0
>     el0_svc_handler+0x2c/0xa0
>     el0_svc+0x8/0x200
> 
> emulation_proc_handler changes table->data for proc_dointvec_minmax
> and so it isn't allowed to reenter before restoring table->data,
> which isn't right now.
> To fix this issue, keep the table->data as &insn->current_mode and
> use container_of() to retrieve the insn pointer. Another mutex is
> used to protect against the current_mode update but not for retrieving
> insn_emulation as table->data is no longer changing.
> 
> Signed-off-by: hewenliang <hewenliang4@huawei.com>
> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
