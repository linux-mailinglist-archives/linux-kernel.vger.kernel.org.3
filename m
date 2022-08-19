Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4C599DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349625AbiHSOuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349621AbiHSOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:50:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69831EEC6A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:50:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo7742203pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=w3d+3YhZ/r7ChwcKNWsYqhB84K9Ro3O4Ausk/FNYHKM=;
        b=DngatJNk+TxbfhHfZBaeRNYYA7ZTT0AblMXDYjq2quy9YriJzZb4s3KkNdUEgDe06H
         4sJvIoD04525v1sG+ua5AeZAPYxegm4l4M4HzwUPskBCSDhDG6CDXqAXo2ZfXaN0C1aU
         PSnSooVznAAtccH3dU+W2AQetFhxBKDZdCmHgFipWv0QYVRw/NvPoTGiQAGAgOisWElU
         Nd7Eo4xdxLp9wYG8bDMUncxKnGzHnYvZeU5D93CdaMx7Hfv0n1TAaRQ1hSYJC4YN3cZE
         Kt0xmyPJvwFLUwAgmvatNJitSvBKdzsdltaofQLt4cHq1tQTt5gfEYMADy5kqJtdCOtI
         coDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=w3d+3YhZ/r7ChwcKNWsYqhB84K9Ro3O4Ausk/FNYHKM=;
        b=Vm84e0mKjOqGEtwC9wxQ/+Pr8nK7+M8inPbsIUHvJfYccon3vxqlOfSBEFVZ6AfIXs
         L5NnAXbzytJqAUlT9Ivwq4eFzVaOeKf+vy4keeRw/Oc49NAS5HECEDC0i2GJiIMv+5Wd
         FUNIR6af+JC2u79vg+T8HCdTWVQKEP1s9BoHktpUmi/d4tq1ay+G9uA12Tbv08l+xH47
         ci7VVNc/WJf1YxYjC2MCscKiSwZu+z5K8oL/lXtQTqjJMKM2u3lbDUbBa4NVzHWWEJra
         0SYON4fNAEt0MHj0/Udj18Ut3NGz1do4U93Tj4FTEj8YW//8rnSGpo2qVjmpCk/exSVE
         Tprw==
X-Gm-Message-State: ACgBeo3NktrNMXlPZNJ29m9b3uysVKkrK+FDMcCa1gC+zLEr+cNffSJ/
        Rn6tN8H9e8mbZbUpl0yMqvva
X-Google-Smtp-Source: AA6agR5+ZfhQ5pgolJX1p5Pz1LzGs6GVil1VIDXcfVsKXuJHpsxUOoOxrusEPQiji3+rgycCO5KyOA==
X-Received: by 2002:a17:90b:1a81:b0:1f4:f9ff:9028 with SMTP id ng1-20020a17090b1a8100b001f4f9ff9028mr15017906pjb.44.1660920628416;
        Fri, 19 Aug 2022 07:50:28 -0700 (PDT)
Received: from localhost.localdomain ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id x24-20020a17090a789800b001f312e7665asm3268380pjk.47.2022.08.19.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:50:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] pci_endpoint_test: Fix the return value of IOCTLs
Date:   Fri, 19 Aug 2022 20:20:13 +0530
Message-Id: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the review of a patch for pci_endpoint_test driver [1], Greg spotted
the wrong usage of the return value of IOCTLs in the driver. This series
fixes that by returning 0 for success and negative error code for failure.
Relevant change is also made to the userspace tool and the Documentation.

Along with those, there are couple more patches fixing other small issues
I noted.

NOTE: I have just compile tested this series. So it'd be good if someone
can test it on the PCI endpoint setup.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220816100617.90720-1-mie@igel.co.jp/

Manivannan Sadhasivam (5):
  misc: pci_endpoint_test: Remove unnecessary WARN_ON
  misc: pci_endpoint_test: Fix the return value of IOCTL
  tools: PCI: Fix parsing the return value of IOCTLs
  tools: PCI: Fix memory leak
  Documentation: PCI: endpoint: Use the correct return value of
    pcitest.sh

 Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++++++--------
 drivers/misc/pci_endpoint_test.c              | 167 ++++++++----------
 tools/pci/pcitest.c                           |  48 ++---
 3 files changed, 179 insertions(+), 188 deletions(-)

-- 
2.25.1

