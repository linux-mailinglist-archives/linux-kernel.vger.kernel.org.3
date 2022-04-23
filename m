Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369BE50CA3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiDWM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiDWM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:56:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6B261;
        Sat, 23 Apr 2022 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650718415; x=1682254415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OBOX3LfVl7XRiJUyCXwa9+7Ll3XU3H92WTMvH//IWQI=;
  b=l7GWD2fnnI50zocnpRhEfFmFafQ/ut9XNgxakJkLaH0ArIUl9JXcYxys
   VRoVKwSNSrL3LWkxIOsj9BL8pzfsZaueuOIg/wit1C9cRE/PbCwc6dnaj
   VJZpd06k06CimVcsYAPFXYPCsznZ1LTHZDd5wWjmv27j/frxGxiv58cx5
   sGMqZEW+aXbsz0bIpW6e0VUIfMXHKlL8OrhvGljwrgl8O3LSWcIxvQk4D
   suy5h7qLz8uzKS40UKbohcGN1vD6M0lXGZlSYlh6VTXeF2X4Ts+GSWWDt
   9SbPtBIv7cHH9i3qVTwPpBQQZKj1mWEICBSj1JzHxVFnP238lgMtY0pAM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244818048"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="244818048"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 05:53:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="556858428"
Received: from vietqle-mobl1.amr.corp.intel.com (HELO [10.212.229.58]) ([10.212.229.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 05:53:33 -0700
Message-ID: <8e09af67-a416-4ead-b406-6c8b998de344@linux.intel.com>
Date:   Sat, 23 Apr 2022 05:53:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>
Cc:     kan.liang@linux.intel.com, Nick.Forrington@arm.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, benh@kernel.crashing.org,
        german.gomez@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
 <20220422212249.22463-1-alisaidi@amazon.com>
 <20220423063805.GA559531@leoy-ThinkPad-X240s>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220423063805.GA559531@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Except SNOOPX_FWD means a no modified cache snooping, it also means it's
> a cache conherency from *remote* socket.  This is quite different from we
> define SNOOPX_PEER, which only snoop from peer CPU or clusters.
>
> If no objection, I prefer we could keep the new snoop type SNOOPX_PEER,
> this would be easier for us to distinguish the semantics and support the
> statistics for SNOOPX_FWD and SNOOPX_PEER separately.
>
> I overlooked the flag SNOOPX_FWD, thanks a lot for Kan's reminding.

Yes seems better to keep using a separate flag if they don't exactly match.

It's not that we're short on flags anyways.

-Andi

