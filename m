Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B026470530
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhLJQIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:08:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239447AbhLJQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:08:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAFwXnQ023556;
        Fri, 10 Dec 2021 16:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0FJK33Ayo3hcdhLtaclH1bs23KNt56Fl+62KbymvUm4=;
 b=l066FEK5HDzjjx0kLyuTx8zXEkecgW/DpWht5d4se12UdvkH2fDiHq8KxaYcyJBQvFLa
 uD5p858JnONeu5QCKLSRPoMMHLBeO4Q6e3qeI3CrTQh37JwUmBPSm8+G+kopocw23exj
 RtNgwosCfwwQ3YPA86aKtiMTTR9v7FspwCwMFx0Rgmi5ATsZj37rCq1ow/yZ+x58RwAi
 UNnkR9roDrUAjrZtR5vL4PbPmom+j2YpAVKJVayy+5GsJwXuKyGt1qJNC4Dj+1VYe5c7
 /K9qb7N1umc2RXXxvCOXMWtPnaKs6UDMhcfAixcmqIQDQrFBC75WsNBGp1pBApkVXI2r Vw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv9jnrs5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 16:05:12 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAG20PV020668;
        Fri, 10 Dec 2021 16:05:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3cqyyaa9e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 16:05:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAG56UI14942466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 16:05:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68BC952063;
        Fri, 10 Dec 2021 16:05:06 +0000 (GMT)
Received: from osiris (unknown [9.145.166.74])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1CB8252051;
        Fri, 10 Dec 2021 16:05:06 +0000 (GMT)
Date:   Fri, 10 Dec 2021 17:05:04 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/3215: fix the array may be out of bounds
Message-ID: <YbN6sMzBqtF507FE@osiris>
References: <20211210070217.188697-1-yinxiujiang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210070217.188697-1-yinxiujiang@kylinos.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XdfYCjGe1YqTssUaajkquFlYr6rr0Zrp
X-Proofpoint-ORIG-GUID: XdfYCjGe1YqTssUaajkquFlYr6rr0Zrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_06,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxlogscore=803
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:02:17PM +0800, Yin Xiujiang wrote:
> if the variable 'line' is NR_3215,
> the 'raw3215[line]' will be invalid
> 
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>  drivers/s390/char/con3215.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> index f356607835d8..29409d4ca4d5 100644
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -687,7 +687,8 @@ static void raw3215_remove (struct ccw_device *cdev)
>  		for (line = 0; line < NR_3215; line++)
>  			if (raw3215[line] == raw)
>  				break;
> -		raw3215[line] = NULL;
> +		if (line < NR_3215)
> +			raw3215[line] = NULL;

This doesn't make sense to me. This could only happen if a device that
was never probed would be removed. The original code could have been
written better to make that more obvious, but with this patch the code
will become even more confusing.

Therefore not applying.
