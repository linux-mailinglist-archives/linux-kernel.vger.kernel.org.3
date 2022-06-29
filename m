Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514FF5606CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiF2Q4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2Q4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:56:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D442250C;
        Wed, 29 Jun 2022 09:56:42 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY6xl5sYcz6H6rt;
        Thu, 30 Jun 2022 00:54:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:56:40 +0200
Received: from [10.195.244.164] (10.195.244.164) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 17:56:39 +0100
Message-ID: <26fb5fec-500d-61c2-f009-556c5f7e86e6@huawei.com>
Date:   Wed, 29 Jun 2022 17:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 2/4] perf jevents: Add python converter script
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        "Felix Fietkau" <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
CC:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20220627025744.106527-1-irogers@google.com>
 <20220627025744.106527-3-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220627025744.106527-3-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.164]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 03:57, Ian Rogers wrote:
> +
> +    def unit_to_pmu(unit: str) -> str:
> +      """Convert a JSON Unit to Linux PMU name."""
> +      if not unit:
> +        return None
> +      # Comment brought over from jevents.c:
> +      # it's not realistic to keep adding these, we need something more scalable ...

Since we're converting to python it might be a good idea to consider 
this - ever have an ideas on something better?

Thanks,
John

> +      table = {
> +          'CBO': 'uncore_cbox',
> +          'QPI LL': 'uncore_qpi',
> +          'SBO': 'uncore_sbox',
> +          'iMPH-U': 'uncore_arb',
> +          'CPU-M-CF': 'cpum_cf',
> +          'CPU-M-SF': 'cpum_sf',
> +          'UPI LL': 'uncore_upi',
> +          'hisi_sicl,cpa': 'hisi_sicl,cpa',
> +          'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> +          'hisi_sccl,hha': 'hisi_sccl,hha',
> +          'hisi_sccl,l3c': 'hisi_sccl,l3c',
> +          'imx8_ddr': 'imx8_ddr',
> +          'L3PMC': 'amd_l3',
> +          'DFPMC': 'amd_df',
> +          'cpu_core': 'cpu_core',
> +          'cpu_atom': 'cpu_atom',
> +      }
> +      return table[unit] if unit in table else f'uncore_{unit.lower()}'
> +

