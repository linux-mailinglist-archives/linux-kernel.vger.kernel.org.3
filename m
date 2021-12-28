Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCF480BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhL1RBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:01:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55752 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232923AbhL1RBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:01:12 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BSF2jrG013235;
        Tue, 28 Dec 2021 17:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=HnOj7Ruj/aiPsemF0RK+yqeJAcI1ks0Mm0MLeijRB0k=;
 b=XWoCeNtjHD83AOJpWuV7RWM6f2sZGfEYS1osz5n0bsX9qZ2f6YZfEuGHJ44wO7EnPRNK
 qef6MFp6RJhBhmzXrAriiMgk0kj0omjKu66e58gCEDqlO0HkNJW/QhPR9MzWjwOSJ8CV
 OZ1wapSrboP0ceeP3TTxMCavmyv3ofkY6Kz+EXW0cTePFeIRv66U40j7vje1SSBNTIyw
 4HWLUBNHsnkUNYLQqNDUzoKpKx24Nkamd94ducNtkF5I40ZaTt4SFFF3nwwrCPZn5wi2
 Tc6tM+zz5Fdigmutmn2KvcrXx5FPn27fb9V6VoYMN3xZP5+UNbqMkT9UwfOyqtvWXOHO 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d81g66p9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 17:00:33 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BSGxEOD038776;
        Tue, 28 Dec 2021 17:00:32 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d81g66p8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 17:00:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BSGwEj7020583;
        Tue, 28 Dec 2021 17:00:30 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3d5txasjgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 17:00:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BSH0Rb930605762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Dec 2021 17:00:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF96842056;
        Tue, 28 Dec 2021 17:00:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A54B4203F;
        Tue, 28 Dec 2021 17:00:26 +0000 (GMT)
Received: from osiris (unknown [9.145.95.23])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Dec 2021 17:00:26 +0000 (GMT)
Date:   Tue, 28 Dec 2021 18:00:24 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     guoren@kernel.org
Cc:     will@kernel.org, tglx@linutronix.de, benh@kernel.crashing.org,
        arnd@arndb.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 5/8] sched: s390: Remove unused TASK_SIZE_OF
Message-ID: <YctCqJsKWltOfLO6@osiris>
References: <20211228064730.2882351-1-guoren@kernel.org>
 <20211228064730.2882351-6-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228064730.2882351-6-guoren@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4jtWmHMXNG03Qh0QF9W5oA_Gpf3QaHpv
X-Proofpoint-GUID: 18xlVlTjbnO_Si-BGff2bmk9Qz6OyusA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_08,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 02:47:26PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This macro isn't used in Linux sched, now. Delete in
> include/linux/sched.h and arch's include/asm.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/include/asm/processor.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks!
