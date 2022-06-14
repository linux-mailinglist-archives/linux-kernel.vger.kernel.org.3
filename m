Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5825B54A3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiFNBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiFNBdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:33:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86C2CDFB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655170423; x=1686706423;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YvbS/tamQc78iYTNaH9LZbGIaWYjPi6QM3l/BEhgpzk=;
  b=aNoAp8NDKDN5M47AlV4JvPH4h2l+XIUbcKe6RnEerecqMB5jaNrJG3H9
   ECcr50lMz4ldr9r7HUD0iQqVDNEUaqlZrLhuX/0trfLOtYioR9GeayPy/
   b5SrLVvR/Rsfe89f9KE6BDJtul6Af5N97IUPAs/GWmhsD2WVPu5sOynMP
   gYkBDncfXoiwTr4ISLRwXgTnn0KVZeX93Y1OTC97MWnmivIPhmjlCFCeq
   tyE4d1dmTyCew5s77HbLsQ0w9hSv3kFf4kmAViBpz/xecxRSOGKZi2kKt
   h6ZklNVRmd91LHMjtT14R+mA3fYQ6YZ7pqboDdixs8uXK5c7BowDl5o2X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261499431"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="261499431"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:33:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="910695106"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:33:35 -0700
Message-ID: <a827193a-2cd3-7d9f-1bb2-3f4be6ae193e@linux.intel.com>
Date:   Tue, 14 Jun 2022 09:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613203842.zyncvndwfauef2yh@cantor>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220613203842.zyncvndwfauef2yh@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 04:38, Jerry Snitselaar wrote:
> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>> To support up to 64 sockets with 10 DMAR units each (640), make the
>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>> set.
>>
>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>> fails to boot properly.
>>
>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> ---
>>
>> Note that we could not find a reason for connecting
>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>> it seemed like the two would continue to match on earlier processors.
>> There doesn't appear to be kernel code that assumes that the value of
>> one is related to the other.
>>
>> v2: Make this value a config option, rather than a fixed constant.  The default
>> values should match previous configuration except in the MAXSMP case.  Keeping the
>> value at a power of two was requested by Kevin Tian.
>>
>>   drivers/iommu/intel/Kconfig | 6 ++++++
>>   include/linux/dmar.h        | 6 +-----
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
> 
> Baolu do you have this queued up for v5.20? Also do you have a public repo where
> you keep the vt-d changes before sending Joerg the patches for a release?

Yes. I have started to queue patches for v5.20. They could be found on
github:

https://github.com/LuBaolu/intel-iommu/commits/vtd-next-for-v5.20

Best regards,
baolu
