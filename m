Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0680516D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384404AbiEBJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352101AbiEBJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:43:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14213D2E;
        Mon,  2 May 2022 02:39:53 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2426twBr021004;
        Mon, 2 May 2022 09:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OEvhbqOZ9NwoylHOvcW5vWY09m40+BG8RWO2gTnZi4s=;
 b=jI3puI/95AKcbgfr5LE/2yipPVyQad875KxQXVlSpzmh069GItF5WeHT67goQfmpjjJ+
 JJOVHxc0ExPQ2f35VG7pJtGoP4oTI0F5ds/hclD5r5zrCcRSYsa0xXNV3y8+kN/xkp3r
 fK3q27wN5oIB5QTSUHWSAp8joXj5LddLJ7yPx7HmxR1WeTgupm2zuEWxR3parXc4EhPn
 F4fuA+/9ImO8U+fmEngw1XVbeqyL7Om8NE5pdxbjmQbEoKxn+qUb/2+XgOzAffuwE/Hl
 y2/IsA1MQglMytDpLhGbr6AfjYKaGLt+ffb3NaV3vUtYhQGEqh+DvoBSNX3/pPxwoFSa xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftafd2udj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:39:50 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2429dovX019565;
        Mon, 2 May 2022 09:39:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftafd2ud5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:39:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2429c8vB005324;
        Mon, 2 May 2022 09:39:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3frvr8t19g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 09:39:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2429di5A53871014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 09:39:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A6911C052;
        Mon,  2 May 2022 09:39:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46C8011C04C;
        Mon,  2 May 2022 09:39:44 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 09:39:44 +0000 (GMT)
Message-ID: <d36e7dc7-e063-365f-2bf4-8cac590b5802@linux.ibm.com>
Date:   Mon, 2 May 2022 11:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] perf test: Add skip to --per-thread test
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20220429061336.1184848-1-irogers@google.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220429061336.1184848-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vX0SZHQjo7c5Jqw1tTa1HPzvVp5p12dK
X-Proofpoint-GUID: GXEDPIT1L1tULqZMTAWKd65zblM7M8ak
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_03,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020074
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 08:13, Ian Rogers wrote:
> As reported in:
> https://lore.kernel.org/linux-perf-users/20220428122821.3652015-1-tmricht@linux.ibm.com/
> the 'instructions:u' event may not be supported. Add a skip using 'perf
> stat'.
> 
> Switch some code away from pipe to make the failures clearer.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record.sh | 44 +++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index cd1cf14259b8..efc0cb07a929 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -5,11 +5,43 @@
>  set -e
>  
>  err=0
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f ${perfdata}
> +  rm -f ${perfdata}.old
> +  trap - exit term int
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup exit term int
> +
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> -  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
> -    | perf report -i- -q \
> -    | egrep -q true
> +  if ! perf stat -e instructions:u --quiet true
> +  then
> +    echo "Per-thread record [Skipped instructions:u not supported]"
> +    if [ $err -ne 1 ]
> +    then
> +      err=2
> +    fi
> +    return
> +  fi
> +  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
> +  then
> +    echo "Per-thread record of instructions:u [Failed]"
> +    err=1
> +    return
> +  fi
> +  if ! perf report -i ${perfdata} -q | egrep -q true
> +  then
> +    echo "Per-thread record [Failed missing output]"
> +    err=1
> +    return
> +  fi
>    echo "Basic --per-thread mode test [Success]"
>  }
>  
> @@ -18,6 +50,10 @@ test_register_capture() {
>    if ! perf list | egrep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing instruction]"
> +    if [ $err -ne 1 ]
> +    then
> +      err=2
> +    fi
>      return
>    fi
>    if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> @@ -39,4 +75,6 @@ test_register_capture() {
>  
>  test_per_thread
>  test_register_capture
> +
> +cleanup
>  exit $err

Ian,

thanks very much for looking into this.
I have tested your patch on several configurations and to be perfect, please
change this line:
# git diff
diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index efc0cb07a929..9cb8494f314d 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -21,7 +21,7 @@ trap trap_cleanup exit term int
 
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  if ! perf stat -e instructions:u --quiet true
+  if ! perf record -e instructions:u --quiet true 2> /dev/null
   then
     echo "Per-thread record [Skipped instructions:u not supported]"
     if [ $err -ne 1 ]
# 

This runs fine, just use record instead of stat, you use perf record later
on anyway.

With this change you have my
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
