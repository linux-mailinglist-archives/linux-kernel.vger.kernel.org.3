Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3754A573C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiGMS0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiGMS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:26:04 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AFB2E9D5;
        Wed, 13 Jul 2022 11:26:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 125so465940iou.6;
        Wed, 13 Jul 2022 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Sqm7pmANsIHaXqfjwRbsObZ/W58Kx9DRWdRfmAe//4=;
        b=X2/7V5MIwLm4JpGj1aDm7zBkXaEgM/SANRxXPeGLeUFogJbcatOd8Odf/PFNuUd8D/
         r6JaJ+ndeuGAS2DmWDILAMAImaFDM8speM/BW2+5pHwjTq0tRud/brlKhCITg1rhZvbn
         aGxLV5zl3Z8ulcOQl+Lt77Q9Ptpdio3x5D8ORG6zJBn5w118f6xiU4W/eKDO9UFEYngs
         A9FYcPbXeDjA+OTCD4z9UL3AA4ohH7gtAhpUjyG/veIR85+tw0ml8YVbmT+hFXplDwY5
         /4w8+mqeaMbXIkPWSxW1O9tCet4HTNGhrIkwUZMBVzzXAfda2RtNA1kjXvbZc3+1sVHQ
         EWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Sqm7pmANsIHaXqfjwRbsObZ/W58Kx9DRWdRfmAe//4=;
        b=aL2JGYGETjjxI3UDp+xWvaBDET1U3ARpJ6w5CRjxp9hIlVBM9emfLtr6Z3qcUx+5Jy
         x3dI4QZbFwSWBzjBcJQuQF5Ys4h/ozUomZ5nYHMnVZqPr3z2FFzWAA3faYcYJPOm97oo
         1ny2x1BqlwBhDeSbpSbl1NkbziB/F1d4HvFoQ+wODeXKdx6R84Gkz37/MbcIEeU+7cvQ
         EZ4satAcJ0srQcV9Ih2cItqs5EtYLTL5J70rdUHSo8wOIEzwGD08RjbOjeA7PrvBd/79
         GB0mjnni4s1zU7eD5ca+Df7C0Kyb6ee5cf1EC5Kmy+dICYVYfN4Gj3dB8qYZEM2nUlZK
         u3Nw==
X-Gm-Message-State: AJIora/BOOD0QgDk+MkJPTiXR3Myg4yxCy/7pA8NNK6C6qpJJQgADHSJ
        uPee/kKzxyqN2o2Ia7yRw1xOp1mtQ8WjNvytyOw=
X-Google-Smtp-Source: AGRyM1vETpob2+qvOtJHHWx50SkIdyowa/dHUC2xBLlnnVMJ2KiZlCYmH57hwc7560OGCnlULD0w0bUwWjAWsGdfrxA=
X-Received: by 2002:a05:6602:2c89:b0:67b:7e8c:11c1 with SMTP id
 i9-20020a0566022c8900b0067b7e8c11c1mr2505211iow.101.1657736763055; Wed, 13
 Jul 2022 11:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220713063204.6294-1-khalid.masum.92@gmail.com>
 <20220713063204.6294-2-khalid.masum.92@gmail.com> <20220713111637.7eca089c@kernel.org>
In-Reply-To: <20220713111637.7eca089c@kernel.org>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Thu, 14 Jul 2022 00:25:52 +0600
Message-ID: <CAABMjtEnPa2PWPJ0SsGVLZjGqO8V=0ajsY9A1ZAdNpmEW5sjTw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] net: kcm: Use sk_psock size for kcm_psock_cache
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 13 Jul 2022 12:32:04 +0600 Khalid Masum wrote:
> > `struct sock` has a member `sk_user_data`, which got its memory allocated
> > in `kcm_attach` by `kcm_psock_cache` with the size of `kcm_psock`. Which
> > is not enough when the member is used as `sk_psock` causing out of bound
> > read.
> >
> > Use `sk_psock` size to allocate memory instead for `sk_user_data`.
> >
> > Reported-by: syzbot+1fa91bcd05206ff8cbb5@syzkaller.appspotmail.com
> > Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
>
> Odd CC list, it looks like a netdev problem but netdev@ is not copied.

I am sorry for the inconvenience. I resent the patch with netdev in CC here:
https://lore.kernel.org/netdev/20220713181324.14228-2-khalid.masum.92@gmail.com/

> We had an other parson looking at this on netdev. Is this happening
> when legit kernel socket gets mixed with BPF sockmap?
>
> Does this fix work?
I will take a look at it.
> https://lore.kernel.org/netdev/165030056960.5073.6664402939918720250.stgit@oracle-102.nfsv4.dev/

Thanks,
Khalid Masum
