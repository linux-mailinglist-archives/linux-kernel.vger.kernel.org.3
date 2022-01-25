Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F5A49ACBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbiAYGu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359535AbiAYGsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:48:16 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11FCC078512
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:12:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t14so13519214ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZGyzBA+XlQ6F5GTLHJupOokjX96+atE9oKu+PQxFbIs=;
        b=GOQ1PbZ6xR8OFtGgBNirZAyrAVd14xJIvA3zYrAEIMlLFI92uPKYur4reEE1aXVUmW
         +iAvRfdKWGz8dWT9+y75NKFANHV6mIwCS3QX+0T3g9WTFoA0JYWRNpSkk6qF0rXmUVNs
         nB/y2p1v0ZrynSKoXJVPeWg6Oa/TYYOO347mGPntmYroCeU4Ca/HEJ79eSRNWUtEU9nl
         SlZSHcBkyemr/mxlBnScqNw4sa44WkIOKKWWYbo45h4RE41Dmw7qVK/jMWtPYCzgg8UY
         v7N2yHTPTxJgTj1/iaCyRTjQEeAcFgLzWm1OUT1zG1c2jk7xTlohKK5WUMT6AGVzPWGQ
         XGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZGyzBA+XlQ6F5GTLHJupOokjX96+atE9oKu+PQxFbIs=;
        b=sF8MqCrDPV5SiahGDLcQ4fOwtmFTVBhUmF1/rbaM5zxCXm1kA/l9/fk1vh04srN8Bi
         RcznnxAIb5t9/8Ew/ZPTnhsPDldT/dFnPBM0NNS1WZ/BRcp6IjVhFcJ5GooCgCp7TlwA
         JsD+87qTkBc3XCoy3wrbDHouRJKoMV+4NxFfacnsvhJLcjjyG8lU+dkvO22PZwVj7JXJ
         FUTZ57tmfwWjpVJq4OWRszxi/y1JI9V6CH+lW6oUmD1uaaeYa/QrQZ9jNABH+vJPLZi9
         rEFhZN0Pwz5u7oJpnqiwKgP3ENUFAEA26jqHqV8F8qewMg6SoQlZSSemSgfsbGYqr0z3
         +Kcg==
X-Gm-Message-State: AOAM531C+f+5Di2sjlJpVljZU3yMR0G3w2RlsV5RmLjOU9GXU9p8SkKr
        ElfsZO5gmjbG83ElxzFLT8BOTVMWqtjCx8XjbZl0Yw==
X-Google-Smtp-Source: ABdhPJwmDQASZqc5TLdz6lkxcncn+MPxfVSubqIKKHVUHrZ6012DuApiU3/H0PMOW5hQghP6qVQ/BCf/TGbi83Nlgjk=
X-Received: by 2002:a2e:8707:: with SMTP id m7mr2935760lji.516.1643087534046;
 Mon, 24 Jan 2022 21:12:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642582832.git.zong.li@sifive.com>
In-Reply-To: <cover.1642582832.git.zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 25 Jan 2022 13:12:02 +0800
Message-ID: <CANXhq0rzTAOrLBShX9AHoNdOy5HPcXj-ZqpND4R_PP-1J-vDag@mail.gmail.com>
Subject: Re: [PATCH 0/4] Refactor the PRCI driver to reduce the complexity
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 5:28 PM Zong Li <zong.li@sifive.com> wrote:
>
> This patch set tries to improve the PRCI driver to reduce the
> complexity, we remove the SoCs C files by putting putting all stuff in
> each SoCs header file, and include these SoCs-specific header files in
> core of PRCI. It can also avoid the W=1 kernel build warnings about
> variable defined but not used [-Wunused-const-variable=], like 'commit
> 487dc7bb6a0c ("clk: sifive:fu540-prci: Declare static const variable
> 'prci_clk_fu540' where it's used")' does.
>
> This patch set also contains the dt-bindings and dts change, because
> we change the macro name for fu540 and fu740 by adding the prefix
> respectively.
>
> Thanks all for your review and suggestions.
>
> Zong Li (4):
>   dt-bindings: change the macro name of prci in header files and example
>   riscv: dts: Change the macro name of prci in each device node
>   clk: sifive: Add SoCs prefix in each SoCs-dependent data
>   clk: sifive: Move all stuff into SoCs header files from C files
>
>  .../devicetree/bindings/gpio/sifive,gpio.yaml |   2 +-
>  .../bindings/pci/sifive,fu740-pcie.yaml       |   2 +-
>  .../bindings/serial/sifive-serial.yaml        |   2 +-
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  22 +--
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi    |  26 ++--
>  drivers/clk/sifive/Makefile                   |   2 +-
>  drivers/clk/sifive/fu540-prci.c               |  89 ------------
>  drivers/clk/sifive/fu540-prci.h               |  91 +++++++++++-
>  drivers/clk/sifive/fu740-prci.c               | 134 ------------------
>  drivers/clk/sifive/fu740-prci.h               | 130 ++++++++++++++++-
>  drivers/clk/sifive/sifive-prci.c              |   5 -
>  include/dt-bindings/clock/sifive-fu540-prci.h |   8 +-
>  include/dt-bindings/clock/sifive-fu740-prci.h |  18 +--
>  13 files changed, 254 insertions(+), 277 deletions(-)
>  delete mode 100644 drivers/clk/sifive/fu540-prci.c
>  delete mode 100644 drivers/clk/sifive/fu740-prci.c
>
> --
> 2.31.1
>

Hi all, thanks for your review, I'd like to know if anything else can
be improved in this patch, or it might be good enough to be picked up.
Thanks.
