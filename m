Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F954F77C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382148AbiFQM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiFQM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:27:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2943B18397;
        Fri, 17 Jun 2022 05:27:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s12so8496271ejx.3;
        Fri, 17 Jun 2022 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDDq9mHhyyDJANgBiJC1PD/32/vKz/kB8FNf6uAGUXI=;
        b=OmgmkAxCQCl/VTS5QiF7IoSfgPpsxMrkgxQQQkBfOCVCf+dBQ/1zggshNXg6vWteje
         fAyfPn9avdQ1XWu9c4dSr2QfQmTh+2hThw939cvEPdZ6O001wPKxnCxwV6f50Ntttvqo
         LyTkmawArzVakNRK7OCoHG4u7umFJX9Gn9XK3fMiR4is/8+VgGzn7O7zlazi3AecIsKM
         R2fSMvrgBS9u0Cp2n+wTNqmFI/FdQYofxe7la5qQQ04a++i3/+3YnbYSkrO5qdyRTnCd
         IJDnGdZ9LcjiR1Lk0eCFA3jeaXsCqMbmScprc3qMQnMOCGh+voWFTpbMa9GaUWo2H0yY
         bOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDDq9mHhyyDJANgBiJC1PD/32/vKz/kB8FNf6uAGUXI=;
        b=DKrNa8KTswQSv00A+oCko9NFTakiVYVNIv3QmGlfHZ/lGRS9i0cAVEmfqSKwgdtxpe
         fOOg5LyZ679A6sOtb75g6S7LOI027tH9riGSfqbbECXQYZlwBNiZSoe1ksQtNF7PJukI
         X/l1lC/mfVw4kJ7lirqWt3Du5FRI3fNCle3tU6aiOg6F5yCGO9rvI0VqLjSFuTMTrDU8
         kHjjbGUPkvZyucDjNhvrhMHobznE1BGma05CMT5vr3HBZ55f+tfNqes33TJ3BSnx0ggY
         YYlrk+Hz3iqObYb0RDYHS+GKEAUIJazDP2t+g7oHRu2ASQCwcZsbDrBdK2FZjgjX9rWN
         DQAw==
X-Gm-Message-State: AJIora+Pav9E7Q4ywwrQiUL7bHzMrsUsznwu+gQeLHz905IXGar/6pjp
        o/QdCPo9ImoGXnQNqe/N/QI=
X-Google-Smtp-Source: AGRyM1ua01kP5imXEyaVMetInj1S4e0MyZpfCj1SS9bmd2k/WBx/teUeSkfRSE0pMDK/1zboMCbBNQ==
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id e8-20020a17090658c800b006fe91d518d2mr8865592ejs.190.1655468876724;
        Fri, 17 Jun 2022 05:27:56 -0700 (PDT)
Received: from localhost (92.40.168.194.threembb.co.uk. [92.40.168.194])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906248b00b0070f8590ee8fsm2098138ejb.159.2022.06.17.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:27:56 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, paul@crapouillou.net
Cc:     maz@kernel.org, andy.shevchenko@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] pinctrl: ingenic: Convert to immutable irq chip
Date:   Fri, 17 Jun 2022 13:28:53 +0100
Message-Id: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two cleanup patches for pinctrl-ingenic.

v2:
* Add print_chip callback to avoid changing /proc/interrupts output
* Add patch to use irqd_to_hwirq()

Aidan MacDonald (2):
  pinctrl: ingenic: Use irqd_to_hwirq()
  pinctrl: ingenic: Convert to immutable irq chip

 drivers/pinctrl/pinctrl-ingenic.c | 64 +++++++++++++++++++------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
2.35.1

