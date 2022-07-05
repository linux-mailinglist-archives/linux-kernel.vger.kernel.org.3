Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC705677FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGETrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGETri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:47:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE019C3D;
        Tue,  5 Jul 2022 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657050457; x=1688586457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Vb7xfZq1vwtZpgIWv0jJKrs3Fn35tFR3X4uht7SrhY=;
  b=R8hFQ24vLrZU1jukMXRDuj99hcayGKB8hxsr6MeVMxAYFSjYJPxO11Ls
   fH1+wVyC9pofFNgmC/FeEgL0E2NQKWNCgzcQq4DVTLjWddFm0k+5IzFzK
   TlJICJUXAOh9URpH0Q5U8W45csOj0f9qxs3S7N6aqojc1YAoZ8SVSnM3q
   MtC73BFr590dW+AJA0SZhoP30ThjmcIu01iMBnmZzamvCpuGAORg/PMZK
   qgSiEfPBk/9MllRY+0pyMwsPQNlGzhSQEx7chzP+KijIYX8qrYzxFpN6e
   hH7kr8f2t6IG8PWABP/g5jv0COmr2gcZxSso4vaQ304gxYMI5Xt4+jfI8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272252921"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="272252921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 12:47:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="619987493"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.144.144.107]) ([10.144.144.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 12:47:37 -0700
Message-ID: <b617a83b-cde1-ed7f-cd5f-9eabcffffafb@linux.intel.com>
Date:   Tue, 5 Jul 2022 12:47:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 0/4] Add Raptor Lake and PCI error recovery support
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
 <ac7bfd35-203b-5002-a3ff-787ca1738a41@redhat.com>
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <ac7bfd35-203b-5002-a3ff-787ca1738a41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/2022 2:54 AM, Hans de Goede wrote:

> Hi,
>
> On 6/30/22 00:13, Gayatri Kammela wrote:
>> Hi,
>>
>> This patch set adds Raptor Lake support as well as PCI error recovery
>> support to PMT driver. It also has a rework patch and a fix for fixed
>> region handling.
>>
>> Patch 1: Rework early hardware code
>> Patch 2: Add support for Raptor Lake
>> Patch 3: Fix fixed region handling
>> Patch 4: Add PCI error recovery support to Intel PMT
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans
>
Thank you Hans!
>> David E. Box (3):
>>    platform/x86/intel/vsec: Rework early hardware code
>>    platform/x86/intel/vsec: Add support for Raptor Lake
>>    platform/x86/intel/pmt: telemetry: Fix fixed region handling
>>
>> Gayatri Kammela (1):
>>    platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
>>
>>   drivers/platform/x86/intel/pmt/class.c     |  23 ++--
>>   drivers/platform/x86/intel/pmt/telemetry.c |  18 ++-
>>   drivers/platform/x86/intel/vsec.c          | 130 ++++++++++++++++-----
>>   drivers/platform/x86/intel/vsec.h          |  11 +-
>>   4 files changed, 136 insertions(+), 46 deletions(-)
>>
>>
>> base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
