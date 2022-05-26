Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB9534DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242121AbiEZLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiEZLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:00:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192AECEB92
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:00:49 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QAtDUC016023;
        Thu, 26 May 2022 11:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=l8ymdFPKx9NxSBaBHmNxGdEPPBdO9GWM3Uxv/hg8+Qk=;
 b=PJKcfNeViCG0zC4CppH69vpjIXO0Kf5zZ4KSXIoneJcTYLPfvgfaYCwri7TCo3RIqmEC
 Gg5Ri9q3zU4Aysin8WKpVcxqNjreU5THuO1Dc1+ZeOiRGiaEUKd9KyIYCQbwPKZLwNKk
 ZwRUCFaF4MIzQQKMZ4rZ9aGALqbf1N90xx6NW6OTIvKy+b7fvkady7ad6YB9k3V7Mxsq
 QgGhpGykfS3hfXhMc4kZd61LSJBMohNlMm8awHBPcSZWcJYU5wMPKrt1aR8qaNyCL+RH
 i2boShNZIbOd6t8WCa9nBaoYBy4fSn+U7wWYmON3rSvdXI1KOPBT6nw39/VPvdfPAxfU Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ga87er24k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 11:00:30 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24QAv9lU026100;
        Thu, 26 May 2022 11:00:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ga87er23s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 11:00:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24QAqchF027501;
        Thu, 26 May 2022 11:00:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3g93uwag3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 11:00:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24QB0Pes47776178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 11:00:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 108F54C04A;
        Thu, 26 May 2022 11:00:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47B034C046;
        Thu, 26 May 2022 11:00:24 +0000 (GMT)
Received: from localhost (unknown [9.43.88.34])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 May 2022 11:00:24 +0000 (GMT)
Date:   Thu, 26 May 2022 16:30:22 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
        <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
        <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
        <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
        <20220520104641.GB194232@MiWiFi-R3L-srv>
        <877d6g0zxq.fsf@email.froward.int.ebiederm.org>
        <20220525125627.acf27b28bb67417a6683a1d9@linux-foundation.org>
In-Reply-To: <20220525125627.acf27b28bb67417a6683a1d9@linux-foundation.org>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1653562638.7zk3zmzd88.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MfXC3c06CYrObppP6N9usjnRovuCi-VE
X-Proofpoint-ORIG-GUID: XQr1JTPr7tfOQdpRu52eY4NCSM3eMPMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_03,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=982
 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205260052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 20 May 2022 14:25:05 -0500 "Eric W. Biederman" <ebiederm@xmission=
.com> wrote:
>=20
>> > I am not strongly against taking off __weak, just wondering if there's
>> > chance to fix it in recordmcount, and the cost comparing with kernel f=
ix;
>> > except of this issue, any other weakness of __weak. Noticed Andrew has
>> > picked this patch, as a witness of this moment, raise a tiny concern.
>>=20
>> I just don't see what else we can realistically do.
>=20
> I think converting all of the kexec __weaks to use the ifdef approach
> makes sense, if only because kexec is now using two different styles.
>=20
> But for now, I'll send Naveen's v2 patch in to Linus to get us out of
> trouble.

Thanks!

>=20
> I'm thinking that we should add cc:stable to that patch as well, to
> reduce the amount of problems which people experience when using newer
> binutils on older kernels?

Yes, please. I missed tagging this for stable. It looks like this is=20
applicable all the way back to v4.9 (though I haven't tested if=20
recordmcount fails in the same manner with those older kernel levels). I=20
will post backports once this gets into linus' tree.


- Naveen
