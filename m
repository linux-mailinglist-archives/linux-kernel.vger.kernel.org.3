Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E46482D12
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiABWuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:50:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbiABWuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:50:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 202JiZAW008803;
        Sun, 2 Jan 2022 22:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=mijyG+TJVloCEmsPNr8b8tAPVp60X6PbsWGBG/lM4w0=;
 b=Tn64pDZ4kVERhCPR0+1y2Topz7gg3ojnd0/pbi7vqCnlbUZ/gGuQlh4zyDln9x/cImtx
 j3ZchtvhvcmhKwWV4z2ffmKavQCQ53FvqoCJp881szdgXnQS4zgXyR9yGsfGX719xgfZ
 Jmvtlaclg6ZkAsEDPxAcySovw97rhd6kkTUysPNLxDharrj9nuBx6fLAgQOv/M3/4lMw
 gZaDLW9FyTQvsPzuC5w68CJumYNdt1F4KaypLf8WIEbdKeI/j1DUtfXHeOhqtiwR0IQa
 CiF7xhaB0hSluj/yyK+ob8JnEQ2PFgoE7PBtYqP+ygJeuhpMoChFV5z5LeLUPFHEaMdt /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dbjfp9rn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jan 2022 22:50:25 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 202MoOW6027710;
        Sun, 2 Jan 2022 22:50:24 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dbjfp9rmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jan 2022 22:50:24 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 202Mi3c5031419;
        Sun, 2 Jan 2022 22:50:23 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3daeka5f1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jan 2022 22:50:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 202MoMiB20775206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 2 Jan 2022 22:50:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0FF8B205F;
        Sun,  2 Jan 2022 22:50:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0FC8B2066;
        Sun,  2 Jan 2022 22:50:21 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.77.132.185])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sun,  2 Jan 2022 22:50:21 +0000 (GMT)
Date:   Sun, 2 Jan 2022 16:50:19 -0600
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: fix typos of "its" and "reponse"
Message-ID: <YdIsK7BI+sG36B1m@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20211226025215.22866-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226025215.22866-1-rdunlap@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ek7jZatt4EW9OF_diMHZi_qEPMgYdeX2
X-Proofpoint-GUID: 7ya2xLZynmqDknpDdHDH_qXXh9mqGzvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-02_10,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=909
 adultscore=0 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201020164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 06:52:15PM -0800, Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction of "it is" ("it's")
> where needed in user-viewable messages.

> --- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> +++ linux-next-20211224/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
> @@ -184,8 +184,8 @@
>      "EventCode": "0x80",
>      "UMask": "0x01",
>      "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
> -    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> -    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",

You should probably s/till/until/, since you're already modifying those lines.
Is there a reason that "Coherent" is capitalized here?

> --- linux-next-20211224.orig/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> +++ linux-next-20211224/tools/perf/pmu-events/arch/x86/haswell/uncore.json
> @@ -304,8 +304,8 @@
>      "EventCode": "0x80",
>      "UMask": "0x01",
>      "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
> -    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> -    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from it's allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "BriefDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",
> +    "PublicDescription": "Each cycle count number of all Core outgoing valid entries. Such entry is defined as valid from its allocation till first of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent traffic.",

same

PC
