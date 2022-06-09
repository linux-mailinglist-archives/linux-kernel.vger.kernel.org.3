Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F1544345
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiFIFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiFIFrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:47:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075523B557;
        Wed,  8 Jun 2022 22:47:16 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2591oqkb013192;
        Thu, 9 Jun 2022 05:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rD56XwPfwvcJV4OHj2qj5QBJ52b3u8YlSv/aLwOv1wg=;
 b=r19LGA28+1bQcqzdrKx/9GXa2nEpy1YiIaAiyzxEPT24A/yfy5wLdsoP7f4KlWEtkRAO
 7mGGsNzSAYC/sdiB+hTbnFE/0w4u1Q4kTpbiaYktN+6sHfAWz0Lr24w19j5Vp9z4M4rm
 dPxf8tVK8yLwCMyHlyWamX9lZZfunwNukaulYxSRhNBZOx3T2AB8y6PNdEJ3y6TRgTMx
 t7PnvqX5CKUjBg2Xz0b3QTg9FVJcodfV1dCkOclcfupvBPsGB+Q2zTss9YSPHtAE/Ub8
 nyL8pKr+C8Va6WmDDsgdLz6LkxhDXp6VqLfNr89EcfIbo747+LtZI1wew7TQQ9hiMkd+ Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gk7jdu9x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:47:09 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2595XQxn005197;
        Thu, 9 Jun 2022 05:47:08 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gk7jdu9wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:47:08 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2595KxIT002469;
        Thu, 9 Jun 2022 05:47:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3gfy18w303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:47:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2595l3u023069132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 05:47:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B888A4051;
        Thu,  9 Jun 2022 05:47:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C15AA4040;
        Thu,  9 Jun 2022 05:46:56 +0000 (GMT)
Received: from [9.43.103.181] (unknown [9.43.103.181])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 05:46:55 +0000 (GMT)
Message-ID: <a959de1b-c938-0e9f-73a4-89fbeb33cf97@linux.ibm.com>
Date:   Thu, 9 Jun 2022 11:16:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] perf expr: Allow exponents on floating point values
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220527020653.4160884-1-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220527020653.4160884-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H_QwSiLXt6k68kLg2VPpyXEqYKm2bJX_
X-Proofpoint-ORIG-GUID: EviJm1Zwh2pOqkriU8fUbMjnPGrK-Ef5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090020
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks fine to me

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>


On 5/27/22 07:36, Ian Rogers wrote:
> Pass the optional exponent component through to strtod that already
> supports it. We already have exponents in ScaleUnit and so this adds
> uniformity.
> 
> Reported-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 2 ++
>  tools/perf/util/expr.l  | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index d54c5371c6a6..5c0032fe93ae 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -97,6 +97,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	ret |= test(ctx, "2.2 > 2.2", 0);
>  	ret |= test(ctx, "2.2 < 1.1", 0);
>  	ret |= test(ctx, "1.1 > 2.2", 0);
> +	ret |= test(ctx, "1.1e10 < 1.1e100", 1);
> +	ret |= test(ctx, "1.1e2 > 1.1e-2", 1);
>  
>  	if (ret) {
>  		expr__ctx_free(ctx);
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 0a13eb20c814..4dc8edbfd9ce 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -91,7 +91,7 @@ static int literal(yyscan_t scanner)
>  }
>  %}
>  
> -number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
> +number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)(e-?[0-9]+)?
>  
>  sch		[-,=]
>  spec		\\{sch}
