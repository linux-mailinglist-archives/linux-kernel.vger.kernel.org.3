Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61E4CDF9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiCDVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiCDVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:05:31 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B87BD2E4;
        Fri,  4 Mar 2022 13:04:43 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id t11so10899740ioi.7;
        Fri, 04 Mar 2022 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+E0PkkZm4GMMA/j/YXjv17yT9pu9dITlUBR8RUwlzY=;
        b=VrJT2u3fwB1RZfA1ws8RJp7Ck2jXPGvKKEFOszNj0C57Etrv6+GbJbRAil6tagMQG0
         RX638ubu19X/K9XkbONfcUGenCTxL+Mp2JMslcM/Z7c1FFlN/meurEeQGwvRmxbz03sI
         chQIb7eanCgBVCCTosn72/gyywDMJSL+HYEQO4KQuVqYyJ9JuuDrCF5oo/WdMoLIlyr8
         qZmDjKkWVwyAJG9yOWgVtwosFvs+wgStFxZtleQAG64SogpgNYvtXOar5n4/AzhRFmO8
         rBybqYhr2meXAEyw5S6Knkxi1HuKl1xEFrKALABQ1DcHKabFDW7DjI81SLQlxXP3q0cY
         mM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+E0PkkZm4GMMA/j/YXjv17yT9pu9dITlUBR8RUwlzY=;
        b=05Ki1fnssLK9kfLtGB+su2ZiP/XZ1MGZnKm93yf1MFW6bnMPGXdCk2vbkC/iJFiiot
         t2xjIRGCx0+g9rOpvkNh0KmRK6ANkwmb6RTe0gEbjDJaTrh2oR3n974cAtreLFgQdAAk
         QAXkP0KOPa67voiQXri6+31jHTBCbPhxfI17AJKN0nf7Iw2EeyBqSZd0x66jsDzABHbE
         3rF5Bkxow/pne9X+M4/CznMdMl/nAqFmJ0qEvmQ19XV8VqezC0+80htdpy5bjZ7QK82J
         UTRzRdGfLPjKDqtW/N/WfqsbP0F3XDleMh+vrUsckBfToWBZv5jInIMNz2phZlhfivgn
         5VMA==
X-Gm-Message-State: AOAM530yUMb0K8/b60r62zgkqxGthEmD3BzZe493eaIniKNGtW9bd12C
        wYdfYJ89mm01YdVZ7ej+Jjd3HlB/fVldcIypLSg=
X-Google-Smtp-Source: ABdhPJzDpEH6kq/lE/65CKhDbZk3TjAZz1VyHGBvt3NPi8FiQIqeIe5nu9xipcBZOr/YbiNPdFZDFKYgiwhLbpqzdHg=
X-Received: by 2002:a6b:661a:0:b0:640:dd42:58ff with SMTP id
 a26-20020a6b661a000000b00640dd4258ffmr420359ioc.64.1646427882556; Fri, 04 Mar
 2022 13:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com> <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org> <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
 <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org> <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
 <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
 <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com> <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
 <ad3567301af7b1b24cf4ac447fec8d618231ea33.camel@perches.com>
 <CANiq72kWJtOTmcXNO+t4NY22v6xM49Z-U2aSB4apNd96PYbD4Q@mail.gmail.com> <451bb2c394b05928c815f1eb349a1281a687a608.camel@perches.com>
In-Reply-To: <451bb2c394b05928c815f1eb349a1281a687a608.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 4 Mar 2022 22:04:32 +0100
Message-ID: <CANiq72kqpcs==-+FOqoRwxHQ0s9D=gf-QAM9UTm4rA=GwHWUVQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
To:     Joe Perches <joe@perches.com>
Cc:     Tom Rix <trix@redhat.com>, Finn Thain <fthain@linux-m68k.org>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 8:28 PM Joe Perches <joe@perches.com> wrote:
>
> Is that statement really disputable?

By "Maybe", I only mean that you may be right (or not), i.e. we cannot
really show one way or the other with data.

But note that many people (including projects, companies and even
programming languages) prefer consistency and automated formatting vs.
the alternative.

> IYO.  I think using an SCCS with better language understanding rather
> than a line oriented one could be an improvement.  Such a tool could
> allow arbitrary style reformatting at check-in/check-out.

clang-format is not line oriented. In fact, you may be able to get
quite close to what you suggest with clang-format if you have a
project that is automatically formatted.

> All of these existing code are more human readable than the code
> reformatted using clang-format.

That is subjective (for some it may be good enough), and anyway you
compared it to the current config file (clang-format 4). The point I
raised is that clang-format 13 and future versions should be closer to
what you expect.

And by saying "I rather doubt clang-format will ever be 'close
enough'.", then there is little incentive for the clang-format team to
actually add support the things we need...

> I used whatever is the latest clang-format here with today's -next.
> https://releases.llvm.org/download.html

I think this may be the source of confusion -- even if you use
clang-format 13, you need to edit the config file to use the new
options.

In other words, when I said something is supported since e.g.
clang-format 9, one still needs to enable it in the config file.

> Then perhaps you as the maintainer of the kernel's .clang-format file
> could update the entries for those new options.

No, I cannot, because that is an error, thus breaks users of old
clang-format versions.

That is why I suggested to track the minimum LLVM supported version in
the kernel, i.e. go at least to LLVM 11. And then over time keep
upgrading it and getting better output.

> I believe the minimum clang version is already 11.  Maybe higher.
> I don't track clang or use it very much.  The clang version I use
> though is 13.

Yes, I am aware, please see above. The issue and why I did not "just
do it" is that people could have been using clang-format from e.g.
their distro, but compiling with GCC.

> But perhaps tweaking will just improve some cases and worsen others.

Yes, of course.

> I don't think so.

Why?

> There is no "one true editor".
> There will not be "one true source code formatter" either.

Not for every project, but for a single project, there can definitely
be a "single formatter". In fact, that is what many other projects do
in practice in order to reach a point where automatic formatting is
done.

Cheers,
Miguel
