Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A6959FF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiHXQVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiHXQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:21:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B237D72B6A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:20:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h24so21390964wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=S2tBbgrx+25RpWaqCl+haIdlbySiWC0Xb4SRnNTuZLo=;
        b=CaBBfJ6zzlzSH8t+T5KGfrvMzLAi5AI0eoDZAVk0yw3cSoKl5RoetN0lKoKeWRh6hP
         r5P8edcEbxW/Ad8FhnLpgrcKO9nzODroDxn0URodX5a9zfEmMBvyQNrmKmfKBYVQHrWN
         TOX3+urD81gS9Ih4cs9hl7+KIvMTFFBJQlmcNWfGci8wUyo2NUiyTmh4MCkSTbDEhalM
         ccAX+7RJgQlxRHJ90k2FI02f6/m0gmf3lK0EziSkKN8eoc85597K8AE4NAwEifpHvNgV
         APwCV35SmUdKYbIxqZ2tLbzCVxnjNZX4poPem4awdsY1nLjYErALPj0Bk98N1GnJdR3t
         cNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=S2tBbgrx+25RpWaqCl+haIdlbySiWC0Xb4SRnNTuZLo=;
        b=QPN2jYhXKbEoh0B+y72sh+2S11cgb0zdF0ocAJ5wIPeXXY+/o61rCmGUVllcodk8F+
         8Cu8A4aeXmTXZn7TzoY7LzpsUgifM5aLIBGm7Aegd6oME2E3c0zLHXSK4414t7b1uHKs
         eGr4emsLVsM+U6bdMUvThuzsVAF2TLskT+l2jTi9vs3sNbRLZMxqIicDpywv+/M+ia30
         napN+9VRYe4n8/zPRDOCK7Xk/+Dp58XqI6L6uY1kyX39Eacgt+zfcQZNXl6iFBpuxkKI
         sfpb+1geui46jukE4+ukyPJ+L9B65ENVoZ6Pt8mLdGuZK8bgKGS9qMNxyXkMiVuWP0jj
         5mRQ==
X-Gm-Message-State: ACgBeo2NDFy8szU8zLfjIhyeLT0TuZy9LDdot/MVNLtQKeYarTdK/DC6
        inBsB8xtKdqCOllG40axBOfrtw==
X-Google-Smtp-Source: AA6agR4/6nKKtxFMnoCc84DqrjQsVm+cjtB+x8R9A0ftf1MIYOg7bI7gO59Np7Of33NfYpXfhEp05Q==
X-Received: by 2002:a05:6000:221:b0:225:464d:b096 with SMTP id l1-20020a056000022100b00225464db096mr24122wrz.32.1661358058303;
        Wed, 24 Aug 2022 09:20:58 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a690f704absm1903582wmq.4.2022.08.24.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:20:57 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <mail@conchuod.ie>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/7] Fix RISC-V/PCI dt-schema issues with dt-schema v2022.08
Date:   Wed, 24 Aug 2022 17:19:44 +0100
Message-Id: <166135795510.3741278.5608627370699269871.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819231415.3860210-1-mail@conchuod.ie>
References: <20220819231415.3860210-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Sat, 20 Aug 2022 00:14:09 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey all,
> 
> Got a few fixes for PCI dt-bindings that I noticed after upgrading my
> dt-schema to v2022.08.
> 
> [...]

Applied to dt-fixes, RISC-V should be back to 0 warnings in the next
linux-next. Thanks!

[4/7] riscv: dts: microchip: mpfs: fix incorrect pcie child node name
      https://git.kernel.org/conor/c/3f67e6997603
[5/7] riscv: dts: microchip: mpfs: remove ti,fifo-depth property
      https://git.kernel.org/conor/c/72a05748cbd2
[6/7] riscv: dts: microchip: mpfs: remove bogus card-detect-delay
      https://git.kernel.org/conor/c/2b55915d27dc
[7/7] riscv: dts: microchip: mpfs: remove pci axi address translation property
      https://git.kernel.org/conor/c/e4009c5fa77b

Thanks,
Conor.
