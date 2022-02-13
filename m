Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658B4B3AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiBMKvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:51:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:51:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005F25DE40
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:51:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6D87B8069A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3779C340F0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:51:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZTD8zDvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644749493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OKUD1T6eLiMSZXX3kUU5bCCpHvwXB1Q2wbEGzMaMNvg=;
        b=ZTD8zDvzqnylhM+pI+eXJKQYp0JstEcZEaguPz5YJuPWE9M+vTsWHoGjl1n+SAJpKHa3GZ
        W6wEwXyCnZwQaBPNXkWFyW/bHADUeBvYmBFhhXTFbwLPqa5n1nra6yL5pdaKqZa9D5osAK
        qPCu78UVsag3+HvnwG8U+pzRPe+4zdg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c16de68b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 13 Feb 2022 10:51:32 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id 124so9842677ybn.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:51:32 -0800 (PST)
X-Gm-Message-State: AOAM531sMiFiMyhStrRvMSyexcQsq0FSUgpTFMdroG6t7KUy7cs8zIf/
        4HRdpq9brUiiWeWUFUirNW7fQnwPVK0+gt6kdOI=
X-Google-Smtp-Source: ABdhPJzGY5CaT42I9qzy9h+53QV1keSdtMVsZwRUsZw2N0mlWxAJoxCurzjdCXFs+18Fl6xVy8/sDaGVYk771qTJrok=
X-Received: by 2002:a81:f10b:: with SMTP id h11mr9625026ywm.396.1644749491835;
 Sun, 13 Feb 2022 02:51:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:888:b0:14e:cd6d:454f with HTTP; Sun, 13 Feb 2022
 02:51:31 -0800 (PST)
In-Reply-To: <YgiraRIkuKK787YC@owl.dominikbrodowski.net>
References: <20220212231022.679926-1-Jason@zx2c4.com> <20220212231022.679926-4-Jason@zx2c4.com>
 <YgiraRIkuKK787YC@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 11:51:31 +0100
X-Gmail-Original-Message-ID: <CAHmME9rtP=YUGk1UbTQQiONhssn8v+c_0ZXnt7tex3mQWY7g+Q@mail.gmail.com>
Message-ID: <CAHmME9rtP=YUGk1UbTQQiONhssn8v+c_0ZXnt7tex3mQWY7g+Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] random: use trylock in irq handler rather than spinning
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

Yes, the decision about RT and trylocks is still undecided, and I'm
actually trying to get the existing design into as optimal shape as
possible before considering deferring it, so we can really have a
complete comparison. It was an error (my error) to introduce the full
lock here in the original patch that added this. So I've actually made
this patch into a fixup for that original one, so we don't need this
one on top.

I'll be looking at the deferred work next week, but I'd like the
existing thing to be as solid as possible before. Otherwise it's too
hard to evaluate pros and cons.

Jason
