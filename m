Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2646FD75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhLJJP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:15:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhLJJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:15:58 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA6wdaL040191;
        Fri, 10 Dec 2021 09:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BsXP9UVCLcAFtZkosEH2P+zvjgKhRwjP/47j/E1kryc=;
 b=dQRqDCTdAn6niEA9VTfkjJ2jYMOymvFIKPNmcd0gHT2hlldlPkr1Ejs0K5TLRyDjugR5
 YEy7t10CdBvx5o7V7p0+cbxN4ZpO+7rGfiA83MM2d6+/9ub4YNRygdpUYlVgg0hZdyIU
 2/oA1COIoNpdKVrG6U8drQLjjeZn8TR0ln8mBlN9cLiPLYw1dQFHOlvN+Jxz7LNOMxuS
 wesevpnTYD5KvvC8bBi1b5Y7i+cwDkfSYri5QqwGhxoWewHY1OUspz4qABtcAQesFyt7
 qhHrva9b1hgR0Csb/7GA++6Kwbtw2FpEVmIhPFMdCXVAvo5pi+G2UFbQFAeyQq6mRzr7 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv23njg4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 09:12:06 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BA904AU003331;
        Fri, 10 Dec 2021 09:12:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv23njg45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 09:12:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BA9BYUH031424;
        Fri, 10 Dec 2021 09:12:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3cqyybh8w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 09:12:03 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BA9C0HC27984320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 09:12:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55BC1A405B;
        Fri, 10 Dec 2021 09:12:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B0FA4066;
        Fri, 10 Dec 2021 09:11:56 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.86.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 09:11:56 +0000 (GMT)
Subject: Re: [PATCH] tools/perf: remove unneeded variable make code cleaner
To:     cgel.zte@gmail.com, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, chi.minghao@zte.com.cn,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
References: <20211210022911.424512-1-chi.minghao@zte.com.cn>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <708b524c-2af5-98a1-f56a-4bb4f268de7a@linux.ibm.com>
Date:   Fri, 10 Dec 2021 14:41:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210022911.424512-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ZWxi_GHZuSkWBuqrymKYVn23-hj7AyD
X-Proofpoint-GUID: 4SEUWh7V6MbxbA7xixaRJdpt6tYvgGVW
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



On 12/10/21 7:59 AM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> return value form directly instead of
> taking this in another redundant variable.

Can we reword the commit message stating what and
from where we are removing it. Its not too clear.
Other than that patch looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  tools/perf/util/callchain.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 8e2777133bd9..ed30da7e14ab 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1301,24 +1301,16 @@ int callchain_branch_counts(struct callchain_root *root,
>  
>  static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int bfsize)
>  {
> -	int printed;
> -
> -	printed = scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
> -
> -	return printed;
> +	return scnprintf(bf, bfsize, "%s%s:%" PRId64 "", (idx) ? " " : " (", str, value);
>  }
>  
>  static int count_float_printf(int idx, const char *str, float value,
>  			      char *bf, int bfsize, float threshold)
>  {
> -	int printed;
> -
>  	if (threshold != 0.0 && value < threshold)
>  		return 0;
>  
> -	printed = scnprintf(bf, bfsize, "%s%s:%.1f%%", (idx) ? " " : " (", str, value);
> -
> -	return printed;
> +	return scnprintf(bf, bfsize, "%s%s:%.1f%%", (idx) ? " " : " (", str, value);
>  }
>  
>  static int branch_to_str(char *bf, int bfsize,
> 
