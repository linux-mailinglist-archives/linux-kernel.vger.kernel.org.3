Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846ED524D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354019AbiELM4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353929AbiELM4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:56:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6541F35879
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:56:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ks9so10089740ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXHro7gaVox36cw8ah1MoV8XyWWmQfflVfvPFhuSgaM=;
        b=hRqPT0w0yk+irBkMpmTmRY2R+xa+1V1oE/6It/lGqYpHcAAN9m0rtkdEsDvASqaNap
         DldzbKNJtnTA/+5dCXAMafa+E1JIWfUaA38BYcdHvxaGHunn/hkd7KU3M7OQJSOc3KTy
         EmtuDE9rd9c44GzGxu4/TpbTEgVcx/xdpcy1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXHro7gaVox36cw8ah1MoV8XyWWmQfflVfvPFhuSgaM=;
        b=VPzb7tGxe/fZkDuTTtMdVm8AWciyyF84grRBICzl/Jxd7ZpB9mevJiPvR1y3kw6lHj
         K8UWVwmuuOW/8Svr4VFDO80li/gNRGj2WksEtYdrqPddd7rgT8ZtIxz6vjqJh45oHbgY
         HcibQU5NS0WVbJ9vLDwZqTBDby7K4n8cwmLOJ2gacoq8lHQA4P4tcfQ1Vm+PYxREcx74
         ILE4duy+oSv02+nj+zv3Glq6NfLPND7QaPdaMicoaWE5s8tazLO5JVOtvta8bFaTm7z4
         rTxji977bK7QQMgSguNQgvp9j4/2orqEwF4peZ8HmqM2xkQsG5WRfiMBvZa0HFYlBXwD
         Jryw==
X-Gm-Message-State: AOAM532lstabQ4BrSJ1rL+ytzenGsxBwQ9anhAqJFNVURducEaisH3ES
        wv8np/hjxZeGzDqQLVf+rOhbGQChZWtKL25UuFs30Q==
X-Google-Smtp-Source: ABdhPJx7geV76GIOYt/2kTtpghbvL+mzsm/wfL9QxWJj0/wVNkf8pqRGsysQ22naoY2pTjrzds6fhviOskv51nOl9fo=
X-Received: by 2002:a17:906:9749:b0:6f5:6cd:5bd9 with SMTP id
 o9-20020a170906974900b006f506cd5bd9mr30477652ejy.523.1652360194010; Thu, 12
 May 2022 05:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
 <03l0hfZIzD9KwSxSntGcmfFhvbIKiK45poGUhXtR7Qi0Av0-ZnqnSBPAP09GGpSrKGZWZNCTvme_Gpiuz0Bcg6ewDIXSH24SBx_tvfyZSWU=@emersion.fr>
In-Reply-To: <03l0hfZIzD9KwSxSntGcmfFhvbIKiK45poGUhXtR7Qi0Av0-ZnqnSBPAP09GGpSrKGZWZNCTvme_Gpiuz0Bcg6ewDIXSH24SBx_tvfyZSWU=@emersion.fr>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 May 2022 14:56:22 +0200
Message-ID: <CAJfpegs4GVirNVtf4OqunzNwbXQywZVkxpGPtpN=ZonHU2SpiA@mail.gmail.com>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
To:     Simon Ser <contact@emersion.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 at 14:41, Simon Ser <contact@emersion.fr> wrote:
>
> On Thursday, May 12th, 2022 at 12:37, Simon Ser <contact@emersion.fr> wrote:
>
> > what would be a good way to share a FD to another
> > process without allowing it to write to the underlying file?
>
> (I'm reminded that memfd + seals exist for this purpose. Still, I'd be
> interested to know whether that O_RDONLY/O_RDWR behavior is intended,
> because it's pretty surprising. The motivation for using O_RDONLY over
> memfd seals is that it isn't Linux-specific.)

Yes, this is intended.   The /proc/$PID/fd/$FD file represents the
inode pointed to by $FD.   So the open flags for $FD are irrelevant
when operating on the proc fd file.

Thanks,
Miklos
