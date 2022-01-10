Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E40489CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiAJQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:01:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3923 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236654AbiAJQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:01:12 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AEU778022359;
        Mon, 10 Jan 2022 16:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wNtqeE/PXUjAJMTDduMaJZsw/+oW1OiDBs4bew5Ic3I=;
 b=gNuaLqwcDmRs9Kzca0ZqlmeGq4lSewDBH0nGvPO7Z2AlX1VfQ84MZn32AOub8RHLNQzE
 ORkmXGjL6AkBa+wac3Tkn6KGpwmQPWdCzWMJt/ikBbSV31XTMWwACOFKFp6CEBZNPj84
 ZuPh/E7y6RTVYeM4O58CnFqRly5znKcTkOJjZ96mBvDCfbFxphwRdYmEjXK9MMbN8yle
 Zg0YXnHom0wEUuMaUXEixzw/eWCyfUzNYqowWq1WsziQXGmaFbzl20bknOYwSlv5XqMm
 /RL7DTcNegYz6BFChvoV6GDI3s1+crHykQ+M4JirfIRfP/Bph+sLXwuXch5yUAsN3Ffe kQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm8jnupx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:01:04 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20AFvhQQ031823;
        Mon, 10 Jan 2022 16:01:03 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3df289qsbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 16:01:03 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20AG12Qh22151546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 16:01:02 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 141FB28073;
        Mon, 10 Jan 2022 16:01:02 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD9E328065;
        Mon, 10 Jan 2022 16:01:00 +0000 (GMT)
Received: from [9.211.155.103] (unknown [9.211.155.103])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 16:01:00 +0000 (GMT)
Message-ID: <29dec8e0-a551-8aa0-4dd4-ae4d7efc37ca@linux.ibm.com>
Date:   Mon, 10 Jan 2022 10:00:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fsi: occ: Fetch OCC response header again to avoid
 checksum failure
Content-Language: en-US
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au, jk@ozlabs.org,
        alistair@popple.id.au
References: <20220105202313.27510-1-eajames@linux.ibm.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220105202313.27510-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6-znbWdXSbF6bredeywG8TV_ZAi0ozNu
X-Proofpoint-GUID: 6-znbWdXSbF6bredeywG8TV_ZAi0ozNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_06,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/22 14:23, Eddie James wrote:
> In the event that the driver state is reset, and the previous OCC
> operation had a sequence number of 1, there is the possibility that
> the SRAM buffer is updated in between fetching the OCC response header
> and the rest of the data (since the sequence number match is really a
> false positive). This results in a checksum failure. To avoid this
> condition, simply fetch the whole response rather than skipping the
> header when fetching the rest of the response.


This can be abandoned in favor of the latest patch, "Improve response 
status checking"

Thanks,

Eddie


>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/fsi/fsi-occ.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index 7eaab1be0aa4..660c3fc43be5 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -546,10 +546,15 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>   	dev_dbg(dev, "resp_status=%02x resp_data_len=%d\n",
>   		resp->return_status, resp_data_length);
>   
> -	/* Grab the rest */
> +	/*
> +	 * Grab the rest, including the occ response header again, just in case
> +	 * it changed in between our two getsram operations (this can happen
> +	 * despite the sequence number check if the driver state is reset). The
> +	 * data length shouldn't change at OCC runtime, and the response
> +	 * status, which may have changed, has to be checked by users anyway.
> +	 */
>   	if (resp_data_length > 1) {
> -		/* already got 3 bytes resp, also need 2 bytes checksum */
> -		rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
> +		rc = occ_getsram(occ, 0, resp, resp_data_length + 7);
>   		if (rc)
>   			goto done;
>   	}
