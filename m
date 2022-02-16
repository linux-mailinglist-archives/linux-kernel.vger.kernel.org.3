Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1C4B925D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiBPUd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBPUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:33:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8574227018A;
        Wed, 16 Feb 2022 12:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645043515;
        bh=Ybn8l+gnMKMMXvs55hiDNOMPxOVIuTwQZmrqM3YEIT4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AntNcnKLyF3jvT6nrcYCG4qX//R6P/jg6GX9PAq9ahEaqC1d66RPjmbHb+W4q1nhN
         pMU7WD5iY0FX3JDLRsLSlGXye9WL2FfhU+BQo9tN+35Wd+ULtBzJKhMvmm/TuqFOvm
         IqYpmS3G8VF0HmaztNK8BDpk8AcbiuITor+K4TAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1oJIk801n5-011mvb; Wed, 16
 Feb 2022 21:31:55 +0100
Message-ID: <de2cbd2a-8d0d-8678-e514-b153d04546cc@gmx.de>
Date:   Wed, 16 Feb 2022 21:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 00/21] Introduce power-off+restart call chain API
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20220130233718.21544-1-digetx@gmail.com>
 <635e8121-fca4-580c-6af5-d9317a2eee1b@gmail.com>
 <CAJZ5v0g0MrBm2+GwctkB7kUyBEt6HTAexRCFFRmTF1UKDrVQ-g@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAJZ5v0g0MrBm2+GwctkB7kUyBEt6HTAexRCFFRmTF1UKDrVQ-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BtWBXH8Hx0gs6H70GSeWdQfjHJJkkJcL0sCha+IYkFzIkqPcTuW
 qKy+2T0ZaFjOf0xL3yRiF1cUpCUYSVgqU7KzwzS+JfDwLwpezAw537tUvZg/2bOLghB+l87
 w3cRaMw1LIHIT6wVzHTvekJyjtx+uVE2jwwagYFCMH9R/cOGUhFKVp6jWY02QQ7l0/6B1hQ
 6lKAfYfgEy3VsBR0gZMrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5CRufpR4Nc=:3YY8ipwdQLVft0dePw9YSh
 GUR0lnlWhCPH8e7cGyZuVRF4QTaiMpo/t4CaEOUGLIsLKu9l5M/J0O5M31HNvfJdp+wCixixW
 ethNV9fQwcaghavvR5Ys8j3bZzVgSa7R1OyImZriy57lwfiqdjxLeLcFAKSN2rNhwXo+L/1W0
 CQyzAyysct5pNIn6YhVq+UHJuMW9E5n4xaMMBrwmLs2OCCvppuqotMNUovPjEQwyXKEJ+eFhM
 9yjpXwZ8d3mtYgImVbnKr09+gh/F/wPYXq7eYIpe39d9AbGAEQBSqL/KVOnCktbbcz2QF5Qbk
 4e7AQF9zoGHa9dkqmKwp5ZIdSigW0kvkTZVGQrYpdQk+jIkqYRXSjx48uK1QfjU+0gP6+BazZ
 vHIF29XOsraFmwyXxbJ9z62U6lScuvKK+hcIdwsTDX1ggSkvbxldkEoF5EU5WckNyKgp3gyzH
 DfO65T9j2hzIuIY+WJVtkWoyJeNgSwsFOR7Izo94OQHlrcyx49oOnlwEdPO+nwrmIJBci5bOR
 WOLNQgMmF6kCc29abhcYlGzqUMIWI+FO/fCqXzwMQQmpGHb0yApKLUA4nUq0AMOk6w+NN8w2X
 /FbqL85ikgC66lPN0ooU1nS7KTmmY5exT9d7V9iWM6nLCea6Xm6zHRAIXEdyFZzA8VCkbFnzD
 h2vE8D32H6zqsIt6XTnvWDjRnU13iMkEj3E7cMmMtSopa2Wp8u/DtvdAeO/wkDmneLWInPLs8
 6RgI97ngQ4wqgYy1sPu7EIk9kIRcFo4/RoCxjHgIBkJrc2sI1wfoeqEIWGAnQxL/RmH+OLvYO
 4yVmqq+p6FhQjuDDZ4yhghQDs+3QKjtVbK+8SqzHgH28Ka1VeSb/Sjw00g5YRoCxba1dPjJUz
 745leF9ctWiJ4d2dLvna8gH4qOiznTFUsQruaIlZTRQt2Q4WnGzd6w/B0Yn+xWmbkRgyZHOZI
 uy8YKYBLf5449zcoQ3q6pmGV9kDPV93qDp6c5xvkslulnnJ92iiU/+AhdlS7dUnaoQWw0libs
 PaL7jI3w3bUjzZ86ihC2Hg/wIiAwKaAAUMew3jB75LdA9Od0L63l2pMobL+2iUUq3y+BntMIe
 DlxSKf+Q98mWIw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 13:25, Rafael J. Wysocki wrote:
> On Tue, Feb 15, 2022 at 11:00 PM Dmitry Osipenko <digetx@gmail.com> wrot=
e:
>>
>> 31.01.2022 02:36, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> Problem
>>> -------
>>>
>>> SoC devices require power-off call chaining functionality from kernel.
>>> We have a widely used restart chaining provided by restart notifier AP=
I,
>>> but nothing for power-off.
>>>
>>> Solution
>>> --------
>>>
>>> Introduce new API that provides both restart and power-off call chains=
.
>>>
>>> Why combine restart with power-off? Because drivers often do both.
>>> More practical to have API that provides both under the same roof.
>>>
>>> The new API is designed with simplicity and extensibility in mind.
>>> It's built upon the existing restart and reboot APIs. The simplicity
>>> is in new helper functions that are convenient for drivers. The
>>> extensibility is in the design that doesn't hardcode callback
>>> arguments, making easy to add new parameters and remove old.
>>>
>>> This is a third attempt to introduce the new API. First was made by
>>> Guenter Roeck back in 2014, second was made by Thierry Reding in 2017.
>>> In fact the work didn't stop and recently arm_pm_restart() was removed
>>> from v5.14 kernel, which was a part of preparatory work started by
>>> Guenter Roeck. I took into account experience and ideas from the
>>> previous attempts, extended and polished them.
>>
>>
>> Rafael and all, do you see anything critical that needs to be improved
>> in this v6?
>>
>> Will be great if you could take this patchset via the power tree if it
>> looks okay, or give an ack.
>
> I need some more time for this, sorry.
>
> I'm a bit concerned about seeing no response to this set from anyone.
>
> It looks like multiple platforms may be affected by it in principle,
> so doesn't anyone care?

I did looked into the whole patch set after applying it locally.

While I agree a new combined API is good, and the beginning looked promisi=
ng,
after some time I started to ask myself if the whole infrastructure might
be a little overdesigned.

Anyway, I tested it and it works for me on parisc.
And it's probably better than what we have today.

Helge
