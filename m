Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2148A378
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbiAJXOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:14:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45954 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242143AbiAJXN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:13:59 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AMFoPM027207;
        Mon, 10 Jan 2022 23:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D8siIzkqJoeELYJGDLZe7vaow3udbOOslyt1pFw8ES8=;
 b=k67tpk/hY5mae+2V7Uo+WRuHf3Dmwrs1YliXvyv14pdPTsZgp/Dzd+ZmmiP3QLAxfaEq
 dXrDY8p8KK7B5MMU843LnHMkdID1A0J5uqeb8SiK8sBjmwMIfAep8YLEiung8xVYHN3O
 DTz274+jDI7f53LXv3AhusODNFl0qjEbfJNiFRboZH7IeIVaiClhrZikcGdLLp43qjsm
 W5GVHIKasAqBYWSrPq/ahbKWjhGqvCvrqWb/z3pCIsIZtr/OIgm6t+9D36TMOq0Uj8TY
 mch+Nec0OBZ6pZ84jcmKlbnqKg6MUhjya2AKvDZi7UiRIUe5/YIA/64gXPXZRS8XoU4p uQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfmjee4yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 23:13:48 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20ANBiFw006853;
        Mon, 10 Jan 2022 23:13:47 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3df28a0y51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 23:13:47 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20ANDkA430277904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 23:13:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B05AB2065;
        Mon, 10 Jan 2022 23:13:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6DC1B2064;
        Mon, 10 Jan 2022 23:13:45 +0000 (GMT)
Received: from [9.211.117.94] (unknown [9.211.117.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 23:13:45 +0000 (GMT)
Message-ID: <82083174-fccb-a9e2-616f-7a706958e2da@linux.ibm.com>
Date:   Mon, 10 Jan 2022 17:13:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] fsi: scom: Remove retries in indirect scoms
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211207033811.518981-1-joel@jms.id.au>
 <20211207033811.518981-3-joel@jms.id.au>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20211207033811.518981-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a-k1DRH2rNje-KbDslh399ah-GnPtvmF
X-Proofpoint-ORIG-GUID: a-k1DRH2rNje-KbDslh399ah-GnPtvmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201100148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/21 21:38, Joel Stanley wrote:
> In commit f72ddbe1d7b7 ("fsi: scom: Remove retries") the retries were
> removed from get and put scoms. That patch missed the retires in get and
> put indirect scom.
>
> For the same reason, remove them from the scom driver to allow the
> caller to decide to retry.
>
> This removes the following special case which would have caused the
> retry code to return early:
>
>   -       if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
>   -               return 0;
>
> I believe this case is handled.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Fixes: f72ddbe1d7b7 ("fsi: scom: Remove retries")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   drivers/fsi/fsi-scom.c | 41 +++++++++++++++--------------------------
>   1 file changed, 15 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index 3b427f7e9027..bcb756dc9866 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -145,7 +145,7 @@ static int put_indirect_scom_form0(struct scom_device *scom, uint64_t value,
>   				   uint64_t addr, uint32_t *status)
>   {
>   	uint64_t ind_data, ind_addr;
> -	int rc, retries, err = 0;
> +	int rc, err;
>   
>   	if (value & ~XSCOM_DATA_IND_DATA)
>   		return -EINVAL;
> @@ -156,19 +156,14 @@ static int put_indirect_scom_form0(struct scom_device *scom, uint64_t value,
>   	if (rc || (*status & SCOM_STATUS_ANY_ERR))
>   		return rc;
>   
> -	for (retries = 0; retries < SCOM_MAX_IND_RETRIES; retries++) {
> -		rc = __get_scom(scom, &ind_data, addr, status);
> -		if (rc || (*status & SCOM_STATUS_ANY_ERR))
> -			return rc;
> +	rc = __get_scom(scom, &ind_data, addr, status);
> +	if (rc || (*status & SCOM_STATUS_ANY_ERR))
> +		return rc;
>   
> -		err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
> -		*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
> -		if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
> -			return 0;
> +	err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
> +	*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
>   
> -		msleep(1);
> -	}
> -	return rc;
> +	return 0;
>   }
>   
>   static int put_indirect_scom_form1(struct scom_device *scom, uint64_t value,
> @@ -188,7 +183,7 @@ static int get_indirect_scom_form0(struct scom_device *scom, uint64_t *value,
>   				   uint64_t addr, uint32_t *status)
>   {
>   	uint64_t ind_data, ind_addr;
> -	int rc, retries, err = 0;
> +	int rc, err;
>   
>   	ind_addr = addr & XSCOM_ADDR_DIRECT_PART;
>   	ind_data = (addr & XSCOM_ADDR_INDIRECT_PART) | XSCOM_DATA_IND_READ;
> @@ -196,21 +191,15 @@ static int get_indirect_scom_form0(struct scom_device *scom, uint64_t *value,
>   	if (rc || (*status & SCOM_STATUS_ANY_ERR))
>   		return rc;
>   
> -	for (retries = 0; retries < SCOM_MAX_IND_RETRIES; retries++) {
> -		rc = __get_scom(scom, &ind_data, addr, status);
> -		if (rc || (*status & SCOM_STATUS_ANY_ERR))
> -			return rc;
> -
> -		err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
> -		*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
> -		*value = ind_data & XSCOM_DATA_IND_DATA;
> +	rc = __get_scom(scom, &ind_data, addr, status);
> +	if (rc || (*status & SCOM_STATUS_ANY_ERR))
> +		return rc;
>   
> -		if ((ind_data & XSCOM_DATA_IND_COMPLETE) || (err != SCOM_PIB_BLOCKED))
> -			return 0;
> +	err = (ind_data & XSCOM_DATA_IND_ERR_MASK) >> XSCOM_DATA_IND_ERR_SHIFT;
> +	*status = err << SCOM_STATUS_PIB_RESP_SHIFT;
> +	*value = ind_data & XSCOM_DATA_IND_DATA;
>   
> -		msleep(1);
> -	}
> -	return rc;
> +	return 0;
>   }
>   
>   static int raw_put_scom(struct scom_device *scom, uint64_t value,
