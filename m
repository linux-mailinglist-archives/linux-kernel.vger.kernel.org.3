Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98150C355
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiDVWTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiDVWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:17:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394DA325835;
        Fri, 22 Apr 2022 14:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650661719; x=1682197719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mnJlzMRuA2xcyrsUtKJwoToHi8lzCbaFKElkF30JqEg=;
  b=H/Z0pzoPofmOjKpkUa8959IiuKO2bZjLxIzXQk9iyviy9e5N8EszG9QV
   PQNBezj7tGLczxCn0spoW4s/QmdqhafSqJLi/0EjHydksgM1tD3e44UDK
   vQPj3ZI9ZtZ/GW0zrY4ySw9Fk0eUdB6QmpuX+If4vU/Jc4vX/VAEREbfo
   PIahefXkLVChPJReIitEzLz/EH5yRSYkIDBKj+cNuQyDfg4EjoglDTswK
   /Vo6ns7Ow2h31eNLQAFLH9DrMpBkJlmYkTYWe15k6sUYfU8S+DvVVNpVc
   PE5eCsVmKYcxwGTVQqguIu0S6oyGWKNDKcRLMBfeXGlFtarg3+k5wFy6G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351236493"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="351236493"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="703707316"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 22 Apr 2022 14:08:38 -0700
Received: from [10.212.135.29] (kliang2-MOBL.ccr.corp.intel.com [10.212.135.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C9B2C580A85;
        Fri, 22 Apr 2022 14:08:35 -0700 (PDT)
Message-ID: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
Date:   Fri, 22 Apr 2022 17:08:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Content-Language: en-US
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     Nick.Forrington@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, german.gomez@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, leo.yan@linaro.org, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org,
        Andi Kleen <ak@linux.intel.com>
References: <a96681b5-5532-470e-17d1-afe4c8d195ad@linux.intel.com>
 <20220422184934.29270-1-alisaidi@amazon.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220422184934.29270-1-alisaidi@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2022 2:49 PM, Ali Saidi wrote:
> On Wed, 20 Apr 2022 18:43:28, Kan Liang wrote:
>> On 4/8/2022 3:53 PM, Ali Saidi wrote:
>>> Add a flag to the perf mem data struct to signal that a request caused a
>>> cache-to-cache transfer of a line from a peer of the requestor and
>>> wasn't sourced from a lower cache level.
>>
>> It sounds similar to the Forward state. Why can't the
>> PERF_MEM_SNOOPX_FWD be reused?
> 
> Is there a definition of SNOOPX_FWD i can refer to? Happy to use this instead if
> the semantics align between architectures.
> 

+ Andi

As my understanding, the SNOOPX_FWD means the Forward state, which is a 
non-modified (clean) cache-to-cache copy.
https://en.wikipedia.org/wiki/MESIF_protocol

Thanks,
Kan
