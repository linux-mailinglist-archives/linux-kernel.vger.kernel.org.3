Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FDF50BBA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449419AbiDVP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449404AbiDVP1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:27:04 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D256215
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:24:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r17so5245194iln.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wxv1VHcdMAWKawTEifnINmazC29umb2i5gHiDAZVeBk=;
        b=335nWJbBDhabHr89gG5tFiLbFOQLvASDcW1EglELgq0uhxBp97C2KaIqEwRKVbYsmx
         GpS+ja0gF1YRQsUZmFTz2Nl2pDXP+Xg6v+vWDRNYMU8cLM1cbEfDWjFhC1kiLwXMHCqc
         eUNTTMg/IucTx/f6rGjggjmKpM7YImY+ja+IfNi+FzeDGPOhrYxJqIu19gGYohfQaFGV
         0SRajNzdFfpfR5CbaoKsMJp5T0wjU80hAdAdMAGsWbQc6pgeR7DyeISxjBih7RRxtKeA
         yyb7xs1AH/m8scE0u5RTvPAz4HOf8cex/5nDUlehQfn/pXUbFnP8ggIcugUC7gLXuD4C
         AWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxv1VHcdMAWKawTEifnINmazC29umb2i5gHiDAZVeBk=;
        b=CjP2FfkUVWOxKlzWLRdydqMf5RNtJf/ICmK04z3iJEk0ivO7ELxcam7Wnimf8BrQ4r
         Ws8c5C/HuMTEcEiOcswgSf/NiEmxnwN1elZuEIcujl+INQ2MabFUFxkuwZqIqQP5t3ME
         OZAhPcBn32I8UfDQwWHzZwaBfUzkQnkOgK7EM6CmSfZzcp5eVxbQ3F2ptEXH0kJx7ZYC
         kyJgQ0KXJaLtjLD8F3RHR+KuiV1nW4xRUIXWG7oONgvHLrTor3DpHcs2ZHFQqO/DENWz
         KHZxNmEsv46b1bvxr43wjDh3vQy6e3jtzrGw+MyB81hl/TJMpbhhC1M/Sd+fJxnERdc1
         GUTA==
X-Gm-Message-State: AOAM532aTjgwhZ4VjDzxPBCpxzNuZZKQKFaRBGARH9gDLZYGJnYiJHve
        gGPdmpQDo/PdlRvk8tvOCAeADFLjqWbNiEdiw/Otpg==
X-Google-Smtp-Source: ABdhPJynI2j2o9aSn9G09xaJSPgHCkDd+G+caW0XT60z6/oGe+SAEg8uILSJZITvWsJcMG2BcnPuKkJSdTWGHxW7IyE=
X-Received: by 2002:a92:d2ca:0:b0:2ca:ca3a:de89 with SMTP id
 w10-20020a92d2ca000000b002caca3ade89mr2225426ilg.127.1650641049737; Fri, 22
 Apr 2022 08:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
In-Reply-To: <20220422054224.19527-1-matthew.ruffell@canonical.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 22 Apr 2022 11:23:58 -0400
Message-ID: <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     Matthew Ruffell <matthew.ruffell@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 1:42 AM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> Dear maintainers of the nbd subsystem,
>
> A user has come across an issue which causes the nbd module to hang after a
> disconnect where a write has been made to a qemu qcow image file, with qemu-nbd
> being the server.
>

Ok there's two problems here, but I want to make sure I have the right
fix for the hang first.  Can you apply this patch

https://paste.centos.org/view/b1a2d01a

and make sure the hang goes away?  Once that part is fixed I'll fix
the IO errors, this is just us racing with systemd while we teardown
the device and then we're triggering a partition read while the device
is going down and it's complaining loudly.  Before we would
set_capacity to 0 whenever we disconnected, but that causes problems
with file systems that may still have the device open.  However now we
only do this if the server does the CLEAR_SOCK ioctl, which clearly
can race with systemd poking the device, so I need to make it
set_capacity(0) when the last opener closes the device to prevent this
style of race.

Let me know if that patch fixes the hang, and then I'll work up
something for the capacity problem.  Thanks,

Josef
