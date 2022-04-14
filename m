Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F8501774
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbiDNPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350919AbiDNO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9317D39A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FED61E80
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D9C385A1;
        Thu, 14 Apr 2022 14:16:46 +0000 (UTC)
Message-ID: <d5ffc004-f55c-c01e-3395-7983fb25e570@linux-m68k.org>
Date:   Fri, 15 Apr 2022 00:16:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [linux-stable-rc:queue/5.4 7091/9999]
 drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit
 declaration of function 'claim_dma_lock'
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <202204130751.lUeRF1y2-lkp@intel.com>
 <CAK8P3a3ow9EpNAyTU9n6zC8Rmw71vJ6oaRSCHmd1qU9Z_c3RuA@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAK8P3a3ow9EpNAyTU9n6zC8Rmw71vJ6oaRSCHmd1qU9Z_c3RuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/4/22 18:54, Arnd Bergmann wrote:
> On Wed, Apr 13, 2022 at 1:07 AM kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Arnd,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.4
>> head:   9185989d84b918f49f720061cedc29c8ed039797
>> commit: 53a72858bcae7eaa7df8d167dbf60682d70f82a6 [7091/9999] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
>> config: m68k-randconfig-r011-20220412 (https://download.01.org/0day-ci/archive/20220413/202204130751.lUeRF1y2-lkp@intel.com/config)
>>
> 
> I've seen a couple of reports for this now, in a few other drivers.
> The intention of
> my old patch was to limit the use of the set_dma_addr() etc interface
> for coldfire,
> because they are not implemented on the other MMU-less m68k platform
> (dragonball), which caused build failures there.
> 
> However, changing the dependency to COLDFIRE means that we now build
> the drivers that need this on /other/ machines that don't have the complete
> API. In particular, coldfire-v4 with MMU is now able to select the COMEDI
> ISA drivers that fail to build because a different part of the API
> (claim_dma_lock())
> is defined in asm/floppy.h on m68k instead of asm/dma.h as it is on the
> other architectures.
> 
> I don't actually see any driver on coldfire using the ISA DMA API any more at
> all, so I wonder if we should just drop the symbol entirely, and perhaps remove
> the definitions for coldfire as well. These are the drivers I found
> using the DMA
> API:
> 
> $ git grep -wl set_dma_mode\\\|request_dma drivers/ sound/
> drivers/ata/pata_icside.c
> drivers/comedi/drivers/comedi_isadma.c
> drivers/mmc/host/wbsd.c
> drivers/net/appletalk/ltpc.c
> drivers/net/ethernet/3com/3c515.c
> drivers/net/ethernet/amd/lance.c
> drivers/net/ethernet/amd/ni65.c
> drivers/net/ethernet/cirrus/cs89x0.c
> drivers/net/hamradio/dmascc.c
> drivers/net/wan/cosa.c
> drivers/net/wan/hostess_sv11.c
> drivers/net/wan/sealevel.c
> drivers/net/wan/z85230.c
> drivers/parport/parport_pc.c
> drivers/pnp/resource.c
> drivers/scsi/aha1542.c
> drivers/scsi/arm/cumana_2.c
> drivers/scsi/arm/eesox.c
> drivers/scsi/arm/powertec.c
> drivers/scsi/mpt3sas/mpt3sas_base.c
> drivers/scsi/mpt3sas/mpt3sas_base.h
> drivers/scsi/qla1280.c
> drivers/scsi/qla1280.h
> drivers/scsi/qla4xxx/ql4_def.h
> drivers/scsi/qla4xxx/ql4_mbx.c
> drivers/scsi/qla4xxx/ql4_os.c
> drivers/usb/gadget/udc/net2272.c
> drivers/usb/musb/musb_cppi41.c
> drivers/video/fbdev/pvr2fb.c
> sound/core/isadma.c
> sound/isa/es1688/es1688_lib.c
> sound/isa/gus/gus_main.c
> sound/soc/au1x/dma.c
> 
> Greg (Ungerer), do you see any of these that are used on Coldfire?
> I can rule out most of them, but there are a few that are unclear to me.

I think the cs89x0 driver may have been used on at least one platform
in the past. But nothing that is currently supported in mainline code.
So we can safely assume none of these are required for ColdFire platforms.

Regards
Greg


