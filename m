Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615B539012
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiEaLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiEaLvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:51:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542249AE57
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:51:08 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V9kRtf029119;
        Tue, 31 May 2022 11:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=o52iNdoPgfNxtCXuGtUnTHxhtVjoQFXXfw2YyfadNQ4=;
 b=nxEFXMvwbp5pU0Q15dqBk8nlrxUJvvNntWb74U7wv4TcxEEzGjbqeANQIQIRz7z69ZA+
 Wb9ghs6u1/4s5bQCSRfixnR6s9JFATai5BN2swBMqPWmIk/iAYY5NLIP4OXyG6R7QEra
 a5hsTmE8zg75XBKD1Zb+7z+SRAEch0oEZVOvfx7OMXPgzm4qYV8nX1sUmoi430XnCd0Y
 6jf0lVoHU1nY3Knq9EtIFE225BgUziSSC3I/LG9Ho7WPfBrzPZPOWa5FWGC2HkIeLATS
 DBYqbSA8H4Gs5P7ePqfSiK0XiWWZGXCjJkGS/9RalyUnSwQ3pZWYr8c07RN7Cmz7z5KE uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdgp4a4jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:50:53 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24VAjvWr026247;
        Tue, 31 May 2022 11:50:53 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdgp4a4jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:50:53 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24VBZnYh032334;
        Tue, 31 May 2022 11:50:52 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3gcxt57s88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:50:52 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24VBopEA25690410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 11:50:51 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D681AE066;
        Tue, 31 May 2022 11:50:51 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E40CAE062;
        Tue, 31 May 2022 11:50:45 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.75.179])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 May 2022 11:50:44 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in node_reclaim
In-Reply-To: <20220416053902.68517-3-dave@stgolabs.net>
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220416053902.68517-3-dave@stgolabs.net>
Date:   Tue, 31 May 2022 17:20:42 +0530
Message-ID: <87h755dip9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hFaP5Wlngd4z14fDXM8_M7vK4N94Bcjo
X-Proofpoint-GUID: 7RA_a--nVo-HGuKedV7RKWPYn2WNoNhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_04,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> writes:

> We have helpers for a reason.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..cb583fcbf5bf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4750,7 +4750,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  	 * over remote processors and spread off node memory allocations
>  	 * as wide as possible.
>  	 */
> -	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id != numa_node_id())
> +	if (node_is_toptier(pgdat->node_id) && pgdat->node_id != numa_node_id())
>  		return NODE_RECLAIM_NOSCAN;
>  
>  	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))


Are we really looking at the top tier in a tiered memory hierarchy here?
The comment seems to suggest we are looking at local NUMA node?


-aneesh
