Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63C355FFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiF2MSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiF2MSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:18:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6891EECB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:18:42 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TC3XJj032380;
        Wed, 29 Jun 2022 12:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=lwqjL+rTVMTV/YnIkpDWycZp39fG1HJxqZxK4n7g3uQ=;
 b=bFomUyV4QLfopuHJVW5HEv97d/sby4G1R+HBOplFF/OX5F8f5Lfi3qd9n7dnebpKaJzL
 dIndpQwfqI3VBOG+s/rgYbcJ+DL3sXnJ/AxnnX/S62E8q3LCz2DrlRCpPow6zhrG91pT
 3b733DYBBdl6CbzjZIazYTsKyX/9dFqbhq7xdLqysC6YKp57AlBJOWUEgq0e39Ajk9b8
 mDngcpMu/zA2btw+G9uGbQD5UAYz/HEHK0BSUf8/0wDu6gWsF7rseO0j/2sxcgxE+TxB
 efPMi4NfUSktnXtZlG5P1FkLT28WG8tm4AJa7/rKkhMTk0FlB7gSg5MDB+wk7YE6a93K Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0pdkgegv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 12:18:16 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25TC51VG009406;
        Wed, 29 Jun 2022 12:18:15 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0pdkgefy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 12:18:15 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25TC8FGJ003555;
        Wed, 29 Jun 2022 12:18:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3gwt094u37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 12:18:13 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25TCIAKp21299524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 12:18:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AFC811C04C;
        Wed, 29 Jun 2022 12:18:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1AF11C04A;
        Wed, 29 Jun 2022 12:18:09 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jun 2022 12:18:09 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org,
        qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: qemu-system-s390x hang in tcg
References: <20220426150616.3937571-24-Liam.Howlett@oracle.com>
        <20220428201947.GA1912192@roeck-us.net>
        <20220429003841.cx7uenepca22qbdl@revolver>
        <20220428181621.636487e753422ad0faf09bd6@linux-foundation.org>
        <20220502001358.s2azy37zcc27vgdb@revolver>
        <20220501172412.50268e7b217d0963293e7314@linux-foundation.org>
        <Ym+v4lfU5IyxkGc4@osiris> <20220502133050.kuy2kjkzv6msokeb@revolver>
        <YnAn3FI9aVCi/xKd@osiris> <YnGHJ7oroqF+v1u+@osiris>
        <20220503215520.qpaukvjq55o7qwu3@revolver>
        <60a3bc3f-5cd6-79ac-a7a8-4ecc3d7fd3db@linux.ibm.com>
        <15f5f8d6-dc92-d491-d455-dd6b22b34bc3@redhat.com>
        <yt9d5ykkhrvv.fsf_-_@linux.ibm.com> <87pmirj3aq.fsf@linaro.org>
        <yt9dbkubhhna.fsf@linux.ibm.com>
Date:   Wed, 29 Jun 2022 14:18:09 +0200
In-Reply-To: <yt9dbkubhhna.fsf@linux.ibm.com> (Sven Schnelle's message of
        "Wed, 29 Jun 2022 12:46:01 +0200")
Message-ID: <yt9d7d4zhddq.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8AhSG-fhtXsT03k4RQQHlt278RxqkdfQ
X-Proofpoint-GUID: cz-P2Qr80a7G7CgtNCMwmrsq8Y0a_bjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_16,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Sven Schnelle <svens@linux.ibm.com> writes:
>>
>>> Hi,
>>>
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 04.05.22 09:37, Janosch Frank wrote:
>>>>> I had a short look yesterday and the boot usually hangs in the raid6=
=20
>>>>> code. Disabling vector instructions didn't make a difference but a fe=
w=20
>>>>> interruptions via GDB solve the problem for some reason.
>>>>>=20
>>>>> CCing David and Thomas for TCG
>>>>>=20
>>>>
>>>> I somehow recall that KASAN was always disabled under TCG, I might be
>>>> wrong (I thought we'd get a message early during boot that the HW
>>>> doesn't support KASAN).
>>>>
>>>> I recall that raid code is a heavy user of vector instructions.
>>>>
>>>> How can I reproduce? Compile upstream (or -next?) with kasan support a=
nd
>>>> run it under TCG?
>>>
>>> I spent some time looking into this. It's usually hanging in
>>> s390vx8_gen_syndrome(). My first thought was that it is a problem with
>>> the VX instructions, but turned out that it hangs even if i remove all
>>> the code from s390vx8_gen_syndrome().
>>>
>>> Tracing the execution of TB's, i see that the generated code is always
>>> jumping between a few TB's, but never exiting the TB's to check for
>>> interrupts (i.e. return to cpu_tb_exec(). I only see calls to
>>> helper_lookup_tb_ptr to lookup the tb pointer for the next TB.
>>>
>>> The raid6 code is waiting for some time to expire by reading jiffies,
>>> but interrupts are never processed and therefore jiffies doesn't change.
>>> So the raid6 code hangs forever.
>>>
>>> As a test, i made a quick change to test:
>>>
>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>> index c997c2e8e0..35819fd5a7 100644
>>> --- a/accel/tcg/cpu-exec.c
>>> +++ b/accel/tcg/cpu-exec.c
>>> @@ -319,7 +319,8 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>>
>>>      cflags =3D curr_cflags(cpu);
>>> -    if (check_for_breakpoints(cpu, pc, &cflags)) {
>>> +    if (check_for_breakpoints(cpu, pc, &cflags) ||
>>> +        unlikely(qatomic_read(&cpu->interrupt_request))) {
>>>          cpu_loop_exit(cpu);
>>>      }
>>>
>>> And that makes the problem go away. But i'm not familiar with the TCG
>>> internals, so i can't say whether the generated code is incorrect or
>>> something else is wrong. I have tcg log files of a failing + working run
>>> if someone wants to take a look. They are rather large so i would have =
to
>>> upload them somewhere.
>>
>> Whatever is setting cpu->interrupt_request should be calling
>> cpu_exit(cpu) which sets the exit flag which is checked at the start of
>> every TB execution (see gen_tb_start).
>
> Thanks, that was very helpful. I added debugging and it turned out
> that the TB is left because of a pending irq. The code then calls
> s390_cpu_exec_interrupt:
>
> bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> {
>     if (interrupt_request & CPU_INTERRUPT_HARD) {
>         S390CPU *cpu =3D S390_CPU(cs);
>         CPUS390XState *env =3D &cpu->env;
>
>         if (env->ex_value) {
>             /* Execution of the target insn is indivisible from
>                the parent EXECUTE insn.  */
>             return false;
>         }
>         if (s390_cpu_has_int(cpu)) {
>             s390_cpu_do_interrupt(cs);
>             return true;
>         }
>         if (env->psw.mask & PSW_MASK_WAIT) {
>             /* Woken up because of a floating interrupt but it has already
>              * been delivered. Go back to sleep. */
>             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
>         }
>     }
>     return false;
> }
>
> Note the 'if (env->ex_value) { }' check. It looks like this function
> just returns false in case tcg is executing an EX instruction. After
> that the information that the TB should be exited because of an
> interrupt is gone. So the TB's are never exited again, although the
> interrupt wasn't handled. At least that's my assumption now, if i'm
> wrong please tell me.

Looking at the code i see CF_NOIRQ to prevent TB's from getting
interrupted. But i only see that used in the core tcg code. Would
that be a possibility, or is there something else/better?

Sorry for the dumb questions, i'm not often working on qemu ;-)
