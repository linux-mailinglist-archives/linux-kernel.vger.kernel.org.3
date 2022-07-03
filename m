Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEADF5644C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiGCEeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGCEee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:34:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D262065A5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656822873; x=1688358873;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dggnYSpV7chR/Zf2YHo3sr0zievBBwaxsO/t3s+0h4I=;
  b=TD8pbVAHeASnJaEeoW5eMkzLZWAHEzGH+eKj/rAB4XWVTJt8fvyDvwMo
   lVMN62vVLJMC802vr1N0G4tDpEl6PEzhTNL0HIsaQ2McVXjvUoZhbLb8M
   hK0nGzw7o/+DjVx7pfKdH2a9kKTFTBUtCuGl8YxHsaW4nKtIvgL+yaLVd
   C17spqLn956lx7fIH39BdSvqVRtvycQF+GqnnxMIRNRlttzokVxD05k5B
   TxfGZ8gq7SzIhiER1omHRj/bZddw15zXVzW/QAIzrAQQz+dkY68BD1yuj
   3ClTgSk/pyZZFgo4BWil+wlYqr+rDTxKnbg2H9u/8z2IoKNYs4SHEljWV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="263292561"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="263292561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:34:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="648966157"
Received: from sunqi-mobl1.ccr.corp.intel.com (HELO [10.249.173.69]) ([10.249.173.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 21:34:31 -0700
Message-ID: <c38b7123-f76d-d4b6-f36e-a385d5ea0cf5@linux.intel.com>
Date:   Sun, 3 Jul 2022 12:34:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A0E52DB09F5D338CEB998CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A0E52DB09F5D338CEB998CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/1 15:58, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com> Sent: Wednesday, June 29,
>> 2022 3:47 PM
>> 
>> The disable_dmar_iommu() is called when IOMMU initialization fails
>> or the IOMMU is hot-removed from the system. In both cases, there
>> is no need to clear the IOMMU translation data structures for
>> devices.
>> 
>> On the initialization path, the device probing only happens after
>> the IOMMU is initialized successfully, hence there're no
>> translation data structures.
>> 
>> On the hot-remove path, there is no real use case where the IOMMU
>> is hot-removed, but the devices that it manages are still alive in
>> the system. The translation data structures were torn down during
>> device release, hence there's no need to repeat it in IOMMU
>> hot-remove path either. This removes the unnecessary code and only
>> leaves a check.
>> 
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> You probably overlooked my last comment on kexec:
> 
> https://lore.kernel.org/lkml/BL1PR11MB52711A71AD9F11B7AE42694C8CAC9@BL1PR11MB5271.namprd11.prod.outlook.com/
>
>  I think my question is still not answered.

Sorry! I did overlook that comment. I can see your points now, though it
seems to be irrelevant to the problems that this series tries to solve.

The failure path of copying table still needs some improvement. At least
the pages allocated for root/context tables should be freed in the
failure path. Even worse, the software occupied a bit of page table
entry which is feasible for the old ECS, but not work for the new
scalable mode anymore.

All these problems deserve a separate series. We could address your
concerns there. Does this work for you?

Best regards,
baolu
