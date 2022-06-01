Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A6E53B00B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiFAW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiFAW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:28:32 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3A5B482
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AkDE+5ZI+IK3BHuS7N7ViWTtDYvZB4rptzcmh8eb1n8=;
  b=ciO8DIRhw86/ODL5KXlAbuCIsWdUVr65CDTHtk2tDoP9AoVAH7qNtfnF
   KU+mwi2rgZ6Cf64GqsKh3HgBkBJMfS2VQbVTEcVT4U7O3d2xR7VeMOmDI
   2ZKs9XO4RK+y56oP0BgJpCEo8Qpz091wtL7m22O6JPphXLTN2WA5VzsxQ
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,269,1647298800"; 
   d="scan'208";a="39079992"
Received: from eth-east-parth2-46-193-69-7.wb.wifirst.net (HELO [10.188.210.33]) ([46.193.69.7])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:28:28 +0200
Message-ID: <d971a684-ccd9-3839-1e30-c166fd55cf49@inria.fr>
Date:   Thu, 2 Jun 2022 07:28:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr>
 <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
 <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
From:   Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/06/01 1:41, Linus Torvalds wrote:
> On Tue, May 31, 2022 at 1:04 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> As an experiment: what kind of results would we get when looking
>> for packed structures and unions that contain any of these:
> 

> I don't think we have that. Not only because it would already cause
> breakage, but simply because the kinds of structures that people pack
> aren't generally the kind that contain these kinds of things.
> 
> That said, you might have a struct that is packed, but that
> intentionally aligns parts of itself, so it *could* be valid.
> 
> But it would probably not be a bad idea to check that packed
> structures/unions don't have atomic types or locks in them. I _think_
> we're all good, but who knows..


I am Julia's student at INRIA and I heard from her that there is an 
opportunity to use Coccinelle to find specific types in packed struct or
enum.

I found 13 definitions of packed structure that contains:
 > - spinlock_t
 > - atomic_t
 > - dma_addr_t
 > - phys_addr_t
 > - size_t

 > - struct mutex
 > - struct device

- raw_spinlock_t

== Results ==
security/tomoyo/common.h: atomic_t in tomoyo_shared_acl_head
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h: spinlock_t in 
key_map
include/linux/ti-emif-sram.h: phys_addr_t in ti_emif_pm_data
drivers/scsi/wd719x.h: dma_addr_t in wd719x_scb
drivers/net/wireless/intel/ipw2x00/ipw2200.h: dma_addr_t in clx2_queue
drivers/infiniband/hw/irdma/osdep.h: dma_addr_t in irdma_dma_mem
drivers/infiniband/core/mad_priv.h: size_t in ib_mad_private
drivers/crypto/qat/qat_common/qat_asym_algs.c:
- dma_addr_t in qat_rsa_ctx
- dma_addr_t in qat_dh_ctx
drivers/atm/idt77252.h: dma_addr_t in idt77252_skb_prv
arch/s390/include/asm/kvm_host.h: atomic_t in kvm_s390_sie_block

drivers/net/wireless/ath/ath10k/core.h: dma_addr_t in ath10k_skb_cb
drivers/net/wireless/ath/ath11k/core.h: dma_addr_t in ath10k_skb_cb
drivers/crypto/ccp/ccp-dev.h: dma_addr_t in ccp_dma_info

The last 3 structures have a dma_adddr_t member defined as the first 
member variable. Most of the others also seems valid.

I used this SmPL script to find them:

@e1@
type T;
identifier i;
position p;
attribute name __packed;
@@
  T@p  {
   ...
(
   atomic_t i;
|
   raw_spinlock_t i;
|
   struct mutex i;
|
   spinlock_t i;
|
   dma_addr_t i;
|
   phys_addr_t i;
|
   size_t i;
|
  struct device i;
)
   ...
  }
  __packed;

@e2@
type T;
identifier i;
position p;
@@
  T@p  {
   ...
(
   atomic_t i;
|
   raw_spinlock_t i;
|
   struct mutex i;
|
   spinlock_t i;
|
   dma_addr_t i;
|
   phys_addr_t i;
|
   size_t i;
|
  struct device i;
)
   ...
  }
    __attribute__((
(
  pack
|
  __pack__
)
  ,... ));

@script:python@
ps <<e1.p;
@@
for p in ps:
   print p.file, p.line
@script:python@
ps <<e2.p;
@@
for p in ps:
   print p.file, p.line


Keisuke
