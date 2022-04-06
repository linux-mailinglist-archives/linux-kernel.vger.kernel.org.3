Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377AE4F5E57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiDFMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiDFMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:47:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFB48C25B;
        Wed,  6 Apr 2022 01:51:08 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2366JJQu016125;
        Wed, 6 Apr 2022 08:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wHKJ2+xwyGZNajEcxxu2aQg2smDO126PmLvXyE+oMws=;
 b=ZUt7Vhmc5QWyGFIEhSuiSr26xyfguOFsrtakuv9sN2wuyrPWj6ebyrh170Yf9EtBxoVO
 FRBmRe+ZLh91wehvl7gt4Vmx0kgHWiloKgdMt5n12spTHlQg5nIArI/Nra4hlT9fIZUa
 dd/RUWDHpB5rSudKm2EV8ppBUvKsfuJKDpEg/mIUMhuZVDV1H3mEookhrmYdgNDfjQMx
 y1QZVvQ1dyJ7Ye15Dqs8oXVwOprzwhbBS/CM/m4oWUCrLnybeOjN/IkeXUmwZUbU0RDR
 UB4Ibi859bBYPMfNb+KjXHbRbU46/qHRaRfhu/NUGpfphK5wZxoegDs3386P2jMf3uoM 8A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f8ut8mjc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 08:50:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2368hNio018634;
        Wed, 6 Apr 2022 08:45:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3f6e48ydxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 08:45:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2368jtwR37028232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 08:45:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E88311C050;
        Wed,  6 Apr 2022 08:45:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E20D711C04C;
        Wed,  6 Apr 2022 08:45:47 +0000 (GMT)
Received: from osiris (unknown [9.145.157.192])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Apr 2022 08:45:47 +0000 (GMT)
Date:   Wed, 6 Apr 2022 10:45:46 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] s390: Simplify the calculation of variables
Message-ID: <Yk1TOpjLnmUcRQt3@osiris>
References: <Ykq2H+POaGs0GHVU@osiris>
 <1649212651-32038-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649212651-32038-1-git-send-email-baihaowen@meizu.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IFtypbOqYdccKy17qyJfLjF-yRvDIxSR
X-Proofpoint-ORIG-GUID: IFtypbOqYdccKy17qyJfLjF-yRvDIxSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_03,2022-04-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=994
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:37:31AM +0800, Haowen Bai wrote:
> Fix the following coccicheck warnings:
> ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
>  !A || A && B is equivalent to !A || B
> 
> I apply a readable version just to get rid of a warning.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: apply a readable and simple version as suggestion.
> 
>  arch/s390/include/asm/scsw.h | 47 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 15 deletions(-)

[full quote below]

Vineeth, Peter, could one of you please Review and or ACK the patch
below?

Thank you!

> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
> index a7c3ccf681da..b7e65f96de3c 100644
> --- a/arch/s390/include/asm/scsw.h
> +++ b/arch/s390/include/asm/scsw.h
> @@ -508,9 +508,13 @@ static inline int scsw_cmd_is_valid_zcc(union scsw *scsw)
>   */
>  static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
>  {
> -	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
> -	       !(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
> -	       (scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS);
> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
> +		return 0;
> +	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
> +		return 0;
> +	if (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS)
> +		return 1;
> +	return 0;
>  }
>  
>  /**
> @@ -522,10 +526,15 @@ static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
>   */
>  static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
>  {
> -	return (scsw->cmd.fctl != 0) &&
> -	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
> -	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
> -		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
> +	if (!scsw->tm.fctl)
> +		return 0;
> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
> +		return 0;
> +	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
> +		return 1;
> +	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
> +		return 1;
> +	return 0;
>  }
>  
>  /**
> @@ -675,9 +684,13 @@ static inline int scsw_tm_is_valid_q(union scsw *scsw)
>   */
>  static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
>  {
> -	return (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
> -	       !(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
> -	       (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS);
> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
> +		return 0;
> +	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
> +		return 0;
> +	if (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS)
> +		return 1;
> +	return 0;
>  }
>  
>  /**
> @@ -689,11 +702,15 @@ static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
>   */
>  static inline int scsw_tm_is_valid_pno(union scsw *scsw)
>  {
> -	return (scsw->tm.fctl != 0) &&
> -	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
> -	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
> -		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
> -		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
> +	if (!scsw->tm.fctl)
> +		return 0;
> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
> +		return 0;
> +	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
> +		return 1;
> +	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
> +		return 1;
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.7.4
> 
