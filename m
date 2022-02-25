Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE774C3E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiBYF6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiBYF6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:58:10 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D932670CF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:57:38 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id j12so3868559ybh.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6oU5BEVkshaAMokAZtOuNVaEgeoac+WRcvJj+j68h0=;
        b=SrswqocacdLGxG8C9W0ZZR8+sUljEIpZDqDP/1us23Mn3RGi8e8jGv25xaYgPgKwzz
         iVQ12hZfsHRvWWCk9SRnATEZj/ybOV+BN8mKpkWkNPwu8bEMxdGHmfwOziAbxoBg+K/I
         /9lqbNwR3oIYNpsPFLgjH4TYdB5P21Z6Cr6Miru8Up/us0cGxoMuiCgsUYeHqOz03JGM
         4elxxKS2SL4W0jKEEEOqLZ/2jFHUo/M5uY3BySVeSIlxMd91UtiBp1NerKJdlwjKcyc7
         DRbU0HDUbTropwqnp6NTyk38RRUECe818VXVom2HnNzGzCQNt4asrjrPoBUAR1K6GXoi
         97AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6oU5BEVkshaAMokAZtOuNVaEgeoac+WRcvJj+j68h0=;
        b=mah2VczIh9mrJ5P5/amrVUDd7EADNcKnnaUsyzb5OrCjjcvORZXLutDValqk39sto0
         PizKZRzVh2utnht2P2NM7OuJjhwlCZ6ZKLySYU2xkrUS2Y1dTq635uVcyp2sMEJNy/Sn
         J9JA1jXq+5VD7rS1wUelC3ilr2N2ofG4GFjeroGyBVdlSxeRFbogzH5jAvdnMqmlbvQm
         tuH+d7rF0dUX0xWiG0C17Jy+HqmR623jLgoIiXb52F9849VUyTVyO2kjEJTWxBYu68Ce
         EfpIdqOyd1tRAblJCe9YdFpwRHtO1qwrGdNc5klD5yGfeiCkETmCPN8bDMTm7+z1FY+T
         H1QQ==
X-Gm-Message-State: AOAM530rZ2Qn9arKPgazeX2wvJ8uMTi2QQO+Dowbvacov2jlpXeZkZP9
        k9/Yku1cnIRfnWHKVf03H14qjeP780zcqcz3mFfMBw==
X-Google-Smtp-Source: ABdhPJy+9jqps8O2zXLCc+Ms096Ep8pMnQRqfYX/yM2STJxCqWbGcMZCfolwyeN1o3xAXcSQyxdyxkRNGPvRIu/sWOY=
X-Received: by 2002:a25:504c:0:b0:619:6279:88cb with SMTP id
 e73-20020a25504c000000b00619627988cbmr5728782ybb.55.1645768657811; Thu, 24
 Feb 2022 21:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20220223175740.452397-1-dima@arista.com> <26c10903-53a1-cab4-b213-440f4a5a18f6@kernel.org>
In-Reply-To: <26c10903-53a1-cab4-b213-440f4a5a18f6@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 24 Feb 2022 21:57:26 -0800
Message-ID: <CANn89i+oyKK6j98B=Tzg9CbfBykwMV8De0eJvO+AHzJQjQy-jg@mail.gmail.com>
Subject: Re: [PATCH v3] net/tcp: Merge TCP-MD5 inbound callbacks
To:     David Ahern <dsahern@kernel.org>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
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

On Thu, Feb 24, 2022 at 7:16 PM David Ahern <dsahern@kernel.org> wrote:
>
> On 2/23/22 10:57 AM, Dmitry Safonov wrote:
> > The functions do essentially the same work to verify TCP-MD5 sign.
> > Code can be merged into one family-independent function in order to
> > reduce copy'n'paste and generated code.
> > Later with TCP-AO option added, this will allow to create one function
> > that's responsible for segment verification, that will have all the
> > different checks for MD5/AO/non-signed packets, which in turn will help
> > to see checks for all corner-cases in one function, rather than spread
> > around different families and functions.
> >
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> > v2: Rebased on net-next
> > v3: Correct rebase on net-next for !CONFIG_TCP_MD5
> >
> >  include/net/tcp.h   | 13 ++++++++
> >  net/ipv4/tcp.c      | 70 ++++++++++++++++++++++++++++++++++++++++
> >  net/ipv4/tcp_ipv4.c | 78 +++------------------------------------------
> >  net/ipv6/tcp_ipv6.c | 62 +++--------------------------------
> >  4 files changed, 92 insertions(+), 131 deletions(-)
> >
>
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

SGTM, thanks

Reviewed-by: Eric Dumazet <edumazet@google.com>
