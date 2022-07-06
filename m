Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFC56864E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiGFLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:01:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03013FBB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:01:43 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266B1OtG013215;
        Wed, 6 Jul 2022 11:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9ECjS3YJuJOkzGYX4kmrLNyDsW1B8QqHQli/hHQnEXs=;
 b=UZu+WVzqwQjDMo7kk3Kr6nVqfRl37ih5x0dTpnlTw3Xpq09XBpopaHqVQ30oKcbW/Hpg
 GTdt1WXKUYykwv0RZ7/Vggt0deKq1ud5GG4wRwgetiqJk2hWvF99yMF10J0ySDmFAIKZ
 TE9oxRnMw49l/2itW5MERAxzu6aqJA3CuA4I8vOdRQxU3mKz2sRJlIKH95XqU7m3Ub34
 aNeWtEhbpJD78MqVZoITd8+xdrADGF1xmvkdC0ssFIbr73U7DESpbxori8u/QpSWaZod
 FflVBmfyQcah4CsCz5jOi6FTxMgWILEcSDLQb8AT1sPYDR0Ydsa9AD43YnhOcUG8z2MD Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h58449nka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 11:01:25 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 266B1PcX013295;
        Wed, 6 Jul 2022 11:01:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h58449n69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 11:01:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266Apkjq004078;
        Wed, 6 Jul 2022 11:01:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h4v4jrv5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 11:01:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266B17dL33030612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 11:01:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE5964204B;
        Wed,  6 Jul 2022 11:00:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 549A142042;
        Wed,  6 Jul 2022 11:00:58 +0000 (GMT)
Received: from localhost (unknown [9.43.110.188])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 11:00:58 +0000 (GMT)
Date:   Wed, 06 Jul 2022 16:30:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] kexec_file: Drop weak attribute from functions
To:     Baoquan He <bhe@redhat.com>, Coiby Xu <coxu@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
        <2cd7ca1fe4d6bb6ca38e3283c717878388ed6788.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
        <YsJoGKribMH77HBQ@MiWiFi-R3L-srv> <20220706015308.heynqgictt47r3c5@Rk>
In-Reply-To: <20220706015308.heynqgictt47r3c5@Rk>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1657104347.v93p7p5tyq.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nJ-Me_QQzVIrPD4117nUAeO-rFpIwr2d
X-Proofpoint-ORIG-GUID: IijnEIfkgsui5T0NgaOcUb5DTntEzaCq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=796 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coiby,

Coiby Xu wrote:
> Hi Baoquan and Naveen,
>=20
> On Mon, Jul 04, 2022 at 12:10:00PM +0800, Baoquan He wrote:
>>On 07/01/22 at 01:04pm, Naveen N. Rao wrote:
>>> Drop __weak attribute from functions in kexec_file.c:
>>> - arch_kexec_kernel_image_probe()
>>> - arch_kimage_file_post_load_cleanup()
>>> - arch_kexec_kernel_image_load()
>>> - arch_kexec_locate_mem_hole()
>>> - arch_kexec_kernel_verify_sig()
>>>
>>> arch_kexec_kernel_image_load() calls into kexec_image_load_default(), so
>>> drop the static attribute for the latter.
>>>
>>> arch_kexec_kernel_verify_sig() is not overridden by any architecture, so
>>> drop the __weak attribute.
>>
>>The dropping of arch_kexec_kernel_verify_sig() conflicts with patch 1 of
>>anotherpatchset, and the other patches in the patchset depends on the
>>patch 1.
>>
>>[PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to verify ke=
xec'ed kernel signature
>>
>>Hi, Naveen, Coiby,
>>
>>Please negotiate how to solve the conflict.
>=20
> Thanks Baoquan for letting me know of this conflict. Naveen, how about
> resolving the conflict based on which patch is merged first? If your
> patch set is going to be merged early, I will resolve the conflict in my
> patch set, and vice versa.

Sure, that's fair. It looks like Andrew has queued up this series=20
though:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-non=
mm-unstable

The conflict itself is trivial, so it should be straightforward to=20
address it.


Thanks,
Naveen

