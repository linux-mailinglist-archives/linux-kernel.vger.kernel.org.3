Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8645E50DD94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiDYKHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbiDYKGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:06:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94AB9255BB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:03:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEAF41FB;
        Mon, 25 Apr 2022 03:03:37 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCEDF3F73B;
        Mon, 25 Apr 2022 03:03:35 -0700 (PDT)
Message-ID: <9debe3ab-603d-0d30-a6aa-8963b48e83d4@arm.com>
Date:   Mon, 25 Apr 2022 11:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] iommu/mediatek: fix NULL pointer dereference when
 printing dev_name
Content-Language: en-GB
To:     Miles Chen <miles.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220425082449.1821-1-miles.chen@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220425082449.1821-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-25 09:24, Miles Chen via iommu wrote:
> When larbdev is NULL (in the case I hit, the node is incorrectly set
> iommus = <&iommu NUM>), it will cause device_link_add() fail and
> kernel crashes when we try to print dev_name(larbdev).
> 
> Fix it by adding a NULL pointer check before
> device_link_add/device_link_remove.
> 
> It should work for normal correct setting and avoid the crash caused
> by my incorrect setting.
> 
> Error log:
> [   18.189042][  T301] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
> [   18.190247][  T301] Mem abort info:
> [   18.190255][  T301]   ESR = 0x96000005
> [   18.190263][  T301]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   18.192142][  T301]   SET = 0, FnV = 0
> [   18.192151][  T301]   EA = 0, S1PTW = 0
> [   18.194710][  T301]   FSC = 0x05: level 1 translation fault
> [   18.195424][  T301] Data abort info:
> [   18.195888][  T301]   ISV = 0, ISS = 0x00000005
> [   18.196500][  T301]   CM = 0, WnR = 0
> [   18.196977][  T301] user pgtable: 4k pages, 39-bit VAs, pgdp=0000000104f9e000
> [   18.197889][  T301] [0000000000000050] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [   18.199220][  T301] Internal error: Oops: 96000005 [#1] PREEMPT SMP
> [   18.343152][  T301] Kernel Offset: 0x1444080000 from 0xffffffc008000000
> [   18.343988][  T301] PHYS_OFFSET: 0x40000000
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
> [   18.369840][  T301]  __iommu_probe_device+0x12c/0x358
> [   18.370880][  T301]  iommu_probe_device+0x3c/0x31c
> [   18.372026][  T301]  of_iommu_configure+0x200/0x274
> [   18.373587][  T301]  of_dma_configure_id+0x1b8/0x230
> [   18.375200][  T301]  platform_dma_configure+0x24/0x3c
> [   18.376456][  T301]  really_probe+0x110/0x504
> [   18.376464][  T301]  __driver_probe_device+0xb4/0x188
> [   18.376472][  T301]  driver_probe_device+0x5c/0x2b8
> [   18.376481][  T301]  __driver_attach+0x338/0x42c
> [   18.377992][  T301]  bus_add_driver+0x218/0x4c8
> [   18.379389][  T301]  driver_register+0x84/0x17c
> [   18.380580][  T301]  __platform_driver_register+0x28/0x38
> ...
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 635319a4a744 ("media: iommu/mediatek: Add device_link between the consumer and the larb devices")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> ---
> 
> Change since v1
> fix a build warning reported by kernel test robot
> https://lore.kernel.org/lkml/202204231446.IYKdZ674-lkp@intel.com/
> 
> ---
>   drivers/iommu/mtk_iommu.c    | 13 ++++++++-----
>   drivers/iommu/mtk_iommu_v1.c | 13 ++++++++-----
>   2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fd75a60abd6..03e0133f346a 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -581,10 +581,12 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   		}
>   	}
>   	larbdev = data->larb_imu[larbid].dev;
> -	link = device_link_add(dev, larbdev,
> -			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> -	if (!link)
> -		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +	if (larbdev) {

Until the MT8195 infra MMU support lands, is there ever a case where 
it's actually valid for larbdev to be NULL? If not, I think it would be 
a lot clearer to explicitly fail the probe here, rather than silently 
continue and risk fatal errors, hangs, or other weird behaviour if 
there's no guarantee that the correct LARB is powered up (plus then the 
release callbacks wouldn't need to worry about it either).

Robin.

> +		link = device_link_add(dev, larbdev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +		if (!link)
> +			dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +	}
>   	return &data->iommu;
>   }
>   
> @@ -601,7 +603,8 @@ static void mtk_iommu_release_device(struct device *dev)
>   	data = dev_iommu_priv_get(dev);
>   	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>   	larbdev = data->larb_imu[larbid].dev;
> -	device_link_remove(dev, larbdev);
> +	if (larbdev)
> +		device_link_remove(dev, larbdev);
>   
>   	iommu_fwspec_free(dev);
>   }
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index ecff800656e6..18365c73eeb2 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -467,10 +467,12 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   	}
>   
>   	larbdev = data->larb_imu[larbid].dev;
> -	link = device_link_add(dev, larbdev,
> -			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> -	if (!link)
> -		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +	if (larbdev) {
> +		link = device_link_add(dev, larbdev,
> +				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
> +		if (!link)
> +			dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
> +	}
>   
>   	return &data->iommu;
>   }
> @@ -502,7 +504,8 @@ static void mtk_iommu_release_device(struct device *dev)
>   	data = dev_iommu_priv_get(dev);
>   	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
>   	larbdev = data->larb_imu[larbid].dev;
> -	device_link_remove(dev, larbdev);
> +	if (larbdev)
> +		device_link_remove(dev, larbdev);
>   
>   	iommu_fwspec_free(dev);
>   }
