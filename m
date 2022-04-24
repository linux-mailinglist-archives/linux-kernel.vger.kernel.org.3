Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7050D0EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbiDXJzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiDXJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:55:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD7E2B249
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:52:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7ca2ce255so23420237b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rmy4idXC2eBClz5DkYm2e4LN35DXVZgPlYi+CftqWGY=;
        b=k+ussjTHyFwnFiBi0uQ5MNWwyonlF9MfOA+TgD8JtWtiYa+puwMoCziDRVoilv6/uh
         QtzmKbTLulTLjntahQa7/oGzgGY1UmpJebhAZHFZFiDWBHdnr/yCSIQRaHfGTYC4+bfu
         aiKvvQrIPFdDMPZG5Lv4IZrSy2XO2hcJU8zAicsoqSwml43WbfcyCd/L84kpT6mnJDOv
         303tJOFDq3WWFH/e42/JiJuApIhcvTU03zC+Fp4lEv/IFjNmrgljuB5Yc3eUFZNiEWwm
         Yqqpl7m4oGft7CVIYtLh68nwMqUxxp2umWmDCBv2ZEHHplRwijju5HVaWSi3lDl9ouvu
         PQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rmy4idXC2eBClz5DkYm2e4LN35DXVZgPlYi+CftqWGY=;
        b=GPNOyon3QqFOZOYTxpITRRc3Nn3I1Op7I8Fndz78ejofxKsMWv4DezxWzOeT7kZ09e
         fdgW2M59n7HGZt5XNrroGqG2PEfj753d2PoGVeYECYRhFFmGtXeZCog8gYtuoVME/GNj
         GfFdH97BMJc5cMQmFKpnhVE6gUU49MrkIzyAw7G3mlk/FpUdte8u5gGE4As1BymWPSFd
         mbfC6z8ewoEDgJ+gS/s563Q2mIAHwOZAOFnEZTwLGs3+UuWIT4VoAdxbCLDdU4lIJiz/
         BsTPZ47jXK1H6oANHpCZF0vX5G7OgsUEyRPu4k2dkh+WhtTOx6R1MwNzjdRgWiXoBqKL
         ZyvA==
X-Gm-Message-State: AOAM5320LVNmdW9xi0rfaF7wv5W0DmS5kHx320Sko9b1gPIQewGlZQvm
        IhA852abRH+Ns4dGS5Z17qDXYcX8KADFl/cPQ0zMJQ==
X-Google-Smtp-Source: ABdhPJx1KTvUMODnyShVCUuKLp0JbEVKjGIWa3nLOZSYLWnRBLzlPlkMAnY4lx4bL3jRJb1yvOLnKtmgVlkjZAgKEFU=
X-Received: by 2002:a81:1087:0:b0:2f7:da07:6d89 with SMTP id
 129-20020a811087000000b002f7da076d89mr1567199ywq.412.1650793930117; Sun, 24
 Apr 2022 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNM0qeKraYviOXFO4znVE3hUdG8-0VbFbzXzWH8twtQM9w@mail.gmail.com>
 <20220424081049.57928-1-huangshaobo6@huawei.com>
In-Reply-To: <20220424081049.57928-1-huangshaobo6@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 24 Apr 2022 11:51:34 +0200
Message-ID: <CANpmjNOOE8z_YYbJXsv=hxBhvCHyWhYapA8VKgnk2bHAtL6=8Q@mail.gmail.com>
Subject: Re: [PATCH] kfence: check kfence canary in panic and reboot
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     akpm@linux-foundation.org, chenzefeng2@huawei.com,
        dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nixiaoming@huawei.com, wangbing6@huawei.com,
        wangfangpeng1@huawei.com, young.liuyang@huawei.com,
        zengweilin@huawei.com, zhongjubin@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 10:10, Shaobo Huang <huangshaobo6@huawei.com> wrote:
>
> On Thu, 21 Apr 2022 15:28:45 +0200, Marco Elver <elver@google.com> wrote:
> > On Thu, 21 Apr 2022 at 15:06, Alexander Potapenko <glider@google.com> wrote:
> > [...]
> > > This report will denote that in a system that could have been running for days a particular skbuff was corrupted by some unknown task at some unknown point in time.
> > > How do we figure out what exactly caused this corruption?
> > >
> > > When we deploy KFENCE at scale, it is rarely possible for the kernel developer to get access to the host that reported the bug and try to reproduce it.
> > > With that in mind, the report (plus the kernel source) must contain all the necessary information to address the bug, otherwise reporting it will result in wasting the developer's time.
> > > Moreover, if we report such bugs too often, our tool loses the credit, which is hard to regain.
> >
> > I second this - in particular we'll want this off in fuzzers etc.,
> > because it'll just generate reports that nobody can use to debug an
> > issue. I do see the value in this in potentially narrowing the cause
> > of a panic, but that information is likely not enough to fully
> > diagnose the root cause of the panic - it might however prompt to
> > re-run with KASAN, or check if memory DIMMs are faulty etc.
> >
> > We can still have this feature, but I suggest to make it
> > off-by-default, and only enable via a boot param. I'd call it
> > 'kfence.check_on_panic'. For your setup, you can then use it to enable
> > where you see fit.
>
> Can I implement your suggestion into the second patch and add the "Suggested-by: Marco Elver <elver@google.com>" tag to it?

I don't think it's necessary, after all the overall patch is still
your idea - you're just using our review feedback to improve it. In
the change-log (after ---) you can of course mention that, but it'll
be stripped upon applying.

Thanks,
-- Marco
