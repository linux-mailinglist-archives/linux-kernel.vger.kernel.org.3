Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8257B62D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiGTMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiGTMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:15:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4C51EEDB;
        Wed, 20 Jul 2022 05:15:22 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KCEpRf023607;
        Wed, 20 Jul 2022 12:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=r/6jWPn4dlWcdAr0FThJw75qwR6TAdYize4o4pWh8RI=;
 b=LwWxJjBx86sO3BOIVWjzX78GseYRYp99HdMfUOAVgDdoFbZ6pz63T+eVzIeyE8J4HTWq
 dUH3qyjvq7UWtVpsGMDzG4juKNqmGaRpZv5dwtl87glh6CU48v9yhL7Z4/CuAolsJyKX
 7FljbknWtNWtKat3jtLHj5+52YVleDYZvy6qAVeZe+UjTL+VQE5gw1+nx/oL3QvybYEa
 esjafb0QzFcBNmAYI9YKnRsSyAEKGeQxY+qxVeUwvhOsAbT4yl7sB2OguWn29wZoUoXd
 FVzh0UWBOQwsUHJvi/UciTRnvkBVatqLxRxHhYzCi9MnYMLnT5XuZpGqqSl8+2ugY3h/ /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hehhr80b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:15:10 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26KCEu5s023852;
        Wed, 20 Jul 2022 12:15:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hehhr80a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:15:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26KC6ggE006072;
        Wed, 20 Jul 2022 12:15:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj5kh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:15:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26KCF56Z23462246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 12:15:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 236D45204F;
        Wed, 20 Jul 2022 12:15:05 +0000 (GMT)
Received: from localhost (unknown [9.171.84.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 085435204E;
        Wed, 20 Jul 2022 12:15:04 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] s390/crash: support multi-segment iterators
In-Reply-To: <cover.1658206891.git.agordeev@linux.ibm.com>
In-Reply-To: 
References: <cover.1658206891.git.agordeev@linux.ibm.com>
Date:   Wed, 20 Jul 2022 14:15:04 +0200
Message-ID: <87edygc75j.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tcWm7o53MzSNvCx0GO95P5c32qDyfoff
X-Proofpoint-GUID: 45iSwJPklw9bzop1mxkTZFx3t6ZRJa4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=936 clxscore=1011
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Alexander,

Alexander Gordeev <agordeev@linux.ibm.com> writes:

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
>
> -- 
> 2.34.1

all our kdump + makedumpfile (with CP as core collector as well) work
with these patches applied.

Tested on LPAR and zVM.
With and w/o KASAN.

Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Regards
Alex 
