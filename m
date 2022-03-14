Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C764D7FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiCNKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiCNKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:34:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751230F;
        Mon, 14 Mar 2022 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647253970; x=1678789970;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tcH7GGg15JCUBMXBBEr4A+gzUlR4DzpJ44QMDaHKhXo=;
  b=A9UqD0DW9K+S/CvEXXSZVh2smEJ6SObgjqDf2xwJiJ156wqXF6kdH8Dd
   IsnXq0g+GAKC5bvUEuEHgnIaEHsHhnc4odPUXkIygMc7+h6oFuC3/MqaH
   dwGpMF7LIVpWhn53OdS48+pVJK+2h1rTFaCQYyxz7mUM8sitteejWSZhK
   /gXs8bf5MGq0evoU1A6+lEn25rPbXzsfgWOKTliNK5qwEnrWIHRr62vUB
   OFHQJ7LViTcDJFwfS5c0RMNoQHEaiFg2xV+x+/msJ4W2N7RYwLeF23Zy3
   +sfDKq6Cd+j0Y6swoOvrsCnWhcyWdfTLbF9BNQWrve+mOMV8M+G4Dle8d
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255941815"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="255941815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="580067063"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 03:32:45 -0700
Message-ID: <4436fbb9-32fa-82f0-bf99-344b9bfddf78@intel.com>
Date:   Mon, 14 Mar 2022 12:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Michael Wu <michael@allwinnertech.com>, ulf.hansson@linaro.org,
        beanhuo@micron.com, porzio@gmail.com
Cc:     lixiang <lixiang@allwinnertech.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <DM6PR04MB6575D203B92955D9A913576CFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575D203B92955D9A913576CFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 09:26, Avri Altman wrote:
> Hi,
>> The mmc core enable cache on default. But it only enables cache-flushing
>> when host supports cmd23 and eMMC supports reliable write.
>> For hosts which do not support cmd23 or eMMCs which do not support
>> reliable write, the cache can not be flushed by `sync` command.
>> This may leads to cache data lost.
>> This patch enables cache-flushing as long as cache is enabled, no matter host
>> supports cmd23 and/or eMMC supports reliable write or not.
> I looked in the spec and indeed couldn't find why enabling cache is dependent of cmd23/reliable write.
> Nor I was able to find the original commit log.

Reliable write was added first, so it might have been an oversight:

commit 881d1c25f765938a95def5afe39486ce39f9fc96
Author: Seungwon Jeon <tgih.jun@samsung.com>
Date:   Fri Oct 14 14:03:21 2011 +0900

    mmc: core: Add cache control for eMMC4.5 device
    
    This patch adds cache feature of eMMC4.5 Spec.
    If device supports cache capability, host can utilize some specific
    operations.
    
    Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
    Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>



> 
> Please allow few days to ask internally.
> 
> Thanks,
> Avri

