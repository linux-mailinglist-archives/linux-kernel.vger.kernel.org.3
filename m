Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50558B2C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbiHEXc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiHEXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:32:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC741A81B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:32:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f22so5100167edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oX5dixeC5cISzlmeE16lJbqJDGD4u5Eew52IH1AkIug=;
        b=OGweQEBV6PwoBvKXWW7hNFk0oy34DwHtq9zVl/wNvm42Kggg7c0oJ/FBOOo1oQaG3b
         vBKqmHIuluGFEQKNy3P/KT7LWjqca78MHWczUx6TQysIZkKyAE927djCJSimDev2kNRi
         Bq1V6hnmwcqPo/6RS8mi1/QjimKryQFOdsZ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oX5dixeC5cISzlmeE16lJbqJDGD4u5Eew52IH1AkIug=;
        b=Z2EZtea6/udIBZrP7fn+dGX1YNaPVDXX4sKJhwFSODZNAyE/CG90nPVVipKB95o+1G
         JEpSzJASxHEQ19SL54ihIR+ll6Jk3ebCOBdhtgIomRxbzwPUKcjpPGl013TLRkguZSRe
         d8q9JuEM7OP05RqJUoWgQB1SYmHuOcDa5YU1GDNCimrAErmdeAz5xUnhFHUBY8leVvpC
         78XEtAF4b7/WpgKBciHiYi2V281rN5TwiAYv4rAdxcQfpsPGLHDUrVY9FZXHXzILRGuC
         1a+dI83kJAravV1QvheAQe1+Jz1+3GvK58KS0VVsmUOh5Fl+6AoyRzdte5OHolz+7b0+
         Ogpg==
X-Gm-Message-State: ACgBeo0/7UJFG83fXb+TrmtmD1jMRrIfbnNO9RhBS9P/gHN/q4c7VJ2J
        VLnhxw7whDF5m4qTTNEIJPnxkYC31FtGFzoV
X-Google-Smtp-Source: AA6agR6Wro8RahJEYSOnHtxZGs/FW2K3HbvupuWMyC+6YxjqMol6m4fR4T5wgRrM6XsAcqIRp4XeGA==
X-Received: by 2002:a05:6402:611:b0:43c:cb2d:76c0 with SMTP id n17-20020a056402061100b0043ccb2d76c0mr8610693edv.425.1659742371730;
        Fri, 05 Aug 2022 16:32:51 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id s4-20020aa7d784000000b0043d2b9b24dfsm606434edq.18.2022.08.05.16.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 16:32:51 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id l4so4721391wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 16:32:50 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr5558868wru.193.1659742370294; Fri, 05
 Aug 2022 16:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
In-Reply-To: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Aug 2022 16:32:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOSXvk=70tpR9E1tvDmCf8s-81bT+92aE-iKocxdTsyw@mail.gmail.com>
Message-ID: <CAHk-=wiOSXvk=70tpR9E1tvDmCf8s-81bT+92aE-iKocxdTsyw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 1:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> - memcg debug/visibility work from Roman Gushchin

Well, not just memcg.

There's that new CONFIG_SHRINKER_DEBUG too.

Which looks like yet another "people add Kconfig options incorrectly".

We don't make new features "default y" unless there's some truly
pressing reason for it (ie "99.9% of all people will want this" or "we
used to always compile this in, now it's optional").

And shouldn't that thing be under the DEBUG_VM heading anyway?

I removed the completely bogus and inappropriate "default y".

People, please stop doing that 'default y' thing.

I realize that everybody always thinks their own code is *sooo*
important that it should be enabled everywhere, but if we've gone 30
years without it in the past, maybe it's not so critical after all,
and maybe people shouldn't randomly enable it unless they WANT it. Ok?

The main reasons for 'default y' tend to be literally

 - this used to be unconditional, now we have a config variable for
it, so let's make it 'default y' so that people don't suddenly lose
functionality

 - this feature truly does cure cancer

 - this isn't actually a feature, but is a gating question to other
features that you may want to just shut up

That last case is mainly used by the network driver subsystem, where
it asks 'Do you want to see drivers by vendor Xyzzy?', and it defaults
to indeed show those options. But admittedly that network driver case
is also _partly_ guided by that first case, ie it has often been
something where a group of drivers were moved to be under a "do you
care about this vendor" situation.

                     Linus
