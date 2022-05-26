Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F905351B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiEZPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiEZPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:55:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2896CDE31F;
        Thu, 26 May 2022 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653580515; x=1685116515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rMKrDH08TcfNZuRlHBlLnu7ad/og3z1jJvc7CIZ0+4I=;
  b=Jgp24VJWIV/8+RD+vx4IAITyQNMsKXzxlOeit447pabH2sqXvJrmMiOS
   nlnUuU4hN8Y3bmFXcgrcAJqunySyuSm/O7+p/tKVaKzC0qMlDGShcvv3s
   MKERBRhKLXTfLhgGRvrphjMP7f2so1qXVTDKNVs2O+G1Uj+0jKSy5u93Y
   zX9R3etS+HBA/v2XHL7SyuecPArW2fSdyctb1h3DcmqCVfbx1JKw0Stea
   5cHav9+Z5kXa5qTxs1gpd0Ildbej4JtKUD2p0igVwCTG/zrZ8y6m4Q8Zi
   O3A+i5rJGdK9lyK5h7//bNRoBGe2Us4/w8F/HJ0AJzBW/9Q3K2xVkUdBE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274201477"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274201477"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 08:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="578920010"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2022 08:55:13 -0700
Received: from [10.252.210.18] (kliang2-MOBL.ccr.corp.intel.com [10.252.210.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B42D3580808;
        Thu, 26 May 2022 08:55:10 -0700 (PDT)
Message-ID: <adf43431-f828-75b2-359e-652c5fc96dc7@linux.intel.com>
Date:   Thu, 26 May 2022 11:55:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        rrichter@amd.com, mingo@redhat.com, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, james.clark@arm.com, leo.yan@linaro.org,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
 <20220523033945.1612-3-ravi.bangoria@amd.com>
 <7c072dd2-de6f-e083-a400-17467d6fe6e8@linux.intel.com>
 <4f7239e2-c065-0800-f679-d4ed797fdecd@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <4f7239e2-c065-0800-f679-d4ed797fdecd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2022 11:08 AM, Ravi Bangoria wrote:
> Hi Kan,
> 
> [...]
> 
>>> +static int write_pmu_caps(struct feat_fd *ff, struct evlist *evlist __maybe_unused)
>>> +{
>>> +    struct perf_pmu_caps *caps = NULL;
>>> +    struct perf_pmu *pmu = NULL;
>>> +    u32 nr_pmus = 0;
>>> +    int ret;
>>> +
>>> +    while ((pmu = perf_pmu__scan(pmu))) {
>>> +        if (!pmu->name || !strncmp(pmu->name, "cpu", 3) ||
>>> +            perf_pmu__caps_parse(pmu) <= 0)
>>> +            continue;
>>> +        nr_pmus++;
>>> +    }
>>> +
>>> +    ret = do_write(ff, &nr_pmus, sizeof(nr_pmus));
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    if (!nr_pmus)
>>> +        return 0;
>>> +
>>> +    while ((pmu = perf_pmu__scan(pmu))) {
>>> +        if (!pmu->name || !strncmp(pmu->name, "cpu", 3) || !pmu->nr_caps)
>>> +            continue;
>>> +
>>> +        ret = do_write_string(ff, pmu->name);
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
>>> +        if (ret < 0)
>>> +            return ret;
>>> +
>>> +        list_for_each_entry(caps, &pmu->caps, list) {
>>> +            ret = do_write_string(ff, caps->name);
>>> +            if (ret < 0)
>>> +                return ret;
>>> +
>>> +            ret = do_write_string(ff, caps->value);
>>> +            if (ret < 0)
>>> +                return ret;
>>> +        }
>>> +    }
>>
>> The write_per_cpu_pmu_caps() also does a similar thing. Can we factor out a generic write_pmu_caps() which works for both cpu and non-cpu pmu capabilities?
> 
> I might be able to do this but..
> 
>> It seems the print_pmu_caps()/process_pmu_caps() can also does similar factor out.
> 
> not this, see below..
> 
>> Actually, more aggressively, why not use the HEADER_PMU_CAPS to replace the HEADER_HYBRID_CPU_PMU_CAPS? The HEADER_HYBRID_CPU_PMU_CAPS is the last header feature. It seems doable. We can always write/print the "cpu_" kind of PMU first to be compatible with the old tools.
> 
> There are some differences in how capabilities are stored in perf.data header
> as well as perf_env. In case of HEADER_CPU_PMU_CAPS or
> HEADER_HYBRID_CPU_PMU_CAPS, all capabilities are stored in a single string
> separated by NULL character. 

I think this is the format for the internal string, not the format of 
the perf.data header.

For the perf.data, here is the existing format for the 
HEADER_HYBRID_CPU_PMU_CAPS.

struct {
	u32 nr_pmu;
	struct {
		u32 nr_cpu_pmu_caps;
		{
			char	name[];
			char	value[];
		} [nr_cpu_pmu_caps];
		char pmu_name[];
	} [nr_pmu];
};

Here is your proposal.

+struct {
+	u32 nr_pmus;
+	struct {
+		char pmu_name[];
+		u32 nr_caps;
+		struct {
+			char name[];
+			char value[];
+		} [nr_caps];
+	} [nr_pmus];
+};

 From my understanding, they are the same. (It doesn't matter where we 
put the char pmu_name[];)

That's also why I think we should merge the HEADER_HYBRID_CPU_PMU_CAPS 
and HEADER_PMU_CAPS. I don't think it make senses to basically handle 
the same thing with different codes.


> Whereas, in case of HEADER_PMU_CAPS, they are
> stored as an array of strings. The reason for this difference is, searching
> in an array is far easier compared to searching in a NULL separated string.

I think the hybrid_cpc_node can be replaced by the env_pmu_caps.
Then you don't need to modify the perf_env__find_pmu_cap().

Thanks,
Kan

> So, I don't think I can extend HEADER_HYBRID_CPU_PMU_CAPS as HEADER_PMU_CAPS
> without adding complexity in perf_env__find_pmu_cap().
> 
> Thanks for the review,
> Ravi
