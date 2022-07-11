Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0714570AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiGKToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGKToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:44:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29D3D106
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:44:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b11so10541059eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwEDVdKbnbZtn9p0uC93yaXB5Vwp4sXmO/V6mgJc1hE=;
        b=Opt4AN70UWDNIKd9DrhmzqMlFdNVINRChnpwp92hsWrOpZvBTfEZJN7paVV3K1qBFM
         7OZBpDZMglnQFlcLjrZ9pDfXTkdTQoUzuP0Hz6eUeQux4XKzh2WKfUasuN2gSwWsHLep
         DzWiJVcrraZfXmxMQGs9Pb2Y/u1AF7nC4xlTKtrnqEUhJhoVIbnrdnqPX2Iy3Rfk7bXT
         5SFxJySXeTvn6G4IFMg7HMX+a9tR0UjYWpLwPE3Q0biZEU0kBbtVAuQNo8jYH7ImbN+0
         PlwWct+os2RQ50ZmFHtlRB1eot1RVM7cLSdtJgMbb737jfzbRmo5RVd/r5jq5syWOwH8
         K+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwEDVdKbnbZtn9p0uC93yaXB5Vwp4sXmO/V6mgJc1hE=;
        b=KVPkRJkruzm4uSJNpdt8WpRb7r9qWJR53yDBQXITtUigNWxpmF8wYaJaRAQrjzXVAd
         gRjohdlY8n00YjPlpimKR3bOAJuRihDuH5k2gYr4nv4bVyjh/ih8zfR23DEJWL33K0l7
         i3xmvT6Go0rsui+/gQNMBkJ4bvghflC5CFbGDdwmq+WRB57289ubu1V2ts8kCJP15os0
         tztLzaVGh6WZ8zs/H0RhwQ6aZiCNoQzNhZ9cYDmKMOZZ+1DYMcZIvl3NPINsNtSp6Mth
         FJ4JKcZd15po/wOTDBSI3raF0GVLJN5dsEfJtZObk/gfCBISYxKUqqYYb6f3IJnZgss4
         VyBw==
X-Gm-Message-State: AJIora+Da7LKzFI0gCxTAJdkP/qtlR1hG2jOZPoDadSumEt1Yayhk7kM
        xff3Gngqe6JA15gWJs3swvpkz6SBgy4wG5/u0oS1eA==
X-Google-Smtp-Source: AGRyM1tHofXUqkdW7BnM1C245t2ran6VcnZvUJuKy6J7zLT7nKrsoMbm7F1S99ufXtKPsrkkFHcy/q7Q5UPlTaovmsk=
X-Received: by 2002:a17:907:60cc:b0:72b:40a8:a5b with SMTP id
 hv12-20020a17090760cc00b0072b40a80a5bmr11795359ejc.379.1657568656253; Mon, 11
 Jul 2022 12:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220707191745.840590-1-justinstitt@google.com> <YsvniilEnfUOd+yk@salvia>
In-Reply-To: <YsvniilEnfUOd+yk@salvia>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 11 Jul 2022 12:44:05 -0700
Message-ID: <CAFhGd8qDwoWLTJEGtap3s2_+AOLdnSg57DO8VgoMrqDtcFY7qQ@mail.gmail.com>
Subject: Re: [PATCH] netfilter: xt_TPROXY: fix clang -Wformat warnings:
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Mon, Jul 11, 2022 at 2:04 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Thu, Jul 07, 2022 at 12:17:45PM -0700, Justin Stitt wrote:
> > diff --git a/net/netfilter/xt_TPROXY.c b/net/netfilter/xt_TPROXY.c
> > index 459d0696c91a..5d74abffc94f 100644
> > --- a/net/netfilter/xt_TPROXY.c
> > +++ b/net/netfilter/xt_TPROXY.c
> > @@ -169,7 +169,7 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
> >                  targets on the same rule yet */
> >               skb->mark = (skb->mark & ~tgi->mark_mask) ^ tgi->mark_value;
> >
> > -             pr_debug("redirecting: proto %hhu %pI6:%hu -> %pI6:%hu, mark: %x\n",
> > +             pr_debug("redirecting: proto %d %pI6:%hu -> %pI6:%hu, mark: %x\n",
> >                        tproto, &iph->saddr, ntohs(hp->source),
> >                        laddr, ntohs(lport), skb->mark);
> >
> > @@ -177,7 +177,7 @@ tproxy_tg6_v1(struct sk_buff *skb, const struct xt_action_param *par)
> >               return NF_ACCEPT;
> >       }
> >
> > -     pr_debug("no socket, dropping: proto %hhu %pI6:%hu -> %pI6:%hu, mark: %x\n",
> > +     pr_debug("no socket, dropping: proto %d %pI6:%hu -> %pI6:%hu, mark: %x\n",
> >                tproto, &iph->saddr, ntohs(hp->source),
> >                &iph->daddr, ntohs(hp->dest), skb->mark);
>
> Could you instead send a patch to remove these pr_debug calls?
Do you mean all Instances of pr_debug in `xt_TPROXY.c` (of which there
are six) or just these two specific cases @ +169 and +177.
> Thanks.
