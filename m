Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04DF56046F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiF2PXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiF2PXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:23:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6CA44C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:23:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v14so22989879wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=E8dLril/sPEIKP4uoSQRUctLF1kHauClBO1fRvFZs6M=;
        b=S1sh9U6PVDe+Fmvx6KxW/5tkKg2vVShLUzbCF65HnaD0v14693sxNQCMZYtLfbTc15
         zUm5vuapUjne3EvgB1GQk72B2/ZD1fRnzZdYKFt/g4gWsJwM+jfwYsYn1RMWEZZJq/Pk
         pYnop5Jo4N7nKz7dQhNjloPCewcWSFCn8WJJXoXu7KyVYiPn/MRX+O0b4uaYxeImA+f+
         W/deD+MRX9MgVl0O/eRQOhSvKW4bC8G9bSY/vgeW2k/+6alBvtuoFAM0Aj12Qk7JMKpC
         eJ4es7WQwDbnKF7t1MzyRiO2sfJU6riDzo7GvTwYAonldmKb+R/FfixGLvg4Qh6ccOmj
         B0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=E8dLril/sPEIKP4uoSQRUctLF1kHauClBO1fRvFZs6M=;
        b=C7e20/+Ojz4/KFjrNpDU1r0ebPtE0qzBTW45Y2oFDDqNvziKYOI6A/VH9jHKwuiSWP
         aL+LWKcmXkOHfqd71/XRvY1x8Uvvm6CXT+/wsH6/0o62TAbm3WhcXQ+CikrNM5JH8EX3
         UK9b83oTREp7Dmrww7B78oQlqVf3jxGyC1Juw0jUXOdwvOMxtA6Z+XbqsAXRzZDmwzdQ
         k8WyAyxnmE2nMRqf5K46rEzyp8H+FlpR3HMBb49WiVYb0XwrbkDd0dg8n5prNshr7E7t
         YyhGASS1kliJQnPVygNfM7RuEwClP3xJnoPBJy+n0mfVO2I50w7HIxHmCwDoivxeaeos
         Ml2w==
X-Gm-Message-State: AJIora/J04O+OddazlsQAlKwoGA8r2wtu3SHLCoXOzJieGdQdeljL1LD
        8Gjps6ogsUAWPqLfebESRXO9Nw==
X-Google-Smtp-Source: AGRyM1vhi0GQF8IFjF2fgeTa5JS18xUprpYxhjeuK8Y92lrIegtSvJjuOeTARxIpIjG7hroKViZ1qg==
X-Received: by 2002:a05:6000:144a:b0:21b:c9bc:ec87 with SMTP id v10-20020a056000144a00b0021bc9bcec87mr3916725wrx.178.1656516198020;
        Wed, 29 Jun 2022 08:23:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b003a04a9504b0sm4717677wmb.40.2022.06.29.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:23:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id BE4491FFB7;
        Wed, 29 Jun 2022 16:23:14 +0100 (BST)
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
 <yt9dbkubhhna.fsf@linux.ibm.com> <yt9d7d4zhddq.fsf@linux.ibm.com>
User-agent: mu4e 1.7.27; emacs 28.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Sven Schnelle <svens@linux.ibm.com>
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
Date:   Wed, 29 Jun 2022 15:52:17 +0100
In-reply-to: <yt9d7d4zhddq.fsf@linux.ibm.com>
Message-ID: <87v8sjh4t9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sven Schnelle <svens@linux.ibm.com> writes:

> Sven Schnelle <svens@linux.ibm.com> writes:
>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Sven Schnelle <svens@linux.ibm.com> writes:
>>>
>>>> Hi,
>>>>
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 04.05.22 09:37, Janosch Frank wrote:
>>>>>> I had a short look yesterday and the boot usually hangs in the raid6=
=20
>>>>>> code. Disabling vector instructions didn't make a difference but a f=
ew=20
>>>>>> interruptions via GDB solve the problem for some reason.
>>>>>>=20
>>>>>> CCing David and Thomas for TCG
>>>>>>=20
>>>>>
>>>>> I somehow recall that KASAN was always disabled under TCG, I might be
>>>>> wrong (I thought we'd get a message early during boot that the HW
>>>>> doesn't support KASAN).
>>>>>
>>>>> I recall that raid code is a heavy user of vector instructions.
>>>>>
>>>>> How can I reproduce? Compile upstream (or -next?) with kasan support =
and
>>>>> run it under TCG?
>>>>
>>>> I spent some time looking into this. It's usually hanging in
>>>> s390vx8_gen_syndrome(). My first thought was that it is a problem with
>>>> the VX instructions, but turned out that it hangs even if i remove all
>>>> the code from s390vx8_gen_syndrome().
>>>>
>>>> Tracing the execution of TB's, i see that the generated code is always
>>>> jumping between a few TB's, but never exiting the TB's to check for
>>>> interrupts (i.e. return to cpu_tb_exec(). I only see calls to
>>>> helper_lookup_tb_ptr to lookup the tb pointer for the next TB.
>>>>
>>>> The raid6 code is waiting for some time to expire by reading jiffies,
>>>> but interrupts are never processed and therefore jiffies doesn't chang=
e.
>>>> So the raid6 code hangs forever.
>>>>
>>>> As a test, i made a quick change to test:
>>>>
>>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>>> index c997c2e8e0..35819fd5a7 100644
>>>> --- a/accel/tcg/cpu-exec.c
>>>> +++ b/accel/tcg/cpu-exec.c
>>>> @@ -319,7 +319,8 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *en=
v)
>>>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>>>
>>>>      cflags =3D curr_cflags(cpu);
>>>> -    if (check_for_breakpoints(cpu, pc, &cflags)) {
>>>> +    if (check_for_breakpoints(cpu, pc, &cflags) ||
>>>> +        unlikely(qatomic_read(&cpu->interrupt_request))) {
>>>>          cpu_loop_exit(cpu);
>>>>      }
>>>>
>>>> And that makes the problem go away. But i'm not familiar with the TCG
>>>> internals, so i can't say whether the generated code is incorrect or
>>>> something else is wrong. I have tcg log files of a failing + working r=
un
>>>> if someone wants to take a look. They are rather large so i would have=
 to
>>>> upload them somewhere.
>>>
>>> Whatever is setting cpu->interrupt_request should be calling
>>> cpu_exit(cpu) which sets the exit flag which is checked at the start of
>>> every TB execution (see gen_tb_start).
>>
>> Thanks, that was very helpful. I added debugging and it turned out
>> that the TB is left because of a pending irq. The code then calls
>> s390_cpu_exec_interrupt:
>>
>> bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>> {
>>     if (interrupt_request & CPU_INTERRUPT_HARD) {
>>         S390CPU *cpu =3D S390_CPU(cs);
>>         CPUS390XState *env =3D &cpu->env;
>>
>>         if (env->ex_value) {
>>             /* Execution of the target insn is indivisible from
>>                the parent EXECUTE insn.  */
>>             return false;
>>         }
>>         if (s390_cpu_has_int(cpu)) {
>>             s390_cpu_do_interrupt(cs);
>>             return true;
>>         }
>>         if (env->psw.mask & PSW_MASK_WAIT) {
>>             /* Woken up because of a floating interrupt but it has alrea=
dy
>>              * been delivered. Go back to sleep. */
>>             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
>>         }
>>     }
>>     return false;
>> }
>>
>> Note the 'if (env->ex_value) { }' check. It looks like this function
>> just returns false in case tcg is executing an EX instruction. After
>> that the information that the TB should be exited because of an
>> interrupt is gone. So the TB's are never exited again, although the
>> interrupt wasn't handled. At least that's my assumption now, if i'm
>> wrong please tell me.
>
> Looking at the code i see CF_NOIRQ to prevent TB's from getting
> interrupted. But i only see that used in the core tcg code. Would
> that be a possibility, or is there something else/better?

Yes CF_NOIRQ is exactly the compiler flag you would use to prevent a
block from exiting early when you absolutely want to execute the next
block. We currently only use it from core code to deal with icount
related things but I can see it's use here. I would probably still wrap
it in a common function in cpu-exec-common.c I'm unsure of the exact
semantics for s390 so I will defer to Richard and others but something
like (untested):

/*
 * Ensure the next N instructions are not interrupted by IRQ checks.
 */
void cpu_loop_exit_unint(CPUState *cpu, uintptr_t pc, int len)
{
    if (pc) {
        cpu_restore_state(cpu, pc, true);
    }
    cpu->cflags_next_tb =3D len | CF_LAST_IO | CF_NOIRQ | curr_cflags(cpu);
    cpu_loop_exit(cpu);
}

And then in HELPER(ex) you can end the helper with:

void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t ad=
dr)
{
   ...

    /*
     * We must execute the next instruction exclusively so exit the loop
     * and trigger a NOIRQ TB which won't check for an interrupt until
     * it finishes executing.
     */
    cpu_loop_exit_unint(cpu, 0, 1);
}

Some notes:

 * Take care to ensure the CPU state is synchronised

  Which means the helper cannot use the flags
  TCG_CALL_NO_(READ_GLOBALS|WRITE_GLOBALS|SIDE_EFFECTS). And you you
  will to make sure you write the current PC in the tcg gen code in
  op_ex()

 * I think the env->ex_value can be removed after this

 * We will actually exit the execution loop (via a sigjmp) but the IRQ
   check in cpu_handle_interrupt() will be skipped due to the custom
   flags. When the next block is looked up (or generated) it will be
   entered but then immediately exit

 * I think even a branch to self should work because the second
   iteration will be interuptable

> Sorry for the dumb questions, i'm not often working on qemu ;-)

There are no dumb questions, just opportunities for better documentation ;-)

--=20
Alex Benn=C3=A9e
