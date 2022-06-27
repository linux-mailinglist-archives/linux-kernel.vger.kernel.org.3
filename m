Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514E55CD15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiF0JzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiF0Jy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:54:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A17C63E2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:54:58 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R9L2Gm023644;
        Mon, 27 Jun 2022 09:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=/y3l5xAjx+IYQtvlH/fk4bKasCuTmYHVC/DKG2WAsHM=;
 b=Q8o0hlYYANpHPdtJNoLwaR8eX6tlEQlXTThyqwLK7JA5pAudQt5ZHyC94ElGRDTc28OT
 VAcidVoSHKwpSWQ3LlWgmfA8GZFvgc6Q9CnBMK6uWbhv6WdELSMYuatnfDSkqBh3AxGf
 v1bMsG4UpBQNBqBKY10uKXdQnIn5L0nuHkbPPumf8Us01vjX9j0KFeTD0dIS38+bnl8Z
 0Ly6mavX/xNazRpHjSW1rN0ghQwvQvVF8kiEm2cfvnKdMs1gLDD6ss8c+o3jZCqLVyta
 mHZavXuLApoJ/pGAyuz6+D9jEeHXlp+1ILVdE5Cidzb5NGCPGGrBmTLAz0RkAc0cNEjV Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gy9uegng6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:54:49 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25R9QSks013472;
        Mon, 27 Jun 2022 09:54:49 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gy9uegnfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:54:49 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25R9pDmB018787;
        Mon, 27 Jun 2022 09:54:48 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3gwt094stu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:54:48 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25R9skV910813860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 09:54:47 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5E046A04D;
        Mon, 27 Jun 2022 09:54:46 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96A626A051;
        Mon, 27 Jun 2022 09:54:46 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.10.229.42])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jun 2022 09:54:46 +0000 (GMT)
MIME-Version: 1.0
Date:   Mon, 27 Jun 2022 11:54:46 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Vladis Dronov <vdronov@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/1] tools/testing/crypto: Use vzalloc instead of
 vmalloc+memset
Reply-To: freude@linux.ibm.com
In-Reply-To: <20220627075148.140705-1-code@siddh.me>
References: <20220627075148.140705-1-code@siddh.me>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9f79f8edfa8f7c5099b842f020782ac2@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xI9r3hS_Qbzt_MtV4L6wEaoZNmA1_1OW
X-Proofpoint-ORIG-GUID: fJmfIu6SBsiFcHS5PBmyP1Oua5vvwc8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=940 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-27 09:51, Siddh Raman Pant wrote:
> This fixes the corresponding coccinelle warning.
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  tools/testing/crypto/chacha20-s390/test-cipher.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/crypto/chacha20-s390/test-cipher.c
> b/tools/testing/crypto/chacha20-s390/test-cipher.c
> index 34e8b855266f..8141d45df51a 100644
> --- a/tools/testing/crypto/chacha20-s390/test-cipher.c
> +++ b/tools/testing/crypto/chacha20-s390/test-cipher.c
> @@ -252,29 +252,26 @@ static int __init chacha_s390_test_init(void)
>  	memset(plain, 'a', data_size);
>  	get_random_bytes(plain, (data_size > 256 ? 256 : data_size));
> 
> -	cipher_generic = vmalloc(data_size);
> +	cipher_generic = vzalloc(data_size);
>  	if (!cipher_generic) {
>  		pr_info("could not allocate cipher_generic buffer\n");
>  		ret = -2;
>  		goto out;
>  	}
> -	memset(cipher_generic, 0, data_size);
> 
> -	cipher_s390 = vmalloc(data_size);
> +	cipher_s390 = vzalloc(data_size);
>  	if (!cipher_s390) {
>  		pr_info("could not allocate cipher_s390 buffer\n");
>  		ret = -2;
>  		goto out;
>  	}
> -	memset(cipher_s390, 0, data_size);
> 
> -	revert = vmalloc(data_size);
> +	revert = vzalloc(data_size);
>  	if (!revert) {
>  		pr_info("could not allocate revert buffer\n");
>  		ret = -2;
>  		goto out;
>  	}
> -	memset(revert, 0, data_size);
> 
>  	if (debug)
>  		print_hex_dump(KERN_INFO, "src: ", DUMP_PREFIX_OFFSET,
Thanks Siddh
I'll forward this patch into the s390 subsystem and on the next merge
window for the 5.20 kernel then it will appear in the upstream kernel.
