Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9AA50A171
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387795AbiDUOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388799AbiDUOFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:05:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6F33B287;
        Thu, 21 Apr 2022 07:02:15 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LCNtng020172;
        Thu, 21 Apr 2022 14:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=aI024WHC/bEMg8nvZ834auRImnWK7kVLOZ4xKww3Qfg=;
 b=CRiCjvirWXl4MnbJVF7/otV8kD8HghhK81jWpyKyzW6Vw0YyWQCsVc6SWw7CUpVwhTir
 R1oqH8ayvLY8Jchbmokq95DNYftbhjgiDLD5lFJ2p+7jkFXlyUthR4LlchklkzlXXHcv
 ANvt+CiK9c6uMngU1TQ917DXmywz55JeDAKTNeBL6KlOfyst9U9Zz0/9cvbkOihVtCkk
 DVXjAMaKjq5OVdf9QygnF+eRomXZe0iwwqTWe6yPsnOiyu51FNTIM7LgEF//ZkkfqreP
 DW+ERxN9eX1WggA3NwqwqSkyXRLd0mr5jcMjw8zGEN+cKizqmcu1w8eclF1/Aiui/IwW 9w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fk1ye94cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 14:02:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23LDrCWM015800;
        Thu, 21 Apr 2022 14:02:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ffne980hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 14:02:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23LE28tQ25362744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 14:02:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3793D11C054;
        Thu, 21 Apr 2022 14:02:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA16D11C04A;
        Thu, 21 Apr 2022 14:02:07 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Apr 2022 14:02:07 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        krebbel@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: -Warray-bounds fun again
Date:   Thu, 21 Apr 2022 16:02:07 +0200
Message-ID: <yt9dzgkelelc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K4RxM8JLj-DcbUAXNWZRXoVGcuvmMJEe
X-Proofpoint-GUID: K4RxM8JLj-DcbUAXNWZRXoVGcuvmMJEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_01,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1011 adultscore=0
 mlxlogscore=248 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while compiling the latest upstream kernel on fedora 36 which
uses gcc-12 by default, i got a lot of -Warray-bounds warnings:

(Note that this is on s390 arch)

In function =E2=80=98preempt_count=E2=80=99,
inlined from =E2=80=98do_one_initcall=E2=80=99 at init/main.c:1290:14:
./include/asm-generic/rwonce.h:44:26: warning: array subscript 0 is outside=
 array bounds of =E2=80=98const volatile int[0]=E2=80=99 [-Warray-bounds]
44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)=
&(x))
   |        ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   /include/asm-generic/rwonce.h:50:9: note: in expansion of macro =E2=80=
=98__READ_ONCE=E2=80=99
50 |         __READ_ONCE(x);
   |         ^~~~~~~~~~~
./arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro =E2=80=
=98READ_ONCE=E2=80=99
17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_R=
ESCHED;
   |                ^~~~~~~~~

This is because S390_lowcore is defined as follows:

#define S390_lowcore (*((struct lowcore *) 0))

Lowcore is a 8K cpu-local memory region on s390 at fixed address 0.

The obvious 'fix' is to use absolute_pointer():

#define S390_lowcore (*((struct lowcore *)absolute_pointer(0)))

That makes the warning go away, but unfortunately the compiler no longer
knows that the memory access is fitting into a load/store with a 12 bit
displacement.

Without absolute_pointer(), reading the preempt count is just a single
instruction: 'l %r11,936'

static inline int preempt_count(void)
{
        return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHE=
D;
 8c4:   58 b0 03 a8             l       %r11,936 <--- load preempt count
 8c8:   b9 04 00 92             lgr     %r9,%r2
        int count =3D preempt_count();

with absolute pointer(), the compiler no longer optimizes the read to
one instruction and uses an additional base register:

static inline int preempt_count(void)
{
        return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHE=
D;
 8c4:   a7 19 00 00             lghi    %r1,0             <-- use %r1 as ba=
se, load with 0
 8c8:   b9 04 00 92             lgr     %r9,%r2
        int count =3D preempt_count();
        char msgbuf[64];
 8cc:   d7 3f f0 a8 f0 a8       xc      168(64,%r15),168(%r15)
 8d2:   58 b0 13 a8             l       %r11,936(%r1)    <-- and finally ad=
d the offset and fetch
        int ret;

The reason for gcc to not optimize that further is likely the asm
statement in RELOC_HIDE (located in include/linux/compiler-gcc.h)

#define RELOC_HIDE(ptr, off)                                    \
({                                                              \
        unsigned long __ptr;                                    \
        __asm__ ("" : "=3Dr"(__ptr) : "0"(ptr));                  \
        (typeof(ptr)) (__ptr + (off));                          \
})


For most of the code this wouldn't be a big problem, but we're storing
information like preempt_count, current thread info, etc in lowcore
because it is the fastest way. I would like to avoid to use additional
instructions/registers just to avoid a warning.

Does anyone have an idea about a different way to make this warning go
away?

Thanks
Sven
