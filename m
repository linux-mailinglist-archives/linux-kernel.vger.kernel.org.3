Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72C505AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbiDRPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbiDRPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:22:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169624EDF6;
        Mon, 18 Apr 2022 07:23:43 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23IE0XXD008922;
        Mon, 18 Apr 2022 14:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D1vKXONw+AN3xZoH/6lkKMME4+9BmnWR8NIKVXFFFvE=;
 b=WyVJMTRxXzus39hsjIeMlmB9OjWEE5T8IRNyWRZwrJX9ubNwF5uJ/ERIamgxasbQprUu
 xWWzaJIh/fFPZWdCoVOkZA7FkiPzIlYlPMG+9jnqnartpLH6twfNnDmzlKcAw2X0kjCJ
 k8erWqJ99YwqyGAWZAZJNuRPJrUJhSbRCl6Zmnbfz3rKcUSuBaxkRpVkqrPnaZNX+OF/
 ZF2MfsjVbrBdItiQEAMo+T9eYzHGDrZUok6ULjAK3HP90tm+/TK32RmgrBacMllUUu54
 6k7mPyX2YX3a8Y2PXge9y6TROfwpSo6Yl8Xy1NnHCjbCgogsI7YVglS82Fy0nTt/hGzD Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg79we4hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 14:23:42 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23IDuZWQ019475;
        Mon, 18 Apr 2022 14:23:42 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg79we4h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 14:23:42 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23IE8pFT000838;
        Mon, 18 Apr 2022 14:23:41 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3ffne9j20v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 14:23:41 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23IENdZB24052116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Apr 2022 14:23:39 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B161FBE054;
        Mon, 18 Apr 2022 14:23:39 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF979BE059;
        Mon, 18 Apr 2022 14:23:38 +0000 (GMT)
Received: from [9.65.204.148] (unknown [9.65.204.148])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 18 Apr 2022 14:23:38 +0000 (GMT)
Message-ID: <2440b3f3-6961-4091-438f-7120b9177164@linux.ibm.com>
Date:   Mon, 18 Apr 2022 10:23:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] s390: vfio-ap: Remove the superfluous MODULE_DEVICE_TABLE
 declaration
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20220413094416.412114-1-thuth@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20220413094416.412114-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AtQlH9Wnul7p-xAysXU9EKk-XjnnFnGF
X-Proofpoint-ORIG-GUID: OiiHRIG7GVSf_sLXQNA_cASzx8tlliLJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204180083
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

On 4/13/22 5:44 AM, Thomas Huth wrote:
> The vfio_ap module tries to register for the vfio_ap bus - but that's
> the interface that it provides itself, so this does not make much sense,
> thus let's simply drop this statement now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   See also my previous patch to register it for the "ap" bus instead:
>   https://lore.kernel.org/linux-s390/20211201141110.94636-1-thuth@redhat.com/
>   ... but since it has been decided to not auto-load the module uncondi-
>   tionally, I'd like to suggest to rather drop this line now instead.
>
>   drivers/s390/crypto/vfio_ap_drv.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 29ebd54f8919..4ac9c6521ec1 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -46,8 +46,6 @@ static struct ap_device_id ap_queue_ids[] = {
>   	{ /* end of sibling */ },
>   };
>   
> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
> -
>   static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
>   {
>   	struct ap_matrix_mdev *matrix_mdev;

