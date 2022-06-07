Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C225854010F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbiFGOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243250AbiFGOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCAEC9647
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC45B6159B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227D2C3411F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654611580;
        bh=bZH5ZJ9O1c7o1nV9kSV3tucwjRFSCJw00v3ezDwnbzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XU5nW0SyzlvDkuAVv8Wiu9E1WLOZNa1lw7ueiqGSwShirAA+zJ1ZKJrKmKhCDk/8q
         kn+XIgF6vscW2cvJhsjvLvP88mrncK4AHo/nVjpoqQoDzld+Ax1z0Vj9nLhErR1Cko
         8f/HD7LDw//CbaAMT6iHq0VCV8utAGGP+epdXUI+SXcP5ubeOeF22bH6TKIB1NIbUw
         K0iz4enSVPcS1tVINyrgBIKWmVxDKFkMRjhNaKavYWRGL9qTlkTf0GCtWiZ1jP/lhm
         E/0rYEJW8eE2mqXL6xb6OXLhtd7LKWJwn0RX6t/wayBwGt46uz+llI/+jdQEZgQQvS
         B9wNAvlpP0AIw==
Received: by mail-oi1-f173.google.com with SMTP id h188so24085731oia.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:19:40 -0700 (PDT)
X-Gm-Message-State: AOAM530MD7Zr/N/vZiRXutGAGWXEH+xkGJonZopL2i3PnEVocAs0qL2O
        Yz/r313QGmcEyHDCnz2kMVup7N3ue1o8eFVEeEM=
X-Google-Smtp-Source: ABdhPJyYaXvFgC97bzAqyyOMltUXFoLViBia0C/LoRZDxvmeZiMnVLNRPbi2Ve83OKRf9mheo5SffYWn9vrNaXY83Z0=
X-Received: by 2002:a05:6808:f88:b0:32b:d10f:cc6b with SMTP id
 o8-20020a0568080f8800b0032bd10fcc6bmr32301096oiw.228.1654611579236; Tue, 07
 Jun 2022 07:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220607111514.755009-1-Jason@zx2c4.com> <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
 <Yp8+6Y+bEcmR1LS0@zx2c4.com> <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
 <Yp9C4xY0+CguTd7l@zx2c4.com>
In-Reply-To: <Yp9C4xY0+CguTd7l@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 16:19:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH4ifsytLNpaVTHAumadMjj8rNEZbsn-8t=hH51ucG11A@mail.gmail.com>
Message-ID: <CAMj1kXH4ifsytLNpaVTHAumadMjj8rNEZbsn-8t=hH51ucG11A@mail.gmail.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to random_init()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 14:22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Tue, Jun 07, 2022 at 02:15:27PM +0200, Ard Biesheuvel wrote:
> > Note that jump labels use asm() blocks, which are opaque to the
> > compiler, and so it is not guaranteed that codegen will be better than
>
> I actually spent a lot of time looking at the codegen on a few
> platforms.
>

I did a quick experiment on ThunderX2 with the following program

#include <stdio.h>
#include <stdlib.h>
#include <sys/random.h>

static unsigned char buf[16];

int main(void)
{
  for (int i = 0; i < 1000000; i++) {
    if (getrandom(buf, sizeof(buf),
        GRND_RANDOM | GRND_NONBLOCK) < sizeof(buf)) {
          fprintf(stderr, "getrandom() error!\n");
          exit(-1);
    }
  }
  return 0;
}

both with and without your revert patch of f5bda35fba615ac applied
onto v5.19-rc1, the results are below (Cortex-A57 @ 2 GHz):

############## WITH STATIC BRANCH

ard@dogfood:~$ perf_5.10 stat ./rnd

 Performance counter stats for './rnd':

            906.01 msec task-clock                #    0.999 CPUs utilized
                 2      context-switches          #    0.002 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                40      page-faults               #    0.044 K/sec
     1,812,010,034      cycles                    #    2.000 GHz
     1,944,549,733      instructions              #    1.07  insn per cycle
   <not supported>      branches
         2,014,408      branch-misses

       0.906695576 seconds time elapsed

       0.140334000 seconds user
       0.765871000 seconds sys


ard@dogfood:~$ perf_5.10 stat ./rnd

 Performance counter stats for './rnd':

            918.37 msec task-clock                #    0.999 CPUs utilized
                 2      context-switches          #    0.002 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                37      page-faults               #    0.040 K/sec
     1,836,733,451      cycles                    #    2.000 GHz
     1,944,572,442      instructions              #    1.06  insn per cycle
   <not supported>      branches
         3,012,020      branch-misses

       0.919027080 seconds time elapsed

       0.159721000 seconds user
       0.758718000 seconds sys


ard@dogfood:~$ perf_5.10 stat ./rnd

 Performance counter stats for './rnd':

            902.06 msec task-clock                #    0.999 CPUs utilized
                 1      context-switches          #    0.001 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                39      page-faults               #    0.043 K/sec
     1,804,103,600      cycles                    #    2.000 GHz
     1,944,563,889      instructions              #    1.08  insn per cycle
   <not supported>      branches
         1,956,027      branch-misses

       0.902793520 seconds time elapsed

       0.172464000 seconds user
       0.729822000 seconds sys

############## WITHOUT STATIC BRANCH

ard@dogfood:~$ perf_5.10 stat ./rnd

 Performance counter stats for './rnd':

            924.79 msec task-clock                #    0.999 CPUs utilized
                 2      context-switches          #    0.002 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                39      page-faults               #    0.042 K/sec
     1,849,568,681      cycles                    #    2.000 GHz
     1,950,584,115      instructions              #    1.05  insn per cycle
   <not supported>      branches
         4,012,227      branch-misses

       0.925500832 seconds time elapsed

       0.204227000 seconds user
       0.720739000 seconds sys


ard@dogfood:~$ perf_5.10 stat ./rnd

 Performance counter stats for './rnd':

            933.06 msec task-clock                #    0.999 CPUs utilized
                 2      context-switches          #    0.002 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                39      page-faults               #    0.042 K/sec
     1,866,097,571      cycles                    #    2.000 GHz
     1,950,574,944      instructions              #    1.05  insn per cycle
   <not supported>      branches
         3,984,008      branch-misses

       0.933798032 seconds time elapsed

       0.323067000 seconds user
       0.610271000 seconds sys


ard@dogfood:~$ perf_5.10 stat ./rnd

 Performance counter stats for './rnd':

            913.16 msec task-clock                #    0.999 CPUs utilized
                 1      context-switches          #    0.001 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                37      page-faults               #    0.041 K/sec
     1,826,308,530      cycles                    #    2.000 GHz
     1,950,559,902      instructions              #    1.07  insn per cycle
   <not supported>      branches
         2,231,050      branch-misses

       0.913874672 seconds time elapsed

       0.164228000 seconds user
       0.749157000 seconds sys

So that's a 0.3% reduction (in terms of actual instructions executed)
in a synthetic benchmark that does nothing but call getrandom() in a
tight loop.

In other words, I think the static branch solves a problem that does not exist.

> > > > - Why do we need to enable this static key so early?
> > >
> > > We don't need to enable it especially early. I've now sent three
> > > different approaches for deferring it until later and you suggested one.
> > > The first of mine is kind of ugly (checking static_key_initialized and
> > > such at different points).  Your suggested one after that did the same
> > > but deferred into crng_reseed(), which I'm not a fan of. My second one
> > > is this patch, which is flawed for the reason you pointed out. But
> > > perhaps my third one is the right amount of simple and okay? That's the
> > > one I linked up top, [1]. Let me know what you think of that.
> > >
> > > My motivation for not wanting to defer it is that if the arch solution
> > > winds up being easy and straight forward (as it was for arm64), then it
> > > would be nice to not need to clutter up random.c as a result.
> >
> > If clutter is a concern, how about getting rid of the
> > execute_in_process_context() dance, and just use a late_initcall()
> > instead?
>
> As I already explained in [1], this does not work. If the order is
> (A)(B), then all this will happen *after* the late init call.
>
> [1] https://lore.kernel.org/lkml/Yp8oOH+9V336LrLk@zx2c4.com/
>

Yeah, I guess finding the right spot is tricky. The more reason just
to drop it altogether.
