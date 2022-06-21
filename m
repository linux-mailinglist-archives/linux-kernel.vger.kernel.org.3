Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1848F552A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbiFUET0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFUETU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:19:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED3E2DD1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:19:20 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L3gD4m032278;
        Tue, 21 Jun 2022 04:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=hwOBoY5qFMEfFMRZbs9LOCT/B/V2y64Uzzn/r8yUL5A=;
 b=hUp3uFMbfV+/Mewg3VXKziIPVel6PY/K85X2H8dJidALUkVPc+cyS2vC6j6UZqClwRg6
 Bf41KA8ytYxPP/s4zIZirseShiT00Ke5dRyz6y6aGcf4fajhjBW/MyuSXNOF3aEvqMBX
 o1L+0lBB7UTfKA26pb/jHpCGLN0ykdnqud0o3busrIMj/laYxejNmkyIjNsf4wsSWKZ+
 YRlFhVcNqi4lk23ASaK1ACxunwa0E7fSenFFfbhk11RQc2o9NlvmYYw3Y12olNiracXH
 26RWJAYQXHLMLA/3ZDc3eUijhIiZjsTgc8FyBGiyRNmFa3JHbO1rEtPlpjWVzNuKWc3x Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gu6ae0p4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 04:19:03 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25L4J3RI014203;
        Tue, 21 Jun 2022 04:19:03 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gu6ae0p4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 04:19:03 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25L49wxs004428;
        Tue, 21 Jun 2022 04:19:01 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3gt008wrnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 04:19:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25L4J1xi9634402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 04:19:01 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8228AC060;
        Tue, 21 Jun 2022 04:19:00 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5462DAC059;
        Tue, 21 Jun 2022 04:18:53 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.205.170])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jun 2022 04:18:53 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [RFC PATCH 1/3] mm/memory-tiers Add functions for tier memory
 usage in a cgroup
In-Reply-To: <94a10c772c50d378b81dad654476551bfc50e3d7.1655242024.git.tim.c.chen@linux.intel.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
 <94a10c772c50d378b81dad654476551bfc50e3d7.1655242024.git.tim.c.chen@linux.intel.com>
Date:   Tue, 21 Jun 2022 09:48:50 +0530
Message-ID: <875ykuabth.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _2_iRA_8FO38nrjsJSbRM4ZfVDQEZ7Ly
X-Proofpoint-GUID: k5MDrmGV_hKijexuBAQBpBWw9EOMkmVE
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_02,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

 +unsigned long mem_cgroup_toptier_usage(struct mem_cgroup *memcg)
> +{
> +	struct memory_tier *top_tier;
> +
> +	top_tier = list_first_entry(&memory_tiers, struct memory_tier, list);
> +	if (top_tier)
> +		return mem_cgroup_memtier_usage(memcg, top_tier);
> +	else
> +		return 0;
> +}

As discussed here, we would want to consider all memory tiers that got
compute as top tier.

https://lore.kernel.org/linux-mm/11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com

V6 patchset actually walk the full memory tier hierarchy reverse and consider any
memory tier with higher or equal rank value than the first memory tier with CPU as top tier.

https://lore.kernel.org/linux-mm/20220610135229.182859-12-aneesh.kumar@linux.ibm.com

-aneesh
