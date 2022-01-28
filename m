Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151BA49FCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbiA1PdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiA1PdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:33:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2236CC061714;
        Fri, 28 Jan 2022 07:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4DF460ECE;
        Fri, 28 Jan 2022 15:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206B7C340E0;
        Fri, 28 Jan 2022 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643383992;
        bh=MAhtffWLvTb95O1nHiMgqFD+X4oKL17RAdXD+wioaRg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=One52MfBvMSDWvTWPac78/g+BCnPDSWcAb1PUw8N14XImZpuNJ1/p9CFB8eXb8tZv
         tg4ShPYSt3qts2nvMDLMYGSsSn/DnXvfxu9cdBcrU6ixNKadN7JG67zd6voHZwBR2u
         uf0aixlfSsaVzScOtGohS1rXjFaVSYm+a2N6rEz7qLfUjPpOHII3CLRIAbaShHjfUI
         rt10bKA1dL4lH4nQuOj7hOzNr6hpbUEKB8MCUEHJryNf22y02QBt34QAboS7ip5a+C
         fcabLaZVOWLMYDM3og08Vf7E0QaAHQtVwf7QYEm2YRYaYUwWvM8oF66cY6/W7Z2r6c
         K/07gBUPvtQyw==
Received: by mail-qk1-f175.google.com with SMTP id g145so5853090qke.3;
        Fri, 28 Jan 2022 07:33:12 -0800 (PST)
X-Gm-Message-State: AOAM530aMM+/AqfH2GzETyIsPUcgBf9FqY1sHaxSB2Zbzk1PnZPMbeCA
        I9If/+OhZlgFWe8DIb0OM2cSb597msKIint9lg==
X-Google-Smtp-Source: ABdhPJwHJMoUCaR7OpeFnThYM1h9Py6xmKEMPwKl8A0tM5s5zsoXWJFTSUkCr8hshCFK2R2ImvFTGUFvdAcfvDH8c1Q=
X-Received: by 2002:a05:620a:4149:: with SMTP id k9mr6154130qko.323.1643383991204;
 Fri, 28 Jan 2022 07:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20220128042321.15228-1-nikhil.gupta@nxp.com>
In-Reply-To: <20220128042321.15228-1-nikhil.gupta@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Jan 2022 09:32:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWmnQde+4tnZ3d90pWguezLVqto4DRe3WRjf9PCQ=L4w@mail.gmail.com>
Message-ID: <CAL_JsqKWmnQde+4tnZ3d90pWguezLVqto4DRe3WRjf9PCQ=L4w@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: move elfcorehdr reservation early for crash dump kernel
To:     nikhil.gupta@nxp.com
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 10:23 PM <nikhil.gupta@nxp.com> wrote:
>
> From: Nikhil Gupta <nikhil.gupta@nxp.com>
>
> elfcorehdr_addr is fixed address passed to Second kernel which may be conflicted
> with potential reserved memory in Second kernel,so fdt_reserve_elfcorehdr() ahead
> of fdt_init_reserved_mem() can relieve this situation.

How does changing the order help exactly? If you have an overlap, that
seems bad no matter what. What if the overlapping reserved area is
used by another core or firmware?

Rob
