Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7204DAEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355334AbiCPL3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345749AbiCPL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:29:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B141A82E;
        Wed, 16 Mar 2022 04:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647430096; x=1678966096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4jogdazBJV35LcyWiOHLVD3Ee6rHelFVxCPdz8kIHnk=;
  b=G42YMc0ts/GjkO7owmhptiEQEDYJmj7wkD+wQoIRl5U371SXIackCN0r
   C+tRMJdMyXdeBFDNhBYgu3GRa20cc/GBVUS37kvXJGQ3khJ5cPe4I/pm9
   77Ea66fktW3KktaRT7fBylEqE1BouL5teaDLaXt2puIUvBryxBf2adJ1N
   hNVtHXBrCjlmvGBbh9Y1uQWPcQtmZi5nB213FGie/QzUKynCpp2rtw9co
   VGOGxDcjXzMmSo3qYMztlDhRryVK7euthufUGZ+2GHk80lJs3HDdSCQDX
   GU3rRjtgQciMbyRkdE8CqjLe6iMuHO1oDGN9b2s2wiD2+4vu2wfX6KOHa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238720659"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="238720659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:28:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557395100"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:28:13 -0700
Message-ID: <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com>
Date:   Wed, 16 Mar 2022 13:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Content-Language: en-US
To:     Avri Altman <Avri.Altman@wdc.com>,
        Michael Wu <michael@allwinnertech.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "porzio@gmail.com" <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        allwinner-opensource-support 
        <allwinner-opensource-support@allwinnertech.com>
References: <20220312044315.7994-1-michael@allwinnertech.com>
 <83edf9a1-1712-5388-a3fa-d685f1f581df@intel.com>
 <88e53cb9-791f-ee58-9be8-76ae9986e0e2@allwinnertech.com>
 <DM6PR04MB6575C3B87DFA920EDCD994CCFC0F9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <32b29790-eb5c-dac0-1f91-aede38220914@allwinnertech.com>
 <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <DM6PR04MB6575A4A2A687A876EA5C04B7FC119@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.3.2022 13.09, Avri Altman wrote:
>> Hi Avril & Adrian,
>> Thanks for your efforts. Could we have an agreement now --
>>
>> 1. enabling-cache and cmd23/reliable-write should be independent;
>>
>> Here's what I found in the spec JESD84-B51:
>>  > 6.6.31 Cache
>>  > Caching of data shall apply only for the single block
>>  > read/write(CMD17/24), pre-defined multiple block
>>  > read/write(CMD23+CMD18/25) and open ended multiple block
>>  > read/write(CMD18/25+CMD12) commands and excludes any other access
>>  > e.g., to the register space(e.g., CMD6).
>> Which means with CMD18/25+CMD12 (without using CMD23), the cache can
>> also be enabled. Maybe this could be an evidence of the independence
>> between enabling-cache and cmd23/reliable-write?
> Acked-by: Avri Altman <avri.altman@wdc.com>
> 
> Thanks,
> Avri
> 
>>
>> 2. We don't consider supporting SD in this change.
>>
>>  > On 14/03/2022 19:10, Avri Altman wrote:
>>  >> Here is what our SD system guys wrote:
>>  >> " In SD we don’t support reliable write and this eMMC driver may not
>>  >>    be utilizing the cache feature we added in SD5.0.
>>  >>   The method of cache flush is different between SD and eMMC."
>>  >>
>>  >> So adding SD seems to be out of scope of this change.
>>
>> Is there anything else I can do about this patch? Thanks again.

So we are not going to let the block layer know about SD cache?
Or is it a separate change?
