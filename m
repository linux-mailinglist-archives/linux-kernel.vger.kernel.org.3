Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BBA578EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiGSAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiGSAGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:06:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FE131933;
        Mon, 18 Jul 2022 17:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658189183; x=1689725183;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=29irNU69Aaj6YHBxBjzfv6PGD4zSfN7x3EpWcwWR9p4=;
  b=OeWxOMa7Yx420vjYbZu6Y5ZIPDKlPltnCSvG1gpOFodDRphGvjUjrD7A
   uWnwIo4KHfN6xgablh6w8N+5Z1BEJIWjd/RHTOall9fih6eTVvuhSDjs3
   NIZ+TDLNZBnhuEAWIbwoo37bO1XlFOv5AU5qLU1Zfc85+xVdS7vBK6A1v
   wkmiCay7RebVH3rGRnQNieVS2T046978tyCfeFRpcDqigkixA9SOZ/FGa
   EUwBUQBueE/YKolb/ZIdvy1ZO5Ve83+CNcYXydJcWzdAKHQfwdR1TLQtS
   LVc4oo8eqNskYnjgFBHvnX0JPAUm7BeZz70CfXdmq+G14SYHKn//vzn5S
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="273179170"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="273179170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:06:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="547694963"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.128]) ([10.254.213.128])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:06:19 -0700
Message-ID: <9614fd81-5feb-b9c9-8317-26ca82d30d55@linux.intel.com>
Date:   Tue, 19 Jul 2022 08:06:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
 <903a1677-4217-d793-6295-3927143d98fb@linux.intel.com>
 <6557623d-3e4e-9f3e-e735-fd9654305f65@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and
 device probe
In-Reply-To: <6557623d-3e4e-9f3e-e735-fd9654305f65@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2022/7/15 20:37, Robin Murphy wrote:
>> In fact the rmrr list in the Intel IOMMU driver is always static after
>> parsing the ACPI/DMAR tables. There's no need to protect it with a lock.
>> Hence we can safely remove below down/up_read().
> 
> IIRC that leads to RCU warnings via for_each_dev_scope(), though. I did 
> try replacing this down_read() with rcu_read_lock(), but then it doesn't 
> like the GFP_KERNEL allocation in iommu_alloc_resv_region(), and that's 
> where I gave up :)
> 
> I'm mostly left wondering whether the dmar_drhd_units list really needs 
> to be RCU protected at all, as that seems to be the root of most of the 
> problems here.

I just posted a fix patch here:

https://lore.kernel.org/linux-iommu/20220718235325.3952426-1-baolu.lu@linux.intel.com/

It can remove the recursive locking and RCU warnings. Can you please
take a look at it?

Best regards,
baolu
