Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B251E51981C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbiEDHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345407AbiEDHa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:30:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90023171
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:26:53 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446hQiG026404;
        Wed, 4 May 2022 07:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=SBi24+Jxau+pYOVpf3DLGv5o1cIzPivxyCrplqCp+Gs=;
 b=Yq/tCE5wbKPkn8JWL8KDNwXfM5Mb/BQpFb0MYmJ0fkGA6qIWJzrkFOFFLpQsTvTBX5gG
 v96b/byRq27YEolwFzgGhM5foigyb5/AeR5TxaFpJ/YVIY/NALDRueW9uqIell1AIuG5
 +v4/sNMLF3ceGVCXaQX2TgjuizfNTWpk8I4ETlvGdf602i1FkdolRN33WnhLTBrpnrsB
 Vy45EqkbA+NQZoFZ1Zal+IyPnbsV0lPPMCD2AlgtKWb7NyE/dhEjZW5fxVwsdts1dB5q
 aL00Q8arC1BLzUdNzWqzBrd/ykLj+uTVTCQQBHrZ7F+NUo3uKcCUhCl9I2yn+P1ag961 Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fumfjgq3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 07:26:41 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2447HBgC021789;
        Wed, 4 May 2022 07:26:41 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fumfjgq2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 07:26:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2447MQwV026346;
        Wed, 4 May 2022 07:26:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3frvr8w7tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 07:26:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2447QaXA15139290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 07:26:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 616ECAE045;
        Wed,  4 May 2022 07:26:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97EF7AE055;
        Wed,  4 May 2022 07:26:32 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.85.138])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 May 2022 07:26:32 +0000 (GMT)
Date:   Wed, 4 May 2022 12:56:25 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in node_reclaim
Message-ID: <YnIqofjeR+Q5FvgH@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220416053902.68517-3-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416053902.68517-3-dave@stgolabs.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oK_01YMoZuzQDmgoNgq_w30gLU-pVJRU
X-Proofpoint-GUID: RR_Ah1MDMvNik6Xan4a_R-T-YOF_VpEb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_02,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1011 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:38:58PM -0700, Davidlohr Bueso wrote:
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
Currently node_is_toptier returns all N_CPU node as toptier but N_CPU
node will not stay necessarily top tier as per discussions on below
thread.

https://lore.kernel.org/linux-mm/CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com/

node_is_toptier() definition can change based on the discussion in above
thread.
>  		return NODE_RECLAIM_NOSCAN;
>  
>  	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
> -- 
> 2.26.2
> 
> 
