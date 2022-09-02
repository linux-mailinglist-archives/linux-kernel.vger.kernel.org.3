Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F85ABAAE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiIBWKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIBWKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:10:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F86B148
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Du4EboxIuNrkWsTrUXb2UIbbsv61yWb6aY5D8GRpJMg=; b=nVzMrBhmKPTZnNqwUf4hxZJKrl
        xF2R1cmFH5cNL12dwATCtJD7hzhMQUj6+xKB+BWTpih+0aA1jKyeOFlNmfH764xBQC8BriyZY6MZ7
        EJ490yE+YQDpchwWhIjeethhg5Y7jkgAoo+MPxcHJxp11OBNnEvlMEAsC0bNpyBlPvXZ7lTLHMbtR
        vJ1yMnLBzLEs1uOLANW7x44EsGhZPMl4+C7mPnZhw4/t65dQq49suUwaL6fP0geSoyq0aFPxxXzca
        12ZWaKk6PmoAnpDhmabUYJAZ1rppNWXwWwA+pOMc8b6jJBal386qd2iRDhkkAxNAAzhf/HZ99maCP
        KCZWrkJQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUErh-00Bt8k-Ij; Fri, 02 Sep 2022 22:10:17 +0000
Message-ID: <8a8822a1-327d-84b9-549a-f11009a15b4f@infradead.org>
Date:   Fri, 2 Sep 2022 15:10:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: amd iommu configuration
To:     Steven J Abner <pheonix.sja@att.net>, linux-kernel@vger.kernel.org
References: <KONJHR.T3DS4EBAXDVX1.ref@att.net> <KONJHR.T3DS4EBAXDVX1@att.net>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <KONJHR.T3DS4EBAXDVX1@att.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 11:36, Steven J Abner wrote:
> Hi
> Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 as base.
> I stumbled across an odd situation and which lacked Kconfig info and lead to oddity.
> /drivers/iommu/amd/Kconfig states 'config AMD_IOMMU_V2' is 'tristate' but unlike many
> other tristate configures doesn't mention that module name is 'iommu_v2.ko' and loading should be done by adding to modules-load.d.
> 
> The oddity is that by loading as module is as follows (differences):
> 
> builtin iommu_v2 version dmesg:
> amdgpu: HMM registered 2048MB device memory
> amdgpu: Topology: Add APU node [0x0:0x0]
> amdgpu: Topology: Add APU node [0x15dd:0x1002]
> AMD-Vi: AMD IOMMUv2 loaded and initialized
> kfd kfd: amdgpu: added device 1002:15dd
> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> memmap_init_zone_device initialised 524288 pages in 0ms
> 
> module not loaded due to missing iommu.conf dmesg:
> amdgpu: CRAT table disabled by module option
> amdgpu: Topology: Add CPU node
> amdgpu: Virtual CRAT table created for CPU
> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
> 
> module load through iommu.conf dmesg:
> amdgpu: CRAT table disabled by module option
> amdgpu: Topology: Add CPU node
> amdgpu: Virtual CRAT table created for CPU
> AMD-Vi: AMD IOMMUv2 loaded and initialized
> kfd kfd: amdgpu: GC IP 090100 not supported in kfd
> 
> Note, only difference on witk/without iommu.conf is:
> AMD-Vi: AMD IOMMUv2 loaded and initialized
> 
> So does this mean missing features by not having builtin?
> If not, should Kconfig have hint about module and loading?
> 
> Steve
> 
> I wish to be personally CC'ed the answers/comments posted to the list
> in response to my posting, please:) Not a list member.

Hi,
Please try these email addresses:

AMD IOMMU (AMD-VI)
M:	Joerg Roedel <joro@8bytes.org>
R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
L:	iommu@lists.linux.dev

Thanks.

-- 
~Randy
