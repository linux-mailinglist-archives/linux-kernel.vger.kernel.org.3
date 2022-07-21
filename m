Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC757C49E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGUGpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGUGpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:45:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E777F2679;
        Wed, 20 Jul 2022 23:45:09 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L5txZd021568;
        Thu, 21 Jul 2022 06:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=C115CktZ2LDU2xFW4CNenTh8SKR5WSuD/At3LJN7JDo=;
 b=KdwyzrhOcmUlkeP9qBWi3kIsUpp7bv2iROuwRtmfWCCRJjbi0s1s3PXDz/4sduPTGUaI
 KY2a+WbJVdvxVQO4bZZd8uXhpmC5Xvx3r85FFTS179o4RyxkzAwj2PCW+AFvwLl40QwN
 ZAylk4IwjkbFoCjsyTYBdTgHqklcI46leifarRFYPfDmzwUtYXKetPYVkJzgGPgUYwjr
 kk4Bzp2QiCrDZiVuQ+D0RXnp8tXAi+vmxA43mub0gYet3+Oj8qiFgUMsswjolkS0/t4X
 wu09eVEbMveXCLHpRbSjpeJuD7ZWN2tUVxPJlHPA9poL0+Pl9ugACe50PSnbzV29e3ia 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hf12x18qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 06:45:09 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26L5vYHN031347;
        Thu, 21 Jul 2022 06:45:08 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hf12x18q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 06:45:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26L6Keaj004360;
        Thu, 21 Jul 2022 06:45:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3hbmy8xg6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 06:45:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26L6j3gs23462178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 06:45:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A80BA4060;
        Thu, 21 Jul 2022 06:45:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B984A405B;
        Thu, 21 Jul 2022 06:45:03 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.22.197])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Jul 2022 06:45:03 +0000 (GMT)
Date:   Thu, 21 Jul 2022 08:45:01 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, svens@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] s390: Fix typo 'the the' in comment
Message-ID: <Ytj17XS54dfmGuG0@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220721033358.44838-1-slark_xiao@163.com>
 <YtjxaKSMDvdTsyM+@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <3e932eb1.1f0c.1821f7b4643.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e932eb1.1f0c.1821f7b4643.Coremail.slark_xiao@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LQjdb2HKHJaXcC1ZpM-ItW88lWQUOeL3
X-Proofpoint-GUID: gmsFi0OjlEA_RYCe-8Dpsdqi0LMl_ALy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=632 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:39:08PM +0800, Slark Xiao wrote:
> 
> Hi,
>   OKay, I will send v2 later.
>   BTW, add subsystems to the title would be enough, right?

Yes. Please, see other similar patches sent.
