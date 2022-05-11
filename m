Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97FC522BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiEKFps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiEKFpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:45:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B42B0;
        Tue, 10 May 2022 22:45:42 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B3Y4ML007404;
        Wed, 11 May 2022 05:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TzAOhHLYqcSGYPfdSZ263v2RrG4tRB9OjEW+MIsWIss=;
 b=UiejOxmNuvQOfLT0TOvdNvTQnyZtUxU1rhlRlpMmciVzAfOS+BmPcb3iHw2Yz/PBSgcF
 Y64HgbzOuwr7DWgSzmz+fZjv9U1uf2Kv31erKc+w5Fnk5SNTGWEJXGIWp0WTFC7jsdKx
 xwNn0GyI+7dS40NH6bBDYDDnFjH4bVX1KqJjBSJRz3lEZICn6IFG+ywaBW6Cferv8A4U
 Jg0tK0O8sZ+rC/67uIQUyYaGRE/aT1nuGSouNZ/pfePBpekfFSNn8Rj/XY74r7WuPMRc
 hvYR7gFyKWbsM8LQeDcj9bOn3WBZUxCJ4NF7Kb8ireKGX1GB2TqSZYRFJ37KdGBSdxlJ vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g05bs9qe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 05:45:22 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24B5jLT3004209;
        Wed, 11 May 2022 05:45:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g05bs9qdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 05:45:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24B5h2uA003637;
        Wed, 11 May 2022 05:45:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8vy4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 05:45:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24B5jHj232178534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 05:45:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 286074C04A;
        Wed, 11 May 2022 05:45:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E27CC4C046;
        Wed, 11 May 2022 05:45:09 +0000 (GMT)
Received: from [9.43.104.77] (unknown [9.43.104.77])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 05:45:09 +0000 (GMT)
Message-ID: <5cb1514a-3f68-d790-4f1f-0856de73b814@linux.ibm.com>
Date:   Wed, 11 May 2022 11:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 3/5] perf mem: Print snoop peer flag
Content-Language: en-US
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, acme@kernel.org
Cc:     benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
References: <20220504184850.24986-1-alisaidi@amazon.com>
 <20220504184850.24986-4-alisaidi@amazon.com>
From:   kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20220504184850.24986-4-alisaidi@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1ZSmooWNbrsT4L_FUe2Hw7c9sA5VlSv9
X-Proofpoint-ORIG-GUID: Ecofb3iS1se9atKYNVWXW8q1jDgo0q5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_01,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110025
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/22 00:18, Ali Saidi wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> Since PERF_MEM_SNOOPX_PEER flag is a new snoop type, print this flag if
> it is set.
> 
> Before:
>        memstress  3603 [020]   122.463754:          1            l1d-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1          l1d-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1            llc-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1          llc-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1          tlb-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1              memory:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
> 
> After:
> 
>        memstress  3603 [020]   122.463754:          1            l1d-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1          l1d-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1            llc-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1          llc-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1          tlb-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
>        memstress  3603 [020]   122.463754:          1              memory:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Ali Saidi <alisaidi@amazon.com>
> Tested-by: Ali Saidi <alisaidi@amazon.com>

Patch looks good to me.

Reviewed-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> ---
>  tools/perf/util/mem-events.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index efaf263464b9..db5225caaabe 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -410,6 +410,11 @@ static const char * const snoop_access[] = {
>  	"HitM",
>  };
>  
> +static const char * const snoopx_access[] = {
> +	"Fwd",
> +	"Peer",
> +};
> +
>  int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>  {
>  	size_t i, l = 0;
> @@ -430,13 +435,20 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
>  		}
>  		l += scnprintf(out + l, sz - l, snoop_access[i]);
>  	}
> -	if (mem_info &&
> -	     (mem_info->data_src.mem_snoopx & PERF_MEM_SNOOPX_FWD)) {
> +
> +	m = 0;
> +	if (mem_info)
> +		m = mem_info->data_src.mem_snoopx;
> +
> +	for (i = 0; m && i < ARRAY_SIZE(snoopx_access); i++, m >>= 1) {
> +		if (!(m & 0x1))
> +			continue;
> +
>  		if (l) {
>  			strcat(out, " or ");
>  			l += 4;
>  		}
> -		l += scnprintf(out + l, sz - l, "Fwd");
> +		l += scnprintf(out + l, sz - l, snoopx_access[i]);
>  	}
>  
>  	if (*out == '\0')
