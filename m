Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458A756B488
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiGHIcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiGHIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:32:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728458238F;
        Fri,  8 Jul 2022 01:32:18 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2688Ttqv029870;
        Fri, 8 Jul 2022 08:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dHzoABMdFE8XEKTymXMUuxjuP3z7HbIjG6GmfQRPD8Q=;
 b=jfPvBh5SeNSwT0AvJCO98SWs9pi+ZnPth2+eZL+CY8HNDkz9lfTpBwZhFNfdGgfdLkHv
 D7kSMgaNO7JFCP78IoHRtUdgzYjLOpRSJvi9d/a/vYMTFFFYNqFoSJMw8/KLjXn4RD7q
 HtXmABzm2ljBIdVU7KyS+atwq72LPQnrx3vzCCBHMZs+hxzTPRUOgIGlOTrXQAI4kPSM
 iTCRAM8Fe9JuYyNW+rvyrA83LJzTSDKW2+WJdYwlzA0hWmgVBZkGW1caPGzbDYn5xNKO
 Orb8+okKcBgtVLne6F8LyYGdmyjwdzU3WWu74KLkJwWWAbnJjvKTAuUDzUg7Q7Mvy7eq EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6h4fg15d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:31:18 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2688UlSD000429;
        Fri, 8 Jul 2022 08:31:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h6h4fg13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:31:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2688LqGo027759;
        Fri, 8 Jul 2022 08:31:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4juq71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 08:31:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2688VBds16187856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Jul 2022 08:31:11 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0C1311C05B;
        Fri,  8 Jul 2022 08:31:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEEF11C050;
        Fri,  8 Jul 2022 08:31:11 +0000 (GMT)
Received: from [9.145.4.47] (unknown [9.145.4.47])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jul 2022 08:31:11 +0000 (GMT)
Message-ID: <0bc35725-43eb-271c-d66e-ca11e5001794@linux.ibm.com>
Date:   Fri, 8 Jul 2022 10:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/2] perf test: Json format checking
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220707201213.331663-1-irogers@google.com>
 <20220707201213.331663-3-irogers@google.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220707201213.331663-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mgqVWLhs-H3cIg8cudiINcoDB65u7bOC
X-Proofpoint-GUID: GjnDGMYcxOkI3bcHwvCMqoxdwPo5WNtx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207080032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 22:12, Ian Rogers wrote:
> From: Claire Jensen <cjense@google.com>
> 
> Add field checking tests for perf stat JSON output.
> Sanity checks the expected number of fields are present, that the
> expected keys are present and they have the correct values.
> 
> Signed-off-by: Claire Jensen <cjense@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../tests/shell/lib/perf_json_output_lint.py  |  95 +++++++++++
>  tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
>  2 files changed, 242 insertions(+)
>  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
>  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
> 
....
I wonder if it is really necessary to have a python file to post process the
perf stat output?

With
commit 7473ee56dbc9 ("perf test: Add checking for perf stat CSV output.")
the same approach was done which led to issues on s390 and required an additional
patch to fix this:
commit ec906102e5b7 ("perf test: Fix "perf stat CSV output linter" test on s390").

I wonder if you can do the perf stat output checking using bash/linux tools as it
was done in commit ec906102e5b7. This would make maintenance much easier.

Just me 2 cents...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
