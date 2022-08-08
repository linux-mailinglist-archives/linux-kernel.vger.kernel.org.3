Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DC58CF6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbiHHUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHHUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:52:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3236D15A2E;
        Mon,  8 Aug 2022 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659991933; x=1691527933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bhQT0u3PtjrFfLcjH/tloZ3NCQW+htlKfL1vcZlonW0=;
  b=NeGbsFZlv8AplYyGkMUkDJ8ywZumlA1SOlT8Qmps8lLGZHsiRFMkthHP
   qNX+2VJR5FJrGJCAQT/5+r5lPe0MyNtuL643ZCp+/fvAJBRRlJWU0TPGM
   14DoAo4f6U8o3jvtWUnLBsqXQRs4T9DBGM/Nwfnsa1pPXTR50EsT1bBPy
   H6a55PG/yWJCQdimfwluN0HkS4MQN3eS+wSwPyxjg1v4OiRYvTDP2zzBg
   l6ya3AK/KZWgRbPnVf/dx+luOycLCYOgNARCjei+mXVq6Hfij7/07Mz3v
   MxpyhDvPx3wO7Hr65lGtBl/DMiJ/y6kKx6cDy54thCakgte4LS/zqddOa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270465458"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270465458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:52:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746786724"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.34.69]) ([10.212.34.69])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:52:09 -0700
Message-ID: <750f836b-2e31-da48-3c72-94be44efb9e4@intel.com>
Date:   Mon, 8 Aug 2022 13:52:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/2] cxl: BG operations and device sanitation
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        bwidawsk@kernel.org, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org
References: <20220804045029.2905056-1-dave@stgolabs.net>
 <bcbe1db2-cb8e-1889-2888-f4618d749bd4@intel.com>
 <20220804200712.gaiswmkjsa3pnkc5@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220804200712.gaiswmkjsa3pnkc5@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/2022 1:07 PM, Davidlohr Bueso wrote:
> On Thu, 04 Aug 2022, Dave Jiang wrote:
>
>> From the operational sense everything looks good to me. As for the
>> polling delay on overwrite, with pre-CXL pmem on Optane, we've
>> discovered that overwrite can take a long time depending on the size.
>> Sometimes MANY hours if the size is really large. We just opted to
>> increment the polling interval as time went on [1] instead of based on
>> size.
>
> Thanks for having a look. Sure, we can do that, I have no particular 
> attachment
> to doing it based on size (it's just the way it occured to me). I am 
> curious,
> though: While regardless of size vs time based estimates, are the numbers
> expected to be similar for volatile regions? All these numbers being from
> nvdimm DSM docs.

I don't either. Just pointing out that's what we did with the Optane 
stuff. I think that the volatile devices (DRAM?) would probably be a lot 
faster when it comes to writes. So maybe won't take as long. And also 
perhaps smaller in size in the immediate future? Just guessing.


>
> Thanks,
> Davidlohr
