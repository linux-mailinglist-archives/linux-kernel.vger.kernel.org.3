Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B142151B4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiEEAij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiEEAig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCAF4BB9F;
        Wed,  4 May 2022 17:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ACDC61D5C;
        Thu,  5 May 2022 00:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D96C385A4;
        Thu,  5 May 2022 00:34:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dIvmPEiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651710896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnC1+qRF+ciP+q6CHbeRaXIz/leRGorupnOwUpOwflA=;
        b=dIvmPEizBesoAFpFaMW5IhHZOZ/abNRUv8YA9jGJKrKgyijFfUvV2ylGMaDm1D3M87ar9j
        3N+jxxVjkkwvRsrwKs8tkYZfCjRgrdgezrCdyoWepSNn4wSu5HUSW7HZanXyGfJa4kapnj
        DpDItaHtWFjJ2cjiiDS9loKVyL1jc9g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2307956d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 00:34:56 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f83983782fso33349357b3.6;
        Wed, 04 May 2022 17:34:56 -0700 (PDT)
X-Gm-Message-State: AOAM530gEEnf8+5X10gl1at8EwJdbbUUALIkkgMR74vos0kO0+rfL2SI
        XT7UVCs4F8PYA8i/9ds3ajesKVjPJCXC34cKpRI=
X-Google-Smtp-Source: ABdhPJxFr907tMrzyLaiI7ZALTgATrZJBmLFKZ4XIFvya0WZsy5rGZDeMn8L4JglFRXceNF2q00ja1PLfDEXJxCdAV4=
X-Received: by 2002:a81:ad5b:0:b0:2f7:c91e:ab42 with SMTP id
 l27-20020a81ad5b000000b002f7c91eab42mr22698261ywk.499.1651710895557; Wed, 04
 May 2022 17:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220503131204.571547-1-Jason@zx2c4.com> <20220504111644.284927-1-Jason@zx2c4.com>
 <YnL6ouh5xxZIJqeN@dev-arch.thelio-3990X>
In-Reply-To: <YnL6ouh5xxZIJqeN@dev-arch.thelio-3990X>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 5 May 2022 02:34:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9o8br7cnG1980=sqC89zw8=_C9sO2ytkcwt5tNhJbQTHw@mail.gmail.com>
Message-ID: <CAHmME9o8br7cnG1980=sqC89zw8=_C9sO2ytkcwt5tNhJbQTHw@mail.gmail.com>
Subject: Re: [PATCH v3] random: use first 128 bits of input as fast init
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! Should be fixed by
https://lore.kernel.org/lkml/20220505002910.IAcnpEOE2zR2ibERl4Lh3Y_PMmtb0Rf43lVevgztJiM@z/
which is actually an earlier commit but unearthed by the one you
bisected to.
