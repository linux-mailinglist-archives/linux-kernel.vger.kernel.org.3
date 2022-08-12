Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17859096D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiHLADn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 20:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHLADl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 20:03:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867839D8FC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 17:03:39 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m12-20020a170902db0c00b0016f89376ad3so12115329plx.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=NjDM8JLM74YS1NI+sefOO7qbdLfxup7nyPkDPlwTFEQ=;
        b=gwNOp7+iOFiJp8c6mY0PEoMT01QxrdtE2gYNKN5/hXlz0gW40jYcKCcC8slvXX7umA
         WHuDF4+3W7sNbldeGy8EOBg+lURhF6STgh/ELrwPy6Poa4M9RDWJiTFzCwWnm+YA21WE
         KPoTR9eAgfCOA6mxttFAqgb9fVHcVgpMNrExmVJQBf8YNLxRyECvnx1gzC86Y12LqZnl
         wa502iNJHE5YOIzTglS96NVWXdnWvUXBET64nWSX7/g1xGgU7chBO8cxJwb9OKmulokK
         54zfLbM1XbbO2w1znzsC+SK/22OAjQAyGGjdeXeoKB6J0nT5ySl2BXXs80+Cel2WL/ok
         5l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=NjDM8JLM74YS1NI+sefOO7qbdLfxup7nyPkDPlwTFEQ=;
        b=j8/LP3ClqX6svR3ElP1QJr7C7ekLPliPefrIUIe/yA+IxPvRtdIoi9sZ/ewTltKNcK
         YbTHYJdC7wAAYSDY19m2zROv3vLcOl3O2n6kXQ8a4xoLEHMA8TI8HyI29E6pvY4crOsW
         5Ty8Trpj6gd7ciAXMxdjEQy8tp8xyYh86Lg9OquEGUaOty6tbz9d3ztZMVpJH16T95wb
         0/os8nhGTclAFjj81rS5+26+LBM7aIj5OyfEDYbSM13a1VrJCq/gPErnuV6vXmaaWRJ7
         P23MXID4wPON6U2oSWO2BvpKM2VSa+gHBBs/9NO7Ep3hrZeh/EOBqQA/XhTiTjD380BZ
         WN9Q==
X-Gm-Message-State: ACgBeo0szh4jNBUvHnLpDEo1tNlxA4ug8ysH73wBnN9uj/yix4Q6lccm
        IPDcDBWEEbgdGJb0x3B1wNq28JMPAt/05Pz/8Gw=
X-Google-Smtp-Source: AA6agR44n5f5uOUpCBLHPQ2Ufh5YI3Q4OSyRaNmFb4BMKpLrDG+6+Kxx8nX+TwPpiA0tZPJumjiQ1Mj/Bq0sUoLVnxU=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:d584:b0:170:8ebf:2048 with
 SMTP id k4-20020a170902d58400b001708ebf2048mr1590630plh.113.1660262619041;
 Thu, 11 Aug 2022 17:03:39 -0700 (PDT)
Date:   Fri, 12 Aug 2022 00:03:24 +0000
Message-Id: <20220812000327.3154251-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
From:   Will McVicker <willmcvicker@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will McVicker <willmcvicker@google.com>
Cc:     kernel-team@android.com, Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've updated the series to address the review comments. Refer to the v4
history below for the changes. Please take a look and thanks again for the
reviews!

Regards,
Will

Will McVicker (2):
  PCI: dwc: Drop dependency on ZONE_DMA32
  PCI: dwc: Add support for 64-bit MSI target address

v4:
 * Updated commit descriptions.
 * Renamed msi_64b -> msi_64bit.
 * Dropped msi_64bit ternary use.
 * Dropped export of dw_pcie_msi_capabilities.

v3:
  * Switched to a managed DMA allocation.
  * Simplified the DMA allocation cleanup.
  * Dropped msi_page from struct dw_pcie_rp.
  * Allocating a u64 instead of a full page.

v2:
  * Fixed build error caught by kernel test robot
  * Fixed error handling reported by Isaac Manjarres

 .../pci/controller/dwc/pcie-designware-host.c | 42 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 28 insertions(+), 24 deletions(-)


base-commit: 2ae08b36c06ea8df73a79f6b80ff7964e006e9e3
-- 
2.37.1.559.g78731f0fdb-goog

