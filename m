Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4949957B0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiGTF6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiGTF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:58:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9F5508D;
        Tue, 19 Jul 2022 22:58:10 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K5mcFZ029228;
        Wed, 20 Jul 2022 05:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uJiofIb2YfK+NiHiju7AHQCKT2vbWMAgX669Dw+AL3c=;
 b=ZX2Uhq8RO2bM6uVn7ZqnttoPvHSZdLMhY16i4yy5ju8/1DhkGbK9V30lGIZ/S4U/tQPj
 l3zMnsXVF7GK/3yuie/hvKjH4TQIktvaYtWkTj6kMm4Q/5qdSZbulMMjU5KY8oVmFvB+
 xdcR8YnLw6x/u5EI82ANfb954I1IzCWesZRNFhs2czi0/YWG3aGhXCBRLNf42pa4MgJS
 /MxAeSYSvFS7c2GA7C7lxyhOXim4Hjbh7Gq2qWQunEUxGl29A5NLpqMMehsC5YB43Sd/
 HK+XOMXRcN84OTIzubo+sm2yK9mDpmLSB/KoYp41l59qiP1RmzcjJoLZ40VkDoZR1wzU Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hebvv85cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 05:57:19 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K5tAYj025516;
        Wed, 20 Jul 2022 05:57:18 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hebvv85bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 05:57:18 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K5oliM030103;
        Wed, 20 Jul 2022 05:57:16 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj56ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 05:57:15 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K5vDfh23200066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 05:57:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E5FC4203F;
        Wed, 20 Jul 2022 05:57:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B7E42042;
        Wed, 20 Jul 2022 05:57:05 +0000 (GMT)
Received: from [9.43.48.169] (unknown [9.43.48.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 05:57:04 +0000 (GMT)
Message-ID: <1c3fc908-860b-0274-832a-dd7d091c5463@linux.ibm.com>
Date:   Wed, 20 Jul 2022 11:27:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 0/4] Rewrite jevents program in python
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220629182505.406269-1-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220629182505.406269-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: moM3zxcNU6cOv-1ZyXdZWpwMuZGNLp34
X-Proofpoint-ORIG-GUID: WJEYRKqAdONssmTYwiuyTWFQo4w-YAeN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_02,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/22 23:55, Ian Rogers wrote:
> New architectures bring new complexity, such as Intel's hybrid
> models. jevents provides an alternative to specifying events in the
> kernel and exposing them through sysfs, however, it is difficult to
> work with. For example, an error in the json input would yield an
> error message but no json file or location. It is also a challenge to
> update jsmn.c given its forked nature.
> 
> The changes here switch from jevents.c to a rewrite in python called
> jevents.py. This means there is a build time dependency on python, but
> such a dependency already exists for asciidoc (used to generate perf's
> man pages). If the build detects that python isn't present or is older
> than version 3.6 (released Dec. 2016) then an empty file is
> substituted for the generated one.
> 
> A challenge with this code is in avoiding regressions. For this reason
> the jevents.py produces identical output to jevents.c, validated with a
> test script and build target.
> 

Patchset looks good to me.

Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
Tested-by: Kajol Jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

> v7. Adds Tested-by from John Garry <john.garry@huawei.com>.
> v6. Adds Tested-by from Zhengjun Xing <zhengjun.xing@linux.intel.com>
>     and Thomas Richter <tmricht@linux.ibm.com>. Fixes issues spotted
>     by Jiri Olsa <jolsa@kernel.org>, jsmn.c wasn't deleted and the
>     empty pmu-events.c didn't pass the pmu-events test. It also adds a
>     missing mkdir which is necessary before creating pmu-events.c and
>     tweaks the quiet display code in the empty case to display a gen.
> v5. Adds a 2>/dev/null as suggested by David Laight
>     <David.Laight@aculab.com>.
> v4. Fixes the build for systems with python2 installed by adding a
>     patch that makes python3 the preferred python (Reported-by: John
>     Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
>     jevents-test.sh and fixes the handling of an empty string for a
>     metric BriefDescription as one was added for sapphirerapids in the
>     metric Execute.
> v3. Updates the patches for merged changes (on
>     acme/tmp.perf/core). Re-runs all comparisons to make sure the
>     generated pmu-events.c isn't altered at all by this change. Adds
>     the jevents.c ExtSel fix in:
>     https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
>     Bumps the python version from 3.5 to 3.6, as f-strings weren't
>     introduced until 3.6.
> v2. Fixes the build for architectures that don't have pmu-events json
>     (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
>     build for python not being present or too old (Suggested-by: Peter
>     Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).
> 
> Ian Rogers (4):
>   perf python: Prefer python3
>   perf jevents: Add python converter script
>   perf jevents: Switch build to use jevents.py
>   perf jevents: Remove jevents.c
> 
>  tools/perf/Makefile.config               |   27 +-
>  tools/perf/Makefile.perf                 |   16 +-
>  tools/perf/pmu-events/Build              |   17 +-
>  tools/perf/pmu-events/empty-pmu-events.c |  158 +++
>  tools/perf/pmu-events/jevents.c          | 1342 ----------------------
>  tools/perf/pmu-events/jevents.py         |  409 +++++++
>  tools/perf/pmu-events/jsmn.c             |  352 ------
>  tools/perf/pmu-events/jsmn.h             |   68 --
>  tools/perf/pmu-events/json.c             |  162 ---
>  tools/perf/pmu-events/json.h             |   39 -
>  10 files changed, 604 insertions(+), 1986 deletions(-)
>  create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
>  delete mode 100644 tools/perf/pmu-events/jevents.c
>  create mode 100755 tools/perf/pmu-events/jevents.py
>  delete mode 100644 tools/perf/pmu-events/jsmn.c
>  delete mode 100644 tools/perf/pmu-events/jsmn.h
>  delete mode 100644 tools/perf/pmu-events/json.c
>  delete mode 100644 tools/perf/pmu-events/json.h
> 
