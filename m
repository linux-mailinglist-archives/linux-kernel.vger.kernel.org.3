Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F94958BE9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiHHA57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiHHA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:57:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998CB49D
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:57:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id m4so13880435ejr.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VeszcK8oCz3d8oKPlworSPbe4m2/3lvPCiLBHwanhw0=;
        b=UfYTyUZmKEWmkJ4WunCAM/RDH8pomwbt4YmpSrfd+t6cRWWaj+8iZyLhRbNXyAhVBV
         ZpePpL67zCCM+OzEimr28ZvCNezQMiV8V2M43Hy3NwGD2sB7blRXDMjR75wUDLoFnQaT
         3UjJkfvujr4b3jiJWdPpo8ORlW3NgLKiI9zKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VeszcK8oCz3d8oKPlworSPbe4m2/3lvPCiLBHwanhw0=;
        b=bUSnIHDwBxa53ZB/qjHwbN12vuYGqa4AS13G4huFQ9U5MklumYkHVKQR7EqMEhC6CZ
         DRqITpeAYrUJZiaywMod5z9/fanQrHckOLsw8iMi2QJqbpbiIZ8GlsyBM++sa/is2blJ
         1whBr4whUQqelo0lbFARHBbxdxf8Yvcmk6TSL5izh5tkthOfXJlDiCX2m2jKgAwooReL
         6NhQEjOTZAKcj+boHT3QxIjt8uOf0EQYKrTmijIh/2QgiNXYHhrt/PQeM4Ig7gnjKcJg
         EGvWZY50W8aeQx69fUUttxs2uYM0Oc3J4MluEX8VygBkO4FFSPWrGoCOR5hPvSz2Kleh
         fhzA==
X-Gm-Message-State: ACgBeo25zSUO8FqOoV47Z7ePSo1IryWvmewL5CNOD5hS8eRlmr+8ZS+I
        WG2ZJjJQ0h8N6ZQicve6nTwS6u/ec9SOvSR0
X-Google-Smtp-Source: AA6agR4JRpQ7ocnPqjQS5dLnxKL/+QW2jqluum0EhVO7Emax/xv2iSKpn2zv/EV31nLYZV6KTmcNbQ==
X-Received: by 2002:a17:907:1611:b0:72b:53cd:ce2 with SMTP id hb17-20020a170907161100b0072b53cd0ce2mr12566069ejc.124.1659920271864;
        Sun, 07 Aug 2022 17:57:51 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906040300b0073043ff06dfsm4250772eja.163.2022.08.07.17.57.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 17:57:51 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id j1so9257419wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 17:57:51 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr10194614wru.193.1659920271018; Sun, 07
 Aug 2022 17:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220805022940.1637978-1-yury.norov@gmail.com> <165991968404.10077.6220067519297859381.pr-tracker-bot@kernel.org>
In-Reply-To: <165991968404.10077.6220067519297859381.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Aug 2022 17:57:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbFrPfKA5DOnPXvn_0hTmSw2oTXPKxtDoC5v12McW2DQ@mail.gmail.com>
Message-ID: <CAHk-=wjbFrPfKA5DOnPXvn_0hTmSw2oTXPKxtDoC5v12McW2DQ@mail.gmail.com>
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
To:     pr-tracker-bot@kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 7, 2022 at 5:48 PM <pr-tracker-bot@kernel.org> wrote:
>
> https://git.kernel.org/torvalds/c/1ab9250751ee91b0ca7bee887894fccfd44ff26a

Oh Christ, and then after all that, I pushed out the wrong merge tree
that didn't have the final fix committed.

I've done a force-push and hope nobody saw that wrong head.

This was even more painful than it needed to be with that
self-inflicted unforced error.

But hopefully people never noticed, because nobody sane is looking at
my tree on a Sunday evening.

            Linus
