Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2014F40EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354639AbiDEU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbiDENEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:04:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA6511F793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:06:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d3so8154340wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z46lGhLfI6ugeu1P3zjJF0oXFB21fasaHhYIlRjoeMU=;
        b=c/SA4frMQAMHJXuDb0VyOfv2BeFzsflHSheqcsZper5NrOSCQcDkjHGkxYhD4uNF1C
         I+Xyo11kF6QE1iNzQI+lBBNtJBJlEw/7qjhL9zW8sCmr6cjvigCUy4IPjhJCB5vSpU94
         9dfv3K/TYdm865KWJVTxotArxbpGIJW+TdPaCTIMUmJW1PQAD6LS4ywWbwzBHQ7eeKu+
         +jmxW9ZK/GZp36hKFxCgGgwc1Qsp6IIjZTNUulESiraVoRjdGe8BJ2ZPyEN0UqrFAEND
         G/xGtqqj7CdZj9tqiScMA7VXvzoLTSrcZ3FGc/BH8vD8+90EyfHcd31cemhdem4NlzJt
         Grug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z46lGhLfI6ugeu1P3zjJF0oXFB21fasaHhYIlRjoeMU=;
        b=IuuAqhyNpfBlFQS/NsaDdEWJEx3wtxpfAyNMnlJ0CpP4kt333aWBKO4tVZppsie2nb
         /NVF8T9sBRvDKNg5EQ4Aj5ciVQWsQLN6Bd12VCJSyrL4FWR/rHxLpQUxW08rJ9Cba39I
         tC+zRzZejSyssW/1Q1oDx1I/MJCh2mtVWaNsm8tqR5ymJ8BcrwepcjfT9+JXX8KPXMdE
         RnputksrxAuDAyLdNa+t4plB7PnMV9dn33SZA6kXBKTPueh8LLO/jWi68DYpTxgE6m51
         X7l4chCbqauIHONJGp0siZc2iO0Ech4ESjYlcwF836dfDsFtcIKfZ+9IAolyJQve9XIh
         +rZg==
X-Gm-Message-State: AOAM533TBrT9S9vSZtZAyfX3uZYmSdgUdQZ00m6l7fSYebXsPN95EpFu
        kQmqLo2gPTiIs9rjSbYTHz4S1w==
X-Google-Smtp-Source: ABdhPJyqTOFEOFeAFt/2YcX1+9+RtfO1i6wtivOXlQ7O002sz/pWInKXqVkJNxQ9hZqMYs1r9BBdQQ==
X-Received: by 2002:adf:8066:0:b0:206:1563:8b2b with SMTP id 93-20020adf8066000000b0020615638b2bmr2518784wrk.582.1649160385937;
        Tue, 05 Apr 2022 05:06:25 -0700 (PDT)
Received: from fedora.lab.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r16-20020a7bc090000000b0038e73023334sm1994323wmh.2.2022.04.05.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:06:25 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v7 0/3] Add support for Maxim MAX735x/MAX736x variants
Date:   Tue,  5 Apr 2022 14:05:48 +0200
Message-Id: <20220405120552.433415-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.35.1
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

v7:
- Reworked the commit message, comments and renamed a struct
  field. No functional change.

v6:
- Fix typo in dt-bindings

v5:
- Remove optional and make vdd-supply mandatory

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

 .../bindings/i2c/i2c-mux-pca954x.yaml         |  44 ++++--
 drivers/i2c/muxes/Kconfig                     |   4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 126 ++++++++++++++++--
 3 files changed, 153 insertions(+), 21 deletions(-)

-- 
2.34.1

