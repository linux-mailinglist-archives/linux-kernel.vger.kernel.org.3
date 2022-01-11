Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E631E48AB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348523AbiAKKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:39:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237905AbiAKKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:39:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8ugoD023411;
        Tue, 11 Jan 2022 10:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=2KSWVqEuYdeVeXQVkUDMn8UjL/H2Nqn1KJweQMRZxow=;
 b=FGY6T3AfTA44nno4Xj+ElYs2S3RoHXDyErvQ+8kB6mWMEx4VHl4kiGncE5PCeGVfHt62
 nX0NPtm6m7D1pF52JuejjGh1MMEElb4gCf2bp8UtExB1A2x7JJ7B1khr1gTRElop0zM9
 VT0CQ1w0Ws5n2rHAJv7HXrReU7A478TC5uCM0EU5bY5DbW4HE7TXlPLIutlSicTv8dUe
 ybaaGQAY5QQ2eOwgZO1P6JbHonmu5cRdB04iTKr3yLlEBgr9sbSlBRQTwr3v1pe8pKp0
 tkEAfGjsd8U4p1kz3OXMCCjQU5VKUyjmDRL5TN2zbxsq3JzHHl0TaEN3vhxCl4BVDtwT kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh6u11xkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 10:38:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20BARfvZ026334;
        Tue, 11 Jan 2022 10:38:12 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh6u11xkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 10:38:12 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BAc6lZ012575;
        Tue, 11 Jan 2022 10:38:10 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3df28ag8mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 10:38:10 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BAc9Bv12189976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 10:38:10 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8840C605D;
        Tue, 11 Jan 2022 10:38:09 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AACDC6055;
        Tue, 11 Jan 2022 10:38:01 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.92.234])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 10:38:00 +0000 (GMT)
X-Mailer: emacs 28.0.90 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 7/9] mm: multigenerational lru: eviction
In-Reply-To: <20220104202227.2903605-8-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-8-yuzhao@google.com>
Date:   Tue, 11 Jan 2022 16:07:57 +0530
Message-ID: <87czkyzhfe.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pg5gpO9q8jfjUxexhw0xTbVE_geykH2H
X-Proofpoint-ORIG-GUID: eYTBPwHrLMKJHelQZVIX0_2Z4auf6jKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...

 +static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
> +			  int *type_scanned, struct list_head *list)
> +{
> +	int i;
> +	int type;
> +	int scanned;
> +	int tier = -1;
> +	DEFINE_MIN_SEQ(lruvec);
> +
> +	VM_BUG_ON(!seq_is_valid(lruvec));
> +
> +	/*
> +	 * Try to make the obvious choice first. When anon and file are both
> +	 * available from the same generation, interpret swappiness 1 as file
> +	 * first and 200 as anon first.
> +	 */
> +	if (!swappiness)
> +		type = 1;
> +	else if (min_seq[0] < min_seq[1])
> +		type = 0;
> +	else if (swappiness == 1)
> +		type = 1;
> +	else if (swappiness == 200)
> +		type = 0;
> +	else
> +		type = get_type_to_scan(lruvec, swappiness, &tier);
> +

Wondering wether it will make it simpler to use
#define ANON 0
#define FILE 1

and then
	else if (min_seq[ANON] < min_seq[FILE])
		type = ANON;

The usage of 0/1 across code do confuse

-aneesh
