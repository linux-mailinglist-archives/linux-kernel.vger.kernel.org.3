Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941CA4E26EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347595AbiCUMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbiCUMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:54:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511AC47540;
        Mon, 21 Mar 2022 05:53:33 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LAfltX026936;
        Mon, 21 Mar 2022 12:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=w6kEeA+SUP3F3PVi0gSj19CE8IsWCwSygoiUg3baZiw=;
 b=pw68UMJBsW/NrhUIPZrLEyaSdRer24zmTIi7WqsjpYzm7K9XGSmrj/k154Z5BIreTOh2
 e2+XN3wp88Gy2FXKDAjTXCOwc44+L5HKSuaSQOSJQtW2ciK+MdE5eOrtEXgYpjIz3hU7
 YOtWo/r+LTVK6zlMAgm0GCQjR0LIyOGYKBAyllIsSdEjRmkBHIVDtsblP3frPKYSJRZq
 8JwIQpds+7gubVVLItFprUlC/Zpfw9BBga7NlVA1T4R/Bex8H9q1CJJt7V6rxgQUGcnw
 RxQCq0UDmD2fLW1GzSj0qnI4kxeap1eSIweG4I2ctJ0ecnGP+ie/5+zxa/H0sgIGwsJr Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exqu3tfqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 12:52:06 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22LCRs7J016396;
        Mon, 21 Mar 2022 12:52:05 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3exqu3tfqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 12:52:05 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LCnVTO014750;
        Mon, 21 Mar 2022 12:52:05 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 3ew6t95b0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 12:52:04 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LCq3pK26345962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 12:52:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A299BE05D;
        Mon, 21 Mar 2022 12:52:03 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECC51BE051;
        Mon, 21 Mar 2022 12:51:48 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.41.132])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 12:51:48 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
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
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
In-Reply-To: <20220309021230.721028-7-yuzhao@google.com>
References: <20220309021230.721028-1-yuzhao@google.com>
 <20220309021230.721028-7-yuzhao@google.com>
Date:   Mon, 21 Mar 2022 18:21:41 +0530
Message-ID: <87czif79k2.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2exQqtW3nJFO0XcsncVqKpT5kKGyBMlE
X-Proofpoint-GUID: zvBbiBo7--xru4vB8wXrHX6ogYqZbCdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_05,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=956
 priorityscore=1501 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 +
> +static long get_nr_evictable(struct lruvec *lruvec, unsigned long max_seq,
> +			     unsigned long *min_seq, bool can_swap, bool *need_aging)
> +{
> +	int gen, type, zone;
> +	long old = 0;
> +	long young = 0;
> +	long total = 0;
> +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> +
> +	for (type = !can_swap; type < ANON_AND_FILE; type++) {
> +		unsigned long seq;
> +
> +		for (seq = min_seq[type]; seq <= max_seq; seq++) {
> +			long size = 0;
> +
> +			gen = lru_gen_from_seq(seq);
> +
> +			for (zone = 0; zone < MAX_NR_ZONES; zone++)
> +				size += READ_ONCE(lrugen->nr_pages[gen][type][zone]);
> +
> +			total += size;
> +			if (seq == max_seq)
> +				young += size;
> +			if (seq + MIN_NR_GENS == max_seq)
> +				old += size;
> +		}
> +	}
> +
> +	/* try to spread pages out across MIN_NR_GENS+1 generations */
> +	if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS > max_seq)
> +		*need_aging = true;
> +	else if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS < max_seq)
> +		*need_aging = false;

Can you explain/document the reason for the considering the below
conditions for ageing? 

> +	else if (young * MIN_NR_GENS > total)
> +		*need_aging = true;

Are we trying to consdier the case of more than half the total pages
young as needing ageing? If so should MIN_NR_GENS be 2 instead of using
that #define? Or 

> +	else if (old * (MIN_NR_GENS + 2) < total)
> +		*need_aging = true;

What is the significance of '+ 2' ? 

> +	else
> +		*need_aging = false;
> +
> +	return total > 0 ? total : 0;
> +}
> +
