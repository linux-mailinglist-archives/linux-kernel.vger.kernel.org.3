Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B03496653
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiAUUXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiAUUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:23:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBCC06173B;
        Fri, 21 Jan 2022 12:23:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7771961770;
        Fri, 21 Jan 2022 20:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E0C340E7;
        Fri, 21 Jan 2022 20:23:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BMscvUpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642796591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBqGV4H7K/jCpP8PTz6+aYreOz0jHaQWza7NI4+WEM4=;
        b=BMscvUpigkybSXqmm6pvM0d9nar+niscgkEtK7t6AlZ255cvnXWJHE57oPKT94a5SPmziW
        3qepWhXljuII19w3iYazpQ4TNYxTBsozuR+Qndq7tczbA5JNAqthomyKT3EP2LdKS3gw4T
        Wb51lIEedSU3FGf5ad1TdX9AuUw/FHQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d9286d3a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jan 2022 20:23:11 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id k31so29193052ybj.4;
        Fri, 21 Jan 2022 12:23:11 -0800 (PST)
X-Gm-Message-State: AOAM533ssxZKzIk3cGE78ZyTrLoct89FNtj8ed+O2ROTPy8wGYDO5N6s
        USxuG+1aOkJUfmmmbiHh4glJy7p/7uTLFKQ5lqw=
X-Google-Smtp-Source: ABdhPJwl2jkYtYtG2nPh5ypMlIKxLf59xn8Y3SzY5dE0QkIWXT8ENiHBOTEA4FBYcb21NZAtyd/9VJpUiC7JY0D0yk4=
X-Received: by 2002:a25:244b:: with SMTP id k72mr8936181ybk.638.1642796590031;
 Fri, 21 Jan 2022 12:23:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qVMomgb53rABKsucCoEhwsk+=KzDdEcGKtecOXuahTZw@mail.gmail.com>
 <20220119135450.564115-1-Jason@zx2c4.com> <YesPesOhftSzp2ft@sol.localdomain>
In-Reply-To: <YesPesOhftSzp2ft@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Jan 2022 21:22:59 +0100
X-Gmail-Original-Message-ID: <CAHmME9ow7TxCaYYayRn9rdJJSdQ48tWQgdrW00g7mHaWvVJ+Zw@mail.gmail.com>
Message-ID: <CAHmME9ow7TxCaYYayRn9rdJJSdQ48tWQgdrW00g7mHaWvVJ+Zw@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: avoid indirect calls to compression
 function for Clang CFI
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 8:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
> There are some lines over 80 columns in this patch.

I'll fix that up.

> Otherwise this looks fine.  It would be really nice to fix this in clang,
> though.

I agree. I'm wondering whether it makes sense to roll with this patch,
or to just not change anything and lean on Clang upstream to fix their
bug. Full LTO is marked as "experimental" still. On the other hand,
Android ships with it turned on, so how "experimental" can it really
be? I don't have a strong read on the Clang ecosystem to know what
makes most sense, to apply this or not. Do you have an opinion?

Jason
