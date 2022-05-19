Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9752CF61
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiESJ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiESJ2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:28:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E425FF10
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:28:41 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J9Rgia019896;
        Thu, 19 May 2022 09:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Us/wTEHc1pNDKFsixu7C15Rmob4t3fstlrDv4JPRNqI=;
 b=TZ9OQbZVdf4/KzGepqqFN47sgCQ5mcFAp8Qs3f1uesfJEOlIWGsh4uH01bXzbAESpVUp
 P7++5pAwqOZPNbu6v/2aQjkvcetjRbDiPp/m6VZ6iw1EZFl3kG/9eLW95RqULFouhXkU
 3MgWYsdXrhflkbcY49lVIYn+fsz0awSf9S+oVvb7/xLQLfGGhShUZut1qNHkGFNp6JaA
 sZa8wLbbxlFePHkQlLMUHd3FffcASrALjaE+8JIx6zR8OSgAT4IX/fufy2A9d0RZhA3v
 ALl7IR95rPuR8xKl+T2sioFRzykr9FIr9NesJ9vD18vS8lQTOlOEa80gyqS2Th60EYW3 kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5k9j80m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:28:27 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24J9SQsu022825;
        Thu, 19 May 2022 09:28:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5k9j80ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:28:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J9D9md032301;
        Thu, 19 May 2022 09:28:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjf15f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:28:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J9SMA943778392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 09:28:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E37B4C04A;
        Thu, 19 May 2022 09:28:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 245BF4C044;
        Thu, 19 May 2022 09:28:22 +0000 (GMT)
Received: from localhost (unknown [9.43.24.187])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 May 2022 09:28:22 +0000 (GMT)
Date:   Thu, 19 May 2022 14:58:20 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
To:     Baoquan He <bhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
        <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
        <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
In-Reply-To: <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1652951723.o9i6ngwfda.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: raQvea1ubc_0i3LcAh7XWdVHZP2Pjm14
X-Proofpoint-ORIG-GUID: WhrT_x4KNw1w69x52_JAdnAvHv0PXd0F
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=266 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He wrote:
> Hi Eric,
>=20
> On 05/18/22 at 04:59pm, Eric W. Biederman wrote:
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>=20
>> > Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> > symbols") [1], binutils (v2.36+) started dropping section symbols that
>> > it thought were unused.  This isn't an issue in general, but with
>> > kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
>> > separate .text.unlikely section and the section symbol ".text.unlikely"
>> > is being dropped. Due to this, recordmcount is unable to find a non-we=
ak
>> > symbol in .text.unlikely to generate a relocation record against.
>> >
>> > Address this by dropping the weak attribute from these functions:
>> > - arch_kexec_apply_relocations() is not overridden by any architecture
>> >   today, so just drop the weak attribute.
>> > - arch_kexec_apply_relocations_add() is only overridden by x86 and s39=
0.
>> >   Retain the function prototype for those and move the weak
>> >   implementation into the header as a static inline for other
>> >   architectures.
>> >
>> > [1] https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Dd1=
bcae833b32f1
>>=20
>> Any chance you can also get machine_kexec_post_load,
>> crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
>> arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
>> arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
>> arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.

I've posted a v2 that uses the approach suggested by Michael, and=20
something that was in use in kexec already. If you are ok with that=20
approach, I will take a stab at converting the rest of the functions=20
that are marked __weak.

>>=20
>> That is everything in kexec that uses a __weak symbol.  If we can't
>> count on them working we might as well just get rid of the rest
>> preemptively.
>=20
> Is there a new rule that __weak is not suggested in kernel any more?
> Please help provide a pointer if yes, so that I can learn that.

I'm not aware of a move away from __weak in the kernel, in general.=20
Steven doesn't prefer it for ftrace, and other maintainers may have a=20
preference.

>=20
> In my mind, __weak is very simple and clear as a mechanism to add
> ARCH related functionality.

Notwithstanding the ftrace issue, the other caveat with __weak functions=20
are that they still make it into the final vmlinux even if they are=20
overridden. That is, you will have instructions from both the __weak=20
variant as well as from the overridden variant in the final vmlinux,=20
which can add up if the weak variants are non-trivial.=20


- Naveen

