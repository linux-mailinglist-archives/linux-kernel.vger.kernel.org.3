Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB23159C2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiHVPYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiHVPYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:24:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9643E72;
        Mon, 22 Aug 2022 08:19:38 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEsfWD028291;
        Mon, 22 Aug 2022 15:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=gjSjjeb6HXbZ4PJz0ru3MMltTzVwA8is9o8omZ87Do8=;
 b=cgfz4FB207JoQHHpCvK5c567vezCAu86av/Q4Yt/U8AICT30C9WGWBf82djntsUMvNnp
 fFhH8//fDK2GII6h1A0THt6XUSgbk7XHhBSMX4VbveeHC/r4hwsFEm1TTRBtTjsVUEdt
 HxchM8rhtithz/HtXwIk477lU2wVURmKCRrbU/FaJ4w8OdcyRXkrXYQJI4We53nbV+Rh
 FvATiZJ5mqWtZ8eWcrjM5n3marNF0BgEb2G/yvW4+7dOtJt0RJuBYGmWi7X5NYjkYOSG
 +xJreneM+Y8AhuphaUCrQaDCrxwhhXVn3qv/KlEvrXIr0CyK5O22oZDwReLsLPsXaZru sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4byugsph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:19:26 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27MEuQDS001764;
        Mon, 22 Aug 2022 15:19:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4byugsng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:19:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MF7Bh8014877;
        Mon, 22 Aug 2022 15:19:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3j2pvj2m78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:19:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MFJKIo33882554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:19:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F2364203F;
        Mon, 22 Aug 2022 15:19:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B231842041;
        Mon, 22 Aug 2022 15:19:19 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Aug 2022 15:19:19 +0000 (GMT)
Message-ID: <3a797c5ccde91c7791b3bdd3d81391a8fb38f2c5.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Mon, 22 Aug 2022 17:19:19 +0200
In-Reply-To: <20220820003125.353570-10-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
         <20220820003125.353570-10-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GQkeq9zSrtetDjoo_C8iinzSj8IKTQy4
X-Proofpoint-GUID: kOW_YKOLgXVunL8dNIQoxyXwzpBumFlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=870 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-08-20 at 08:31 +0800, Baoquan He wrote:
> Add hooks arch_ioremap() and arch_iounmap() for s390's special
> operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> converted to use ioremap_prot() from GENERIC_IOREMAP.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/Kconfig          |  1 +
>  arch/s390/include/asm/io.h | 26 +++++++++++------
>  arch/s390/pci/pci.c        | 60 +++++---------------------------------
>  3 files changed, 26 insertions(+), 61 deletions(-)

Sorry I missed this mail until now and will still need a bit of time to
review and test the code as this is indeed pretty special on s390. From
a first glance this does look like a nice simplification.

Just out of curiosity, I wonder why get_maintainers.pl didn't add me
nor Gerald for direct CC despite the bulk of the changes affecting
arch/s390/pci/*.

> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
---8<---

