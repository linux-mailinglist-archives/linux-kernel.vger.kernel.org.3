Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51395063FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbiDSFqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348666AbiDSFqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:46:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD327CF8;
        Mon, 18 Apr 2022 22:44:01 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23J345KV020017;
        Tue, 19 Apr 2022 05:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=obwN8oUvupwjyjKY/chlEjlYvImpg6BZ2gGJ3oZ9MwY=;
 b=dgoPyJFhY+BNKhUlGkVjv4MfPskZ2U8A30ydo4lWJxo12l3hPljZVbMvaC07dE4SesLJ
 v/D8c5AeoveyZe1hvLn+uJi8sLD9oe1stHeuz8dDcqjZsKp3xCiu4J0UzxRV2ULIok2e
 sconbOrDN/BBn95u8vqH7OEiRggpRUYeYGtBunj7mJSkHlGn4uAfBikepY6n1nweeArH
 3mowyXlb+daSfF6FiUq7gKonObxzFnSAT0miyDxeNLPf2DlnFnaz6gCtGRF0Ye01KWiD
 9DwpxK8/wEAlGS1xLZEKKjjcIrAw52GA8+pD2iKqtT4lL6XTfNOeuurgEwnYsnV0nhZz 9w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7bsx4vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 05:43:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23J5baKD001935;
        Tue, 19 Apr 2022 05:43:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2huquf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 05:43:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23J5V55h48300306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 05:31:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C1B252054;
        Tue, 19 Apr 2022 05:43:50 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C1CEF52050;
        Tue, 19 Apr 2022 05:43:49 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390/dasd: Use kzalloc instead of kmalloc/memset
References: <1650332600-5307-1-git-send-email-baihaowen@meizu.com>
Date:   Tue, 19 Apr 2022 07:43:49 +0200
In-Reply-To: <1650332600-5307-1-git-send-email-baihaowen@meizu.com> (Haowen
        Bai's message of "Tue, 19 Apr 2022 09:43:20 +0800")
Message-ID: <yt9dilr539wq.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _spaM9_F1r8VDQHNTlX6YYj_oLnddAYl
X-Proofpoint-GUID: _spaM9_F1r8VDQHNTlX6YYj_oLnddAYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_01,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxscore=0 mlxlogscore=757 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Haowen Bai <baihaowen@meizu.com> writes:

> Use kzalloc rather than duplicating its implementation, which
> makes code simple and easy to understand.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index 8410a25a65c1..74a035c56c3e 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1480,7 +1480,7 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
>  {
>  	struct pe_handler_work_data *data;
>  
> -	data = kmalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
> +	data = kzalloc(sizeof(*data), GFP_ATOMIC | GFP_DMA);
>  	if (!data) {
>  		if (mutex_trylock(&dasd_pe_handler_mutex)) {
>  			data = pe_handler_worker;
> @@ -1489,7 +1489,6 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
>  			return -ENOMEM;
>  		}
>  	} else {
> -		memset(data, 0, sizeof(*data));
>  		data->isglobal = 0;

Maybe also remove the isglobal assigment above, so the whole else block
could go away?

>  	}
>  	INIT_WORK(&data->worker, do_pe_handler_work);

Thanks,
Sven
