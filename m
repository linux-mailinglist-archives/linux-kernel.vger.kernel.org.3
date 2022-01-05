Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26264485C34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbiAEXUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:20:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245348AbiAEXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:20:01 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205MC5m7013705;
        Wed, 5 Jan 2022 23:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=5nhAuUGy4s/feljIwBRFAak36LkwKkjrrPJnBSJyHw4=;
 b=LpOZLfG/yorAP1uqCownEE2tB5vYpx6Z/6JYUsqzx6804FgGe7wwbSeKGbFki6KN5Voo
 DT9f+Eb643E2TNu0hrW6jh43Xv6xd6ujPZk4jRrR4unKMlpYu2wVVIbAqELQq5KF6gFS
 r4iHlmIiQqGA5Wbw9VQEmKAIqaYAAgNESIGhb98zQIgmojXdc7ZkbP+9l6DvGc1+uKSU
 PLomTeaZGYFIKiYAQpRdmmbTq4/WTIwvFOLKkMKQ60BbUrgLgYHFvE49qOmTb3QWq2U9
 qRzi1FgPM2fexLheUTzYrez8nNH/5v2k0JI5UQqGmZ6PITlWGlddLklCzVjueVWuBd4c 0Q== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxtd1hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 23:19:53 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 205NIK11022817;
        Wed, 5 Jan 2022 23:19:52 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3daekbj5a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 23:19:52 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 205NJoOq36897172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 23:19:50 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C359B6E054;
        Wed,  5 Jan 2022 23:19:50 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 602986E053;
        Wed,  5 Jan 2022 23:19:50 +0000 (GMT)
Received: from localhost (unknown [9.65.92.26])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 23:19:49 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4] powerpc/pseries: read the lpar name from the firmware
In-Reply-To: <25527544-b0ac-596c-3876-560493b99f6b@linux.ibm.com>
References: <20211207171109.22793-1-ldufour@linux.ibm.com>
 <25527544-b0ac-596c-3876-560493b99f6b@linux.ibm.com>
Date:   Wed, 05 Jan 2022 17:19:49 -0600
Message-ID: <8735m1ixd6.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AHwdpzrmszQBOJqeRl9Xam2MeG5QAYGM
X-Proofpoint-ORIG-GUID: AHwdpzrmszQBOJqeRl9Xam2MeG5QAYGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_07,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=801 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> On 07/12/2021, 18:11:09, Laurent Dufour wrote:
>> The LPAR name may be changed after the LPAR has been started in the HMC.
>> In that case lparstat command is not reporting the updated value because it
>> reads it from the device tree which is read at boot time.
>> 
>> However this value could be read from RTAS.
>> 
>> Adding this value in the /proc/powerpc/lparcfg output allows to read the
>> updated value.
>
> Do you consider taking that patch soon?

This version prints an error on non-PowerVM guests the first time
lparcfg is read.

And I still contend that having this function fall back to reporting the
partition name in the DT would provide a beneficial consistency in the
user-facing API, allowing programs to avoid hypervisor-specific branches
in their code. I don't understand the resistance I've encountered here.
The fallback I'm suggesting (a root node property lookup) is certainly
not more complex than the RTAS call sequence you've already implemented.
