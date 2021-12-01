Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0476A4653AA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhLARNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:13:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231379AbhLARNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:13:34 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Glfh8018387;
        Wed, 1 Dec 2021 17:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2YkocgshkxUm4oqRLSxIPYhafjxpXZO2WxBkFPjg/BQ=;
 b=Sheuo6HKUWdNyW4JCrVRN2s+eGFFlAVJvNAVZPioNwW74IAj1RxNDAGVjHkcAjQB1+mI
 zFlcu8jwNj+BuIZ7pjIAXOMoY2RQ+j7AE9I96NsnkHupRUFFqxzQB46uXORJJmrmy5Vd
 plbOmxW1I/GXej6T2v96BIWuqDv/DwdxwNvAvKI+8LMnfsTGKeqduTfgJB8urfYlqGYU
 YuNPCIL8JljNuxp5pIDxnW9rAIftwsiWTA01AkeK1ScZXSUGWYNjpWpyvrci/YBB+/F0
 cVfWjri1q72OMJvrz/Jh+2uFuUQolSY6XshqQYqOMcjil6LTnzc5kGlCR9aq4a45X8Ec 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpcvqrekh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:10:11 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B1Go6El029260;
        Wed, 1 Dec 2021 17:10:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cpcvqrej7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:10:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B1H7lwv021638;
        Wed, 1 Dec 2021 17:10:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3ckbxkc9rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Dec 2021 17:10:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B1H2b7r27722050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Dec 2021 17:02:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02D6F4C050;
        Wed,  1 Dec 2021 17:10:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 877104C05A;
        Wed,  1 Dec 2021 17:10:04 +0000 (GMT)
Received: from funtu.home (unknown [9.145.74.207])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Dec 2021 17:10:04 +0000 (GMT)
Subject: Re: [RFC PATCH] s390: vfio-ap: Register the vfio_ap module for the
 "ap" parent bus
To:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211201141110.94636-1-thuth@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Message-ID: <210e3c57-bdc2-09ed-3e41-8dab57e8f36c@linux.ibm.com>
Date:   Wed, 1 Dec 2021 18:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201141110.94636-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B2Do6vHDdT1A4H27gGkvjGoA2cOYhBDQ
X-Proofpoint-ORIG-GUID: KE5ZKGfpvVmQ1VOYdJ9wOeRsawfF1EY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.21 15:11, Thomas Huth wrote:
> The crypto devices that we can use with the vfio_ap module are sitting
> on the "ap" bus, not on the "vfio_ap" bus that the module defines
> itself. With this change, the vfio_ap module now gets automatically
> loaded if a supported crypto adapter is available in the host.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: Marked as "RFC" since I'm not 100% sure about it ...
>        please review carefully!
>
>  drivers/s390/crypto/vfio_ap_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 4d2556bc7fe5..5580e40608a4 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -39,7 +39,7 @@ static struct ap_device_id ap_queue_ids[] = {
>  	{ /* end of sibling */ },
>  };
>  
> -MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
> +MODULE_DEVICE_TABLE(ap, ap_queue_ids);
>  
>  /**
>   * vfio_ap_queue_dev_probe:
Hello Thomas, interesting.
Did you test this ? I mean did you build a kernel and have it run on a s390 with crypto cards available ?
My strong feeling is that this will make the AP bus code stumble as the code silently assumes there are exact
two types of ap devices attached to the ap bus: ap cards and ap queues. This is a fair assumption as the ap bus
is the 'owner' of what's attached to the bus it maintains. But with this change and no further arrangements
in the ap bus code my feeling is ...
However, Tony is the owner of the vfio ap stuff, so maybe he has another opinion.
Harald Freudenberger

