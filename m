Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F605840BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiG1OLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiG1OLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:11:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3786714C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:10:37 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e127so2688699yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=75gOm0H87vvC1WlvPgACJzv27unhimx+IMWBYn64pbQ=;
        b=Lfm5b0MN3sZ7fYdXnWwO2l+W1c33yoFNj+30RDLpQhvHqz41Za276fmqSfCyW2azex
         j/dfoln/YRVf6ua1uvcrkWiuX8HO32/q1uioMjnktU0I8davQeefxLG4ZJ/m8ApsRqXc
         huCz3tdtyr5djx5Sf2GUJMU+LtTgPZy3ja//UCXV8WJaSvlW+9PAPYUU7INo/7kdoxGD
         KauQOBOW0r9m/7/f6vl2G2YEK7g+vJS7AFnQN1vfQ6vPk87PkbDc5SwaZnpfjpzpWbnE
         87xqZSD6qLlkx56JbKOgshJFAAjntvJPGtWoCwimpn9xC54RHVXbZIyTpnNWoNXOzIMj
         bfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=75gOm0H87vvC1WlvPgACJzv27unhimx+IMWBYn64pbQ=;
        b=OnNLhseDA2QL5bElRDozHSKmcPkIA+/48N/id65gdjNX9+p/QYspQrqZgmCjkMlj6F
         qiTL3N/A6BHLOS/+X6AzbUHWnFi5SlqcA7J/qyZidTEMjiOHtVRE5Wa3eHQ30DT++ety
         hjlnXUPE4HwA5OrUFh3c+LijEYaVncMVQixdqM/kazjKWmMkM3xVgFfZsKrvi1eTgVbU
         I5RQLyMEejF3PTC9V4ScRZg7Y28vitHUNrO9+NBeRXKU994JnRHS7rZgtAwGNJtZQwGx
         yIkDbyZUkTYE7m7gGAbFyak1wpbpy+eocuoeQT3HX44fPPey1+0oAFUMXfGkCPAXL6zE
         10Zw==
X-Gm-Message-State: AJIora8u/7NkB0F6xRgKtbsfoEwteoZ7awMvGxf9kgZmRFYQA2/Jnd7Y
        qNlbejn9u5eDEOLxdMO3u74wtmmhM3ZQoSZa5Wc=
X-Google-Smtp-Source: AGRyM1ulpvmND1h7zZGYK1vyOSZtQ5Qgr9vCeHmTwIZVsxr5qK5+IjMpgobHltOCDdWgX5peWU67IrbNTm0H6HpmNik=
X-Received: by 2002:a25:bb86:0:b0:670:ef2:7f9a with SMTP id
 y6-20020a25bb86000000b006700ef27f9amr21514981ybg.318.1659017436352; Thu, 28
 Jul 2022 07:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com>
 <YuIyKjvQ0vOeRWhl@kroah.com>
In-Reply-To: <YuIyKjvQ0vOeRWhl@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 28 Jul 2022 16:10:25 +0200
Message-ID: <CAKXUXMzp=b7MTZmwzjO=i3P1ftnDLGNV7tvtwDHhF=ZbyySqzw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in post_one_notification
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dipanjan Das <mail.dipanjan.das@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, fmdefrancesco@gmail.com,
        Eric Dumazet <edumazet@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 8:52 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 27, 2022 at 02:28:45PM -0700, Dipanjan Das wrote:
> > Hi,
> >
> > We would like to report the following bug which has been found by our
> > modified version of syzkaller.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > description: KASAN: use-after-free Read in post_one_notification
> > affected file: kernel/watch_queue.c
> > kernel version: 5.10.131
> > kernel commit: 8f95261a006489c828f1d909355669875649668b
> > git tree: upstream
> > kernel config: https://syzkaller.appspot.com/x/.config?x=3De49433cfed49=
b7d9
> > crash reproducer: attached
> > patch: This bug was previously reported by syzkaller for kernel
> > version 5.17. The same patch works for kernel version 5.10 as well,
> > i.e., we tested that the repro can no longer triggers the reported
> > crash with this patch:
> > https://syzkaller.appspot.com/text?tag=3DPatch&x=3D13b8c83c080000
>
> I'm sorry, I do not understand.  So this is fixed in Linus's tree?  But
> not in 5.10.y?  Or it is not fixed everywhere?
>
> If it is fixed, what is the git commit id of the patch in Linus's tree
> that fixes this that should be backported to 5.10.y?
>
> confused,
>

I will try to help our poor confused kernel maintainers here with some
quick background information I could quickly find (just out of
curiosity on what these reports are all about...). Maybe, next time,
the bug reporters can do that simple and basic investigation before
reporting, and provide that information in a condensed form and at the
right point in time, so Greg or Sasha can really act upon that.

For the syzkaller-found KASAN bug report above, there is a patch in
discussion (https://lore.kernel.org/lkml/182407602ce.190e58816827.790436418=
6178466266@siddh.me/)
to resolve the issue in mainline. As of writing, the author still
intends to provide a proper working v3 patch, which then might be
applied by David Howells. So far, this patch has not been in
linux-next, nor even Linus Torvalds' tree (mainline). The reporters in
this email suggest that this patch once it reaches mainline can be
backported to the 5.10 stable branch to resolve an existing
syzkaller-triggered bug in the v5.10 versions.

Dipanjan, are you aware of the preferred options to work with stable
maintainers mentioned in
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html?
Please read that page if you have not done that yet.

Dipanjan, could you please follow and influence the development and
handling of the patch above?

Either, you can achieve that the patch is already prepared properly,
so that it is picked up to stable due to the meta-information in the
patch commit message (Option 1 in the stable-kernel-rules, preferred).
Or, after the patch has been merged to Linus=E2=80=99 tree, send an email t=
o
stable@vger.kernel.org containing the subject of the patch, the commit
ID, why you think it should be applied, and what kernel version you
wish it to be applied to (Option 2 in stable-kernel-rules, if Option 1
is not successful).

I believe that this above is a good way (maybe even the best way) to
interact with the kernel community and its stable maintainers and get
the issues resolved that you are reporting.


I hope this helps,

Lukas
