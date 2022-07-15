Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917F575CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiGOHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiGOHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:49:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E06C3F328;
        Fri, 15 Jul 2022 00:49:23 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F7gO2x008426;
        Fri, 15 Jul 2022 07:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=obIETS1plMGdBYnXOhK0FWQ76TayIWIT5daNAJ2hqvE=;
 b=FGkaaWsYhxG4yGU2bDow3vSORDHXRocPpkDoEtReLjqq6qkaE7N/UOdue0sNscX+h90k
 38KWJrVHmLTzxvNJnYPo16z7AiqPABK1hnoVuftR2ic0OV+k+CF43SmwpLr7mA8J1H1Q
 S1e1k1s7hEUFXwlkfvvhkPCDEwB+BRqcnFJvm1E9Wr/r16s7G0djhLFhhQeDw6vdMfhi
 St/s0cSMiwABaoKSC4F52vAWq+kVpFrCfcxGnTIqW4Kinw05e6jz4/zRoPAdeZyNfTnc
 a4PQDUzfbiNqDeNp4QLcLs2cteTr3cj33zoxwkjsxtw5AqwVlszaoPEmYgtP+9/aWmJq Ew== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb42vr4q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:49:21 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F7b3xo019282;
        Fri, 15 Jul 2022 07:49:18 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3h71a8p47q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:49:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F7nFHB20840722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 07:49:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AFA7AE056;
        Fri, 15 Jul 2022 07:49:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66D6AAE053;
        Fri, 15 Jul 2022 07:49:15 +0000 (GMT)
Received: from vela (unknown [9.145.26.36])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Jul 2022 07:49:15 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.94.2)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1oCG4X-0002V8-M2; Fri, 15 Jul 2022 09:49:13 +0200
Date:   Fri, 15 Jul 2022 09:49:13 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH v2 0/3] s390/cpufeature: rework to allow different types
 of cpufeatures
Message-ID: <YtEb+ZeHJ+NbuQKD@linux.ibm.com>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713125644.16121-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NrlKyrrwodamK7ZPJwExaYSrWT6tPx8g
X-Proofpoint-ORIG-GUID: NrlKyrrwodamK7ZPJwExaYSrWT6tPx8g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxlogscore=756 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe, I am bit late ...

On Wed, Jul 13, 2022 at 02:56:41PM +0200, Steffen Eiden wrote:
> Currently the s390 implementaion of cpufeature is limited to elf_hwcap
> bits. Using these to automatically load modules also exposes this
> cpufeature to userspace which, sometimes is not intended.

Those features are (always) exposed to user space as module loading is
actually done by udev rules. However, we had some pseudo-hwcaps (e.g. sie64a)
in the past.. but I very appreciate this change!

Thanks.
