Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82336565C25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiGDQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiGDQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:31:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C496404;
        Mon,  4 Jul 2022 09:31:10 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264G2wcS023517;
        Mon, 4 Jul 2022 16:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=gJnL/G7O20Rd6U2Rbs8HerMEoRfqGWgNBlHNnsoKfbE=;
 b=Kl8uHM6iasT3vuqppIAyjB4nBDdSIbUAoddnUZFhpqnVZSGqoFsmjT+tgZVkxoku2sG4
 qQd4NbDpqiJLl/rdvYoZI2FXFHCsF4H872bPrGtVGSytOJ8rPfzyWfwNQq62r40Ofkc5
 1y57ob/MmM3vtlpswvDHol6XBUWqpghj88H/kFxB1KQ7yrCBBQ9tOBUjwAQx6DV2yuvJ
 Czp4U7Q5oG+ZcowYxRl5Idzr0OF+r+iaMtLrRh8y95iIx4JRQvIfRDqCCFb6wRyPgpw+
 wSyVlXvK9oPxKzcPmAtVOmtUaN6kn+NYEou8yV7qPDzFj5YqpmaehZceGe1Jf7036tuO bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h43cu0hs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 16:30:57 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 264G3tlW026793;
        Mon, 4 Jul 2022 16:30:56 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h43cu0hrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 16:30:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 264GMC97008512;
        Mon, 4 Jul 2022 16:30:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3h2d9jaxbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 16:30:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 264GTdaw20054430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 16:29:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42A4A11C050;
        Mon,  4 Jul 2022 16:30:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3422611C04A;
        Mon,  4 Jul 2022 16:30:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.191.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  4 Jul 2022 16:30:51 +0000 (GMT)
Date:   Mon, 4 Jul 2022 19:30:49 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] secretmem: drop unneeded initialization in
 secretmem_file_create()
Message-ID: <YsMVuVBoCVWUawsq@linux.ibm.com>
References: <20220704092605.19604-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704092605.19604-1-lukas.bulwahn@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eHOg46GdlyEixKN991psQ6ZIf0VubMuc
X-Proofpoint-ORIG-GUID: gIlQ0z65uu7v642PDYHSFqXRCZenWHWt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_16,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Mon, Jul 04, 2022 at 11:26:05AM +0200, Lukas Bulwahn wrote:
> Drop the unneeded initialization of the local variable file in function
> secretmem_file_create().
> 
> No functional change and no change in the resulting object code.
> 
> This unneeded initialization was already introduced with the introduction
> of secretmem in commit 1507f51255c9 ("mm: introduce memfd_secret system
> call to create "secret" memory areas"). This minor code-stylistic issue
> was discovered as a dead store with clang-analyzer.

You are right and in the current code the initialization is unneeded, but
there's a pending patch that relies of this initialization:

https://lore.kernel.org/all/Yr1jKwz2+SGxjcuW@kernel.org/

Let's wait and see how that fix develops.

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mike, please ack.
> 
> Andrew, please pick this minor stylistic clean-up patch. Thanks.
> 
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 7584aab54d20..46b431d62761 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -171,7 +171,7 @@ static struct vfsmount *secretmem_mnt;
>  
>  static struct file *secretmem_file_create(unsigned long flags)
>  {
> -	struct file *file = ERR_PTR(-ENOMEM);
> +	struct file *file;
>  	struct inode *inode;
>  	const char *anon_name = "[secretmem]";
>  	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
