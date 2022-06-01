Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5811553B049
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiFAU6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiFAU6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:58:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9565C21A569
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:58:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q1so6158732ejz.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oRhRRXkS4gcQY3huiGBgzO1+1XDsVvPhPhivTE45IY=;
        b=LHqRAl3FERSqJvk9zPmSajjXej4l4jl2TW9I10C88w4KuygJWujPAfRvILHZ47nKyu
         BjOeeHCsp14sFGSYpt7YTrpH87BsFokU8MaDhXvFbMFNA3dVM3zM747cl5wlm48NPlVG
         uOzpSlMGCWdFl5Ctv2NCvWcZno1WdbKJ6zVAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oRhRRXkS4gcQY3huiGBgzO1+1XDsVvPhPhivTE45IY=;
        b=8NZIy8sK/Qi7U7JaSDdwABkpHcpk9tMGQ07j28JgHXBzImLzaIxOWambWL02XbgsaS
         4G0j+nW3T3vaWcKSJp7SMTTGaeN5qakTaeNOc3948TXiiT5h5esVdNVDvXSNjbc3Wabe
         i9BOm0peTFrKmWr4TL4BxkdeDYjZDhYRy5aiYrvorQCQ5I7q1+O5qR17+zH/aLkZRtKC
         jvPnNpDBU9uh3ipFRNcuIVRhDhJu1cTgoU06ZQECdqDrE8VauRysSUbdYt+S92PHi6BW
         kGDR5WsX0NshCbicPZnd93A1MMu7Er9cLKvsUlV1ucCXl5f5THXtG4iB45H9/rTESPMl
         zG3w==
X-Gm-Message-State: AOAM53119yBvXREu6doRWdSHelxKQOWTilBdR3AYtqA3Lgxvm3smbZoW
        k4OnygxofnnjLpT/MT93EpzCmvj6/m6KGHi5
X-Google-Smtp-Source: ABdhPJxtIr9OQhsk3cIxXYdLq+B7cSFaQc9Ampxnqu2AiaIhfFaY3HIZmJdXC4KTlCZgarHrQz4hEQ==
X-Received: by 2002:a17:907:7d8a:b0:6fe:dccb:cf4c with SMTP id oz10-20020a1709077d8a00b006fedccbcf4cmr1330663ejc.714.1654117089235;
        Wed, 01 Jun 2022 13:58:09 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906259000b006f3ef214daesm1083306ejb.20.2022.06.01.13.58.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 13:58:08 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id q21so3940498wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:58:08 -0700 (PDT)
X-Received: by 2002:a05:6000:1605:b0:210:307a:a94a with SMTP id
 u5-20020a056000160500b00210307aa94amr977501wrb.97.1654117088304; Wed, 01 Jun
 2022 13:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220601111128.7bf85da0.alex.williamson@redhat.com>
In-Reply-To: <20220601111128.7bf85da0.alex.williamson@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 13:57:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9QJsTw-Ob5z8-ioaHqzOXQd3qqUfOd3Meyq-eXM5kMg@mail.gmail.com>
Message-ID: <CAHk-=wi9QJsTw-Ob5z8-ioaHqzOXQd3qqUfOd3Meyq-eXM5kMg@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v5.19-rc1
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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

On Wed, Jun 1, 2022 at 10:11 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> I'm not sure where git pull-request is getting the diffstat below, the
> diff of the actual merge of this against mainline looks far less scary.
> If I've botched something, please let me know.

It's all normal, and due to you having merges in your tree and
multiple merge bases.

See

    Documentation/maintainer/messy-diffstat.rst

for details (yay, Jonathan scrounged together docs so that I don't end
up having to write a long email explanation any more, and there are
links to some of my previous explanations on lore).

That also has a suggested remedy, ie just do a temporary merge and use
the diffstat from that one instead.

But I can also re-create that messy diffstat (and thus verify that
what you sent me matches what I got) here locally too.

So while the diffstat is messy and not very useful for a "this is what
changed" angle (because it has a lot of other changes mixed in), even
that messy diffstat is actually useful for my secondary reason, namely
as a verification that yes, I got what you were trying to send and
just didn't document very clearly because of those multiple merge
bases.

I can (and do) also check the shortlog, since the actual log doesn't
have any issues with merges, it's only "diff" that needs a single
well-defined <start,end> tuple.

                 Linus
