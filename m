Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1157C460
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiGUGZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiGUGZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:25:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EAEF20;
        Wed, 20 Jul 2022 23:25:52 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L4Kd06001025;
        Thu, 21 Jul 2022 06:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M2JiBalwW4CD0ytKTgXWsVduvHfTTbLfJmMWCa+ruTo=;
 b=iZSo7VPT1M0gQM729fcZqTKrcghH2tz21YIEhU2TaumIbBd+AdhpEz6T3lSkJLf67Z6E
 ECB42n88pf7PTDodk8qnfLzraYsbMW0/PrzTxlUIu4WlwkV9i9izzPLx5Lxvp1BkKsgq
 18skh9QpBcOmPAgWA+FTrDL/fihEcllCsH0DhAXA8onGG80X5oxaW44xAU0wGDurgEjT
 1HIX1DdbpTEksG4Jp63X0afwVfa9vzIEf8UOcOEdAhs27mvOGIfW/OZQ3T1P48u+ya+v
 5goRjGFY4WV0CGJ66GrpZQzNpNU9zkF9g5WH6mP/X7R3xEqmmthDdV485qBsYxgPpK/n zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3heypn3epq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 06:25:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26L6HNXI008746;
        Thu, 21 Jul 2022 06:25:52 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3heypn3enx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 06:25:51 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26L6MA4M030351;
        Thu, 21 Jul 2022 06:25:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3hbmy8vx2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 06:25:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26L6PkdN24052198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 06:25:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC6D52054;
        Thu, 21 Jul 2022 06:25:45 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 921BB52050;
        Thu, 21 Jul 2022 06:25:45 +0000 (GMT)
Date:   Thu, 21 Jul 2022 08:25:44 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Fix typo 'the the' in comment
Message-ID: <YtjxaKSMDvdTsyM+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220721033358.44838-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721033358.44838-1-slark_xiao@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b75hMYjowo3flnNLqOsBze3rRdv4bfrW
X-Proofpoint-ORIG-GUID: V349dZAfTqmJnLSDX6dDtSALmLTZZuFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=738 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207210023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:33:58AM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  arch/s390/kernel/perf_cpum_sf.c | 2 +-
>  arch/s390/kernel/sthyi.c        | 2 +-

Please, split in two patches and add subsystems to the descriptions.

Thanks!
