Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92E4E4244
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiCVOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiCVOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:49:38 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B53112ACC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:48:10 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by gnuweeb.org (Postfix) with ESMTPSA id 165C47E34B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647960490;
        bh=nhc/SeLNGo4re2yxQ5GoFnaoYMAKUce8gFXe5zfGqKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P6BxpChDot2nfSG+lx9YbB3VILHuaugqpPNbFL95BMy34lnRQwG4iNbW6VrAGY4Ey
         L/mWHHvhIDuy8yL2rIvcGfwIoUumgpc2paCDCL9bbzV2FQApI+EEC+T2KVo3dwF5kZ
         UCpMGMwkfFIdBfmigZ3qP/xvA1cz10ZDcuHwEe6bxM6tSJVO6gMRew0l5e08w3oTLy
         qvT5ZPQtNpAJkps2BOTDJv2WMJv2w6hxYksB5PKzWfyYGZUGrwfEfji1k2F8vyuK9C
         DWoFhwN2WGFsPh8UY+gT1kpqqwBXv5jQDkAYqbwcBQHGuboL3kwVv7oCTQbL9FPR5W
         Nd8a3isHmV2Jg==
Received: by mail-lf1-f46.google.com with SMTP id w7so30207526lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:48:09 -0700 (PDT)
X-Gm-Message-State: AOAM532Ff/p2PvuezCptGId8T4/Y3J8Y64nftwIEGQv3WsgSdo6L2Slr
        +P/ZJsVuIbevMI935e0D0cJ+7GMqbSbQkuU9wrQ=
X-Google-Smtp-Source: ABdhPJws2O+yg6MTOzRKnrJ03Qv3OmYB19iwU83i646P4wI3U5QwCr8Nh6DmLxi2UmhoItx5UgiRuFRnOThEvm9siNM=
X-Received: by 2002:a05:6512:c06:b0:44a:2a0f:9d3c with SMTP id
 z6-20020a0565120c0600b0044a2a0f9d3cmr7838759lfu.136.1647960488026; Tue, 22
 Mar 2022 07:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-4-ammarfaizi2@gnuweeb.org> <8653f6784a9b4272a59a75a530663567@AcuMS.aculab.com>
 <a8eeec1d-656d-15a3-dde5-0f8cc8c5956b@gnuweeb.org> <20220322121338.GD10306@1wt.eu>
 <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
In-Reply-To: <22fd9709b3a64a548226741b682ca155@AcuMS.aculab.com>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Tue, 22 Mar 2022 21:47:56 +0700
X-Gmail-Original-Message-ID: <CAOG64qP=Hn+Z6zO2pEafE4acLiGig79OCPQCAktb4bhV6DFBAg@mail.gmail.com>
Message-ID: <CAOG64qP=Hn+Z6zO2pEafE4acLiGig79OCPQCAktb4bhV6DFBAg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6 arguments
To:     David Laight <David.Laight@aculab.com>
Cc:     Willy Tarreau <w@1wt.eu>, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 8:37 PM David Laight wrote:
> dunno, 'asm' register variables are rather more horrid and
> should probably only be used (for asm statements) when there aren't
> suitable register constraints.
>
> (I'm sure there is a comment about that in the gcc docs.)

I don't find the comment that says so here:
https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html

The current code looks valid to me, but I would still prefer to use
the explicit register constraints instead of always using "r"(var) if
available. No strong reason in denying that, tho. Still looks good.

-- Viro
