Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BF848EB0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbiANNqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiANNqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:46:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4247EC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:46:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t24so35108812edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWRH+rvwHqP1z4qchF8L9hZG2NGx1v2K+/SKPTErMzY=;
        b=YgoipMgKyro6jhYaoBISHi6o0+jzJtH4pf7nE3n8Il8c9EeiBNt04Y0WBlh3M+Lo1B
         DitUOHbXTcE8ForIPXgyFrU3bYuRCXzvRPEfCnoBL0exnKMjLqKN8+XdplsJ8ivFf2W4
         m0gOXN1tK9WVG8zjW79Cn57gnc105aPJuGABE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWRH+rvwHqP1z4qchF8L9hZG2NGx1v2K+/SKPTErMzY=;
        b=mlUbMOV4LdGuD0AsMjk+sT0iBCNjGVe3/Juhm5HigaRf2D+wzwXztO6JhHJUmXnzVV
         3Zsg5fdIz7MKFrwGKKUQpjRmJ01vHTTsR+K8B7ihqYQPbyNVSME4prR0oM+Pti7Kw8vy
         qdwC5mykstRPMI8klvoX7X/sXbtme+RKcjnOpKyoJmM0fYgOypicyDkYycmDr1n5egpv
         SIsoYqCQfBto4RWkux69SnkP5gjmOjBCjV0YyDxVDzfllCkbUnyqEF0AJswroROvBYp7
         xtSMMPRkjb7tjgwbypUNBdzxmtZtpE7VxaGK11/9Hu3ITlho9rI0abmr5nhTvqXcZLu3
         wgEg==
X-Gm-Message-State: AOAM533+JhkdSqYWx8SUjLkTf4m3dDBVhd+NLIYrtw2gicRMxBxSo0O4
        /qIGudalxPLZs5311z0nUU/ILPmQmyVOLtWm
X-Google-Smtp-Source: ABdhPJzBwUX8zmIUoxn7JxwnWF7yT4Cjr/ldQKwhyVT9P6+4J4z1PgeB8h0YBGzUzHlMnrV3I46CFw==
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr8848197edd.64.1642167978653;
        Fri, 14 Jan 2022 05:46:18 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id 13sm1858091ejh.225.2022.01.14.05.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 05:46:18 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id s1so15704634wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:46:17 -0800 (PST)
X-Received: by 2002:a5d:4575:: with SMTP id a21mr8140206wrc.281.1642167977708;
 Fri, 14 Jan 2022 05:46:17 -0800 (PST)
MIME-Version: 1.0
References: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
In-Reply-To: <31f8716fbb4f1e2a332b2b3e3243a170e8b01145.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jan 2022 14:46:01 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjx_q9Aa=o5kiiSpCC_4U+H2D1=H3umFOwVMUbFmdQjGA@mail.gmail.com>
Message-ID: <CAHk-=wjx_q9Aa=o5kiiSpCC_4U+H2D1=H3umFOwVMUbFmdQjGA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.15+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:22 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Adrian Hunter (4):
>       scsi: ufs: ufs-pci: Add support for Intel ADL
>       scsi: ufs: Let devices remain runtime suspended during system suspend
>       scsi: ufs: core: Fix another task management completion race
>       scsi: ufs: core: Fix task management completion timeout race
[...]

You seem to have forgotten to fetch my upstream tree, so your shortlog
(or diffstat) doesn't seem to take the various fixes pulls you did for
5.16 into account.

The only actual new commit I got from Adrian was

Adrian Hunter (1):
      scsi: ufs: Let devices remain runtime suspended during system suspend

and the same for other fixes..

Not a big deal, but when the shortlog and diffstat don't match what I
get, I waste time figuring out why. So please do a "git fetch linus"
or whatever so that git can take all your previous pulls into
account..

                Linus
