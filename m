Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A12C500113
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiDMVXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbiDMVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:23:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F902BB37
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:20:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bg24so3250030pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eMGB2zfPbAG9Q8WOOd6Fy48l+atpiddj7/fan+CEbbg=;
        b=ktIH450oeVvWGl4fzzvsVVfe+uBGTeIwIIF87quitTz+JZUrWK7zlxSKIZC7EPRfIj
         mTKK14MeJjAWdnYLKuc7p35D43iZYPomIJV9cznWMxfFMDNIoAjOrv1aWFS045v9Lzjt
         FgTiH2N2MkrJIiMj70Vsp1n2fwjpa3kdF1qGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eMGB2zfPbAG9Q8WOOd6Fy48l+atpiddj7/fan+CEbbg=;
        b=tvTGLLeh/Wp5QfK4SrI1Kdo2QNpTW84AU4k6+Havw4SWg2hPS0CIAWsPznDz3fc96o
         Q60bHUCmxNTI9WhqAzZNiidOVECu6dZ4CfQbytOU9NfGpTDofHZ/G2s1yGrldhX3qKu6
         bank2PogVexnmVFdPizHahkGploINOTPHPTmE2ZqOsKSJWzJWOF4AOhdBl2v0R/nqYgc
         L7T1GOcbAl9ulHorQiLtx0ttKj9Kq1/wfela/B7YWSeKscfaEZzgTo81NEvONB3zh7TW
         +boSWw8Ts9G9PbXdty8oEpfQLwhhzIy0xrDbHboOeK3AeFo5tKWQrLFSTlbIy9QEudNy
         z2sg==
X-Gm-Message-State: AOAM532AX9ViK9/PAEM94hrq/gQ23Gza08IjlEfy7VGX3zfkLLAURzgo
        49fHCWfJ5uFZTdv8VzeUQwlLRQ==
X-Google-Smtp-Source: ABdhPJyI/txgkIATfc9o3YYs6eT53/rozlKJ9Mvz4Kx+Swh0erWgHqDdBlMYX0n5vUrnH02mjv1ykw==
X-Received: by 2002:a17:90a:8595:b0:1bb:fbfd:bfbf with SMTP id m21-20020a17090a859500b001bbfbfdbfbfmr682428pjn.125.1649884849632;
        Wed, 13 Apr 2022 14:20:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79d84000000b00505f920ffb8sm4678pfq.179.2022.04.13.14.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:20:49 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:20:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Message-ID: <202204131405.025EAE89@keescook>
References: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
 <202204121440.FEE123D7@keescook>
 <672572c0-b698-ab5c-b99c-bc78c61db956@csgroup.eu>
 <20220413210131.46tqfxlkwtcayurs@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220413210131.46tqfxlkwtcayurs@meerkat.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 05:01:31PM -0400, Konstantin Ryabitsev wrote:
> On Wed, Apr 13, 2022 at 06:29:36AM +0000, Christophe Leroy wrote:
> > I have a [patatt] section in .gitconfig which contains:
> > 	signingkey  = ed25519:xxxxxxxx
> > 	selector = xxxxxxxx (the same value as above)
> > 
> > What should I do now for you to get the key ? I don't even know where 
> > the key is stored in my computer.
> 
> Your key is stored in ~/.local/share/patatt, but you don't really need to do
> anything, Kees can do the following:
> 
>     b4 kr --show-keys 363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu

Ah-ha, excellent.

> 
> For now, this just provides instructions on what to do with the key:
> 
> 	christophe.leroy@csgroup.eu: (unknown)
> 		keytype: ed25519
> 		 pubkey: HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
> 		 krpath: ed25519/csgroup.eu/christophe.leroy/20211009
> 	   fullpath: /home/user/.local/share/b4/keyring/ed25519/csgroup.eu/christophe.leroy/20211009

"fullpath" seems misleading for my config, given:

[patatt]
	...
        keyringsrc = ~/korg/pgpkeys/.keyring

Shouldn't this report fullpath as:

	/home/kees/korg/pgpkeys/.keyring/ed25519/csgroup.eu/christophe.leroy/20211009

And as a side note, should I prefer .local/share/b4/keyring over adding
keys to a branch of the kernel keyring git tree?

> 	---
> 	For ed25519 keys:
> 		echo [pubkey] > [fullpath]
> 
> So, for Kees to start being aware of your key, he needs to do:
> 
> 	mkdir -p /home/user/.local/share/b4/keyring/ed25519/csgroup.eu/christophe.leroy
> 	echo HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0= > /home/user/.local/share/b4/keyring/ed25519/csgroup.eu/christophe.leroy/20211009
> 
> I know this is awkward and clunky right now. Future versions of b4 will
> streamline keyring management to make it a lot easier, I promise.

Thanks for this walk-through! I think I managed this in the past with
another ed25519 key, but I failed to figure it out this time. ;)

Now it works! :)

  ✓ [PATCH v2] lkdtm/bugs: Don't expect thread termination without
CONFIG_UBSAN_TRAP
    + Signed-off-by: Kees Cook <keescook@chromium.org>
    + Link: https://lore.kernel.org/r/363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu
  ---
  ✓ Signed: ed25519/christophe.leroy@csgroup.eu


-- 
Kees Cook
