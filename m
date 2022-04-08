Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B594F9630
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiDHMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiDHMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:55:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C233F4635;
        Fri,  8 Apr 2022 05:53:16 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238BpF1d008179;
        Fri, 8 Apr 2022 12:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wsBnHun015lCQuaK8oqGWat9NvvVMJqWW59CeiA+eZs=;
 b=lV79TKqM5iF4fzhoD5BO75GRYiIe0EAMnA34RAKRgG+PxB1a2wwD3htfbgOM3tB/sclc
 OcCqMlaDiSv0ZNTSX6caSbCIkMjZm3OrLHK0Ba0dLJdjk/hpOObwZgj6YjeDLVcv2/GA
 FB4DAhpRBS7iCnntyz5dPklegwfYkr2b1zi9cFPGjETDtgw0qgh36P0mz62KqluxJMf0
 CRmDOj4/EUCq9JRhEIMjyKi6MfxEFBKWHWbtOOMwjiMiIzSxeHTXgtL08YtZ2nxMeFQ3
 ypma3T5ZsIst2Kt5qNbL8h5rBUL1DQuBU6Jl6QlugJP8URdFE6636VCETCH4oZBxWfMy FQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fa5fb1nyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 12:53:08 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238Cr6hR022864;
        Fri, 8 Apr 2022 12:53:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3f6drhspys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 12:53:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238Cr3me54329806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 12:53:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7916FA405F;
        Fri,  8 Apr 2022 12:53:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21989A405B;
        Fri,  8 Apr 2022 12:53:03 +0000 (GMT)
Received: from [9.145.39.73] (unknown [9.145.39.73])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Apr 2022 12:53:03 +0000 (GMT)
Message-ID: <c4c5ae75-29e0-c2f0-045c-1911d0f28067@linux.ibm.com>
Date:   Fri, 8 Apr 2022 14:53:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH V3] s390: Simplify the calculation of variables
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
 <1649297808-5048-1-git-send-email-baihaowen@meizu.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <1649297808-5048-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1sv5n2Zy8wqCZ2_FrwYTQDKjAV0qN3WO
X-Proofpoint-ORIG-GUID: 1sv5n2Zy8wqCZ2_FrwYTQDKjAV0qN3WO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_04,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=862 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.2022 04:16, Haowen Bai wrote:
> Fix the following coccicheck warnings:
> ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
>  !A || A && B is equivalent to !A || B
> 
> I apply a readable version just to get rid of a warning.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

A definitive improvement over the current version. Thanks!

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
