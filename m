Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919065880F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiHBRXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiHBRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:23:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9648EA9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659460986; x=1690996986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sFeSnQ3Jh+eJSBpBMVT7FWaGVkgqv+hXL8zcIgQ/F98=;
  b=V1idJGrMGnoNj9/7r3lxLDcE2UKfvCWdTuVieW8N2MoqMoOnCqilv8we
   n6Zw9nMd9M4SXS5Jizp4FKocDrK41kCuEwxeigqMkN+0qqPWN+tdRRE7E
   MSDFlRALrXYhdhpHYnK6KmdXWy6doYZNtBk2ZD4xQtt1vQVkmRLWyo8TL
   AZd+MFmudC0S277IhHlNdCxizFTfbNHX9ksvIZd0ZCnjCXsbch8KVY83o
   9jdF/0+VBRtp4RcP/yRGs392sKQfKD/sVj817rN2TLeaMi9kcWMY1S6WO
   B1QDCM/T38RVQeVRxfi9GLcHEYBfasio5K6KA07DkkpTeg5lJDaByafyq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290687355"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290687355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 10:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="552993217"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 10:23:06 -0700
Received: from [10.252.214.98] (kliang2-mobl1.ccr.corp.intel.com [10.252.214.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ED34E580AA7;
        Tue,  2 Aug 2022 10:23:04 -0700 (PDT)
Message-ID: <d45ac9ca-2b65-3cff-989a-99db5a6096bb@linux.intel.com>
Date:   Tue, 2 Aug 2022 13:23:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
Content-Language: en-US
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, tilak.tangudu@intel.com
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
 <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
 <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
 <20220723185617.vz3swht66lbtuwzl@ldmartin-desk2>
 <bec1bc73-b3bc-50da-8aa7-0aab2328d62f@linux.intel.com>
 <20220802142213.d2f6qzwl2w3sfm5g@ldmartin-desk2.lan>
 <b0bd2b88-2ac8-42f2-22dd-587a21a7e9dd@linux.intel.com>
 <20220802160237.uqgez4f3ctm7rpyc@ldmartin-desk2>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220802160237.uqgez4f3ctm7rpyc@ldmartin-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-02 12:02 p.m., Lucas De Marchi wrote:
>>> 2) Trying to read the MMIOs when device is possibly in D3 state:
>>
>> The uncore driver skips the device which doesn't support the discovery
>> mechanism.
>> If 1) is fixed, the uncore driver will not touch the MMIO space of a PVC
>> device. The power issue should be gone.
>>
>> I've already sent you a patch to ignore the PVC added OOBMSM device, you
>> can double check with the patch.
> 
> (2) is a more generic issue that I'm mentioning. Forget for a moment we
> are talking about PVC - that will be fixed by (1). We are trying to read
> the mmio from a device that can be in D3, either because it started in
> D3 or because a driver, loaded before intel_uncore, moved it to that
> state. That won't work even if the device supports the discovery
> mechanism.

The uncore driver is designed to only support the *PMON* discovery
table, not all the discovery tables. The DEVSEC_ID 1 indicates the
*PMON* discovery table.

For other devices which support the discovery mechanism, they should use
another DEVSEC_ID. The uncore driver will ignore the device.

Thanks,
Kan
