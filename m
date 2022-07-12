Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9948571939
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiGLL5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiGLL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:57:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533D4BFA;
        Tue, 12 Jul 2022 04:56:46 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CBhTSI032402;
        Tue, 12 Jul 2022 11:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xxM1sBw1RpcPmqSpO/GY77EKZByGzVx/ORbOWcO5qxo=;
 b=f2cwwTTON7TEzct2RaDF32enwFddVe0lYbQ4CY/hjyGNhQuP+PQ84L8sEesvSVD7BIdj
 Y2sbpiIodpjUYYKkr8KvtFTIlRx6YT+I5eR+z/nrQUDokv4KgVDnSKJCgtnz01u8FKJx
 TyS0Ugx0kbw4lfczOY1U3xbbFAr5e5JGg9wRxVF7aJen3jxBQUiZKK6aksxVAj44mlaD
 3KLCRPSLshyOFQX+Tmm+49SKBcravGL/fhECHzf3uAD+yr3p2DuB/ZAcvQ6kyYG8kbdu
 Ilf9Ywm1GIspNq7lwHlBi+hiXoidi5QSNBcQZphRthAb+rinfa8uhf/nluHPVky6Sqkx 3A== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9640ca4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:56:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CBpXu2000558;
        Tue, 12 Jul 2022 11:56:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3h71a8kd68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 11:56:41 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CBucpD9371904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 11:56:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 856D511C050;
        Tue, 12 Jul 2022 11:56:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEEE11C04C;
        Tue, 12 Jul 2022 11:56:38 +0000 (GMT)
Received: from [9.145.42.82] (unknown [9.145.42.82])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 11:56:38 +0000 (GMT)
Message-ID: <367ea79f-293e-d93f-6c99-65c62c886e70@linux.ibm.com>
Date:   Tue, 12 Jul 2022 13:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only hwcap
 bits
Content-Language: en-US
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     nrb@linux.ibm.com
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-2-seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <20220712105220.325010-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NtT4heE-oEbzHjbZGKjMIswCE6v0lgmG
X-Proofpoint-GUID: NtT4heE-oEbzHjbZGKjMIswCE6v0lgmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_08,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 12:52, Steffen Eiden wrote:
> Rework cpufeature implementation to allow for various cpu feature
> indications, which is not only limited to hwcap bits. This is achieved
> by adding a sequential list of cpu feature numbers, where each of them
> is mapped to an entry which indicates what this number is about.
> 
> Each entry contains a type member, which indicates what feature
> name space to look into (e.g. hwcap, or cpu facility). If wanted this
> allows also to automatically load modules only in e.g. z/VM
> configurations.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sorry for the confusion. I modified a rfc from Heiko he sent to me.
My amended modifications also changed the author to myself of that
patch automatically.

Steffen
