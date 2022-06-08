Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAD542A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiFHI6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiFHI5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5AA3DDF14
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 795826160D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A739CC341C6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:18:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oR7Qp4kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654676284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y48EB/+qYWGE2v81oslfm42q3nbiPcHgndLfChUYuUA=;
        b=oR7Qp4kIauI254o1w9LMj/KBqCNNq16ujn84yhG7iLxkWaT2uc3EG4yN1+xY3mHnwLgGJR
        q5huvKfOIDOtmtwxZeDUGcYP0NgfrLNTyZ491lngtqx8VQTqLKYLi7cx658+H0e8zbpg8s
        R0hGECUrW2/Jtm6WRXLLzCL32OBCw9Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f16ec508 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 8 Jun 2022 08:18:04 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ff7b90e635so201016677b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:18:04 -0700 (PDT)
X-Gm-Message-State: AOAM532Y5KMEAsw1CYCwoqFHsCT7JS0ocNsLcB+/QGb814EbHL10nTK0
        uNyjdeWEMC1BzbVzaZRDZjPk/sHYN5wX3PgCUdA=
X-Google-Smtp-Source: ABdhPJyfhGUwl9a+4mLnY79hQd5voE7ulIvmcll3+HUVh330Y2eTEuLSP3vpjZ+5HMHaenpd2DvbIbvV4XBEhS9fuA0=
X-Received: by 2002:a0d:cd04:0:b0:300:4784:caa3 with SMTP id
 p4-20020a0dcd04000000b003004784caa3mr35748864ywd.231.1654676282763; Wed, 08
 Jun 2022 01:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220607195752.1146431-1-Jason@zx2c4.com>
In-Reply-To: <20220607195752.1146431-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 8 Jun 2022 10:17:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9pycN94eCArsqNhr-6no=vDqPhdVyRhpRHGn=sO3bM2hA@mail.gmail.com>
Message-ID: <CAHmME9pycN94eCArsqNhr-6no=vDqPhdVyRhpRHGn=sO3bM2hA@mail.gmail.com>
Subject: Re: [PATCH] riscv: initialize jump labels before early_init_dt_scan()
To:     linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russel King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
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

This patch isn't needed in the end. An equivalent patch is needed on
xtensa, powerpc, arc, mips, arm32, arm64, riscv. That's a bit much and
points to a larger issue. So I'll fix this the ugly way in the
random.c code :(.

H o w e v e r, I'm pretty sure that you do need to move the sbi_init()
call above the existing jump_label_init() call as already existing. So
you might consider doing that.

Jason
