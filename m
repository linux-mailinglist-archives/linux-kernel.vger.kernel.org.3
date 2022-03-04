Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BBC4CDCE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiCDSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiCDSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:49:26 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774A91C1EF1;
        Fri,  4 Mar 2022 10:48:37 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u2so8512177ioc.11;
        Fri, 04 Mar 2022 10:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZVqR2IXuPYi/CmafDbS5W6yfPjJBN8Q1wn/cKiQemY=;
        b=fR7l0zn8xJNMq3ZimB+MotJrfmWksw5FUbuKX8xZ0KrU81Er3UcSQr8Xz4fO32Vwbg
         Nu2Js1VOxv0PA6FZIG279vnxnytdo6BMI0fUwdBcYrZWEpTR0zhmzVWQU8rQGcquEg/Y
         d22VOQF6SO2u2GzyC6roO8Le49UQBMgxQaxX1xT3xNKRB57pbnU2e1r2R1nik0ynqq2g
         dJWfq0S7irxYaPdbuugyp2Q7aYuhjL4y8y7815ItnrHQiBvG1qteJNAOdfvHNdNz68r6
         4VSxq37S4cm8QehTxMrQiWGYhtaUE0h5th6ntso3uMwaC0yK0kJJ5MsJHxb7gMZR+9b8
         axng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZVqR2IXuPYi/CmafDbS5W6yfPjJBN8Q1wn/cKiQemY=;
        b=n7ekN0xOb6gIkiV5pGXH1Awvpskq02MSRf73ntQ1z8w+CrMtqrr+W4u8Kp8kMmjYBY
         9o44DcddssT12FfgtEN5rjREw8qUCn+2MAzd/BZL0QFgDSJgZJ8i3JvIYTjIfZykLS4w
         hXaluo907TsCw1gk5NcnvXrkryqozeS8mS3PfLEGELp6ag+PKLNQrcphWTXnW9Vud18i
         balgJ3Ci0amWAMkgx136od15BqT4BdyJ3WYKIBue+I+7jY4119DEeqrjmyKj59MFiVdt
         wLLOwyzlz//CzOOQ3lm1XaSeKPAnofC4JF2BZH3cs9cZEQEhyHinZqjDHz1z26W23kqu
         XzPg==
X-Gm-Message-State: AOAM533QhIgRp/p7R7oNuleymN4vN7bw3FI586JhGwV8fIFocXs9H+9e
        hxdkYtBt4rE+uiqCVg/5pHQKkTpjmnpD5ve8FpI=
X-Google-Smtp-Source: ABdhPJy63i/BlI2iCbWovC/qOl03K/3nFIt5/6OUfXFTorzmrGEY769OhKk8AcXgjvay/k1hXPrVLapa0NAo6BScxtY=
X-Received: by 2002:a05:6602:15c6:b0:611:591d:1d9a with SMTP id
 f6-20020a05660215c600b00611591d1d9amr31562359iow.177.1646419716803; Fri, 04
 Mar 2022 10:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20220127151945.1244439-1-trix@redhat.com> <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com> <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com> <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
 <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org> <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>
 <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org> <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>
 <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>
 <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com> <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com>
 <ad3567301af7b1b24cf4ac447fec8d618231ea33.camel@perches.com>
In-Reply-To: <ad3567301af7b1b24cf4ac447fec8d618231ea33.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 4 Mar 2022 19:48:25 +0100
Message-ID: <CANiq72kWJtOTmcXNO+t4NY22v6xM49Z-U2aSB4apNd96PYbD4Q@mail.gmail.com>
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

On Fri, Mar 4, 2022 at 6:37 PM Joe Perches <joe@perches.com> wrote:
>
> I rather doubt clang-format will ever be 'close enough'.
>
> A human's sense of 'taste' for reading code is very different than
> what an automated tool produces.

Maybe, but it is a trade-off. If it is close enough, the benefits of
automatic formatting may overcome the downsides.

> Also, try looking at the changes clang-format does on a file chosen
> at random:
>
> o columnarized definitions -> not columnarized
> o odd line continuation placement using spaces and not tabs before \
> o odd array definition layouts
> o per line definitions with comments poorly laid out
> o individual line definitions rewrapped
> o enum definitions on multiple lines compressed to single lines
> o u8 array definition layouts where the first element has a separate
>   meaning than the subsequent elements are compressed and made
>   difficult to understand

I am not sure what you are trying to show here -- some of these are
precisely the things that the tool could improve or have already
improved, and we may just need to use the new option.

For instance, for the columnarized macros case, it is possible to
align them since clang-format 9. For array of structures, there is
also a new alignment option since clang-format 13. Etc.

For the wrapping and related bits, now that the limit on 80 is a bit
more fuzzy, we could perhaps tweak the penalties to improve the
decision making.

In summary, what we should be trying to do is improve the tool
configuration and tool itself to see if we can get it to be close
enough to the kernel style to make it more widely used.

> I think _some_ clang-format output is ok, but the concept of
> enabling/disabling specific reformatting bits would be quite useful.
>
> And sprinkling "clang-format on/off" lines in the code is not good.

Definitely, but it is fine in some exceptional cases.

> Any control codes that determine when source code layout might be
> immutable or allowed to be modified could be should be tool name
> agnostic.

I don't see why would that be a problem, and I don't understand why we
would use several different formatting tools (the point is to be
consistent, after all); but sure, we could propose an alternative
spelling.

Cheers,
Miguel
