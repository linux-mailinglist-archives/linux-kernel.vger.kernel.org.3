Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C76256C535
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiGHX1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiGHX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:27:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C401419BE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:27:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y18so156655ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Oi60uoXzvamvc3/SFoRIFUoo3eDrzVvDd6TkmxROEc=;
        b=eLIcA0wmLBrkZp3xFCD89JHRf3MzzY1K5ZOseLf2l7FsxyK5DEZYcIVMeX/d+KpKER
         RcLpKuJrJQMfTz4LDBMDQMCuZYLw6nfsRCZXgoLtqZn8EoYFiOnEzOEiPe34RdsugaC9
         DVLlB6vSXVef+DVhAEhpFaI4XSiAeLpIjhibeOYxJdGfRQP3u//Y5/7iw8E3MDi/jZTB
         HTWyHH0EVqtHdHaJt8xzJXzKX7nonEXKDdbPuT+SFp1c4j12HMZd23G5PLZ6t0nRQvS1
         dNIdWHL94B6lAEg8zgHC8S+f9q0NxYcNpbjlFQqSMYhWf8jHQdQEHsmMtXIrlLbEeVE4
         VLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Oi60uoXzvamvc3/SFoRIFUoo3eDrzVvDd6TkmxROEc=;
        b=nYtxjYpNj2tmWuy/hBgwc/WTJk974ml2lMAtHwbO0IjnIfT9HYx6j+W0TYhSR8xzrW
         QlTezI5ucxBoESFbJeZ0YmaU0sZrizpynVRXtf4WhnFemFwGNNqxC3pJfZRXlo7GosOH
         tRbeRlNXvU5iIDQAvtgF7haPNLdIu6puxMXYOwqOvprWTbDyafCi1wLWzCj50IsC6Ps7
         w++n90R0WvrmeyihsOeJpD9tmPpdZeZZwt1NEJFwjq+dYhaMGgptHgcYlpvwcaAsNz1u
         jqJb099ozNBDflxPMv3ja6GPyGg58dlcvelCney57YWOpRiP7m6A2cEGXiv6suiq5kq2
         DRpg==
X-Gm-Message-State: AJIora8iu/QPeGKZUIfIC/MDZbCRZM0YmAUIKEfLRrGckt+HtLwcH37r
        HgZzZYxcfOH24ydK5aXviIMyzUdTA7sZNGCKXz+pIw==
X-Google-Smtp-Source: AGRyM1sbMd0h5mqMlOe3r5zsM/tg9DtuIaGzYY2PpvqrczlMjK3CvvTTNq4tPC2fb+KpnIF626wm3H/eHrl36HdX56k=
X-Received: by 2002:a05:651c:2104:b0:25b:f4ed:db93 with SMTP id
 a4-20020a05651c210400b0025bf4eddb93mr3316572ljq.295.1657322848370; Fri, 08
 Jul 2022 16:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220707181532.762452-1-justinstitt@google.com>
In-Reply-To: <20220707181532.762452-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jul 2022 16:27:16 -0700
Message-ID: <CAKwvOd=YiLPPyXq3Xvwh8+hMfSL1Ak_HE14No5YncbMMyM60Rg@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: esp4: fix clang -Wformat warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>
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

On Thu, Jul 7, 2022 at 11:15 AM Justin Stitt <justinstitt@google.com> wrote:
>
> This is the exact same issue (and fix) as:
> https://lore.kernel.org/all/20220707173040.704116-1-justinstitt@google.com/
>
> This really should have been a 2-patch series but I've been going
> through warnings and systematically fixing them whilst submitting
> patches as I go.

In that case, since Joe had feedback on that patch, perhaps you can
fold this into that patch, and apply Joe's suggestions (sending a v2)?
-- 
Thanks,
~Nick Desaulniers
