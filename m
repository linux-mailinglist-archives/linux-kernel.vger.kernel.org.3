Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298A4F11C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352127AbiDDJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDDJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:16:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB043B3D6;
        Mon,  4 Apr 2022 02:14:44 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2348jSuK022927;
        Mon, 4 Apr 2022 09:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GQa4dUqo2VI4GxIa+aRuhSHq4bfQQ7AzPX5fSNIQSkU=;
 b=XlJ3MGa7JW67J3qreQG26cArrYURWUjJADmmbxJq6t2kqNJySeQxAUwDIgZTNbvSIiR/
 ZPJnuvfFfAuoqbbQPcsSaAXdFklQy/z+JeuhTyZRQAvUsZ/1q1DTTsqyW/ZyI7ghKDv3
 MOoicpxeO5A5z1VEm1VR6ftgiRx/7a149yzdcoLRlTZ/FeKIjVO7RPic3hCr8jgmHYDJ
 zKxLyay9rxaT60RlS++cdCVEsBcnuGgS7VrrypAcPvUTow3VHWtAqcYObGxjT4DcAKfO
 91bjzGtVNVY6zL6IrztBcicGoRxeBIujnJdovBuXdFM2xWvStwIDmEDeKu8UxSa3tYq1 JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6ywhmxyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 09:14:43 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2348jKo7031946;
        Mon, 4 Apr 2022 09:14:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6ywhmxye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 09:14:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234973cj013551;
        Mon, 4 Apr 2022 09:14:41 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhk8s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 09:14:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2349EcqT32244172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 09:14:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E2975204F;
        Mon,  4 Apr 2022 09:14:38 +0000 (GMT)
Received: from osiris (unknown [9.145.2.177])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D4C4C5204E;
        Mon,  4 Apr 2022 09:14:37 +0000 (GMT)
Date:   Mon, 4 Apr 2022 11:14:36 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     cgel.zte@gmail.com
Cc:     gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, lv.ruyi@zte.com.cn,
        egorenar@linux.ibm.com, oberpar@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] s390: replace zero-length array with flexible-array
 member
Message-ID: <Ykq2/JEubkdX7GWR@osiris>
References: <20220401075639.2407457-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220401075639.2407457-1-lv.ruyi@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gRvhvQFwpneu12mUj-Lcyhje4TrFXbcA
X-Proofpoint-ORIG-GUID: 5Kwx4m1tPBDxh7Wi_SxQMlF2KeVhWCEw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_03,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 clxscore=1011 mlxscore=1
 mlxlogscore=207 suspectscore=0 spamscore=1 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 07:56:39AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/s390/char/sclp_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please resend with a proper sign-off chain. Thanks!
