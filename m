Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82CB53FE40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiFGMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiFGMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:03:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D176464D02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B792B80DB1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5C6C36AFE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654603422;
        bh=+ViRAfXAe9W+pLFYqjFQr2b/AEjKHxY3Y1+jWdYOufg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pqOU2pPhklQwJz0Z/EoBa0lQrrDHdoki9xPpyrdpmzoXyynoAlHNBw1w4SxSYHh02
         Fqq3wdHGuZzg681gww7k/isQs1kIuREIAB5FcQNlhMpBzn/W6MM4u5v06ArFTB1KFT
         6SXJqu+xgdVr9TlDF6TKOz/mJ7dufoho43HUoSKD7Mdf70bJX90x9namivlvhq21on
         bZNEMJaxfjzvhKysdY75eV1utwAFwCsBDIIe1wR+AZFTmHocdvmPmdnHXkKkXaUA2W
         LVjqL06Y6gOam7w7yl2F1ZdGgQUCGPrZj81+C7m71YbhDS/w1/gwTWgjDLlSXRLgnE
         XXzVraXkrTjGg==
Received: by mail-oi1-f180.google.com with SMTP id q184so6652886oia.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:03:42 -0700 (PDT)
X-Gm-Message-State: AOAM530VGqW5yqDnm25pIrFsz6S2Dd2y9mxSlHkTR8BAXcI8t4jNpwYn
        +DmrtpqqIDobQmtYgoxmLtS2FCvCI0DN6sKHk5s=
X-Google-Smtp-Source: ABdhPJx3SWtWiz0d+VOvxLV/8oPe56jPNbjtsEb8F5xQ5NUQpVY5G9RWit6TW/YCxZgdePdTkKx5Tz5VkjxHHVym7q0=
X-Received: by 2002:a05:6808:f88:b0:32b:d10f:cc6b with SMTP id
 o8-20020a0568080f8800b0032bd10fcc6bmr31929999oiw.228.1654603421508; Tue, 07
 Jun 2022 05:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220607100210.683136-1-Jason@zx2c4.com> <CAMj1kXEAuh-tokcqvKCQF5Vq+jZKj4ZM=PyGaHKapXPJKVyOrg@mail.gmail.com>
 <Yp8oOH+9V336LrLk@zx2c4.com> <Yp8rcFrqK/IkzKXj@zx2c4.com> <CAMj1kXHV833uMJYrdUagJpH5hoj4ivC6zxMJvNnxLAF2NG3_sg@mail.gmail.com>
 <Yp8wz2Ey4J4u+ZlK@zx2c4.com> <CAMj1kXFK9pFUdOABKP0Zp7tEJNVS1dTjxp5DgSwqzM8TEYJLTQ@mail.gmail.com>
 <Yp839NjwW3scZEqi@zx2c4.com>
In-Reply-To: <Yp839NjwW3scZEqi@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 14:03:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF7NToZgAW66puCOwc1+d7ZTmVm_CbDYEeH+j0XJH1vug@mail.gmail.com>
Message-ID: <CAMj1kXF7NToZgAW66puCOwc1+d7ZTmVm_CbDYEeH+j0XJH1vug@mail.gmail.com>
Subject: Re: [PATCH] random: do not use jump labels before they are initialized
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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

On Tue, 7 Jun 2022 at 13:35, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Tue, Jun 07, 2022 at 01:10:52PM +0200, Ard Biesheuvel wrote:
> > Fair enough. What I would like is to remove the need to play around
> > with the placement of jump_label_init() across architectures. Jump
> > labels are fundamentally a performance optimization, so unless you can
> > explain how setting it as early as possible makes a material
> > difference, performance or otherwise, I really think we should pursue
> > a solution that does the static key manipulation at some later time.
>
> Alright. It sounds like Catalin also prefers the same. This seems simple
> enough with minimal downsides: https://lore.kernel.org/lkml/20220607113238.769088-1-Jason@zx2c4.com/
>

That looks simple enough. Do we risk causing any boot stalls due to
the crediting being deferred? Or new warnings about randomness being
used before CRNG is ready?

> So maybe we should just go that route.
>

It is not my preferred approach, but I can live with it.
