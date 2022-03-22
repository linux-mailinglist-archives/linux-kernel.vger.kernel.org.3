Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7744E387A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiCVFaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiCVFaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:30:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A4DAF;
        Mon, 21 Mar 2022 22:28:34 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M47KBQ018787;
        Tue, 22 Mar 2022 05:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=TqqfIpaYW5JGR3JKgjRylpIbTY9DrPh5H2+7LKVkXyY=;
 b=Yk1O5LcktVUoQcWy1/VJG12+S6hktSZSyaUh3TGeEjFvDh5mDbe02e3L2js/pTZqCJU2
 3X6lNb9uIRGdyNMKp4dcb4hcUVudCs3hNZsNGvNjqYKaXwHAlUnS6WcUWFQ+VDKNGaDO
 unwcxCOXFOWn45zrrg1mrz8oa19xT/TSSwwtcO1t/Q8LDnSyNhtf8ZrjcIwChmAYnecW
 ucdJw/jRmR69ur7lln3Sg11CjyU50DeYJ4uJ7Y44uJjs4x1FlTjG5U6yfEGyeutGb4V4
 J9pNUdIRikUclNKo0neG06P+AY1gGhe1YuT1A5hiOSzdXK6xZouO7+aP+VjLcfDCg304 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3expy0wdpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 05:27:14 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22M5Qc3f001357;
        Tue, 22 Mar 2022 05:27:13 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3expy0wdnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 05:27:13 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22M5MmWb027594;
        Tue, 22 Mar 2022 05:27:12 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3ew6t9xf10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 05:27:11 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22M5RAap5439978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 05:27:10 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BE62136065;
        Tue, 22 Mar 2022 05:27:10 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1E1613605D;
        Tue, 22 Mar 2022 05:26:53 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.75.167])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Mar 2022 05:26:53 +0000 (GMT)
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
Date:   Tue, 22 Mar 2022 10:56:50 +0530
Message-ID: <877d8m7e1x.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ql37j01KajwgF00k2OgU6gOK2r3sWXEJ
X-Proofpoint-GUID: DAQxEiwBayf4Zp-JJHxC8P33uRYSCots
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_10,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

 +
> +static void inc_min_seq(struct lruvec *lruvec)
> +{
> +	int type;
> +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> +
> +	VM_BUG_ON(!seq_is_valid(lruvec));
> +
> +	for (type = 0; type < ANON_AND_FILE; type++) {
> +		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> +			continue;
> +
> +		reset_ctrl_pos(lruvec, type, true);
> +		WRITE_ONCE(lrugen->min_seq[type], lrugen->min_seq[type] + 1);
> +	}
> +}
> +
> +static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
> +{
> +	int gen, type, zone;
> +	bool success = false;
> +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> +	DEFINE_MIN_SEQ(lruvec);
> +
> +	VM_BUG_ON(!seq_is_valid(lruvec));
> +
> +	for (type = !can_swap; type < ANON_AND_FILE; type++) {
> +		while (min_seq[type] + MIN_NR_GENS <= lrugen->max_seq) {
> +			gen = lru_gen_from_seq(min_seq[type]);
> +
> +			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
> +				if (!list_empty(&lrugen->lists[gen][type][zone]))
> +					goto next;
> +			}
> +
> +			min_seq[type]++;
> +		}
> +next:
> +		;
> +	}
> +
> +	/* see the comment on lru_gen_struct */
> +	if (can_swap) {
> +		min_seq[LRU_GEN_ANON] = min(min_seq[LRU_GEN_ANON], min_seq[LRU_GEN_FILE]);
> +		min_seq[LRU_GEN_FILE] = max(min_seq[LRU_GEN_ANON], lrugen->min_seq[LRU_GEN_FILE]);
> +	}
> +
> +	for (type = !can_swap; type < ANON_AND_FILE; type++) {
> +		if (min_seq[type] == lrugen->min_seq[type])
> +			continue;
> +
> +		reset_ctrl_pos(lruvec, type, true);
> +		WRITE_ONCE(lrugen->min_seq[type], min_seq[type]);
> +		success = true;
> +	}
> +
> +	return success;
> +}
> +
> +static void inc_max_seq(struct lruvec *lruvec, unsigned long max_seq)
> +{
> +	int prev, next;
> +	int type, zone;
> +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> +
> +	spin_lock_irq(&lruvec->lru_lock);
> +
> +	VM_BUG_ON(!seq_is_valid(lruvec));
> +
> +	if (max_seq != lrugen->max_seq)
> +		goto unlock;
> +
> +	inc_min_seq(lruvec);

Can this min seq update result in pages considered oldest become young.
ie, if we had seq value of 0 - 3 and we need ageing, the new min seq and
max_seq value will now become 1 - 4. What happens to pages in the
generation value 0 which was oldest generation earlier and is youngest
now.


> +
> +	/* update the active/inactive LRU sizes for compatibility */
> +	prev = lru_gen_from_seq(lrugen->max_seq - 1);
> +	next = lru_gen_from_seq(lrugen->max_seq + 1);
> +
> +	for (type = 0; type < ANON_AND_FILE; type++) {
> +		for (zone = 0; zone < MAX_NR_ZONES; zone++) {
> +			enum lru_list lru = type * LRU_INACTIVE_FILE;
> +			long delta = lrugen->nr_pages[prev][type][zone] -
> +				     lrugen->nr_pages[next][type][zone];
> +
> +			if (!delta)
> +				continue;
> +
> +			__update_lru_size(lruvec, lru, zone, delta);
> +			__update_lru_size(lruvec, lru + LRU_ACTIVE, zone, -delta);
> +		}
> +	}
> +
> +	for (type = 0; type < ANON_AND_FILE; type++)
> +		reset_ctrl_pos(lruvec, type, false);
> +
> +	/* make sure preceding modifications appear */
> +	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
> +unlock:
> +	spin_unlock_irq(&lruvec->lru_lock);
> +}
> +

....

 +
> +static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
> +{
> +	int type;
> +	int scanned;
> +	int reclaimed;
> +	LIST_HEAD(list);
> +	struct folio *folio;
> +	enum vm_event_item item;
> +	struct reclaim_stat stat;
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +
> +	spin_lock_irq(&lruvec->lru_lock);
> +
> +	scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
> +
> +	if (try_to_inc_min_seq(lruvec, swappiness))
> +		scanned++;

we are doing this before we shrink the page list. Any reason to do this before?

> +
> +	if (get_nr_gens(lruvec, LRU_GEN_FILE) == MIN_NR_GENS)
> +		scanned = 0;
