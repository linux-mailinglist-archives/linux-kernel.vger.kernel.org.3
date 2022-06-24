Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB9559EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiFXRBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiFXRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:01:22 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D960F2D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:01:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id x38so5468196ybd.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Jns4dsIe8eb094ZZ61J5I0GwrZpoyUPKckm9PMjM6A=;
        b=PLUzB92rTaw0yKzXR/fbqdnplZiu/04+Hcuj/qFWhBE5U7BXJBIHatMeX4obUVPbQS
         A4Bjtu0V4lRKjcan/QqiuPC4DL/T39L7jYp1vGwmbUJWDFHq4QCznjmPCi1ERCpuSmsv
         8NANYZrJIodQD6ZeyqP4fRMOU31B0gEhDwMNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Jns4dsIe8eb094ZZ61J5I0GwrZpoyUPKckm9PMjM6A=;
        b=StnVnEKbIwtl+OcVJGEBptZMhdmgW4iz0NraZO2tVoCyU6CaPiAGc4hXGbgDnFU0i2
         tuD6cxJkBi9gYSHjgdVIx4X/jtVIFdjiqVCO8LWmVJmnV9ph5A/0DbTH1ygWOjzF06LZ
         vecujFYttFC9FtrChTKAaqpi4XGiwI9n5GIfYlVn42GfsI9MfD1bfllYImggeziYs58l
         iHO9/JNI3GAQnMBbAxa+sLN4Uhx8t87mzhjpoDYWUE9GlfdQKvUI3Kp6u/3ULh+wZwF0
         uCkAXajqAtlPENeRUltv1iIYeqKkooBswd4PhzlgO+ZCAktM4nQZhNM/nAvTiE1mXNoa
         95/w==
X-Gm-Message-State: AJIora8/JsBf6Z8Uqpxq92KBJA5cv0fL1en20tGkARBLJTc/HTEN2urz
        96K5Pt15GXy8zR1heRfAeMH7wfPxh6PGxtd/pYz8
X-Google-Smtp-Source: AGRyM1vBM6wzRqtQPsY/GBTxWhWMVAPeZO7wStS8yWUZs4AjrmBSarknA+yzpWkGvpKLGaRxqyMdQFgQtOsHyHWrBc4=
X-Received: by 2002:a5b:c4:0:b0:669:15d4:8b68 with SMTP id d4-20020a5b00c4000000b0066915d48b68mr100443ybp.473.1656090080201;
 Fri, 24 Jun 2022 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160117.3206-1-nikita.shubin@maquefel.me> <20220624160117.3206-4-nikita.shubin@maquefel.me>
In-Reply-To: <20220624160117.3206-4-nikita.shubin@maquefel.me>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jun 2022 10:01:07 -0700
Message-ID: <CAOnJCU+B+dXXhqL6CYRG7Lhr_QWwyxrDZdGZG6HphnTEE9o5Mw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf arch events: riscv arch std event files
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jun 24, 2022 at 9:01 AM Nikita Shubin <nikita.shubin@maquefel.me> w=
rote:
>
> From: Nikita Shubin <n.shubin@yadro.com>
>
> cycles, time and instret counters are defined by RISC-V privileged
> spec and they should be available on any RISC-V implementation, epose the=
m
> to arch std event files, so they can be reused by particular PMU
> bindings.
>
> Derived-from-code-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.u=
lisboa.pt>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Why do we need this ? The PMU driver already parses the standard perf event=
s.
So you can pass -e cycles -e instructions.

Even though time is described as a counter and accessibility
controlled by mcounteren, you can not start/stop it (no bit in
mcountinhibit).
Thus, it can't be used from perf.

> ---
>  .../pmu-events/arch/riscv/riscv-generic.json  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json b/tools/=
perf/pmu-events/arch/riscv/riscv-generic.json
> new file mode 100644
> index 000000000000..a7ffbe87a0f7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
> @@ -0,0 +1,20 @@
> +[
> +  {
> +    "PublicDescription": "CPU Cycles",
> +    "EventCode": "0x00",
> +    "EventName": "riscv_cycles",
> +    "BriefDescription": "CPU cycles RISC-V generic counter"
> +  },
> +  {
> +    "PublicDescription": "CPU Time",
> +    "EventCode": "0x01",
> +    "EventName": "riscv_time",
> +    "BriefDescription": "CPU time RISC-V generic counter"
> +  },
> +  {
> +    "PublicDescription": "CPU Instructions",
> +    "EventCode": "0x02",
> +    "EventName": "riscv_instret",
> +    "BriefDescription": "CPU retired instructions RISC-V generic counter=
"
> +  }
> +]
> --
> 2.35.1
>


--=20
Regards,
Atish
