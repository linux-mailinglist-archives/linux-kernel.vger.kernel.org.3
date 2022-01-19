Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C83493AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354167AbiASNUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:20:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237573AbiASNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:20:17 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JConFE022601;
        Wed, 19 Jan 2022 13:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=xdixTif3MT1ekKmqX1EMbwwvOCdQ8mq9DE0bMZxOR84=;
 b=D/ViA2p2hsaJT5k9VqbY+OzWe0ct1e5blKlCyGDHt/g55YOY1A3JyE2yVERb7nosnOQd
 9pigkom5J9w8BbE+h32yHFfot3hSiXkB0FP5Um82t2tZzC64LxjepN35k/cYmFyqGLwr
 ia2BdaieyLDJLJpRknju8KthnGVPVIgPWbW3+SgAoLqHC0ChUjGMAh/sv2wQ4EoHcThQ
 ykQBa6WYwxRpDQ059ot/EtcsDwdS9gJF+3nvmtHWoM8KuaBKWB/cYnXWi1VJE/knJUXS
 owAw4ThEsR38Fw8/0aeINd9yehLJemylxnHx5aF9MT/UUsYmow6QTbNmfLXq4Q8OnjYO vg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpgfm42bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:20:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JDHkAI006367;
        Wed, 19 Jan 2022 13:20:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3dknhjp1gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 13:20:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JDKB9937683570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 13:20:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41E00A4054;
        Wed, 19 Jan 2022 13:20:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5084A4068;
        Wed, 19 Jan 2022 13:20:10 +0000 (GMT)
Received: from osiris (unknown [9.145.70.139])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Jan 2022 13:20:10 +0000 (GMT)
Date:   Wed, 19 Jan 2022 14:20:09 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked
 access to user memory
Message-ID: <YegQCTqEsiFTUZ2R@osiris>
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com>
 <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -pzLhij0uyAo65HlgYuiB8NEGEO6kTm-
X-Proofpoint-GUID: -pzLhij0uyAo65HlgYuiB8NEGEO6kTm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_07,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 mlxlogscore=336 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:02:34PM +0100, Janis Schoetterl-Glausch wrote:
> > That's a lot of code churn... I would have expected that the existing
> > functions will be renamed, get an additional key parameter, and the
> > current API is implemented by defines which map copy_to_user() &
> > friends to the new functions, and add a zero key.
> 
> I don't think I understand you. I can implement raw_copy_from/to_user
> in terms of raw_copy_from/to_user_with_key, which does save a few lines,
> but that's it, isn't it?

Right you are. I only looked at your patch, and forgot about that all
the wrapping is nowadays done in common code.

So what I really don't like about this approach is that we get an arch
specific copy_to_user() implementation back. This means that all those
extra calls like might_fault(), instrument_copy_to_user(), and friends
now have to be kept in sync by us again, if new instrumentation or
security options are added to common code.

Given that this is manual work / monitoring I'm sure this will not
work in the mid or long term, like it has been proven several times in
the past for other features. We need something better, which works
out-of-the-box wrt common code changes / enhancements.
