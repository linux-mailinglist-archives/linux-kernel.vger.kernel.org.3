Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB85A1912
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiHYSvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiHYSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:51:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B2B0896
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:51:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33da75a471cso89679847b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=UaweP+hutoQUCrkWUYrkD+ciXP7WXgYs/dDq7y/nMqY=;
        b=RsCXT18g9rB4L6xdxOFuMmvdk3RedLQEKhf6SHh/O5yoemRRhp8mu8g4um1BhlHHWP
         XHs1/fCTCkqzMABIK1+LaKhWpLTH+NISFBrG2Pam3kumPnNsw0Jb08r1C2GLurK+7xR3
         Dw4DnUuNOlMsJBNXK4WUZRBsZKsqLPKfAkc+QKv44409bL+ATMWPUIK1GYnjJhW6wRFn
         sZNRWTExWa4hknKPzCesdVwzKz05pv7+hK6Mcl2rFa6q1GVLc9oko8BfZCLqUfC0POk2
         KYk7oCbTvcWJu/IxZlQCppiISlqauiJa+88ftnOPeNW/0zGFQb4GhDlY0XD/XOKBOP/A
         xp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=UaweP+hutoQUCrkWUYrkD+ciXP7WXgYs/dDq7y/nMqY=;
        b=frjjxjHBALETa9wbRPO5lfybz2v3qg9eGsyQD5JFEzWuc2Cbh5zdcjxsuoEkbhF3ow
         20Lm7X8I3Y1E6NhLh778JqRXKR4E/EPImDcgGM1/V+bNNmxqJPw8eKpjAm09Ag0IrGo9
         V+m04DfYhdG5Bec64H77GMmsSZCztotDXPpoGfkrob6Lq30EU6qRrCwds4uUPYxJ+8rd
         NS9NEb08xT871QqZmGL7G1JdhR/mgozEe9WwIsAPYFnBjZfgE5eTD9V+kTIKPJtun475
         YAAFeJAHPiW+bzKqGvy25lG099pA19StSENAApu2SXfVoHTAqS6+6KBkACvXDoLUDc0E
         vDRw==
X-Gm-Message-State: ACgBeo04mA1TqZ2fkn10J8aMHdqUrD7Wjjw2nHKpQJy2PQPICnLMcxRC
        YNbm5F9F7qwwz4IUpfV014w9zuJ+GZkGwhiHiOU=
X-Google-Smtp-Source: AA6agR4sOROMVTV/Pp5patOHyT6WPfqLKXz727gAhzJqf+pPwy4Afq6jTbJSFMbkOz8oYn/6g8Bv3lRvo1FTFgq+MII=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a25:d9d8:0:b0:695:58d5:e7f6 with SMTP
 id q207-20020a25d9d8000000b0069558d5e7f6mr4269117ybg.101.1661453460634; Thu,
 25 Aug 2022 11:51:00 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:50:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825185026.3816331-1-willmcvicker@google.com>
Subject: [PATCH v5 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
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
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

I have updated the second patch to first try allocating the DMA buffer
with a 32-bit mask. If that fails and the host supports a 64-bit msi_msg
buffer, then the driver will retry the allocation with a 64-bit DMA mask.

I rebased the series and tested with a Pixel 6 on 6.0-rc1
(android-mainline) and a db845c with 5.15. Thanks for the reviews!

Regards,
Will

Will McVicker (2):
  PCI: dwc: Drop dependency on ZONE_DMA32
  PCI: dwc: Add support for 64-bit MSI target address

v5:
 * Updated patch 2/2 to first try with a 32-bit DMA mask. On failure,
   retry with a 64-bit mask if supported.

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

 .../pci/controller/dwc/pcie-designware-host.c | 54 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c  |  8 +++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2.672.g94769d06f0-goog

