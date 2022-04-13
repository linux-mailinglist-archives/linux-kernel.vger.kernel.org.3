Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E59150007D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbiDMVEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiDMVD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:03:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC849276
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:01:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ay4so2266447qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53xZC/O9UyqpGImr9R1mlpH431NIXU6bLsXMAgQ60tY=;
        b=Cb7jS5srlil3xnNArsgvM8sfvSyjPGnrhCGF92oDFb1+bHORvFUi0J9X/jfdaqOxIf
         zmi6P47O8jDmKPMFVcY5xAHO4l2ztEgF4S/7i2lqpD6korUL+2hT2l0rK/mCkJYULRFO
         L6TJJgXBemM+/agjkBlrmMgHwrVK80bLXmaZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53xZC/O9UyqpGImr9R1mlpH431NIXU6bLsXMAgQ60tY=;
        b=1eO8S5/97ahVgr4Vmef0JJNZhR2PACSlV1JowmlExe79CIpCduRuAOi+SxOFxsA75K
         tTbAVq/coTtVZ5ETU/KlNiC5u+Tj6D/dPeoF1J69p0Im/iWi9yukMPBqhyMBYHxxvurE
         PwCSnfLeTaZyHGATv0IXNeUsdUeb8GHwn92FznXGCO7zv1Rv9fxXct9Uc5nfuYx4YlpH
         CD/YFTn/xFo/pI7HHafaDAPbyvBWlGChj7Bs58jFx3mNSy3zEW06f3C/Hj0malI2d3bq
         ePO1kkpZ8tyBWdhyKTZ6h6j56JjzgBM0h40SAHI/40As9TBVXs2n6FovbNhY8uh9HAEa
         uVJA==
X-Gm-Message-State: AOAM532JVvSYQuwYDFXCNNr3gn7IcIUFF+nsNb+oYhlHWgifUNt8NIpe
        8XVriWaQD+jvG8Vy7JXH4BhROg==
X-Google-Smtp-Source: ABdhPJy7rSpT7n33E9TTMvSaYR4b6eBYooLu9g9j0Ll9iQPouUjI51f4nPMp8cyI+6tlbAT+4kAzcA==
X-Received: by 2002:a05:622a:1e07:b0:2ef:b1ef:850c with SMTP id br7-20020a05622a1e0700b002efb1ef850cmr8593542qtb.292.1649883693008;
        Wed, 13 Apr 2022 14:01:33 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id m14-20020a05622a054e00b002e2072cffe6sm30985qtx.5.2022.04.13.14.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:01:32 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:01:31 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Message-ID: <20220413210131.46tqfxlkwtcayurs@meerkat.local>
References: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
 <202204121440.FEE123D7@keescook>
 <672572c0-b698-ab5c-b99c-bc78c61db956@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <672572c0-b698-ab5c-b99c-bc78c61db956@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:29:36AM +0000, Christophe Leroy wrote:
> I have a [patatt] section in .gitconfig which contains:
> 	signingkey  = ed25519:xxxxxxxx
> 	selector = xxxxxxxx (the same value as above)
> 
> What should I do now for you to get the key ? I don't even know where 
> the key is stored in my computer.

Your key is stored in ~/.local/share/patatt, but you don't really need to do
anything, Kees can do the following:

    b4 kr --show-keys 363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu

For now, this just provides instructions on what to do with the key:

	christophe.leroy@csgroup.eu: (unknown)
		keytype: ed25519
		 pubkey: HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
		 krpath: ed25519/csgroup.eu/christophe.leroy/20211009
	   fullpath: /home/user/.local/share/b4/keyring/ed25519/csgroup.eu/christophe.leroy/20211009
	---
	For ed25519 keys:
		echo [pubkey] > [fullpath]

So, for Kees to start being aware of your key, he needs to do:

	mkdir -p /home/user/.local/share/b4/keyring/ed25519/csgroup.eu/christophe.leroy
	echo HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0= > /home/user/.local/share/b4/keyring/ed25519/csgroup.eu/christophe.leroy/20211009

I know this is awkward and clunky right now. Future versions of b4 will
streamline keyring management to make it a lot easier, I promise.

-K
