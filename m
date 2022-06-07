Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4B53FD6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiFGLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242791AbiFGLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5855C2E0AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCC0616A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E4EC34119
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:22:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Srv6/nzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654600953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyIyZa135ViHebuXCrJA3Flo9/57KxoVHoQeUS9+uqQ=;
        b=Srv6/nzfXdGh1ys3dVW+NxNWMmHWvirx7E4BXLyAy0Tr/baW67AMJ6tDKM5qbEfgui79H1
        jCHBiV6nO9PlIDDktJs6ZVJUcC6Y5PMO5rxe/DL/5tWqJXoE9+ICUJj30686MT0/uAaebx
        +QgVkIjt1q5vcjkT6FjS5mZJcctg08w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 25383e6c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 7 Jun 2022 11:22:33 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id x187so3032923ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:22:33 -0700 (PDT)
X-Gm-Message-State: AOAM533twp7smN3cxXn2yZwGp9k/AllGDo5kcP0AGvIFPhyMp1IBKVyJ
        AHCzqGI9j8pZPwYBiIzdSy2gGV3QdWDb/XhqjOg=
X-Google-Smtp-Source: ABdhPJzUH7d9rVttOaFgpVPXrSn6isdhTRl5tpA4PlDU8a8Ynb0UTt7nuhBxlZ3T7ZMCZ7q//ait8E/DI7CPcfjH/yE=
X-Received: by 2002:a5b:dcf:0:b0:64a:6923:bbba with SMTP id
 t15-20020a5b0dcf000000b0064a6923bbbamr31094964ybr.398.1654600951873; Tue, 07
 Jun 2022 04:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220607111514.755009-1-Jason@zx2c4.com>
In-Reply-To: <20220607111514.755009-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Jun 2022 13:22:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9pspbPpLnfjypneOCPuVFLd5U29D92kyuqiCaH7fHZ8zQ@mail.gmail.com>
Message-ID: <CAHmME9pspbPpLnfjypneOCPuVFLd5U29D92kyuqiCaH7fHZ8zQ@mail.gmail.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to random_init()
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
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

Yet another approach would be to mix immediately, but defer crediting
until random_init().

Jason
