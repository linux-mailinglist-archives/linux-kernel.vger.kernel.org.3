Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684175A2824
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbiHZM6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:58:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135125D0D3;
        Fri, 26 Aug 2022 05:58:45 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QCfpF8034558;
        Fri, 26 Aug 2022 12:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JUvVbFgb3369Nhi1ivAk/Xyry4AjX+gGSfQseyMHBYw=;
 b=LbBHP6qE1ooQTD/CSXp1O9KyUFDl41GrJmmug0Jb0JcgM4FyzTsHHehEyPNYYWUcqYd1
 ad+j3L/5TJEKlOCuxu61k0h52c3RtBlYX8jfe7ZgdcSgifTYiOTSRKS/Pl0yuWbDIOUP
 /V3JEmXCg9uf36Q8SzBm+h5q031AhzmRZQgJn3hFeAM6kMEy8di/8URyLqm8QwC94T1w
 /O1nj1A3nwLRjDlYNEc0s4VfcYDFW96u1Xzcu3t///4knDLzygPPlJPRnGFO8AlBsx61
 KET5ba0MPOcTeS2HiMJX+9VJvfrUa33njTqqzRFuL41ARMWGWV60+CBXlgJufpZUHuBm bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6x70rggb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:57:26 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27QCg12F034898;
        Fri, 26 Aug 2022 12:57:25 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6x70rgfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:57:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27QCp6ZK027844;
        Fri, 26 Aug 2022 12:57:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3j2q88wppn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:57:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27QCvfnW30540032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 12:57:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A359E5204E;
        Fri, 26 Aug 2022 12:57:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0755252050;
        Fri, 26 Aug 2022 12:57:20 +0000 (GMT)
Date:   Fri, 26 Aug 2022 14:57:18 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event
 encoding
Message-ID: <YwjDLl8QXQzaCYaS@tuxmaker.boeblingen.de.ibm.com>
References: <20220614143353.1559597-1-irogers@google.com>
 <20220614143353.1559597-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614143353.1559597-5-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ni8eP2UL1PtshvZUllReDI7B2-JM23NS
X-Proofpoint-GUID: GqoI1u7sry_i2E8Yk2I2pODVvVaZfjiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_06,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=931 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers wrote:

Hi Ian,

Although it is committed, still have a question.

> index e7758707cadd..d2d32589758a 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  #include <linux/limits.h>
>  #include <linux/bpf.h>
> +#include <linux/compiler.h>

Is it correct approach to include it into user-exposed headers?
AFAICT headers_install.sh strips #include <linux/compiler.h> and
compiler*.h itself do not get installed with make headers_install.

[...]

> +struct __packed perf_record_cpu_map_data {

And it is only needed to pull __packed macro, right?

Thanks!
