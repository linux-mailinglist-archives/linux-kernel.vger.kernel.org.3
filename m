Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C1D4AB7B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351732AbiBGJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiBGJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:29:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C1C0401C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:28:59 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s7so1978699edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLK2lp6TV74+ddpLQXtHe3jOczUqIhg5KCOPYjiimz0=;
        b=W0nozGTs3WBmNHCv6hIDWxLGpDVfJILMUf2O7Q/U9PCKWMULtz2UcOLfcz//u2iceU
         IoObxtwzO/To7yeAbTWa6r8Oi4yd7dHk8MwrAekAhX17xjmKepV9K4vOWiwoTm1TmVD0
         eEGXAxCDM9LwgwWfUk+Fbuo7247yBhiHhW1/NgAwsRoprLDT6329unNOAaU8eYA4J1SA
         ZvRkaqThsWYRMYFI2GRgQWRUHSeNQhUpdcoeXnRjmwmB6RefMjXwCJ0v5eux2BLm4Izq
         e1b5OzXD76KGfSAdNASTO0nj+ilzpOsA6hGPS7Do+nWGs+FzATKtEetdHV6CN8KnjXrV
         OIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLK2lp6TV74+ddpLQXtHe3jOczUqIhg5KCOPYjiimz0=;
        b=j+i0+peWMrOvPqm3EHidno3l6RnI4EKRKHJ6orGE1rYUjMhRyw6pwq3lEGXLcQ/JoA
         A4beYV6H8tfWmYwS+g1vxTNd2iZWC9N8ZMYOk3CeZ1et8bKqAbUjdk1ZmUxfX/Wy81ro
         12p+inLPb6NnD1yhVsWcqODw0/NZjf1bU2i0jprdh+kDi1itO4P7t9VIYGFZAxpvc+Eq
         FT20Xhgl3vxjE+Np+gu3JmZPBiyj/1vJw/SXEE397csTVpWGPhf9PrpbeAUlTl0vqIDR
         r9dIHLwslvuP/I4EBCVSLDFlNQ7zzDNqlNOD+rg6TQaKNkUjy7gNVWIit2wGINLwd+ik
         kpmA==
X-Gm-Message-State: AOAM532xukkv6bn49T2Ag2xJvg5U3esxhHdD8//5h4Bb9i2Do10Z1ejS
        C95QMOeTq3TWc1N4YhMaEQpH3g==
X-Google-Smtp-Source: ABdhPJzq7Tl8lnhKa+CHP0KNKxJ+ynu8aSyKQT7YIPwHg7TUfcTAIjzGO4fZEHCM2sksJn/flRHBUQ==
X-Received: by 2002:a05:6402:38e:: with SMTP id o14mr9121850edv.414.1644226137585;
        Mon, 07 Feb 2022 01:28:57 -0800 (PST)
Received: from fedora.. (ip-088-153-139-166.um27.pools.vodafone-ip.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id g9sm3487059ejm.152.2022.02.07.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:28:57 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org
Subject: [v4 0/3] Add support for Maxim MAX735x/MAX736x variants
Date:   Mon,  7 Feb 2022 10:28:23 +0100
Message-Id: <20220207092827.104978-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Add missing maxitems dt-bindings property

v3:
- Merge dt-bindings into i2c-mux-pca954x.yaml

v2:
- Move dt-bindings to separate file
- Added support for MAX736x as they are very similar
- Fixed an issue found by kernel test robot
- Dropped max735x property and custom IRQ check
- Added MAX7357 config register defines instead of magic values
- Renamed vcc-supply to vdd-supply

Patrick Rudolph (3):
  dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
  i2c: muxes: pca954x: Add MAX735x/MAX736x support
  i2c: muxes: pca954x: Add regulator support

 .../bindings/i2c/i2c-mux-pca954x.yaml         |  44 +++++--
 drivers/i2c/muxes/Kconfig                     |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 124 ++++++++++++++++--
 3 files changed, 151 insertions(+), 21 deletions(-)

-- 
2.34.1

