Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC6B57F824
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGYCIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGYCIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:08:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4757DFC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gq7so9073799pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDda38ftiWFRNttMhuRernVpZQXsqi8IpfSnZlurJxs=;
        b=Ls0KPy6b5ulxhqyz4+bCPKJLfsPZSAq5XO+gaHXaoZnT+2q7En9y4g22sE9avaZOva
         NbvkrzwOHu4YR9HdhmV8h9seB8lIwMxgqvLlsXkH6O3StuSER4wrFCVMiC1u8iC+3MqR
         Wm/jVw56POC/i6AoN6cgsXBjj6UTabx79zO5gOgsqFauLxJwr4+jugc1oV7ipxZ28su0
         ulchCPqImjpiaQzc5eaRe3S31MkPH5XnboG5m2C1dC5CerdXuUCjv6bRv3+HzRukr9x0
         Wyg8ryMdc/G8S8szaqnoI90J84soA14gt+zu5e746dmWxlBDIsveOMJV8lPSGGk6FimA
         /uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDda38ftiWFRNttMhuRernVpZQXsqi8IpfSnZlurJxs=;
        b=At4w06kNVEirC+GXMTpQvgYkhvUoVeCZrX+ZYj7pfFIq36ITlDfXJHlleDG3Hu19n5
         bm5lNMTNgRqifREkqjM3zdWh18eLGbvAGOfggmctvwm5LwZbiknLTij37tuANQDX7ews
         lBXN/b1bprWEPHKIvkL7cS/Nfnh2XGHCOQBDL9ArKCmTA1OS/oTn765wlrrmX9MvVFXm
         2UnAfUiQ1yWOm3+ZUxdbIcq2/Oh8RGCyQKBARzn3EAShN3RYbMPLHJQCAsIS6a7xzspf
         +drI4+KGBjHpxBTO+OTCGUW0PojA2yhK2L5+oIO+pXwxbI6xUTpiJkXw55gji0AcKlOa
         Fpbg==
X-Gm-Message-State: AJIora8azjEZ4qA63sgR+ty0xvzT4WlMgwjyy88t5WoeGM5zItiWBOUw
        +02/8P8QH1OPwF9VrjtR/bsg6SKGFl8=
X-Google-Smtp-Source: AGRyM1vKQJYdbed1AOzMzqIbywOcyIo8Ch2WVgpVKcj2quf0d1JB0i7ykVEZqhN69Ko/0y8vD2LonA==
X-Received: by 2002:a17:902:ce83:b0:16c:d47e:bd3f with SMTP id f3-20020a170902ce8300b0016cd47ebd3fmr10390705plg.57.1658714886955;
        Sun, 24 Jul 2022 19:08:06 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b12-20020aa7950c000000b0050dc7628178sm8101055pfp.82.2022.07.24.19.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 19:08:06 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH v3 0/3]  OpenRISC support for virt platform with PCI
Date:   Mon, 25 Jul 2022 11:07:34 +0900
Message-Id: <20220725020737.1221739-1-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

[1] https://github.com/stffrdhrn/qemu/tree/or1k-virt-3

Changes since v2:
 - This is based on the pci cleanup patches from
   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/header-cleanup-immutable
   so pci.h is removed.
 - Change comment about parport.h in patch 2/3.
 - Added a patch to define __pci_ioport_map as NULL when when IO ports
   are not supported.
Changes since v1:
 - Remove PIO support as suggest by Arnd

Stafford Horne (3):
  asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
  openrisc: Add pci bus support
  openrisc: Add virt defconfig

 arch/openrisc/Kconfig                |   5 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   2 +-
 include/asm-generic/pci_iomap.h      |   2 +
 5 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig

-- 
2.36.1

