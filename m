Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C6589509
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiHCXxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbiHCXww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:52:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F10C3B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:52:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gk3so21913505ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UhuLkTz4ewjebruBu000VR+SoEVViViRI+eLh3drHz4=;
        b=RLa0K/3J+fTz0JDtX8L4ZznORLoy8hmPB+h5IkdM4E4Y58FxDb54Mgxryd6itqZvMJ
         BsHeZ9FjMeKkargYLuBr1ZXJagY4sVlpG+czrZL0S/vAF5m/DhxIhxMPiUn816YDa0bp
         NJYZ2HjhcfeD0xI9YUGVS4uT0SZXLyEpsjo2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UhuLkTz4ewjebruBu000VR+SoEVViViRI+eLh3drHz4=;
        b=usaugVO4YD+Ovvt2CNuFla05jA5t3aEN8g5M2gw0aV35unLIzlqk90jrUx72ii+lWN
         9uvDtbw1VHxfH9m5nd0ciEA8Za2opQN8axh9HwxsHBmL2X0BMWmIV0+hK1nlNKtMIuMO
         AUUmXqdWDAAoUBu425vPHkIy9impKLMvdypc2Aib3/SseZk3a4bvODgu17B+j338rLgF
         NpD21MuoykaZFV5wFf7lIc5v+llWR1x62g1sW7wNeZ0m3axmSye42HFrXxYz93t0zlGM
         Sc+PVACtAGwtHYRowJIn4wEWZBwiMm88TCV8HdRlw2YXoRi/x47woe2d8AxBuX/njO/7
         0mQg==
X-Gm-Message-State: ACgBeo1FGgvzzUWO2R0V7g814734+Qo2V2toPacDlqnIgTaWmtgkRGpw
        SocASRB4IsEmxwmgXM3+sUlK9lSe819LTvOb
X-Google-Smtp-Source: AGRyM1vv63MidV1d5MxaAvj/q/M9Xq4y0qVj7SVmLOxqrx+XuCGt4qvQNy06JdlcdhNo/dVaxvNIGA==
X-Received: by 2002:a17:907:a050:b0:730:3da2:7c1a with SMTP id gz16-20020a170907a05000b007303da27c1amr19107366ejc.707.1659570769516;
        Wed, 03 Aug 2022 16:52:49 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709063caa00b0072eddcc807fsm924637ejh.155.2022.08.03.16.52.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:52:48 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id n20-20020a05600c3b9400b003a4f2261a7eso1568526wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:52:48 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr4356909wmf.38.1659570768369; Wed, 03 Aug
 2022 16:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220803101438.24327-1-pabeni@redhat.com>
In-Reply-To: <20220803101438.24327-1-pabeni@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 16:52:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=widn7iZozvVZ37cDPK26BdOegGAX_JxR+v62sCv-5=eZg@mail.gmail.com>
Message-ID: <CAHk-=widn7iZozvVZ37cDPK26BdOegGAX_JxR+v62sCv-5=eZg@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 6.0
To:     Paolo Abeni <pabeni@redhat.com>, Vlad Buslov <vladbu@nvidia.com>,
        Oz Shlomo <ozsh@nvidia.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 3:15 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.0

Hmm. Another thing I note about this.

It adds a new NF_FLOW_TABLE_PROCFS option, and that one has two problems:

 - it is 'default y'. Why?

 - it has 'depends on PROC_FS' etc, but guess what it does *not*
depend on? NF_FLOW_TABLE itself.

So not only does this new code try to enable itself by default, which
is a no-no. We do "default y" if it's an old feature that got split
out as a config option, or if it's something that everybody *really*
should have, but I don't see that being the case here.

But it also asks the user that question even when the user doesn't
even have NF_FLOW_TABLE at all. Which seems entirely crazy.

Am I missing something? Because it looks *completely* broken.

I've said this before, and I'll say this again: our kernel config is
hard on users as-is, and we really shouldn't make it worse by making
it ask invalid questions or have invalid defaults.

                Linus
