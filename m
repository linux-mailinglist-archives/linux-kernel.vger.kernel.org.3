Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D204AB79F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349547AbiBGJ1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351434AbiBGJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:20:52 -0500
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:20:51 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77626C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:20:51 -0800 (PST)
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7AAk-1oO5HL39Wm-017Wqs for <linux-kernel@vger.kernel.org>; Mon, 07 Feb
 2022 10:08:11 +0100
Received: by mail-wr1-f44.google.com with SMTP id m14so23389943wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:08:11 -0800 (PST)
X-Gm-Message-State: AOAM5311qF47p1TGDXgeksQ/KBI0+XQA9TGqAFyA4/EYLxkzrji0gGwU
        yQutwXKag0tiey6KkCmbKwKzBFh3TCU7JaGmOpE=
X-Google-Smtp-Source: ABdhPJy2OAsF40cRhp1hQ7PY7Unl0deCaPSYBDIEWOpw8v3CO2PPO1fqgQT5QBnVuSRSgX6rbfXRrkb7Q4LqWG3ZD10=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr9133772wrt.219.1644224891245;
 Mon, 07 Feb 2022 01:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20220206174359.2986-1-jszhang@kernel.org> <CAEn-LTrZwq1-6F8PWScGPp1TRk1eaB-7qOrvPjyLhK=OzDTQBQ@mail.gmail.com>
 <87bkzjvzpt.fsf@igel.home>
In-Reply-To: <87bkzjvzpt.fsf@igel.home>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Feb 2022 10:07:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ncwMz-yngiv_waYYNBydveLrhX=kEfWC_hfonHZ7k4w@mail.gmail.com>
Message-ID: <CAK8P3a3ncwMz-yngiv_waYYNBydveLrhX=kEfWC_hfonHZ7k4w@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1r0L1CA9uxaUQDsE8nw5v0TvvyodMgrjp4YXx522bOwZ6tbI93B
 SG5a5onUFRg2oUr4ZzhKDDT4Jd8ECp6tfMaRfnprgntIzfdJAF/UO1sTwomi2TLeb8ViPFU
 jZsXO/qX7O0qY0hkcVflhO3eBopu5uEmS1UIZgxkaVXhogB/dRupeaYaT6FR4hVMsDXiOEf
 MdGF6419WUTyKkjG4rB9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oAtlLQrS464=:+Nj6Kiq4ePMXwy2W6WnOvj
 9C4M+KVM52vn1C1SLF56g9VaFPwu0mfSpAvHeZBL/2LJVEQ7uU1MTYuzmv+vU4M8MqigeWZva
 Pi1TXZg1GMzj4IvwMpze49nX9l/4bVChDJBlRI1myvXIeWieJxtEex6ljUQaWqROiTCaijw54
 GuMDQSyBBlq/HpRz+q9hHDZx6+GjEygswj65TcMPRfS70vMblm1bfdtgVgL9SGlhWRPir8B1l
 rfWduAqMaOBXZ6ARt+5Qp/Gk2irwFxEL2kojwgejcbAJYeebr8EXGcja+6GlpNWMtx0kot/E+
 O/zYAIHtC78Tp54pUWiyXd+vAVgdPBTIrW4HjzgCznd9B7tgjTr98e+Y2ioP7uq5XFPiyX4KB
 z/JOv8cwhV3XZQBvUx9JZ+zAaFzceSwgUJ02+enirJghdCV073CyhxKzrJOJvN/Sh/TMlFoCl
 FWbq8uyEAhs2CPWuVd3Fb/g7UqqhvbTd9hEyt0lTXMJ7AYGDIKu7k9BFkZwHmJtZriMydbaTX
 4rY8M3VLgFxdmVDuPrbvrACaIcdyVVii3g0cALk46EFh1KyAui9j0nusETbtgSUiY5F085reB
 XjwCNvF62pWEUDOwMaJDkV3efJt1mCDkKO5lSdaENNZ1rqPjMH+q1FE1jp3wDAiW/caCj/n8L
 Oifl7di+7h9mkmzxyVC35513rpMeU5wlvVNPgVaRAUWSrmyi6VbW3mgRgIrsNGDnXuRM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 9:38 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Feb 07 2022, David Abdurachmanov wrote:
>
> > On Sun, Feb 6, 2022 at 7:53 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >>
> >> After irq stack is supported, it's possible to use small THREAD_SIZE.
> >> In fact, I tested this patch on a Lichee RV board, looks good so far.
> >
> > We went from 8K to 16K somewhere in mid-2020 on riscv64 because we
> > were seeing some random crashes in various distributions (Debian,
> > Fedora, OpenSUSE). Thus we matched what other popular arches do, i.e.
> > 16K.

It sounds like 2020 predates both HAVE_ARCH_VMAP_STACK and
IRQ stacks, so I would say that it was necessary back then because the
crashes were too hard to debug, but it's worth trying again now at least
as a compile-time option under CONFIG_EXPERT.

You need VMAP stacks to reliably get a backtrace out, and you need
IRQ stacks to make overflows happen reproducibly (and less often).

> I think NFS is one of the worst offenders.  I'm running an Unleashed
> with NFS root, which probably amplifies this.

I think there are a few others that can be equally bad, and some of them
might stack on top of others, such as swap over ecryptfs over nfs over
an encrypted network tunnel over infiniband. In the end, you just need
one badly written driver, or a compile bug to trigger it, and we have
plenty of both.

      Arnd
