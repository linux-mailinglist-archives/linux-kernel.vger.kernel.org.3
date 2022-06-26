Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81C655B014
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiFZH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiFZH6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:58:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4F12D03;
        Sun, 26 Jun 2022 00:58:33 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25Q64Pvl025285;
        Sun, 26 Jun 2022 07:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XZ90HtNDrlRjkiJkulFjUc8f67d4YhL3Kx3bFG8OuUA=;
 b=CSGvo7GpN5YCxmrbK/tIUTc+JZTqN4ZLc+WHmkDHA/NjREwnoCnDe+WOajL84uP2uU31
 UluZkljR0GR1vutz2MpI/jHPJk9H3hhZ8WiVpXccBOooIz2hbldluTm8LEyHbGbz3sNb
 2szy4NmkG2RotrMOeSRekjxCS6dPpvRWAUMzgPozxpYVEryoTNeqoQGiqRRxjdHV3PMl
 +1mk8GEQAs4mlu+cdIUidg1VkOwtRm9TNeav9H8DDdjxOX7W8v7FIp/ovEr6MZ6hVlxh
 2vXKFmEAPCV7j5YAR3No6i/vMgEIEaRRq63pUJV5UYB1z0nuoq3HonAp3PAMuE+lIJml fg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxc046sh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 07:58:00 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25Q7pWED012856;
        Sun, 26 Jun 2022 07:57:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3gwt08s2a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 07:57:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25Q7vtdl14549294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 07:57:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E984DAE04D;
        Sun, 26 Jun 2022 07:57:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66C62AE045;
        Sun, 26 Jun 2022 07:57:54 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 26 Jun 2022 07:57:54 +0000 (GMT)
Date:   Sun, 26 Jun 2022 09:57:52 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/3] jump_label: s390: avoid pointless initial NOP
 patching
Message-ID: <YrgRgKgBPs+oOVB3@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220615154142.1574619-1-ardb@kernel.org>
 <20220615154142.1574619-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615154142.1574619-2-ardb@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b5QUtcNkKcJxrnkTgswLWrjaXCRAC_M2
X-Proofpoint-GUID: b5QUtcNkKcJxrnkTgswLWrjaXCRAC_M2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-25_11,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206260026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:41:40PM +0200, Ard Biesheuvel wrote:
> Patching NOPs into other NOPs at boot time serves no purpose, so let's
> use the same NOP encodings at compile time and runtime.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/s390/include/asm/jump_label.h |  5 ++---
>  arch/s390/kernel/jump_label.c      | 23 +++++---------------
>  2 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
> index 916cfcb36d8a..895f774bbcc5 100644
> --- a/arch/s390/include/asm/jump_label.h
> +++ b/arch/s390/include/asm/jump_label.h
> @@ -10,7 +10,6 @@
>  #include <linux/stringify.h>
>  
>  #define JUMP_LABEL_NOP_SIZE 6
> -#define JUMP_LABEL_NOP_OFFSET 2
>  
>  #ifdef CONFIG_CC_IS_CLANG
>  #define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> @@ -21,12 +20,12 @@
>  #endif
>  
>  /*
> - * We use a brcl 0,2 instruction for jump labels at compile time so it
> + * We use a brcl 0,<offset> instruction for jump labels so it
>   * can be easily distinguished from a hotpatch generated instruction.
>   */
>  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>  {
> -	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
> +	asm_volatile_goto("0:	brcl 0,%l[label]\n"

Please, use tab after brcl, not space.

>  			  ".pushsection __jump_table,\"aw\"\n"
>  			  ".balign	8\n"
>  			  ".long	0b-.,%l[label]-.\n"
> diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
> index 6bec000c6c1c..d764f0d229ab 100644
> --- a/arch/s390/kernel/jump_label.c
> +++ b/arch/s390/kernel/jump_label.c
> @@ -44,14 +44,8 @@ static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
>  	panic("Corrupted kernel text");
>  }
>  
> -static struct insn orignop = {
> -	.opcode = 0xc004,
> -	.offset = JUMP_LABEL_NOP_OFFSET >> 1,
> -};
> -
>  static void jump_label_transform(struct jump_entry *entry,
> -				 enum jump_label_type type,
> -				 int init)
> +				 enum jump_label_type type)
>  {
>  	void *code = (void *)jump_entry_code(entry);
>  	struct insn old, new;
> @@ -63,27 +57,22 @@ static void jump_label_transform(struct jump_entry *entry,
>  		jump_label_make_branch(entry, &old);
>  		jump_label_make_nop(entry, &new);
>  	}
> -	if (init) {
> -		if (memcmp(code, &orignop, sizeof(orignop)))
> -			jump_label_bug(entry, &orignop, &new);
> -	} else {
> -		if (memcmp(code, &old, sizeof(old)))
> -			jump_label_bug(entry, &old, &new);
> -	}
> +	if (memcmp(code, &old, sizeof(old)))
> +		jump_label_bug(entry, &old, &new);
>  	s390_kernel_write(code, &new, sizeof(new));
>  }
>  
>  void arch_jump_label_transform(struct jump_entry *entry,
>  			       enum jump_label_type type)
>  {
> -	jump_label_transform(entry, type, 0);
> +	jump_label_transform(entry, type);
>  	text_poke_sync();
>  }
>  
>  bool arch_jump_label_transform_queue(struct jump_entry *entry,
>  				     enum jump_label_type type)
>  {
> -	jump_label_transform(entry, type, 0);
> +	jump_label_transform(entry, type);
>  	return true;
>  }
>  
> @@ -95,6 +84,4 @@ void arch_jump_label_transform_apply(void)
>  void __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
>  						       enum jump_label_type type)
>  {
> -	jump_label_transform(entry, type, 1);
> -	text_poke_sync();
>  }


With the comment above:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

> -- 
> 2.35.1
> 
