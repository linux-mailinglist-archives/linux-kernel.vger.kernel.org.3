Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7270C54433A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiFIFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFIFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:39:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6CBB9;
        Wed,  8 Jun 2022 22:39:44 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2594oZrA007235;
        Thu, 9 Jun 2022 05:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EDv8jyraTXFV1hw++h1FdwyA3FCiO7E2HB87LfjQkpU=;
 b=avU1EKVydkzHE0/iHyZv9+eMhEPLlGV86gyO7RN/NWRsil5nWJvVDlk9jAuK/pIJiudj
 LreH1Rx7YdRjAJrkHSDCQ7LXdzOpWAIHzjntxHByiYgjZrdXaog4JbTVLAy98hYQUCQp
 TCzIZyG/aNJKSTicbVMAnRvMVXM4ingBBviOJw0swl9756R6Fr+mHeAeUurCF8lPKazv
 dC0uuXahB6Cd6zLbZbrWRIUixiSv0/QI0epzCxJrOSGFcdN8gSaT9qF8erM5Da35wQB0
 JzlLffw1hfTtZ+VXgTkVKB9GaaGV4pMZLPp7Zlv5asIUVTmUVs6W/eMmzffCGbkoNyVF qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gka6nrrhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:39:31 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2595dU4R005982;
        Thu, 9 Jun 2022 05:39:30 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gka6nrrg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:39:30 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2595JrUB031113;
        Thu, 9 Jun 2022 05:39:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3gfy18w31d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 05:39:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2595dRKY21823904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 05:39:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC173A4059;
        Thu,  9 Jun 2022 05:39:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1C9CA4040;
        Thu,  9 Jun 2022 05:39:16 +0000 (GMT)
Received: from [9.43.103.181] (unknown [9.43.103.181])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 05:39:16 +0000 (GMT)
Message-ID: <4ae75240-0673-5429-2d03-54050e7013c2@linux.ibm.com>
Date:   Thu, 9 Jun 2022 11:09:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/4] libperf evsel: Open shouldn't leak fd on failure
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220609052355.1300162-1-irogers@google.com>
 <20220609052355.1300162-2-irogers@google.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220609052355.1300162-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YNrYLek-BB5zL9Mh_v5ZdutMw0erXPBA
X-Proofpoint-GUID: bByjQRBQuVR01CJOhRdM5AeehKiNPloK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
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



On 6/9/22 10:53, Ian Rogers wrote:
> If the perf_event_open fails the fd is opened but the fd is only freed
> by closing (not by delete). Typically when an open fails you don't call
> close and so this results in a memory leak. To avoid this, add a close
> when open fails.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evsel.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Patch looks fine to me

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index c1d58673f6ef..952f3520d5c2 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -149,23 +149,30 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  			int fd, group_fd, *evsel_fd;
>  
>  			evsel_fd = FD(evsel, idx, thread);
> -			if (evsel_fd == NULL)
> -				return -EINVAL;
> +			if (evsel_fd == NULL) {
> +				err = -EINVAL;
> +				goto out;
> +			}
>  
>  			err = get_group_fd(evsel, idx, thread, &group_fd);
>  			if (err < 0)
> -				return err;
> +				goto out;
>  
>  			fd = sys_perf_event_open(&evsel->attr,
>  						 threads->map[thread].pid,
>  						 cpu, group_fd, 0);
>  
> -			if (fd < 0)
> -				return -errno;
> +			if (fd < 0) {
> +				err = -errno;
> +				goto out;
> +			}
>  
>  			*evsel_fd = fd;
>  		}
>  	}
> +out:
> +	if (err)
> +		perf_evsel__close(evsel);
>  
>  	return err;
>  }
