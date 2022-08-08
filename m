Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEFB58C82B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiHHMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242542AbiHHMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:10:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D055A0;
        Mon,  8 Aug 2022 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659960646; x=1691496646;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PJsJRjP0xD7sFRzhSEFx/9O+fxkSsDfX3HWlgxjQon0=;
  b=cULH9ng+Ev6ta2eKJgduuPrvhel0jkJ02fHT0pSlCgWfZcqUHnrq1+g3
   U7cfGlpu8CRRyiRa1ItJWR6KFRqj43g1FbfpA0slafjeGyvgq4hWqxwD2
   RHhcAfqiSbA3idv2sG0RDoN6SzCQ5r1z+q1xr50WfC/uT2eY52wTD8REK
   aloAXVOC4A0JIBhxw1ypmaByqfhRk7Mb4oCh2NkjyQ5/FHXlosYjCjH5V
   gernCUWwV+oP/R60CdQmEmkDXQfFLXzTTsFGqT43bkQKsHuB4pOU2z65x
   KS31FtZISeoKZRRv4Ewjz450Dlw6KhtTcfKSvh8wFAXXI1dVzzGfouH3J
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="376869370"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="376869370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:10:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663916902"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:10:44 -0700
Message-ID: <cdee60c7-b9d4-74fc-d077-34739483fc3d@intel.com>
Date:   Mon, 8 Aug 2022 15:10:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: block: Dont report successful writes with errors
Content-Language: en-US
To:     Christian Loehle <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
 <992cc198-6c7c-977a-1af8-56665e939cc9@intel.com>
 <a66fe29560f545e18b91af57f4d0dddb@hyperstone.com>
 <95116fcd-a374-d0c7-47f3-10921325e331@intel.com>
 <5ef57568791d4a80987b3cb715bbe9d1@hyperstone.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <5ef57568791d4a80987b3cb715bbe9d1@hyperstone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/22 17:20, Christian Loehle wrote:
> 
>>> If not I would at least add the !mmc_is_host_spi condition for calling mmc_blk_status_error to make it a bit more clear that this function does do what is intended for SPI cards.
>>
>> I am not sure what you mean.  Isn't it OK to check CMD13 response for SPI?
> 
> You can do that for sure, but e.g. without some knowledge about what state you're in it doesn't tell you a lot.
> If you get all zeroes after a write e.g., you cannot always tell if the SPI card is holding the line LOW because of busy[*], or you actually got an SPI R2 with no error bits set. (The CMD12 = ILLEGAL assert would fix it, but now all cards behave this way and the spec doesn't mandate it.)
> It cannot really be dealt with in a nice manner.
> Furthermore cards are, according to spec, free to treat cmd13 as ILLEGAL during data state.
> If so, that's nice for us, we get a 0x4 back and know we have to fix state, some cards also
> accept CMD13 (no error bits set), perfectly legal, but we don't know if we should fix state or not.
> (Furthermore, how to fix state is then dependent on the issued (e.g. timedout command)
> 
> *The SD SPI spec e.g. says in 7.2.8 that a CMD13 must ALWAYS be responded to, but that is clearly not the intention of the spec, a card always listening for CMD13 in RCV state simply doesn't make sense.

Note, my comments were structural, not functional:
	- use mmc_blk_status_error() to check the status only, since that is what that function is for,
	- make the brq->data.error check a separate patch since it needs its own explanation

WRT getting SPI error handling to work the way you need, that is up to you,
so long as there is a reasonable explanation.
