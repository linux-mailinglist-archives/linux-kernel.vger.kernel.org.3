Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9055FA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiF2INJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiF2ING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:13:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A00B1B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:13:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so30874886ejj.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PIGbqvRKGSnAd7dUjgLKR8+0fKI979WXL11KEVouBS8=;
        b=Mst7JHfvhMp7T9HYxlRri+KnTpedoD8p5dv5FzFplRIR5dPwAEDmjeATvc9uzLPlS4
         Z/VpTWrcHm/eS2dKfDsrBWma7Ka6kRi4oeobJUiWKYu81I8WwsmCwHJMGXwwmSyPtWhc
         07l+UZtgnMfZkymgEue3iN8MEi423BFDGx2CZxnbzIB5xLIfRoqdnhM2weNbu8nfow+J
         MLFqPp4dmVlKUhYO/4oGm466EHk4cuFhrw9MylYIkaxe0z0WVOqXO8awzwPgD8Mkc6BN
         hqWs/91URLBTtiudfH7e9bZZSUCxz86ex3ZaADs2re8HM8joD+wJNze2uYvUJD/Rji6O
         3lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PIGbqvRKGSnAd7dUjgLKR8+0fKI979WXL11KEVouBS8=;
        b=wRL3QfqUSrHaCUQFsdPcjiGsGEFQeYRkN+9hwsY30MHs17wS/87I4OUZv9mXEp7R0O
         I9br9abW73wpDULct7jzTaytm4z4+5FfbFXkNm7sceACVTQID75K0j0eZzBPjn2AY0l3
         g/jUCIDHGJzy/O/8qZCbJdZMpQuBhtdWCFIyxYwRx7ev+LbQNDNW1m+pcCNFeWKmkmw7
         LGubjBl/BrjBGvgbk+1hFzrAYOZK7f+uiiv/yBXcdIMwsJBP9RyNn3fCtmGYWD+pmgam
         hlUV4c+62kKBNWo7AiitPtiDijq5QzgKx/sYCm/iFB5TXq7GkDEsRjleKNlYy49Iq+Lh
         RZVg==
X-Gm-Message-State: AJIora+1sEQ9p30l80dRBpMECyYZKX8q+5FgnKjkNh+/RNi+W6fc7rCt
        w23hQKdPvpc1wwTmFMAXsAIbUg==
X-Google-Smtp-Source: AGRyM1tPnKTVVZy8C+dwTO0lqvLAH9ElVYJH9bs+Cd32mWZRKrNlBRkmBntb9jaIQOz8Su5fLqXKCw==
X-Received: by 2002:a17:906:284c:b0:727:3773:1a53 with SMTP id s12-20020a170906284c00b0072737731a53mr1986597ejc.765.1656490383244;
        Wed, 29 Jun 2022 01:13:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b00711edab7622sm7411953ejk.40.2022.06.29.01.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:13:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 1EFC51FFB7;
        Wed, 29 Jun 2022 09:13:01 +0100 (BST)
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
 <yt9d5ykkhrvv.fsf_-_@linux.ibm.com>
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
Subject: Re: qemu-system-s390x hang in tcg (was: Re: [PATCH v8 23/70]
 mm/mmap: change do_brk_flags() to expand existing VMA and add
 do_brk_munmap())
Date:   Wed, 29 Jun 2022 09:10:57 +0100
In-reply-to: <yt9d5ykkhrvv.fsf_-_@linux.ibm.com>
Message-ID: <87pmirj3aq.fsf@linaro.org>
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

> Hi,
>
> David Hildenbrand <david@redhat.com> writes:
>
>> On 04.05.22 09:37, Janosch Frank wrote:
>>> I had a short look yesterday and the boot usually hangs in the raid6=20
>>> code. Disabling vector instructions didn't make a difference but a few=
=20
>>> interruptions via GDB solve the problem for some reason.
>>>=20
>>> CCing David and Thomas for TCG
>>>=20
>>
>> I somehow recall that KASAN was always disabled under TCG, I might be
>> wrong (I thought we'd get a message early during boot that the HW
>> doesn't support KASAN).
>>
>> I recall that raid code is a heavy user of vector instructions.
>>
>> How can I reproduce? Compile upstream (or -next?) with kasan support and
>> run it under TCG?
>
> I spent some time looking into this. It's usually hanging in
> s390vx8_gen_syndrome(). My first thought was that it is a problem with
> the VX instructions, but turned out that it hangs even if i remove all
> the code from s390vx8_gen_syndrome().
>
> Tracing the execution of TB's, i see that the generated code is always
> jumping between a few TB's, but never exiting the TB's to check for
> interrupts (i.e. return to cpu_tb_exec(). I only see calls to
> helper_lookup_tb_ptr to lookup the tb pointer for the next TB.
>
> The raid6 code is waiting for some time to expire by reading jiffies,
> but interrupts are never processed and therefore jiffies doesn't change.
> So the raid6 code hangs forever.
>
> As a test, i made a quick change to test:
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index c997c2e8e0..35819fd5a7 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -319,7 +319,8 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>
>      cflags =3D curr_cflags(cpu);
> -    if (check_for_breakpoints(cpu, pc, &cflags)) {
> +    if (check_for_breakpoints(cpu, pc, &cflags) ||
> +        unlikely(qatomic_read(&cpu->interrupt_request))) {
>          cpu_loop_exit(cpu);
>      }
>
> And that makes the problem go away. But i'm not familiar with the TCG
> internals, so i can't say whether the generated code is incorrect or
> something else is wrong. I have tcg log files of a failing + working run
> if someone wants to take a look. They are rather large so i would have to
> upload them somewhere.

Whatever is setting cpu->interrupt_request should be calling
cpu_exit(cpu) which sets the exit flag which is checked at the start of
every TB execution (see gen_tb_start).

--=20
Alex Benn=C3=A9e
