Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727214F981D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiDHOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiDHOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:34:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA6E3A52F8;
        Fri,  8 Apr 2022 07:32:37 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238BsItx011875;
        Fri, 8 Apr 2022 14:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Yyoh96ToAORcDBu7MBR2eTzEMFQp2ULLdGv1Qt3neVA=;
 b=EhocSSuyXbQPZyAsXGpyknsngeNux10yYqhXqTrIyPXOKvuhqfQP9cD5QBn5yLRiIe6C
 Cko6vYrOfeTIoJbBIngc5CE6SGxcOXkNfCA5pgFAZqj5MRjZwi8tmX2F2fVexvZVVmOg
 5doc3mwNIfOvbGWOC2/lHw8IQiRelqPDmXdrVoLM60zhIRxsgayx+V7bnQ9tDPOZjuve
 f6y0WzpE1rigzXNL0o2tYfxnwMl5gXV9QcSTykMavN8tpobRb2C2zK2fkBhIMlzBgifh
 Md3wO/ppRw/YzEtWoSXySMjuRZ6A0qT9mqTaPpNYgd3W6ZuwX2UFDMFJl65uAlljLi8A VA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3faesst5vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:32:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 238EDMR7009660;
        Fri, 8 Apr 2022 14:32:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhuxg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:32:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 238EWVm343581912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Apr 2022 14:32:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6AE811C052;
        Fri,  8 Apr 2022 14:32:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 452DA11C04C;
        Fri,  8 Apr 2022 14:32:23 +0000 (GMT)
Received: from osiris (unknown [9.145.55.81])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Apr 2022 14:32:23 +0000 (GMT)
Date:   Fri, 8 Apr 2022 16:32:21 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Haowen Bai <baihaowen@meizu.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] s390: Simplify the calculation of variables
Message-ID: <YlBHdey48aFxBoFg@osiris>
References: <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
 <1649297808-5048-1-git-send-email-baihaowen@meizu.com>
 <c4c5ae75-29e0-c2f0-045c-1911d0f28067@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c5ae75-29e0-c2f0-045c-1911d0f28067@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ybeoSkcRxCShtnhPC1K_PYCw3vqD5lN3
X-Proofpoint-GUID: ybeoSkcRxCShtnhPC1K_PYCw3vqD5lN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_05,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=850 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204080071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:53:02PM +0200, Peter Oberparleiter wrote:
> On 07.04.2022 04:16, Haowen Bai wrote:
> > Fix the following coccicheck warnings:
> > ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
> >  !A || A && B is equivalent to !A || B
> > 
> > I apply a readable version just to get rid of a warning.
> > 
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> 
> A definitive improvement over the current version. Thanks!
> 
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Applied, thanks!
