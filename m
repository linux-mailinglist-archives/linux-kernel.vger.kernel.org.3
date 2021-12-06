Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C84469DA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387566AbhLFPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:31 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:35059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346677AbhLFPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:31 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mzhax-1mhYFk0F2P-00vdcC; Mon, 06 Dec 2021 16:16:01 +0100
Received: by mail-wr1-f51.google.com with SMTP id j3so23209474wrp.1;
        Mon, 06 Dec 2021 07:16:00 -0800 (PST)
X-Gm-Message-State: AOAM533Ki0OwtYOTWv1JV4700fjNSV1YhpZ/US+6siWVDUs4ZAFPipKD
        1948UK22GrH5QVr5fUbOEYgMfN9y3NN2eQyTiYk=
X-Google-Smtp-Source: ABdhPJw/ZXYF+K/CJn1HXgPjlPbQr4ytrnThyfQ8C9mdA4sndqRRwQaKMfw+ZhUv1DSh/BoBzDsj/99pArMtUx8ZXSs=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr43984765wrw.32.1638803760643;
 Mon, 06 Dec 2021 07:16:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <cc649faf144fce439b7a341303b6cc73ac285949.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a2JSSJxs92uEiJQAa0iQOvA6NDuww3+Br5cAxYvXVOOAQ@mail.gmail.com>
 <7b2b5888-c2ca-2ca0-8c0c-32128fcb37d2@quicinc.com> <CAK8P3a0TZp349d7xFvpa6rzGSa4Wj2cAhqOg9-BAewA-d+yvJA@mail.gmail.com>
 <2efe933e-de1e-0dfc-959a-c0003e28f830@quicinc.com>
In-Reply-To: <2efe933e-de1e-0dfc-959a-c0003e28f830@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 16:15:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com>
Message-ID: <CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com>
Subject: Re: [PATCHv5 1/4] arm64: io: Use asm-generic high level MMIO accessors
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Wjrf/T3f5sUEsHPW/Ia8K03tSVda3MNopEC8jhYmXuEeo2L1uin
 E4y80EPFSRu5qnUmBp5y3KJBp6Phm82gefMwn3cYekIVQ/WrU0S0gTsZpPXng7fR2q0luyj
 OVFIPicdvi5JRwNPBe1wt0xpZi8CJ282sgmhRYlfK4LXhE+aDH3kfJKxBbJ6zQKAb8RYzoq
 az6uJ+RepbWuEMAAyEZlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:06KoaJJmiVM=:drZuR5Ja2h+TKyGMwaASIY
 B9O2gT3GfCzTNNJ68hJOp/5QjimHR3N3U8Xv+Ejin559Z7bxEOrOUAOWgtVo4+XaoCOWwHBcZ
 PAFOS3t/iSqhhfEETwFk+c9jCcm1RQwX87LS1DkSsfWON0bJK2XBNXakNRspx83xSSTUuxl8N
 ih5bI/bivTOJ5MkRXqkeGqNUW+qcC6/HOv1XQkPKn0GeVBRYddLCxpQAZPRqqG+XCjqJeGqbz
 uv8JRqkszm58/9mym+7FN0PW4otdoDsdcizuXDn7YNAQJ8bMNRsfCbK4SUjJKhdeEk3ZrUd1+
 T+J2UMg2Pgz5D5u/eRFSUj2Z5tdouY+cs5CxZ7aVOh/KjGZJdAwJ6WjVNigzv2wGkFfxaXbJx
 Ln59eK3E81nR1AdF1bDWC9bD+4oXvUS3MCMQH4MnMckILT6cj4QTXy2uXKlb69Vrv88Hx0g6h
 Dj/1uYutCXTTS1Urm0I9uzdsYrxHXj9BJNHS/PcqsurZag5zDzuhwshtTUfA6QlP9GWx9tn/S
 uYvZK8watBdn+Icn40qf0SwMBvIXlV/s5v840joKmLPn+SwJ8DQMU2HZfPGHbvkzOOSA0/HXz
 KboY/M2i5WQpTdn9RjyRIkn0xSlJgNpv7Qllydyx4P+D4qqKdFlv8k9l7ohOJbrt7FAn3NLNb
 Rqtxj4Ws1eG5+uvRRM9CZU2LLDhgbHSH8KjdnvFPzcnXUlAMJrlgIuQZJkzrZGkgBAQz7tCBW
 fJY0wpXVawQEFRyu4F04igUOs8NXHzmt6RxF+zln9kz521KN8fG/3r+R2f1ebFBKq0O5wri1i
 u8kZpAqOgCbveYx4/JzO4REhWRGDp3PP9qdgC2/iOARoufQ9+4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 2:52 PM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
>
> Sorry, what I meant was the literal name of these macros, i.e.,
> __iormb() has more explicit naming as
> IO read memory barrier and __io_ar() is IO after read? So doesn't it
> make more sense that __iormb()
> should be the primary definition which is already the case and ar/bw
> should be based on them.

My reasoning was that we should ideally only have one set, and that
__io_ar()/__io_bw() are the ones used in architecture-independent code,
so I'd rather use those and deprecate the arm64 specific ones, eventually
moving all the arm64 specific code to use those directly where needed.

        Arnd
