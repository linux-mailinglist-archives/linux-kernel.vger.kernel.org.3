Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FB47C02E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhLUM4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:56:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231538AbhLUM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:56:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLChdYv029670;
        Tue, 21 Dec 2021 12:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SpLvhm7tF9KE5fpCNTj6hVoObGxGQ8mrc91u2Ve+pjs=;
 b=GE60ICZowdNtiRanuYbRFXDrIM1P+RIWJw6SRfpoS3k/zV8mGGvGyLBctlreEptTIlts
 lwkGnxL+LsdknfnQfxAPk/Z3ihduBfpucvV/XYX56ZkQPohvUuREr1ika43mjemcPRu8
 bdnAlf6Wbkl9u9r/BA/R1Si2C+cat44v04zqmoYnST9DGCOK9BouRtIQWVWaapJoYLwT
 PuMFs+l7ukgWN/pmjbgFimEpzllcrFxJ1URcUWhwIxHXdlUmdIZyr/W7OhMnZbt1xbzX
 DQEaydtBhAnP+UM7SqKnmHatHmBHtI3C+2sx8Y6DkdJrXEk+9zKmMIz6451aFVW8RryN VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d1saj569u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 12:56:10 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BLCqTP2024554;
        Tue, 21 Dec 2021 12:56:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d1saj569f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 12:56:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLCqgEp006218;
        Tue, 21 Dec 2021 12:56:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3d16wjny4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 12:56:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLCu6s638666630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 12:56:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2488F5204F;
        Tue, 21 Dec 2021 12:56:06 +0000 (GMT)
Received: from sig-9-65-79-111.ibm.com (unknown [9.65.79.111])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 25FD052052;
        Tue, 21 Dec 2021 12:56:05 +0000 (GMT)
Message-ID: <15ff5c8f3a3ffc2929baf3accd5670bb524f2f6f.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Do not load MOK and MOKx when secure boot be
 disabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        James Morris <jmorris@namei.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>,
        Petr Vorel <pvorel@suse.cz>
Date:   Tue, 21 Dec 2021 07:56:04 -0500
In-Reply-To: <20211218020905.7187-1-jlee@suse.com>
References: <20211218020905.7187-1-jlee@suse.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eJzMBshLAnDnD_O4__RxQZa8_D7u2LtQ
X-Proofpoint-ORIG-GUID: MZV8p-Fv_7qufVawJReQ_cI4GNRtOund
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

On Sat, 2021-12-18 at 10:09 +0800, Lee, Chun-Yi wrote:
> The security of Machine Owner Key (MOK) relies on secure boot. When
> secure boot is disabled, EFI firmware will not verify binary code. Then
> arbitrary efi binary code can modify MOK when rebooting.
> 
> This patch prevents MOK/MOKx be loaded when secure boot be disabled.
> 
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Sorry for the delay in testing this patch.  I got the booster Friday
and am still suffering from fever spikes, chills, and headaches. The
kexec selftest might need to be updated as well.

thanks,

Mimi

> ---
>  security/integrity/platform_certs/load_uefi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
> index f290f78c3f30..08b6d12f99b4 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -6,6 +6,7 @@
>  #include <linux/err.h>
>  #include <linux/efi.h>
>  #include <linux/slab.h>
> +#include <linux/ima.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include "../integrity.h"
> @@ -176,6 +177,10 @@ static int __init load_uefi_certs(void)
>  		kfree(dbx);
>  	}
>  
> +	/* the MOK/MOKx can not be trusted when secure boot is disabled */
> +	if (!arch_ima_get_secureboot())
> +		return 0;
> +
>  	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
>  	if (!mokx) {
>  		if (status == EFI_NOT_FOUND)


