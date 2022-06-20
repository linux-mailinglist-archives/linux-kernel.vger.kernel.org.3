Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92825551777
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiFTLcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiFTLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B361659C;
        Mon, 20 Jun 2022 04:32:09 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K9lqKu014285;
        Mon, 20 Jun 2022 11:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jVK9wEHh9LZRmdSSR3RPiJgDvlpS/1VQQpJjOHSTab0=;
 b=oygUGqBa7ycL8mx/OsywQTa3pk8zMctBovo4rC7Ab8fGYjkJ+kJlLsJt0e+KqjtGcyEP
 WrpJfcXrj/zcoMaRLE3AswFGdOitqiOuUOs7dDKRVGGGHmEYgaHrH+o9eKD+AVj4Jb+r
 JfGsxxwvGP1/OsXAaHmJPIhiimo8rRc96Jx/RhMknEo/nLjipO4eqO78t1D9/i9+OG5x
 O8ttdT2MR4sNm1EMW1aBXzaMAKCd7jkCkbC0Zo+XiPXLml1j82512naZ2+PpZ5ddRCxL
 08NKMCDteuRNOFBrXrer95bKWmgsXF2j/+3/usQ0nn08EaPLv5HdsM75nB4A57UnXyrO EA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr0ufa3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 11:32:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25KBLq2T013053;
        Mon, 20 Jun 2022 11:32:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b92e0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 11:32:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25KBW1mG19464534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 11:32:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C3AC11C054;
        Mon, 20 Jun 2022 11:32:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A9211C04A;
        Mon, 20 Jun 2022 11:32:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Jun 2022 11:32:00 +0000 (GMT)
Date:   Mon, 20 Jun 2022 13:31:59 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2] s390/kvm: avoid hypfs error message
Message-ID: <YrBarz+NVJmS+bBb@tuxmaker.boeblingen.de.ibm.com>
References: <20220620094534.18967-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620094534.18967-1-jgross@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4zcbB7HEji5h78Opc3VL9WADUSoFH-jM
X-Proofpoint-ORIG-GUID: 4zcbB7HEji5h78Opc3VL9WADUSoFH-jM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=931 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:45:34AM +0200, Juergen Gross wrote:
> When booting under KVM the following error messages are issued:
> 
> hypfs.7f5705: The hardware system does not support hypfs
> hypfs.7a79f0: Initialization of hypfs failed with rc=-61
> 
> Demote the severity of first message from "error" to "info" and issue
> the second message only in other error cases.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Applied, thanks!

> ---
> V2:
> - don't bail out if KVM, but avoid error messages instead (Christian
>   Borntraeger)
> ---
>  arch/s390/hypfs/hypfs_diag.c | 2 +-
>  arch/s390/hypfs/inode.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
> index f0bc4dc3e9bf..6511d15ace45 100644
> --- a/arch/s390/hypfs/hypfs_diag.c
> +++ b/arch/s390/hypfs/hypfs_diag.c
> @@ -437,7 +437,7 @@ __init int hypfs_diag_init(void)
>  	int rc;
>  
>  	if (diag204_probe()) {
> -		pr_err("The hardware system does not support hypfs\n");
> +		pr_info("The hardware system does not support hypfs\n");
>  		return -ENODATA;
>  	}
>  
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 5c97f48cea91..ee919bfc8186 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -496,9 +496,9 @@ static int __init hypfs_init(void)
>  	hypfs_vm_exit();
>  fail_hypfs_diag_exit:
>  	hypfs_diag_exit();
> +	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
>  fail_dbfs_exit:
>  	hypfs_dbfs_exit();
> -	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
>  	return rc;
>  }
>  device_initcall(hypfs_init)
> -- 
> 2.35.3
> 
