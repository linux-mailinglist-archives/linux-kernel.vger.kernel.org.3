Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D14C46E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiBYNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiBYNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:51:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291631DA440
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:50:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d3so4671826wrf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VkNCX+lIAf7Yd75ITkXB1i7sYuA9EWWkYAIfdUFPMio=;
        b=PLOhf6DTDfANHg1DrFIbOCgA2YIKq5CmFD9eWLd3Zvx9JKuNevzFbEIOzCXTvnxKc8
         Yq0itCHLyrATx+oYWbzRCvhkkNz/y2ke28gqsvJxjLYvsltiAXaje0TnoXYbyQvZc2/T
         hujYboNeTUKh50rugo5jE8OA1HdMmFuHIQkgwD1e8iFZG4hA7OgrKabYCZ2HbHmTxqaL
         RxkjxvLmhvzhDYvJh81+pTFN1fwOei3UyIsC05IvM36v4OfhMwmwey6yEeBVjYTofAy7
         2jTb45dMHyXPmTnR8uraKnO5y6o3jy0Gnl4TWCJ0gypeYzKEaytXx+khXRfXVBlQd3p+
         SCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VkNCX+lIAf7Yd75ITkXB1i7sYuA9EWWkYAIfdUFPMio=;
        b=DQpbXiH7NpjL2EQNsJio0JDK71hg3FiZLWipcvAn/+LS5tQk8LkPiqrH1ZZ0oCKWCq
         H8eRgGOBoGLzpGiikl+sMDiarhAsFw2q39RcMKB2P0TxLFVoEBvcnhHvVHphub/WUCch
         3jGOSw7XC6F6PZil8gCItq2r5fi0etbHHXtiAAVqPU1NVM0OuKSI34t/kkYgSa2+Tgcw
         KECOb7I2ySAu5uuwi/2mZvW/ZKOtUMYV7pK3fi9vLPsm0EOp7ZG+jtOedlxpyKysOAG+
         z6Iqi2MSbLwSnGlnRksiIZAv+YBftx5RWlfVA5hgfj+XyzhAVVP3ib2Qszz+ieJXbujg
         pyYg==
X-Gm-Message-State: AOAM530xSsyTqwpRsHtmmztNNiZHoCR6IpjCx0c2VLlEMDZFhCyN1hrG
        B5A5kA3IFzw9ahJ8icQTJ4KkFnh6Km1itw==
X-Google-Smtp-Source: ABdhPJzyaZ4XaDW6SSc/elFUIccxixDAYELf3UPMmPM7MA0yvu6nYV6CtDCQOhNmsIJ0WVqSf5FZNQ==
X-Received: by 2002:adf:e54e:0:b0:1ea:9746:16d5 with SMTP id z14-20020adfe54e000000b001ea974616d5mr6218619wrm.186.1645797027448;
        Fri, 25 Feb 2022 05:50:27 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c420100b003811fb95734sm3295346wmh.37.2022.02.25.05.50.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Feb 2022 05:50:26 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/1] microblaze: Fix issues with freestanding
Date:   Fri, 25 Feb 2022 14:50:24 +0100
Message-Id: <cover.1645797022.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with GCC 10 there is issue with simple memset implementation which is
called recursively. There are couple of discussions about it and the first
two patches are trying to workaround this.
The third patch only removes simple implementations from arch code and use
generic one which is the same.

Thanks,
Michal


Michal Simek (1):
  microblaze: Use simple memmove/memcpy implementation from lib/string.c

 arch/microblaze/include/asm/string.h |  2 +-
 arch/microblaze/lib/memcpy.c         | 18 ++---------------
 arch/microblaze/lib/memmove.c        | 29 ++--------------------------
 3 files changed, 5 insertions(+), 44 deletions(-)

-- 
2.35.1

