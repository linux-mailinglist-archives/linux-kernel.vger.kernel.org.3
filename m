Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C244A9F91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiBDS7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiBDS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:56:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E94C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:56:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so6419816pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Jg17IORQiX50k9hzchIY/5BxWqpFAaTYJl32S7Q4Sbg=;
        b=uPCBA5viYD0QY7M/Rk2spN+UqATL+2sZOvKQcSrR4zPjEW8JpEMsNra2IDMdJN9IFZ
         BYaxujrLvUFl/sMTSX2rkGMLjT0+NSDY734GgVVQ4Dsg43Nj2oFOjdRafThSkGAgFH5l
         mpNkDd2Qa/R25MLGEYLjum9O3COWIlqByeP0h4mvo66JhYflXvWEKPZTxfXDEiCk6KUs
         9DeKMHJf9vbBqzFVxLRVLBrhtBN3QkkZuEGOzyBDmJDtXWT+0xGI9XxlrhvI1K9dtGfd
         VU0yIxCI82FBO6Abcczrit4gG0k1Wvvu8R2S5E6dddfzHuv+eaMnjGDAfSxDh1eDN8GN
         468A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Jg17IORQiX50k9hzchIY/5BxWqpFAaTYJl32S7Q4Sbg=;
        b=XjORIPXRiOOv9ttwbr8vZiFPrLGAOFjBXbL25d652nfFpFrVVrVJdwS0USHi1h6nr7
         zoxiKBLX1iYIBEJMfaghZO1sx5DBgKtIZjlIlSQcWMVmEbVj4TT4f7hvUSleQqOviQrQ
         plR1/cyrdQi6Ek9+rQLwT+nc/tTfenYO57l+OZ6n/gj1/5XWYr55BlPpe1eCAwA9XqP9
         oSMrEe9DpkAu8q2QTegd0Fjaq8gR+Qadsgpoj46YcWyTHnnx0LXIvVOPueUIa16DB0Ic
         xTIILtNYGRUJbDOKJHJIMW2lQagis8XHQUQnjxDma3k2TCQhb95eMpIDi6jOVP1SO1MY
         fAag==
X-Gm-Message-State: AOAM533H2ih77loB+Kv3tqwQurMGKiSJMifBDFQ0dZM/uw3r1a2PuwsS
        h1rBJ/yVVAvUkpj54UuUE2t26A==
X-Google-Smtp-Source: ABdhPJzT7RTMUBVz+1BYpBITNrUEw6VSIBcSnFJFo16PdfPLdPCpcPdkajv5i36AHs82/DM/7IfWOg==
X-Received: by 2002:a17:90a:d144:: with SMTP id t4mr4663574pjw.18.1644000982761;
        Fri, 04 Feb 2022 10:56:22 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h3sm3069688pfo.66.2022.02.04.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:56:21 -0800 (PST)
Date:   Fri, 04 Feb 2022 10:56:21 -0800 (PST)
X-Google-Original-Date: Fri, 04 Feb 2022 10:46:13 PST (-0800)
Subject:     Re: [PATCH 0/4] Refactor the PRCI driver to reduce the complexity
In-Reply-To: <cover.1642582832.git.zong.li@sifive.com>
CC:     mturquette@baylibre.com, sboyd@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-ffd770d4-8f8a-417a-a589-f14d09f55282@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 01:28:37 PST (-0800), zong.li@sifive.com wrote:
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

IIUC these there aren't bisectable: the bindings change will break 
builds of the DTs and drivers.  I'm not sure what's generally the way to 
go with these, but I always try to avoid broken builds in the middle of 
patch sets.

Aside from that this generally looks good to me, but the DT and clock 
folks are probably a better bet for a proper review here.  Happy to take 
this through the RISC-V tree, but IMO it's a better candidate for the 
clock tree so

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # aside from breaking bisect

Thanks!

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
