Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BA5A1D64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiHYXyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbiHYXyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:54:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A2C59E4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:54:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k62-20020a638441000000b0042b66a99b6aso927575pgd.18
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=Iz+Fc3AXb8dLZ4mX3Mgbx3efWp93wo58I27EBlqSLxo=;
        b=T4+VXUmx1xdJxgSBWRyLx2UnPcil+44wnJP2E/zsfDwLP5Ilsrcjtp/NZ9abuKxm5G
         G47IGaf3NQn/fSBDMjdFkBsV8vcGBAD9GF1W94A8nXn+MGGtGuwe7MtAHcqXj2H957GZ
         WycLes5UWv3Idezjs64bo9cmzq/sxvtWwKPVTPcI2yiDaWMlc361CJrIglCIHLGupwQA
         PKa6VqMo0qX1LxzpjT3EnwPd8Em+E2RvwE3T4PxLERsGioDXRISg3jks8BzCt5EHnYf5
         IhOskMj+IuzdZf754L6aYKWEYP57nSa7KAWvSY7zo7N5ervmfCg2aNbJxlV/9d7h/37D
         OVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=Iz+Fc3AXb8dLZ4mX3Mgbx3efWp93wo58I27EBlqSLxo=;
        b=dAMR5tggn+CPVsubOb/WtjIWNmqvD3O5EQJBYKIGDhuiuQi4CPVP/ehjaGn+SEz9gX
         Ml8yoxjXfXGYC+c8ZAs3KmAZyjtPQPWiiPrEYmKDn0cU4lJMys1bZ4+wgFzCD0UMDTHl
         7Vx7X0NGhMuZqD2hBlrQalKYLhRYcfP32o6t6z8RO5d/cTfqmgZAgiqhY9VeDfSgJk9z
         gb5GNwE0y/NlE+FljAL6lg7ZYUDK2RR47oTOUqq/Z9inP0DXvY6u3cf51wYXFNfeoQ6j
         +PJG48NlOct8eu7DWTVRruYPPY04jSjZ1FvnTOY0VOwhgF5Z6oWavwj631sKd+qzqFKT
         V5HA==
X-Gm-Message-State: ACgBeo2Fc5C2ZI+LzuWiBDhuXtn/OaP3HN+towtQrxWkmixLadToga/S
        7a0ylMcQmyNNdI4wd/qA0LX1EhDvs8o6kx55RAw=
X-Google-Smtp-Source: AA6agR4XW1up7g6vcQ5pspby6TOQetmMBtqIH4cL6KO7i9zeE0uIlRdZusdeSi4RTg0vlkmIyX2xAHVuePdT+3gtl5c=
X-Received: from wmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ebe])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:ce12:b0:172:dc6e:18f6 with
 SMTP id k18-20020a170902ce1200b00172dc6e18f6mr1394260plg.34.1661471647366;
 Thu, 25 Aug 2022 16:54:07 -0700 (PDT)
Date:   Thu, 25 Aug 2022 23:54:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825235404.4132818-1-willmcvicker@google.com>
Subject: [PATCH v6 0/2] PCI: dwc: Add support for 64-bit MSI target addresses
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

I've update patch 2/2 to address Robin's suggestions. This includes:

 * Dropping the while-loop for retrying with a 64-bit mask in favor of
   retrying within the error if-statement. 
 * Using an int for the DMA mask instead of a bool and ternary operation.

Thanks again for the reviews and sorry for the extra revision today!
Hopefully this is the last one :) If not, I'd be fine to submit patch 1/2
without 2/2 to avoid resending patch 1/2 for future revisions of patch 2/2
(unless I don't need to do that anyway).

Thanks,
Will

Will McVicker (2):
  PCI: dwc: Drop dependency on ZONE_DMA32

v6:
 * Retrying DMA allocation with 64-bit mask within the error if-statement. 
 * Use an int for the DMA mask instead of a bool and ternary operation.

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
 PCI: dwc: Add support for 64-bit MSI target address

 .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 30 insertions(+), 23 deletions(-)


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2.672.g94769d06f0-goog

