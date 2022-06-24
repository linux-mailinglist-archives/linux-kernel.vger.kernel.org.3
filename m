Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833FD55937B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiFXGcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiFXGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:32:45 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338285DF05
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:32:44 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3176d94c236so15586167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OshtKPyDmR7YV5uvnKbuzQWgcD3M6gJPkQNeuhQ0T4=;
        b=B4OWrDTnmgU/qgSF0bK8sg0O9qDchT1gyXRsgdE2LYSbxuSOLpe04fvvyUDzjqF50h
         oA88JZ6r/jVAZ+i5wc1hLHIlFBrRSIH2kSjOb0AGT/WoloHAphN+x1nNBVYo0I0vL+S2
         WYO9/26Q8t/A0xOXmeHJsZ24ihbWxBkGk1uHVBnxPDtTVMn4uzT0h1JFIr4XWUL30sxk
         B4uCWxDgJJJWS7ExWTgI8JpnrlAu1KGvSrIWdFBB6amwVlIBqmFXRTM1bQFB+IFfRFz6
         mQ6X7AoPZkpaHE4irnmEoqQaecMMuy17hTmVs8zFWt6f0WJ3/Dh0Hhpu+UL0SU51sFwL
         4+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OshtKPyDmR7YV5uvnKbuzQWgcD3M6gJPkQNeuhQ0T4=;
        b=f8YmHwEWBNmEBRyUSjwHPkfmCGyD1FQihYm5i9/eQLru+wyrPbL8dXjUA4iPE25Q8x
         Riy2u6M8rePa+8eDbWKqUtyc8LBks3GIjTLhAG1KV+svMX4b9uDevSZhvTXe5yfPfgDK
         SsaaMe7ZjcpmkkRcC1pTjFWxvCgW2XSeGqAyp+kPOltvgxsVDfAxFZkN09Oo0mIEBRwg
         Yx9IFE6Oou+2N5OVxvPVgqYWpuVyaFQRCNZkCdddbxfGSazKRGsrExShHQxZxhsYl3Iy
         mpXtrt7N7zATZW7fc/BuvGKdxJSm9ro035/Q2pfBkABPKGaOWs2xwhhpnqR0nbQ4R3ST
         dp2A==
X-Gm-Message-State: AJIora87aDFXCHkCbHRzCGCq0hjxwiBJVGmViGEeBDA53+Pfwyf+rT5N
        NTIbQXfE3pPZJFIFKai0qTQmkd+x8Yyb5v3Vc7rfTQ==
X-Google-Smtp-Source: AGRyM1upexU7nH70k2OVAPeGCqZo4Njm4UBNxm5xm4hJV8kd77tC+MlkEjLJsYM/feTLsXCxabBH2QAJc8GcRdfHWmw=
X-Received: by 2002:a81:3a81:0:b0:317:7dcf:81d4 with SMTP id
 h123-20020a813a81000000b003177dcf81d4mr15025328ywa.47.1656052363192; Thu, 23
 Jun 2022 23:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <YrVUujEka5jSXZvt@archdragon> <CANn89iKLpGamedvzZjnhpNUUpPJ7ueiGo62DH0XM+omQvhr9HA@mail.gmail.com>
 <YrVYywPFYiqWJo4a@archdragon>
In-Reply-To: <YrVYywPFYiqWJo4a@archdragon>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 24 Jun 2022 08:32:31 +0200
Message-ID: <CANn89iJOibYQCsY+ekObagmwmPap0FGqYdJacsO1mVvOgkKmdg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cfusbl_device_notify
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 8:25 AM Dae R. Jeong <threeearcat@gmail.com> wrote:
>
> On Fri, Jun 24, 2022 at 08:15:54AM +0200, Eric Dumazet wrote:
> > On Fri, Jun 24, 2022 at 8:08 AM Dae R. Jeong <threeearcat@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > We observed a crash "KASAN: use-after-free Read in cfusbl_device_notify" during fuzzing.
> >
> > This is a known problem.
> >
> > Some drivers do not like NETDEV_UNREGISTER being delivered multiple times.
> >
> > Make sure in your fuzzing to have NET_DEV_REFCNT_TRACKER=y
> >
> > Thanks.
>
> Our config already have CONFIG_NET_DEV_REFCNT_TRACKER=y.

Are you also setting netdev_unregister_timeout_secs to a smaller value ?

netdev_unregister_timeout_secs
------------------------------

Unregister network device timeout in seconds.
This option controls the timeout (in seconds) used to issue a warning while
waiting for a network device refcount to drop to 0 during device
unregistration. A lower value may be useful during bisection to detect
a leaked reference faster. A larger value may be useful to prevent false
warnings on slow/loaded systems.
Default value is 10, minimum 1, maximum 3600.


> Anyway, this UAF report seems not interesting.
>
> Thank you for your quick reply.
>
>
> Best regards,
> Dae R. Jeong.
