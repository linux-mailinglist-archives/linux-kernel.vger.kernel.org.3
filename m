Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A24D554B79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355672AbiFVNkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiFVNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:39:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B430F4C;
        Wed, 22 Jun 2022 06:39:56 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MDL5BV000423;
        Wed, 22 Jun 2022 13:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MIOkSCnlVLcAhLd5cb5OReABj2o3Cvs4r07uhlU71k4=;
 b=VQejSdNn3cG38sXiNMzNb1mE+SRWmY4LeCvw9oiB54fYbOqpOKFCrFONoEs1QXqQrex6
 VPoX2mXOrByjes8KhGeJxN/WD+mVq0jjDaKm5QpGQMz73TNwmc4t1S03tjQ8N6TwyMNp
 gDM1UFN+/0tG7+5UmxaJDQMO3ejVHr7ND2BY0JuhNeuWXpcw+7NKXTmviD88OAmVToVY
 j6bnvtqy2KEtYSD7pZ0QFaZgUZX7jVXBCV59MHYlv+RnPVA+WSvxBreNiFaaHLQgg4G3
 LjftO7R8M1mnaWoeIO9NUHO9PeIsO5wwG6rcOh8fVFFFqV38+mgYc7fr+79gyxxbdiDa uQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv3vy0gvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:39:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MDZ3Uk014063;
        Wed, 22 Jun 2022 13:39:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3gs5yhnqqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:39:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MDdjdO13304092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 13:39:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF3ADA4055;
        Wed, 22 Jun 2022 13:39:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F0F5A4040;
        Wed, 22 Jun 2022 13:39:45 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 13:39:45 +0000 (GMT)
Date:   Wed, 22 Jun 2022 15:39:43 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390: remove unneeded 'select BUILD_BIN2C'
Message-ID: <YrMbn54exFHzC2AJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220613170902.1775211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613170902.1775211-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AM2h9ezXQ1c0MRTAsPtp1e60bofLxRSk
X-Proofpoint-ORIG-GUID: AM2h9ezXQ1c0MRTAsPtp1e60bofLxRSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=858 priorityscore=1501 malwarescore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206220069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:09:00AM +0900, Masahiro Yamada wrote:
> Since commit 4c0f032d4963 ("s390/purgatory: Omit use of bin2c"),
> s390 builds the purgatory without using bin2c.
> 
> Remove 'select BUILD_BIN2C' to avoid the unneeded build of bin2c.
> 
> Fixes: 4c0f032d4963 ("s390/purgatory: Omit use of bin2c")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 91c0b80a8bf0..8cd9e56c629b 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -484,7 +484,6 @@ config KEXEC
>  config KEXEC_FILE
>  	bool "kexec file based system call"
>  	select KEXEC_CORE
> -	select BUILD_BIN2C
>  	depends on CRYPTO
>  	depends on CRYPTO_SHA256
>  	depends on CRYPTO_SHA256_S390

Applied, thanks!

> -- 
> 2.32.0
> 
