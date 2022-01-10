Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA048A377
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbiAJXN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:13:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242143AbiAJXN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:13:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AM2g4I006099;
        Mon, 10 Jan 2022 23:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nL1zNfOtg2xDTBWto4WY5EGHjN9yJR41TReQXGIiyc4=;
 b=hVOxYeCQsYN+jaQjYY3bCrj0SdV4aQATLEwEM9TMZPO196mnKkmd0xma7u8UfeR4MA3t
 ibV8uRDg3T6O771On97DoqEmJCm/HTmtaG8ILiMhs9cIEa/DrC7W5pYL9RSIKflqX1ni
 KCp+X/evzpyIeLlmJ7krTV0QfqYtMr8EV4DAGup+tCHdEB7+lFKJj0mQWss8Mm3jZSnt
 H4bpB0C8uKreASI5Fp3vAG2qMcy1W1ASvjIjgQSbpFRNlaAJaPac11Hum7Wl6SkDWkDq
 m7L4CY50LU8V23PUfQw5pucT1V8+OJ4TJdFiyDSBtzEEBbgHdy9E0t60v24tjlzFl/DI pg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm5s74d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 23:13:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20ANC3Jl026832;
        Mon, 10 Jan 2022 23:13:11 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3df28a10a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 23:13:11 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20AND8Er34079008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:13:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31630B2068;
        Mon, 10 Jan 2022 23:13:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80BADB2067;
        Mon, 10 Jan 2022 23:13:07 +0000 (GMT)
Received: from [9.211.117.94] (unknown [9.211.117.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 23:13:07 +0000 (GMT)
Message-ID: <e4435a87-da52-e781-4833-c7095a890275@linux.ibm.com>
Date:   Mon, 10 Jan 2022 17:13:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] fsi: scom: Fix error handling
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211207033811.518981-1-joel@jms.id.au>
 <20211207033811.518981-2-joel@jms.id.au>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20211207033811.518981-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LI1Ggpa-NFf0UnhjiqFzGvQSEYUtr-yQ
X-Proofpoint-ORIG-GUID: LI1Ggpa-NFf0UnhjiqFzGvQSEYUtr-yQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/21 21:38, Joel Stanley wrote:
> SCOM error handling is made complex by trying to pass around two bits of
> information: the function return code, and a status parameter that
> represents the CFAM error status register.
>
> The commit f72ddbe1d7b7 ("fsi: scom: Remove retries") removed the
> "hidden" retries in the SCOM driver, in preference of allowing the
> calling code (userspace or driver) to decide how to handle a failed
> SCOM. However it introduced a bug by attempting to be smart about the
> return codes that were "errors" and which were ok to fall through to the
> status register parsing.
>
> We get the following errors:
>
>   - EINVAL or ENXIO, for indirect scoms where the value is invalid
>   - EINVAL, where the size or address is incorrect
>   - EIO or ETIMEOUT, where FSI write failed (aspeed master)
>   - EAGAIN, where the master detected a crc error (GPIO master only)
>   - EBUSY, where the bus is disabled (GPIO master in external mode)
>
> In all of these cases we should fail the SCOM read/write and return the
> error.
>
> Thanks to Dan Carpenter for the detailed bug report.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Fixes: f72ddbe1d7b7 ("fsi: scom: Remove retries")
> Link: https://lists.ozlabs.org/pipermail/linux-fsi/2021-November/000235.html
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   drivers/fsi/fsi-scom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index da1486bb6a14..3b427f7e9027 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -289,7 +289,7 @@ static int put_scom(struct scom_device *scom, uint64_t value,
>   	int rc;
>   
>   	rc = raw_put_scom(scom, value, addr, &status);
> -	if (rc == -ENODEV)
> +	if (rc)
>   		return rc;
>   
>   	rc = handle_fsi2pib_status(scom, status);
> @@ -308,7 +308,7 @@ static int get_scom(struct scom_device *scom, uint64_t *value,
>   	int rc;
>   
>   	rc = raw_get_scom(scom, value, addr, &status);
> -	if (rc == -ENODEV)
> +	if (rc)
>   		return rc;
>   
>   	rc = handle_fsi2pib_status(scom, status);
