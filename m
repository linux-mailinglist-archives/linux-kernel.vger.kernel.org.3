Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699FB5A3975
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiH0SXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0SXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:23:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2489BB79;
        Sat, 27 Aug 2022 11:23:32 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27REjarW008473;
        Sat, 27 Aug 2022 18:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NQxorI2Me18IOBWI5m1zSi0KqPW1GhV4JZ7Y51/zFgg=;
 b=OQGUGIfGLd7SzCqnzxW/U7quor4Nmx7aO86naavHd0HVzNAYfN6Pf51WUfvl5J0/zMjR
 tGQYikfys2jYfZSJAeefzOk8JvhfsZW9/kYGdZCTdaYosnxSON5ifYQIIm4XbDBJhMm9
 ayrZMDHVURoVzO0HwD/CF0iz68DUq3DV0aWKHAieOQZc9Dp4pyXue4cSOLpPF40Pv3sx
 HLZgKT5NpftrY5tGw8X7cHaF6CR66qS5H6CA44eTUsRVqnCmsq1rmZYVCtelc9Vx29S9
 zydaYtrWxM7putpJWTLZHG8EU0sRq7zCTzxaSq2ipWa/+0YhUlpgJyyEJa9sJEWW4H+Y MQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7naj36s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 18:23:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27RIMDld007950;
        Sat, 27 Aug 2022 18:23:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3j7aw90k0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 18:23:21 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27RINI9p38666678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 18:23:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE982A405B;
        Sat, 27 Aug 2022 18:23:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 792FDA4054;
        Sat, 27 Aug 2022 18:23:18 +0000 (GMT)
Received: from osiris (unknown [9.145.35.167])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 27 Aug 2022 18:23:18 +0000 (GMT)
Date:   Sat, 27 Aug 2022 20:23:17 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [PATCH RFC] s390: Fix nospec table alignments
Message-ID: <YwphFXr+pHxf4PGT@osiris>
References: <8719bf1ce4a72ebdeb575200290094e9ce047bcc.1661557333.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8719bf1ce4a72ebdeb575200290094e9ce047bcc.1661557333.git.jpoimboe@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QuXVXJnZMR0p3yzOO8U1d8HAS9bNpNbj
X-Proofpoint-GUID: QuXVXJnZMR0p3yzOO8U1d8HAS9bNpNbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=991
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208270068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 04:55:44PM -0700, Josh Poimboeuf wrote:
> Add proper alignment for .nospec_call_table and .nospec_return_table in
> vmlinux.
> 
> Fixes: f19fbd5ed642 ("s390: introduce execute-trampolines for branches")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
> This is RFC because I don't know anything about s390 behavior for
> unaligned data accesses, but this seemed to fix an issue for me.
> 
> While working on another s390 issue, I was getting intermittent boot
> failures in __nospec_revert() when it tried to access 'instr[0]'.  I
> noticed the __nospec_call_start address ended in 'ff'.  This patch
> seemed to fix it.  I have no idea why it was (only sometimes) failing in
> the first place.
> 
> The intermittent part of it is probably at least partially explained by
> CONFIG_RANDOMIZE_BASE.  Except now I can no longer recreate it :-/
> 
> Regardless, this patch seems correct.  I just can't explain what I saw.
> Any ideas?
> 
>  arch/s390/kernel/vmlinux.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index 2e526f11b91e..5ea3830af0cc 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -131,6 +131,7 @@ SECTIONS
>  	/*
>  	 * Table with the patch locations to undo expolines
>  	*/
> +	. = ALIGN(4);
>  	.nospec_call_table : {
>  		__nospec_call_start = . ;
>  		*(.s390_indirect*)

On s390 labels must be at an even address due to instructions like
"larl" (load address relative long), which generate a pc-relative
address adding the number of words encoded into the instruction to the
current IP.

With commit e6ed91fd0768 ("s390/alternatives: remove padding
generation code") I managed to reduce the size of struct alt_instr by
one byte, so it is now only 11 bytes in size. So depending on the size
/ number of members of the __alt_instructions array nospec_call_table
starts at an uneven address, which would explain this.

Unfortunately I was unable to let any compiler generate code, that
would use the larl instruction. Instead the address of
nospec_call_table was loaded indirectly via the GOT, which again works
always, regardless if the table starts at an even or uneven address.

This needs to be fixed anyway, and your patch certainly is correct.

Could you maybe share your kernel config + compiler version, if you
are still able to reproduce this?
