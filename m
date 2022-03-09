Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101F64D3C91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiCIWGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiCIWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:06:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F811EF2A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:05:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso3505226pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ol07yB2pc4Hx2YpjxX8IDkmGa1Ut0RXCUKHI0BlLywM=;
        b=N5JXehWwWuC4FwbhbSiMdnv1JqdJYcNh+IKME6/AwQDzvtCfK61grGuRwv3x+0S504
         OZfzislLftIUuu+eTY0ij+1lpxA96FHcWXljVoqByHuVKUNSJO6hendZ8xihqIDFaALK
         IitMl2Rq4/Oj2paqCMYhmSF5W893FOI5l0cPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ol07yB2pc4Hx2YpjxX8IDkmGa1Ut0RXCUKHI0BlLywM=;
        b=tLxGrlLUWpRAvCnNu6/JvOHhlcqTahJ9Pnb+nv/W5dXS+qtITShP6hMxpHkli06v5q
         mcFot6l/BLCq+tBsV93ftLY3EH7U+bwm3qhlj0pvTXNkUWjoHrFLrKT0ks6gYHaS4qXW
         k8twSex5T40LubuV2wrXlzN1PWenAVyKy0l2l670mqPYJbiRfQCrWn/a3/xzuZXY7OKZ
         OhvB/qGfM4DROiE2LlKX3WL28pUVBU1tDzoq7ROUJdZjTkb7OYLWtz6OoJ1xK1YKbP73
         bPO7GQQinWMlvRy5rJZBWhKIQSYU/eOWVZctv/PMLnJKmVpgSEVC4aeNrx8vf5z/bzcu
         jURQ==
X-Gm-Message-State: AOAM531SeaKWktJwlcK5rld7Ib2RZNUslxFR5Y5r5Cq9EbsHsz8f/aGv
        lz7u5fIMWgCqoQF4UJSb3nZAPxVsT2o+QQ==
X-Google-Smtp-Source: ABdhPJyGPublwuLOMOVGGkAn+uCqEykbtEDrUSKkIin3o3/MXyEy6lr28SGfex4fbL3/1BVSE2KwoA==
X-Received: by 2002:a17:902:c745:b0:153:b0e:8586 with SMTP id q5-20020a170902c74500b001530b0e8586mr1643074plq.9.1646863515178;
        Wed, 09 Mar 2022 14:05:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i11-20020a056a00004b00b004f6907b2cd3sm4173818pfk.122.2022.03.09.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:05:14 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Cree <mcree@orcon.net.nz>, linux-arch@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH] a.out: Stop building a.out/osf1 support on alpha and m68k
Date:   Wed,  9 Mar 2022 14:04:59 -0800
Message-Id: <164686349541.391760.11942525130947458475.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu> <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com> <YeHLIDsjGB944GSP@zn.tnic> <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com> <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic> <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de> <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2022 14:03:42 -0600, Eric W. Biederman wrote:
> There has been repeated discussion on removing a.out support, the most
> recent was[1].  Having read through a bunch of the discussion it looks
> like no one has see any reason why we need to keep a.out support.
> 
> The m68k maintainer has even come out in favor of removing a.out
> support[2].
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] a.out: Stop building a.out/osf1 support on alpha and m68k
      https://git.kernel.org/kees/c/f451569b9da8

-- 
Kees Cook

