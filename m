Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51CD502112
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiDODyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiDODyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:54:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23DF340E1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:51:40 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F38RZr012679;
        Fri, 15 Apr 2022 03:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 reply-to : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pp1;
 bh=vALf+WQvPVlXNJIKBWGBIlY6MFZpgu2JSpIf1y0Agxw=;
 b=pN3bJ/JWkyu6gkqJULME2UHIqqswASbQc3GWMHlFj3/NAwtveAXAMSBpMIDqN1xfpzbD
 MfGzfugzT+cVzoERCM68UuERt3LRhKaBZh6Zql/eNkiwe8rv3QysRPp69cden4uKehDU
 G3ekvirt9BGXQb+Hv+4LxzX6ymNMQfChMv1y8dS4fC0GHqLgwNO07A/L9tDyr9Bi92Kh
 KyHg48SQ7ozsCePMbi5CVI/YOtrMLplLZxSXvMR/esvllH2+idzit+mGEtXzmEJvxkwF
 CrhJB0hGwMTLhpZDH8mUq2QyG9sw/JAPhpbmT2DB4mphtY4ZlhmB9BMF4F/eDg9EiU1A 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fefa050rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 03:51:38 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23F3pc7Q014127;
        Fri, 15 Apr 2022 03:51:38 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fefa050rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 03:51:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23F3l7Wb022587;
        Fri, 15 Apr 2022 03:51:37 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3fb1sap8ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 03:51:37 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23F3pa6s7472124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 03:51:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EB21AC05B;
        Fri, 15 Apr 2022 03:51:36 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EDDEAC05E;
        Fri, 15 Apr 2022 03:51:35 +0000 (GMT)
Received: from [9.160.168.34] (unknown [9.160.168.34])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Apr 2022 03:51:35 +0000 (GMT)
Message-ID: <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
Date:   Fri, 15 Apr 2022 00:51:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Reply-To: muriloo@linux.ibm.com
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
Content-Language: en-US
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        dinechin@redhat.com
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
From:   =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220415023002.49805-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B6OS1YiADaGoVhCS7hzp93AgCMkxN8cr
X-Proofpoint-ORIG-GUID: Xn6QBZEtqrYu3-PvPFQ6FUCH4T-ndqeZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_01,2022-04-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150019
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 23:30, Murilo Opsfelder Araujo wrote:
> GCC 12 enhanced -Waddress when comparing array address to null [0],
> which warns:
> 
>      drivers/virtio/virtio_pci_common.c: In function ‘vp_del_vqs’:
>      drivers/virtio/virtio_pci_common.c:257:29: warning: the comparison will always evaluate as ‘true’ for the pointer operand in ‘vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 256)’ must not be NULL [-Waddress]
>        257 |                         if (vp_dev->msix_affinity_masks[i])
>            |                             ^~~~~~
> 
> In fact, the verification is comparing the result of a pointer
> arithmetic, the address "msix_affinity_masks + i", which will always
> evaluate to true.
> 
> Under the hood, free_cpumask_var() calls kfree(), which is safe to pass
> NULL, not requiring non-null verification.  So remove the verification
> to make compiler happy (happy compiler, happy life).
> 
> [0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102103
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>   drivers/virtio/virtio_pci_common.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index d724f676608b..5046efcffb4c 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>   
>   	if (vp_dev->msix_affinity_masks) {
>   		for (i = 0; i < vp_dev->msix_vectors; i++)
> -			if (vp_dev->msix_affinity_masks[i])
> -				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> +			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
>   	}
>   
>   	if (vp_dev->msix_enabled) {

After I sent this message, I realized that Christophe (copied here)
had already proposed a fix:

     https://lore.kernel.org/lkml/20220414150855.2407137-4-dinechin@redhat.com/

Christophe,

Since free_cpumask_var() calls kfree() and kfree() is null-safe,
can we just drop this null verification and call free_cpumask_var() right away?

-- 
Murilo
