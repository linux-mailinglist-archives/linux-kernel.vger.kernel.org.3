Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EB57B425
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiGTJsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiGTJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:48:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5077655B8;
        Wed, 20 Jul 2022 02:48:08 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K97lFU032028;
        Wed, 20 Jul 2022 09:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3IVm3dRidrUMpJPgr6uvEFc2Q2XZwLujB5od9JKNv/8=;
 b=cwe64IaLaggak1WE3f7mQ3uqlo31v54rKro/FH/x2Obfo+jR0uCBYnXe3oHK1gFK+CYO
 JaLFsBEmWbJ4qV+AZudaX8DBUhvHFDtbo4hd0jZoGGJKKR1FptEtQAD3azbZnxsMckuN
 9g8PJW/8AwIkYFb2R3tYRfGqORvhZOsnZ67vN5PHy1LrSEJgF3VCJLg2u9aJbPbFkwwC
 varKI4xxbrekqaQsXjg+9LOx8QBbrYef3TwcOPax2nK/92Zaa+iuLTPEtAA3kDxC5G0v
 G+OJcYbiPSWsRS8JllgSmFnhg2hTTBTRunrSuw18WdNps3IWKvfesDzIO2gMFvj/fL/q UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hedpe2p3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 09:47:56 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K98Tmg003361;
        Wed, 20 Jul 2022 09:47:56 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hedpe2p2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 09:47:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K9anXg023077;
        Wed, 20 Jul 2022 09:47:54 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3hbmy8wdq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 09:47:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K9lpfH24510802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 09:47:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF256A404D;
        Wed, 20 Jul 2022 09:47:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9079AA4040;
        Wed, 20 Jul 2022 09:47:50 +0000 (GMT)
Received: from osiris (unknown [9.145.148.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Jul 2022 09:47:50 +0000 (GMT)
Date:   Wed, 20 Jul 2022 11:47:49 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] s390/crash: support multi-segment iterators
Message-ID: <YtfPRZJs3Q3EX9dP@osiris>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658206891.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l5ViG2XHGvEEK2aOc7vE6w9Uk8HkBk53
X-Proofpoint-GUID: qnn1gR2zsL9LmXG2mKm9Z71nXqA38Lwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1011 adultscore=0 mlxlogscore=746 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:16:32AM +0200, Alexander Gordeev wrote:
> Hi Matthew et al,
> 
> This series completes 5d8de293c224 ("vmcore: convert copy_oldmem_page()
> to take an iov_iter") for s390.
> 
> Changes since v3:
>   - concurrent access to HSA and oldmem swap buffers protected;
> 
> Changes since v2:
>   - Matthew Wilcox suggestion is adopted, with that...
>   - copy_to_iter() is used instead of custom implementation;
> 
> Changes since v1:
>   - number of bytes left to copy on fail fixed;
> 
> Thanks!
> 
> 
> Alexander Gordeev (4):
>   s390/zcore: fix race when reading from hardware system area
>   s390/crash: move copy_to_user_real() to crash_dump.c
>   s390/crash: use static swap buffer for copy_to_user_real()
>   s390/crash: support multi-segment iterators
> 
>  arch/s390/include/asm/os_info.h |  17 ++++-
>  arch/s390/include/asm/sclp.h    |   4 +-
>  arch/s390/include/asm/uaccess.h |   1 -
>  arch/s390/kernel/crash_dump.c   | 114 ++++++++------------------------
>  arch/s390/mm/maccess.c          |  26 --------
>  drivers/s390/char/zcore.c       |  55 ++++++++-------
>  6 files changed, 71 insertions(+), 146 deletions(-)

FWIW,
Acked-by: Heiko Carstens <hca@linux.ibm.com>
