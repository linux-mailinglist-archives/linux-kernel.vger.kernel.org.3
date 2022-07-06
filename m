Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6838568ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiGFOFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiGFOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:05:04 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F431031
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:05:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i14so7755916yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVoGDHkmg2bV3dEPVfOyFVTv4T1dp99x9dXZ6++KkGc=;
        b=cdo6+uYBatnadqEjI5guS0rIxTahsAQIeUq45tTSVhz23zrCM96eQ4BT4Jo3qowS7F
         zwvrozvhVd7zFWB+PxqeU2qtg3dLEK9pYxuInFXgEWHWATikP5H272k78mRw/8A2M0bP
         nuS5TSe8/G+NX0Q1E3IBiBi2M8aETzG8enil6Gos7nWggMBDe/5UumGenZ+aCC/PUIAg
         oy8uzghMOZYCWOuUt85ssn1mfDPfKJehj5ZzD0krTTlBqrGaeuNEA0ldGcDqE6N7E6y7
         CiMY6S/riZB+qlTjX3boa4jcJthwzSNM53w/Ph5/4rCOauSDEp0U3mAINbQ0DJHvSC7f
         7/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVoGDHkmg2bV3dEPVfOyFVTv4T1dp99x9dXZ6++KkGc=;
        b=qVxypHqqIc+AyKR+k1G7GU52J/Pcgu6RnoxIdaiOvkTRUGZM6pqVnzIYBudeBzMjZh
         LrbdKJ0HpGOwbt3bKaE8sUk159ZcPM+ZBZx62imXWJDt5QEDfmjiTxhuTztY06LkrY4L
         5/qKPZ0jPCbpRH/BPsQ5BAn8FeEGwiSqIT8w+plMLz0e6GXIPbQO+gRcYuuMe8iHaxvL
         0WK4sgQHyFKL65c17MMFzWld52ENL3TZDGU3PfzqEGeI42p17Hr06jQ5Bh3TPH7d3bjX
         v4/o7F90Pl+GVle02dMKJ9GAeQw0HxYIiHV1dRX2EYxwTbYXU7KTqVjeoTgZ3WB7VtDx
         dN/A==
X-Gm-Message-State: AJIora/EOeJYZCkl3SCht5sAmqMdmyZhYZLH/pV66AjslP8CKSPet8a5
        TWVODtF7eWw70sCeIMsbh3lKeMLtUri+6PYwqlKz+w==
X-Google-Smtp-Source: AGRyM1vvPdKHgBPAPQoHPnplrll3WuBZpno3rPELKLbCaPm8kAqegFo2BdOcqTQ6rLOzjsy/LVP7pS1Hssh6NJY/3EY=
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr45625905ybh.36.1657116302422; Wed, 06
 Jul 2022 07:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <74c6f54cd3869258f4c83b46d9e5b95f7f0dab4b.1656878516.git.cdleonard@gmail.com>
In-Reply-To: <74c6f54cd3869258f4c83b46d9e5b95f7f0dab4b.1656878516.git.cdleonard@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Jul 2022 16:04:51 +0200
Message-ID: <CANn89iKxoSDOO3gx2qVXPaQ2g+6rJi8Q0CN2GAW-nf4WTo1GBw@mail.gmail.com>
Subject: Re: [PATCH] net: Shrink sock.sk_err sk_err_soft to u16 from int
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Wei Wang <weiwan@google.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 10:07 PM Leonard Crestez <cdleonard@gmail.com> wrote:
>
> These fields hold positive errno values which are limited by
> ERRNO_MAX=4095 so 16 bits is more than enough.
>
> They are also always positive; setting them to a negative errno value
> can result in falsely reporting a successful read/write of incorrect
> size.
>
> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> ---

We can not do this safely.

sk->sk_err_soft can be written without lock, this needs to be a full integer,
otherwise this might pollute adjacent bytes.

>  include/net/sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I ran some relatively complex tests without noticing issues but some corner
> case where this breaks might exist.
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0dd43c3df49b..acd85d1702d9 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -480,11 +480,11 @@ struct sock {
>         u16                     sk_protocol;
>         u16                     sk_gso_max_segs;
>         unsigned long           sk_lingertime;
>         struct proto            *sk_prot_creator;
>         rwlock_t                sk_callback_lock;
> -       int                     sk_err,
> +       u16                     sk_err,
>                                 sk_err_soft;
>         u32                     sk_ack_backlog;
>         u32                     sk_max_ack_backlog;
>         kuid_t                  sk_uid;
>         u8                      sk_txrehash;
> --
> 2.25.1
>
