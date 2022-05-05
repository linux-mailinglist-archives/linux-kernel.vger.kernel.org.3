Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3951C31D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380880AbiEEPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiEEPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:01:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E87B2A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:57:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5F7D01F4589E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651762640;
        bh=852xH/KcBe3CUteZgRNyrG66GO4E9q7U2O3+DhPjsUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YWDw1Y2G4i8MWiG6/sJvV4mWgfsBcV7yg6XtgOeF95Bx6aCIwxDNJvqrRuIOoC1qt
         58q5In4zFxu4BDJWGH6/v8asx74ifrFLhfhQUBIUNXaec25iuW6Xzb3e8s1EE3eBVA
         GyddmwMKa0DTzCgWBGAXNK03eA2ORbVbKr3gKq36g0yZ8hAcCJu1+joONFTHWKt48n
         pxLDyUGTZDeezP/3QA1nZ9nBbwhhXpbb0vWmF6PFXTevYGBAF50J3poKbXvnqHAS9X
         TnkUn6m9u/UeYgHMaefak1qkV+6/0D8CK3yR2zIpqBChIFeCx6N+2X1S+VEhfww07W
         IdwJAegQHk9Dg==
Message-ID: <e10d2b34-adbe-4ec5-04f3-55b52fa2f006@collabora.com>
Date:   Thu, 5 May 2022 16:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] iommu/mediatek: Fix NULL pointer dereference when
 printing dev_name
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220505132731.21628-1-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220505132731.21628-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/05/22 15:27, Miles Chen ha scritto:
> When larbdev is NULL (in the case I hit, the node is incorrectly set
> iommus = <&iommu NUM>), it will cause device_link_add() fail and
> kernel crashes when we try to print dev_name(larbdev).
> 
> Let's fail the probe if a larbdev is NULL to avoid invalid inputs from
> dts.
> 
> It should work for normal correct setting and avoid the crash caused
> by my incorrect setting.
> 
> Error log:
> [   18.189042][  T301] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
> ...
> [   18.344519][  T301] pstate: a0400005 (NzCv daif +PAN -UAO)
> [   18.345213][  T301] pc : mtk_iommu_probe_device+0xf8/0x118 [mtk_iommu]
> [   18.346050][  T301] lr : mtk_iommu_probe_device+0xd0/0x118 [mtk_iommu]
> [   18.346884][  T301] sp : ffffffc00a5635e0
> [   18.347392][  T301] x29: ffffffc00a5635e0 x28: ffffffd44a46c1d8
> [   18.348156][  T301] x27: ffffff80c39a8000 x26: ffffffd44a80cc38
> [   18.348917][  T301] x25: 0000000000000000 x24: ffffffd44a80cc38
> [   18.349677][  T301] x23: ffffffd44e4da4c6 x22: ffffffd44a80cc38
> [   18.350438][  T301] x21: ffffff80cecd1880 x20: 0000000000000000
> [   18.351198][  T301] x19: ffffff80c439f010 x18: ffffffc00a50d0c0
> [   18.351959][  T301] x17: ffffffffffffffff x16: 0000000000000004
> [   18.352719][  T301] x15: 0000000000000004 x14: ffffffd44eb5d420
> [   18.353480][  T301] x13: 0000000000000ad2 x12: 0000000000000003
> [   18.354241][  T301] x11: 00000000fffffad2 x10: c0000000fffffad2
> [   18.355003][  T301] x9 : a0d288d8d7142d00 x8 : a0d288d8d7142d00
> [   18.355763][  T301] x7 : ffffffd44c2bc640 x6 : 0000000000000000
> [   18.356524][  T301] x5 : 0000000000000080 x4 : 0000000000000001
> [   18.357284][  T301] x3 : 0000000000000000 x2 : 0000000000000005
> [   18.358045][  T301] x1 : 0000000000000000 x0 : 0000000000000000
> [   18.360208][  T301] Hardware name: MT6873 (DT)
> [   18.360771][  T301] Call trace:
> [   18.361168][  T301]  dump_backtrace+0xf8/0x1f0
> [   18.361737][  T301]  dump_stack_lvl+0xa8/0x11c
> [   18.362305][  T301]  dump_stack+0x1c/0x2c
> [   18.362816][  T301]  mrdump_common_die+0x184/0x40c [mrdump]
> [   18.363575][  T301]  ipanic_die+0x24/0x38 [mrdump]
> [   18.364230][  T301]  atomic_notifier_call_chain+0x128/0x2b8
> [   18.364937][  T301]  die+0x16c/0x568
> [   18.365394][  T301]  __do_kernel_fault+0x1e8/0x214
> [   18.365402][  T301]  do_page_fault+0xb8/0x678
> [   18.366934][  T301]  do_translation_fault+0x48/0x64
> [   18.368645][  T301]  do_mem_abort+0x68/0x148
> [   18.368652][  T301]  el1_abort+0x40/0x64
> [   18.368660][  T301]  el1h_64_sync_handler+0x54/0x88
> [   18.368668][  T301]  el1h_64_sync+0x68/0x6c
> [   18.368673][  T301]  mtk_iommu_probe_device+0xf8/0x118 [mtk_iommu]
> ...
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 635319a4a744 ("media: iommu/mediatek: Add device_link between the consumer and the larb devices")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


