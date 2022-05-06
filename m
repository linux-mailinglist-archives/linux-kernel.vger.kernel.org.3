Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75C51DDDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443921AbiEFQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443923AbiEFQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:53:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A496D851
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:50:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ks9so9122186ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yplf98ia4dOhlCOAe+KKhCE6naxsVz+d+kEBiiSDb2o=;
        b=bKMsEZkyKCQY7Fxfb0+ouGSxND7jafXV0dLZYhl+HLtJKACIZ5cQbaDz0frgAy1W10
         nC5jAznFwMgcchc3gQrHcWTvbpyXwFmtCo/n0RF87Vhl5WbR8564JDrYNq2PiAtXBLhg
         DrMsq7DLAFtq1VXC4o3RCco6faxQxHGb8fxeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yplf98ia4dOhlCOAe+KKhCE6naxsVz+d+kEBiiSDb2o=;
        b=C5PF/CRU3jP9HJtWm93G/JfNmK1cs9gsI1NrTmWZZBi/r+HcwKQpZARztdnr+ZwXEk
         Lr5JGjti9RVgt4NeB5Mg6l8eF/P/92uT4haJUzHILFSWvpf2vWQXVCOXU+YFGa2XzFXa
         yOKJEvU2rG3TBf2EMOBaergx2R7C/O6CFW8gFe7vAVnnwLckbJLzf516GGDH8kg57gKD
         JcnVdq0AZbEBYAGN2N5qeykzjoDWSW0uc3mSZipN7vSeX7bTRTG8CoVmrPqXPBGMnqFI
         A2Z7Q3ilVh3aCXAxtrFBXtdlCE8Y3Br0398W2cVSBIgxYhFt2oSFcnDS3zRTS6B6eVDq
         ywAA==
X-Gm-Message-State: AOAM531/QU/Ere9IYxM1bye7EhI30PglTtRIYj/34xzxrpOZ3lZlhd/1
        BUkpYDzNEnmKOQFfkHlY5eJ+p3OTFgMBmJF3IKw=
X-Google-Smtp-Source: ABdhPJwAz8xofWTxhLv2d0VgYdn3/PlC3kWxaMxDYZZS5GOMaXv+VS0nMPBBjotpXl099oZMxP5nbg==
X-Received: by 2002:a17:907:7f1c:b0:6eb:c702:7f4e with SMTP id qf28-20020a1709077f1c00b006ebc7027f4emr3750576ejc.496.1651855803244;
        Fri, 06 May 2022 09:50:03 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm2471445edt.73.2022.05.06.09.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:50:02 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id j15so10805185wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:50:02 -0700 (PDT)
X-Received: by 2002:adf:ec08:0:b0:20a:d39d:6ab6 with SMTP id
 x8-20020adfec08000000b0020ad39d6ab6mr3430614wrn.442.1651855802195; Fri, 06
 May 2022 09:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyaQ8RSYwuh4muEefV3fbjio5gVvYipWVaKjqUycRkS+A@mail.gmail.com>
In-Reply-To: <CAPM=9tyaQ8RSYwuh4muEefV3fbjio5gVvYipWVaKjqUycRkS+A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 May 2022 09:49:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtEptPBvJtdbezMLJh6k3O7Y-on=tbC31z4e+ksLda1w@mail.gmail.com>
Message-ID: <CAHk-=wjtEptPBvJtdbezMLJh6k3O7Y-on=tbC31z4e+ksLda1w@mail.gmail.com>
Subject: drm pull request (was Re: )
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 9:07 PM Dave Airlie <airlied@gmail.com> wrote:
>
> pretty quiet week, one fbdev, msm, kconfig, and 2 amdgpu fixes, about
> what I'd expect for rc6.

You're not getting the automated pr-tracker-bot response, because your
subject line was missing...

Just a "how did that happen" together with a "here's the manual
response instead".

                  Linus
