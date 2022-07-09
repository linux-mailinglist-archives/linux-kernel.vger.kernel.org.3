Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674E56CB80
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGIVQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIVQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0BFB1FF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:16:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y18so1526421plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+pbbkuTfdK3RD+xw+jDI7D4rUYNVSIOak1x3V2zW8Y=;
        b=aICdV93jXxwJmbvGcHBbHwGyDRdI7NX1U4p9MYRjoL3DEX8cOykCUhtw31eWwfHRjB
         BovmjJaS29bmvBExHQuyfAyTiZjCrsjR4FlUqISc8W1OKwKSVMRIC9hKJEc0md+/hSCc
         zqiiQ8mbWq59/LoveRtGbmTHgiuwgtoxZuWJG4rb6F2mFdIQbUdFtUMSHMqXc+teUAcr
         RUmVOYgk++PUDVwWeS1zgiMI6w05paWtLPkHFir064I4rbtHZvzi1VzPklkyoasXGWGl
         i7Z6GZKVGzcNq9e1x4Z+RF0LEWCdG/rbWspDokcSK1zUStGPE3AxyasMlwDyi6ALRlNH
         sYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+pbbkuTfdK3RD+xw+jDI7D4rUYNVSIOak1x3V2zW8Y=;
        b=I19KbQ1whQTnhPOffkZABSCMOjv4HiQtowqjYU/vJSsyklwZbA3vYP46VkQFaxgsfh
         LFzYD4Dv3e+Kz+IbMvhDqb6mIdD/Qg9n2DjnEbtsLQirWACBnEHxuyIbqxV778RO3630
         qZHa1YFqbr3uxB3pHVDZ9PKGOMMF8ILyfnXQKhLqTc8DMvKpWtN9TukTRMcqE5oqTZCX
         xAL3021wgRQ8JMVqwlMh/jFphpYA0uHQ7XwOJ7x0ruPz1ZKNDIUX1tfWCim5pCzuvjXM
         eLCdQRuqCcGnZTsTt1jZxNYBs9wgnlEE+vr7kkZCq4PrVxD2oBdTObuv0W2qZnomi/ud
         0XqQ==
X-Gm-Message-State: AJIora93zYv1NCPRDQ3zzbYsaKZOCFyUGiWUfhescmkJ5XzPIQYFSUVI
        W5Dh0PkfYmJVi7/YLHK9THZj4amLHfM=
X-Google-Smtp-Source: AGRyM1vY3LIMJkl3C67NFy0C5/Bk1O6eH26Rb3zoV4lXG3RQL8jGzj12n0y8C/t1/bHY+4m7wb+UWw==
X-Received: by 2002:a17:902:dac2:b0:16c:6a1:692c with SMTP id q2-20020a170902dac200b0016c06a1692cmr10180535plx.19.1657401377063;
        Sat, 09 Jul 2022 14:16:17 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id a8-20020a621a08000000b00528e84c3093sm1952354pfa.143.2022.07.09.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 14:16:16 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] OpenRISC support for virt platform with PCI
Date:   Sun, 10 Jul 2022 06:15:47 +0900
Message-Id: <20220709211549.1163327-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a set of kernel patches which I have been using to support the new QEMU
virt platform [1].  The virt platform supports PCI hence I have a patch here to
add PCI support to OpenRISC.

A defconfig is also included which turns on drivers supported devices include
virt network cards and the goldfish RTC.

[1] https://github.com/stffrdhrn/qemu/tree/or1k-virt-2

Stafford Horne (2):
  openrisc: Add pci bus support
  openrisc: Add virt defconfig

 arch/openrisc/Kconfig                |   7 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   4 +-
 arch/openrisc/include/asm/pci.h      |  36 +++++++++
 5 files changed, 151 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig
 create mode 100644 arch/openrisc/include/asm/pci.h

-- 
2.36.1

