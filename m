Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F510567A16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiGEW1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiGEW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:27:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B24B14094
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:27:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y8so11323246eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GF7rzd33kYZapxzmXqOhPb30+qFnkW9YqU0BeBES418=;
        b=dRe1YXyxJpTUVZt38fqaCHbBqNddZCxIaV39InTg7SqnG+vndujWdF1c+JQxLSjhZY
         ZSoIv19nYtf5+FaQei8ykjpLx4GMeAg0gAEl4ZCE4BpGKiO3LWnhH30H5YINxdN4k9dg
         MUNcjokx7x9ciwQfRpvEC288v1LWwll5nxYxc+9jXxYp4W3ffeoVWZD5nAhgzjWD1Hjh
         MXq3vvWHiwiwQp2aUBu87UrtDyBuT6blVxhp5v523t9ez9QjcLjuk8IMGLV778WGhQEQ
         F8FTwEy8UgsRnw1z9JgXeZcDuxa8z9pKgDowOqjMe0BeIj4CfSzjQ/cUXoA5EuNJxne1
         Ie4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GF7rzd33kYZapxzmXqOhPb30+qFnkW9YqU0BeBES418=;
        b=wuysm8mu8CsFgzboze+ROnhBNT+55tV1efcPig+nK4TXl8OXm2iUgIzHecf8SJ4inh
         YQAWTDPTRc8XwPfNDVFdd8I18/VhUR7RJlnASl61J52uS3WZ1+UurcgGffP+E6wRCvgW
         tgxWSmgC+L6gJh+2qdNN3LSf/i7t8QLuNqaVICz9cERepdZed+fhhm2GsOVXTUsHQell
         xjj7Yy+iacZymE2SzeJhAtV+6ppQeihFUkfeX6i0L2U/9hPYPdL39ekUauchGhlAWc0J
         KMXGNBfixTss5DAvybSbJXEnLHHVPm9ug98cP+32AKBWKXdxfKDoOjZhjaEQAGlVpjjh
         GgDw==
X-Gm-Message-State: AJIora/WMg7brD72a3MADcl/ieQpCuDwtDi5m7cBDed9YPars1HBi4T0
        0kELygrsK6akRrPf14eNOe/Cjp6WbNjyAF0u+1vixA==
X-Google-Smtp-Source: AGRyM1vSxaaItxpvw2gjnhaAcDSzQoVbJdrIsurynAvnZ7jN5axUiIZB4N3jj0PS0usnfJPNyhY7Pcf3ukzvUd65Zts=
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id
 ew4-20020a056402538400b004316d84b451mr48696360edb.46.1657060038675; Tue, 05
 Jul 2022 15:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <74c6f54cd3869258f4c83b46d9e5b95f7f0dab4b.1656878516.git.cdleonard@gmail.com>
 <248071bc915140d8c58669b288c15c731407fa76.camel@redhat.com> <324c9844-1ecb-60c0-c976-16627dff1815@gmail.com>
In-Reply-To: <324c9844-1ecb-60c0-c976-16627dff1815@gmail.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Tue, 5 Jul 2022 18:26:42 -0400
Message-ID: <CACSApvZoi1sMHOfJ+a9fen53NJ=O7GNayeWWUCghAkNiT1YUHA@mail.gmail.com>
Subject: Re: [PATCH] net: Shrink sock.sk_err sk_err_soft to u16 from int
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 9:01 AM Leonard Crestez <cdleonard@gmail.com> wrote:
>
> On 7/5/22 13:31, Paolo Abeni wrote:
> > On Sun, 2022-07-03 at 23:06 +0300, Leonard Crestez wrote:
> >> These fields hold positive errno values which are limited by
> >> ERRNO_MAX=4095 so 16 bits is more than enough.
> >>
> >> They are also always positive; setting them to a negative errno value
> >> can result in falsely reporting a successful read/write of incorrect
> >> size.
> >>
> >> Signed-off-by: Leonard Crestez <cdleonard@gmail.com>
> >> ---
> >>   include/net/sock.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> I ran some relatively complex tests without noticing issues but some corner
> >> case where this breaks might exist.
> >
> > Could you please explain in length the rationale behind this change?
> >
> > Note that this additionally changes the struct sock binary layout,
> > which in turn in quite relevant for high speed data transfer.
>
> The rationale is that shrinking structs is almost always better. I know
> that due to various roundings it likely won't actually impact memory
> consumption unless accumulated with other size reductions.
>
> These sk_err fields don't seem to be in a particularly "hot" area so I
> don't think it will impact performance.
>
> My expectation is that after a socket error is reported the socket will
> likely be closed so that there will be very few writes to this field.

Since you're packing sk_err and sk_err_soft into a DWORD, I'd suggest
adding another patch on top to move both fields right before sk_filter
where we have a 4-byte hole. As far as I can tell, this should save
one QWORD from "struct sock".

Eric, I believe these fields are read-mostly and that wouldn't infer
with your previous layout optimizations. Is my understanding correct?

Thanks,
Soheil

> --
> Regards,
> Leonard
