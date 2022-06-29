Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC64355FDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiF2Kqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiF2Kqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:46:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EB13E0CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:46:36 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TABtPs020725;
        Wed, 29 Jun 2022 10:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=kGZXggY+tCaT0yZ1hPXjUp9auqS8258zuO5VtLp1H4Y=;
 b=bKLONT42Yqpz8rn0sOOnVIX4jTV/RLxhqLgbFbbop0YGoNwSsFH/CC9DEj42pPKrFpVs
 KujXBdvgOhqFaxD3s5iyyT9FMhq1/q2V3VzRloNm6aikA/QNSrHsk+dJgmsr6Im/2bAj
 UiYcPD/7CAPXzNh3DkfHkXOfPSAiXnhRojckfJCIClDCMT30o86rwjSoEy/28oPaEZy3
 WK7jYHt41XeVKL5JJeVEBBpWV092VUP9JAoNtntAHFpGRQ9qTrWfxTXvOPGwdGJnPYdY
 DzT9MfyjTC/5hUNjwgZRqX30yk56zchpS3DPT0tSjqEDrA+VIRMUVVH1Y8BjU3MHysNO uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0ms6rthy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 10:46:08 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25TAOP87016127;
        Wed, 29 Jun 2022 10:46:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0ms6rthb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 10:46:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25TAZFeL008012;
        Wed, 29 Jun 2022 10:46:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj6d21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 10:46:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25TAj0oC17826092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 10:45:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6C4FA4054;
        Wed, 29 Jun 2022 10:46:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5019BA405C;
        Wed, 29 Jun 2022 10:46:01 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jun 2022 10:46:01 +0000 (GMT)
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
Date:   Wed, 29 Jun 2022 12:46:01 +0200
In-Reply-To: <87pmirj3aq.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 29
        Jun 2022 09:10:57 +0100")
Message-ID: <yt9dbkubhhna.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h0cEczqfoaEJNGG-59v-njgJ9dbThzNy
X-Proofpoint-GUID: rWQ9ETwU3sh0VDlCLponboGWcicOUCdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_15,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Sven Schnelle <svens@linux.ibm.com> writes:
>
>> Hi,
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 04.05.22 09:37, Janosch Frank wrote:
>>>> I had a short look yesterday and the boot usually hangs in the raid6=20
>>>> code. Disabling vector instructions didn't make a difference but a few=
=20
>>>> interruptions via GDB solve the problem for some reason.
>>>>=20
>>>> CCing David and Thomas for TCG
>>>>=20
>>>
>>> I somehow recall that KASAN was always disabled under TCG, I might be
>>> wrong (I thought we'd get a message early during boot that the HW
>>> doesn't support KASAN).
>>>
>>> I recall that raid code is a heavy user of vector instructions.
>>>
>>> How can I reproduce? Compile upstream (or -next?) with kasan support and
>>> run it under TCG?
>>
>> I spent some time looking into this. It's usually hanging in
>> s390vx8_gen_syndrome(). My first thought was that it is a problem with
>> the VX instructions, but turned out that it hangs even if i remove all
>> the code from s390vx8_gen_syndrome().
>>
>> Tracing the execution of TB's, i see that the generated code is always
>> jumping between a few TB's, but never exiting the TB's to check for
>> interrupts (i.e. return to cpu_tb_exec(). I only see calls to
>> helper_lookup_tb_ptr to lookup the tb pointer for the next TB.
>>
>> The raid6 code is waiting for some time to expire by reading jiffies,
>> but interrupts are never processed and therefore jiffies doesn't change.
>> So the raid6 code hangs forever.
>>
>> As a test, i made a quick change to test:
>>
>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>> index c997c2e8e0..35819fd5a7 100644
>> --- a/accel/tcg/cpu-exec.c
>> +++ b/accel/tcg/cpu-exec.c
>> @@ -319,7 +319,8 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>
>>      cflags =3D curr_cflags(cpu);
>> -    if (check_for_breakpoints(cpu, pc, &cflags)) {
>> +    if (check_for_breakpoints(cpu, pc, &cflags) ||
>> +        unlikely(qatomic_read(&cpu->interrupt_request))) {
>>          cpu_loop_exit(cpu);
>>      }
>>
>> And that makes the problem go away. But i'm not familiar with the TCG
>> internals, so i can't say whether the generated code is incorrect or
>> something else is wrong. I have tcg log files of a failing + working run
>> if someone wants to take a look. They are rather large so i would have to
>> upload them somewhere.
>
> Whatever is setting cpu->interrupt_request should be calling
> cpu_exit(cpu) which sets the exit flag which is checked at the start of
> every TB execution (see gen_tb_start).

Thanks, that was very helpful. I added debugging and it turned out
that the TB is left because of a pending irq. The code then calls
s390_cpu_exec_interrupt:

bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
{
    if (interrupt_request & CPU_INTERRUPT_HARD) {
        S390CPU *cpu =3D S390_CPU(cs);
        CPUS390XState *env =3D &cpu->env;

        if (env->ex_value) {
            /* Execution of the target insn is indivisible from
               the parent EXECUTE insn.  */
            return false;
        }
        if (s390_cpu_has_int(cpu)) {
            s390_cpu_do_interrupt(cs);
            return true;
        }
        if (env->psw.mask & PSW_MASK_WAIT) {
            /* Woken up because of a floating interrupt but it has already
             * been delivered. Go back to sleep. */
            cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
        }
    }
    return false;
}

Note the 'if (env->ex_value) { }' check. It looks like this function
just returns false in case tcg is executing an EX instruction. After
that the information that the TB should be exited because of an
interrupt is gone. So the TB's are never exited again, although the
interrupt wasn't handled. At least that's my assumption now, if i'm
wrong please tell me.

So the raid6 code is spinning waiting that the jiffies value reaches a
timeout, but as the timer interrupt was lost it will never change.

So i wonder now how this could be fixed.
