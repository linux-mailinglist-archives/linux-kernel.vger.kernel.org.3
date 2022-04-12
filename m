Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283A54FEB14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiDLXUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiDLXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:19:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42715A00
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:06:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v12so366950plv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aNzMWQjBJ1umcrqZJuk3YBANA1WoxuEAShIoKqb7qRk=;
        b=Y+T9dicOe8i/4Z8itl/AAwJHwqXNizrX8SFccWBcJDJV3IfzGGcagOzn1levHA2yjh
         5PFxwaQRaBkasLT35diQ6ERDh2CQIrwBpiTl/Rukdt/mq5dm37+12DCVPRC5rAzvu5oE
         9ykzAHM2GSYK1WJX6iGxT1G5EVJWB3zuV6Kt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aNzMWQjBJ1umcrqZJuk3YBANA1WoxuEAShIoKqb7qRk=;
        b=65w9O5oCnP2ZGghS0WCAKyWJxJa66y2c6TY6kseijGDDUK7aOS5JvmiAyWoaJ7vW6f
         XEwV/iTvTWxuBrYaI9DX8wy/x7iy6/6PUiLgS74LaVUhwVTFGQoxbQMWE3RBosL/EEON
         YGHYqagDqkbZbJlslCkHEQpDkeqwKozxUcSKHe0OhEbBwl3y0U0xecMJhZ6iS3/77Hn4
         rAAqVo6otfKXNtPBs5Jwp/Xep3L9qZdw958navH+6RV6Lmb/lTRtiiAmTvGBK408WQab
         gG1e2Zv7c5buuu5X2/BsUaLt8ilUqwKLvx//4Exf1jD3oDNKTxuEI+hOHmQw8IdlGlPX
         xi+w==
X-Gm-Message-State: AOAM533qab5EWN5lmk8NQ2psBmQHZ9kyzaTKqLKcw/MrtqBaaO465cjI
        Pfj/Y1KYiQHgFSQ8VvAaRiBbwQ==
X-Google-Smtp-Source: ABdhPJyYYXKNnjWv7woMsfP7YEeP5sZcNr+zkXOvzyOujtAgpWeYyfkFsxMeV2BSJPYhdC2eyceWcw==
X-Received: by 2002:a17:90b:1a8b:b0:1c7:386b:4811 with SMTP id ng11-20020a17090b1a8b00b001c7386b4811mr7665564pjb.4.1649804781936;
        Tue, 12 Apr 2022 16:06:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b003810782e0cdsm3783811pga.56.2022.04.12.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:06:21 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:06:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] lkdtm/bugs: Don't expect thread termination without
 CONFIG_UBSAN_TRAP
Message-ID: <202204121440.FEE123D7@keescook>
References: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 09:13:39PM +0200, Christophe Leroy wrote:
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks! I will fetch this in a moment, though I tripped over this:

Checking for newer revisions on https://lore.kernel.org/all/
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v2] lkdtm/bugs: Don't expect thread termination without CONFIG_UBSAN_TRAP
    + Signed-off-by: Kees Cook <keescook@chromium.org>
    + Link: https://lore.kernel.org/r/363b58690e907c677252467a94fe49444c80ea76.1649704381.git.christophe.leroy@csgroup.eu
  ---
  ✗ No key: ed25519/christophe.leroy@csgroup.eu

Is there some place I can fetch your key from that has a chain of trust?

Also, Konstantin, I note that
https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/
does not have a .keyring/ed25519 directory. Should it? I added one
locally for at least one other developer, as I use this setting:

[patatt]
        keyringsrc = ~/korg/pgpkeys/.keyring

Am I holding this thing wrong? :)

-- 
Kees Cook
