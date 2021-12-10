Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE6546FD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhLJJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:21:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233028AbhLJJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:21:50 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA6wbUV040152;
        Fri, 10 Dec 2021 09:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sCUp2gunpgsst+Ptkr0udx0VT2ivxJ/IAL0EVGqMlw8=;
 b=P9ACkXV32i6ejvxsr8YthLLr35rCLRZ75dW5EmHut9PztuV0NMkX/sepfJFLtYltAoxq
 9vFUq/RPXSa1zC13NpNyFBcpQCiaDhu6bGP9k7UgVrntzrRe4QSZxu5NTgKoOE/7LobR
 0PkJoAPocNMgx+5ZBu12yP9slPjkwG5fV9FmYqbzuLkyFG1cyoBzGYlYLZhIGL6hB72H
 /WMLyBD9rX8ej2Q5GV91WVVoU+wP75svY3xW0nCK0mwzUMTzWkIb12BG2qQV0wmzIlle
 CzPyJaRSUJQ4Gqkl5/jKEGN2Nhx6YIF1RDYI2qwSVVSBgI/9kPqee5TRB+r3K7mcz4v9 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv23njkee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 09:18:02 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BA7RgrO021771;
        Fri, 10 Dec 2021 09:18:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv23njkdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 09:18:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BA9EC7j030790;
        Fri, 10 Dec 2021 09:17:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cqyyasbdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 09:17:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BA9Hu8s32571702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 09:17:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E41A9A405F;
        Fri, 10 Dec 2021 09:17:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B24F7A4062;
        Fri, 10 Dec 2021 09:17:50 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.86.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 09:17:50 +0000 (GMT)
Subject: Re: [PATCH v1 1/4] perf tools: Prevent out-of-bounds access to
 registers
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-2-german.gomez@arm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <6705021e-5b02-3323-7dbc-4b774f22a435@linux.ibm.com>
Date:   Fri, 10 Dec 2021 14:47:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201123334.679131-2-german.gomez@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3VwXn0xGApwvvGnybtVArkK_c3fXbUfh
X-Proofpoint-GUID: S8D0NhTU3ovY96fl9qCknqis3HFEGLgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/21 6:03 PM, German Gomez wrote:
> The size of the cache of register values is arch-dependant
> (PERF_REGS_MAX). This has the potential of causing an out-of-bounds
> access in the function "perf_reg_value" if the local architecture
> contains less registers than the one the perf.data file was recorded on.
> 
> Since the maximum number of registers is bound by the bitmask "u64
> cache_mask", and the size of the cache when running under x86 systems is
> 64 already, fix the size to 64 and add a range-check to the function
> "perf_reg_value" to prevent out-of-bounds access.
> 

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/event.h     | 5 ++++-
>  tools/perf/util/perf_regs.c | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 95ffed663..c59331eea 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -44,13 +44,16 @@ struct perf_event_attr;
>  /* perf sample has 16 bits size limit */
>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>  
> +/* number of register is bound by the number of bits in regs_dump::mask (64) */
> +#define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
> +
>  struct regs_dump {
>  	u64 abi;
>  	u64 mask;
>  	u64 *regs;
>  
>  	/* Cached values/mask filled by first register access. */
> -	u64 cache_regs[PERF_REGS_MAX];
> +	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
>  	u64 cache_mask;
>  };
>  
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 5ee47ae15..06a7461ba 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -25,6 +25,9 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
>  	int i, idx = 0;
>  	u64 mask = regs->mask;
>  
> +	if ((u64)id >= PERF_SAMPLE_REGS_CACHE_SIZE)
> +		return -EINVAL;
> +
>  	if (regs->cache_mask & (1ULL << id))
>  		goto out;
>  
> 
