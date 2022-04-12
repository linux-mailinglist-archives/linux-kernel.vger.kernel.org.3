Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F84FE815
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349830AbiDLSgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244045AbiDLSgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:36:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079A4EA03
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so3882749pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIORrv+/2LRk4nx6ozs3wWj/aKmJXy1Yh96OLl5WUNE=;
        b=T/14KOgusZu9tE7Blvj716S2MXYnWYGVXdWWFu+K6ZQDeNHFwkMMIHNUFluS3bodzj
         /tNQdZvWhxuJ0PLZ+WAjbo9t4/nnirzb7Ha22W5twpHPDukCX+a7chuh2iMg/+hoCCnq
         EvOCgHo5h9VByatHhCI8kqXmIR668+T8d9bj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIORrv+/2LRk4nx6ozs3wWj/aKmJXy1Yh96OLl5WUNE=;
        b=gTdgyE5hyiZFLnmSAqOCJtGAVIGSCMR8hRnRa8YSbuiDzky+Mxwv1J2k8LUlDwgUUV
         DEASODiN1+TDZ7DYK/ZFZOevnkZMm+dDWjxoFiD8TlRN78COWm8v1ZZufGuneJeJooXf
         ZZf5P5qNhqXU0F4qGMWY8fd3IUJfgaxwm6mo0M+aJU/otRd2MqoexMtlyVz1zF8IKEqn
         BPmOxXWzcdMtRd5LDS9QT83W2HlEEEoAm9ouIwS1yl+TsbAnOygDx2f8AwB51C0ujoWi
         tRWLuof/gT7WL5kVRhrnm5qRItPxSD5fGh2SdSyd3FInAH+uMDrvEQM2WZaUVdV6c/Rp
         n7oQ==
X-Gm-Message-State: AOAM531JyvSB3/H5BlUEwFxY1Fl1s6mNQOt8K3986F+jK3IFiwTT216T
        Wxmc6F2DhcT0ioqjAfALRxgMhPXiifdQrQ==
X-Google-Smtp-Source: ABdhPJwqcoomSOwjtJV29/CjOi1tnfkh4AfcHk1QUOr0hmpLGP9VH5eKPVzKPHi8RM6bXgAHa+o/9Q==
X-Received: by 2002:a17:903:2284:b0:154:3b97:8156 with SMTP id b4-20020a170903228400b001543b978156mr39323752plh.95.1649788434440;
        Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j18-20020a633c12000000b0038204629cc9sm3597529pga.10.2022.04.12.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:33:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        PaX Team <pageexec@freemail.hu>,
        linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4] gcc-plugins: latent_entropy: use /dev/urandom
Date:   Tue, 12 Apr 2022 11:32:48 -0700
Message-Id: <164978836579.3579300.2356881730976056198.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405222815.21155-1-Jason@zx2c4.com>
References: <CAHmME9pV4SdoSyMq4kax3w3Vu1nPxjO3faCZKq8d0RDo8t731g@mail.gmail.com> <20220405222815.21155-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 00:28:15 +0200, Jason A. Donenfeld wrote:
> While the latent entropy plugin mostly doesn't derive entropy from
> get_random_const() for measuring the call graph, when __latent_entropy is
> applied to a constant, then it's initialized statically to output from
> get_random_const(). In that case, this data is derived from a 64-bit
> seed, which means a buffer of 512 bits doesn't really have that amount
> of compile-time entropy.
> 
> [...]

Applied to for-v5.18/hardening, thanks!

I dropped the version number change, added a pointer to the GCC bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105171, and noted the
rationale for the buffer size. I'll get this sent to Linus shortly.

[1/1] gcc-plugins: latent_entropy: use /dev/urandom
      https://git.kernel.org/kees/c/c40160f2998c

-- 
Kees Cook

