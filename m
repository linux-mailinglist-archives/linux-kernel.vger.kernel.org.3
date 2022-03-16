Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC64DB5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbiCPQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349953AbiCPQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:10:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA965808;
        Wed, 16 Mar 2022 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647446932; x=1678982932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/8QegcIk90/shkE5eRxvinZRzrjv5RZeBgcX0bqDxMs=;
  b=JPHctJxqcZaF9KzJG60IKf3UPapZqEPCo8HO4QK+8lBseg3f6NeSgWGo
   dPlTqJSACY7xSWvdPvztVVzfomKiQZAY8pJdzkh20LR+Dn4vkSvgYXP24
   v6MKadxNvzbiAOJ5gUqC8V/qnxLROhHkJVRSyr5xj2hV2y7ndUsPNVb49
   P5oJAA+1rTk3HsfL0Q0KnwCVcihv1M3Ux+EsAVJozEWGC57pQ8b/xyGjv
   uIogcp3kxnz4b+UgYWnKBzKsJiX7yjSgImqMfDfnFX9dvdJpLksy2rIkA
   2dHOWLQ7pgbwVxyb6eePBg6X0Ahmrm8sxYvNIhjowFmDZvHm5J0jocUn/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="238809817"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="238809817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:06:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="540987379"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.28])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:05:59 -0700
Message-ID: <a1230f11-a2dd-1959-5444-28c57d3babf6@intel.com>
Date:   Wed, 16 Mar 2022 18:05:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
Content-Language: en-US
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        Avri Altman <Avri.Altman@wdc.com>,
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
 <312d724c-e43f-d766-49fb-9c5b10fe8b07@intel.com>
 <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7ec0cf3e316a4ed9987962b4cbf01604@hyperstone.com>
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

On 16.3.2022 16.46, Christian Löhle wrote:
>> So we are not going to let the block layer know about SD cache?
>> Or is it a separate change?
> 
> I have some code for this laying around, but as it requires reading, parsing and writing Function Registers,
> in particular PEH, it's a lot of boilerplate code to get the functionality, but I'll clean it up and send a patch in the coming weeks.
> 

We have the sd cache flush.  We would presumably just need to call blk_queue_write_cache()
for the !mmc_card_mmc(card) case e.g.

	if (mmc_has_reliable_write(card)) {
		md->flags |= MMC_BLK_REL_WR;
		enable_fua = true;
	}

	if (mmc_cache_enabled(card->host))
		enable_cache = true;

	blk_queue_write_cache(md->queue.queue, enable_cache, enable_fua);

Avri, were you objecting to that?

> 
> 
> 
> 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Sent: Wednesday, March 16, 2022 12:28 PM
> To: Avri Altman; Michael Wu; ulf.hansson@linaro.org; beanhuo@micron.com; porzio@gmail.com
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; allwinner-opensource-support
> Subject: Re: [PATCH] mmc: block: enable cache-flushing when mmc cache is on
>     
> On 16.3.2022 13.09, Avri Altman wrote:
>>> Hi Avril & Adrian,
>>> Thanks for your efforts. Could we have an agreement now --
>>>
>>> 1. enabling-cache and cmd23/reliable-write should be independent;
>>>
>>> Here's what I found in the spec JESD84-B51:
>>>   > 6.6.31 Cache
>>>   > Caching of data shall apply only for the single block
>>>   > read/write(CMD17/24), pre-defined multiple block
>>>   > read/write(CMD23+CMD18/25) and open ended multiple block
>>>   > read/write(CMD18/25+CMD12) commands and excludes any other access
>>>   > e.g., to the register space(e.g., CMD6).
>>> Which means with CMD18/25+CMD12 (without using CMD23), the cache can
>>> also be enabled. Maybe this could be an evidence of the independence
>>> between enabling-cache and cmd23/reliable-write?
>> Acked-by: Avri Altman <avri.altman@wdc.com>
>>
>> Thanks,
>> Avri
>>
>>>
>>> 2. We don't consider supporting SD in this change.
>>>
>>>   > On 14/03/2022 19:10, Avri Altman wrote:
>>>   >> Here is what our SD system guys wrote:
>>>   >> " In SD we don’t support reliable write and this eMMC driver may not
>>>   >>    be utilizing the cache feature we added in SD5.0.
>>>   >>   The method of cache flush is different between SD and eMMC."
>>>   >>
>>>   >> So adding SD seems to be out of scope of this change.
>>>
>>> Is there anything else I can do about this patch? Thanks again.
> 
> So we are not going to let the block layer know about SD cache?
> Or is it a separate change?
>     =
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 

