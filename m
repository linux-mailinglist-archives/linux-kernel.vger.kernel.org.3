Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F88D52B877
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiERLUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiERLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EE1737FE;
        Wed, 18 May 2022 04:19:52 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IBDsJg019124;
        Wed, 18 May 2022 11:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=NMUk7scsu6NZ9A1gFglIKuqfx7tEaQ6FQyLAtW1QS68=;
 b=rtE8Wqlxjoe8QfOFmSd2+jRg3IUTqV3FBLPi7MVk9L7p90i6gipSPe9NcI2xPjg6BpKF
 g1qqE+RriQPYLON6LaGWrVMe1ANb9pAbUeoJlAjU6h1H3QXNlts93RjPDYOngIMbBvKM
 7gBGqQ9QmDq1k43jGPIKqLv5aYPSe30rrR7vxFi0P3bILBp1G3p5P27/v3T9XZjMMKof
 GLClDFCsNLXPHYhJmxQ5Sn7K+KL1mbrjmA/yoU8enaNgfTwHzkNgLRuyghgenHoOYCCq
 Zcx54Cj4Mu78UVaINU6YoTUwBjQuoEt1Ucd+U6hPcOnbGzZNomqX7rrWVW+STONjdbO8 xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4yr4g41v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:19:47 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IBFUAt022640;
        Wed, 18 May 2022 11:19:47 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4yr4g41c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:19:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IB8OMI029648;
        Wed, 18 May 2022 11:19:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjdm57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 11:19:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IBJfqI44892572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 11:19:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79BA54C046;
        Wed, 18 May 2022 11:19:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C3764C040;
        Wed, 18 May 2022 11:19:41 +0000 (GMT)
Received: from osiris (unknown [9.145.54.247])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 May 2022 11:19:40 +0000 (GMT)
Date:   Wed, 18 May 2022 13:19:39 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Jann Horn <jannh@google.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/crypto: fix scatterwalk_unmap() callers in AES-GCM
Message-ID: <YoTWSxEYPo1MLQTc@osiris>
References: <20220517143047.3054498-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517143047.3054498-1-jannh@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pdTgmxH6gZ8qS8AQOKYU6qdavpgfHgm3
X-Proofpoint-ORIG-GUID: 7x1tqo9l-E_uOcaMWYkxGA9jVmv9O3fb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_04,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=767 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:30:47PM +0200, Jann Horn wrote:
> The argument of scatterwalk_unmap() is supposed to be the void* that was
> returned by the previous scatterwalk_map() call.
> The s390 AES-GCM implementation was instead passing the pointer to the
> struct scatter_walk.
> 
> This doesn't actually break anything because scatterwalk_unmap() only uses
> its argument under CONFIG_HIGHMEM and ARCH_HAS_FLUSH_ON_KUNMAP.
> 
> Note that I have not tested this patch in any way, not even compile-tested
> it.
> 
> Fixes: bf7fa038707c ("s390/crypto: add s390 platform specific aes gcm support.")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> IDK which tree this has to go through - s390 or crypto?
> maybe s390 is better, since they can actually test it?

Applied to s390 tree. Thanks!
