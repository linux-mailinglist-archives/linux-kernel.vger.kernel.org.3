Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521505999A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348165AbiHSKQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348051AbiHSKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:16:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55FDAA25;
        Fri, 19 Aug 2022 03:16:18 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l5so2977178qtv.4;
        Fri, 19 Aug 2022 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ADSKbpogRZlDU9n3ifnRUc33Vsi63y1uvA/ha4YLmHE=;
        b=i8PBBhDWC26ca+yNixL2xWjMqtpmDBQLNXSyysTGt5bb+0zRtXc+aUdW4o2IDSvz0z
         PQaijn0pK2zpF5gRvJycNFrHz95kTU8AZ6TF6F1FLjlYpmDu1neYYlxd1TpMMx/uOx09
         nqtn2303qZzZhHK6t3qn9eQkxUJqx0LLD/jaz2juglYeLZJrKR8GedvEtMwwxFn/q2sP
         YDjk8IJVOQYjad0667EC9jLgUldL3D4AE/cfzC1raV0+G+2xem7vAV7o9pLTb4d03xr6
         D2+SVOB3sNbm3EEy4pZ1iR8lflr+9F67YEuC4YKbJ2gauNrbYGTGuuGF6StoJV/k4589
         W4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ADSKbpogRZlDU9n3ifnRUc33Vsi63y1uvA/ha4YLmHE=;
        b=Zsg1jiH2Z+yUuFNFspkCpj/2QGzMIyyfZXj3U33px5ZlGd9GpP2xqSo26W1XDRfk5P
         D4cWLn1yA8TCz1wQCkdZN2LJTO/yps/tOH9AOqkGh3pnHsh/2zQcdRM001NLVyicp8qO
         gpEU4WFtnkA9x2+yCLjO2b8I1q1EQ95EMv387Lul6ctmunsEeohIGkeBrCaz4ZATrvL4
         m4kP6vYbzKFmYlyj1Ss0dq36QK8NgGNtQjyXjSpnAruRCJGvJ2iaSvsYcgYNlRrP0SVx
         C0j1YZ6WReoaQ5D4wq3XjZsZ758gUKPXJTT55aRb4ouM1vl1Ml5kVVxDq3YKsQ8XnqtT
         TsJQ==
X-Gm-Message-State: ACgBeo1Ke77Vqt1jJufLtBQOIhgMiCVQ4jOviM9QXhAZSXixBEmKBKrD
        NXxIY+yyxtFhYVmfydWqWil7RGJ7AXyQgJp8tAm1ce3jDB2HKw==
X-Google-Smtp-Source: AA6agR6SaSQ19q2UqYnMxJw7FCkWyGiLx06+wAqWACxJ1AlhJ6+OjPJAuoZ8qH/ooDiimIes55K04FFptUbN9uHUtaM=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr6008326qtj.384.1660904177633; Fri, 19
 Aug 2022 03:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220817105643.95710-1-contact@artur-rojek.eu>
 <20220817105643.95710-2-contact@artur-rojek.eu> <CAHp75Vd49aCKkK+KvmxJrW2mKk7=VgtSBCTYE9umOhZhc4Y8FA@mail.gmail.com>
 <4GXUGR.SAF00K92YJMF@crapouillou.net>
In-Reply-To: <4GXUGR.SAF00K92YJMF@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 13:15:41 +0300
Message-ID: <CAHp75VdqHiPZT+cpT4OZR1HB32xS1OF=PqgXcsRW9Vn=XjC0hg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio/adc: ingenic: fix channel offsets in buffer
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 1:07 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Andy,
>
> Le ven., ao=C3=BBt 19 2022 at 11:12:38 +0300, Andy Shevchenko
> <andy.shevchenko@gmail.com> a =C3=A9crit :
> > On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu>
> > wrote:
> >>
> >>  Consumers expect the buffer to only contain enabled channels. While
> >>  preparing the buffer, the driver also (incorrectly) inserts empty
> >> data
> >>  for disabled channels, causing the enabled channels to appear at
> >> wrong
> >>  offsets. Fix that.
> >
> > What consumers? Have you tested on all of them? Please, elaborate. It
> > might be that some of them have to be fixed. In such case you need to
> > report the issue to their respective channels and put the
> > corresponding links here.
>
> There are no consumers to fix, only this driver. I believe it  wasn't
> noticed until now because all consumers were only using channels 0 and
> 1.

Something like this explanation is missed in the commit message, with that
added (in the above or similar form)

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> > P.S. It doesn't mean I'm against the patch.


--=20
With Best Regards,
Andy Shevchenko
