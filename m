Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CC50815D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355703AbiDTGrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352533AbiDTGrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:47:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377F2702;
        Tue, 19 Apr 2022 23:45:04 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K5NsRi027973;
        Wed, 20 Apr 2022 06:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=Q/OoGAt84YUtee6RudtEDHYR8suIEFSOH24kMxzGjmI=;
 b=GAFsjJISaJyjPi+dbLXRTDxNt5+ntyRFkPyiaEGqalwFgFpZunYGfxOHLLFOduZwU1sE
 CDczYIL6zfuEk3+/h7NL35SJxey5UBWQb54lebwDCGw7RzqpM0oxv+4h58zNUTY46xse
 DWwRyMpPCBOW6BO/bd2z3WFLzHgKj1/lB8Lcfc/hZBCRPpodaLl5AutUiXVhveSPpDV0
 hrqCS+HrHN7TjUUZGM/E1D5TsShLnqTTERoVwoi0utWAC7/HpAlEJrbXV+RSwDMQIGoR
 BU1bzHsLt6ag1wofucNXhQFOeSMXTHrGEtlQDSXorx36X6g4qRe8YP15ayT33U0WthvJ ag== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7ctv3db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 06:45:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23K6hBVD002772;
        Wed, 20 Apr 2022 06:44:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne95s3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 06:44:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23K6itMk50201000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 06:44:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10CE952051;
        Wed, 20 Apr 2022 06:44:55 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B96895204F;
        Wed, 20 Apr 2022 06:44:54 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <gor@linux.ibm.com>, <hca@linux.ibm.com>, <hoeppner@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <sth@linux.ibm.com>
Subject: Re: [PATCH V2] s390/dasd: Use kzalloc instead of kmalloc/memset
References: <yt9dilr539wq.fsf@linux.ibm.com>
        <1650348310-18553-1-git-send-email-baihaowen@meizu.com>
Date:   Wed, 20 Apr 2022 08:44:54 +0200
In-Reply-To: <1650348310-18553-1-git-send-email-baihaowen@meizu.com> (Haowen
        Bai's message of "Tue, 19 Apr 2022 14:05:10 +0800")
Message-ID: <yt9dy200xnh5.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: imJ-wYaYsRrgwYw1_S3lcLJjrUhUSfkP
X-Proofpoint-ORIG-GUID: imJ-wYaYsRrgwYw1_S3lcLJjrUhUSfkP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_08,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=747 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haowen Bai <baihaowen@meizu.com> writes:

> Use kzalloc rather than duplicating its implementation, which
> makes code simple and easy to understand.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: also remove the isglobal assigment above, so the whole else block
> could go away
>
>  drivers/s390/block/dasd_eckd.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index 8410a25a65c1..6b70f9dfff02 100644
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
> @@ -1488,9 +1488,6 @@ static int dasd_eckd_pe_handler(struct dasd_device *device,
>  		} else {
>  			return -ENOMEM;
>  		}
> -	} else {
> -		memset(data, 0, sizeof(*data));
> -		data->isglobal = 0;
>  	}
>  	INIT_WORK(&data->worker, do_pe_handler_work);
>  	dasd_get_device(device);

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
