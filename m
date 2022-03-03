Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438264CC94C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiCCWoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiCCWoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:44:04 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFB53E2F;
        Thu,  3 Mar 2022 14:43:18 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so7431581oot.11;
        Thu, 03 Mar 2022 14:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqiHr78s5ozF+E5CUQRyZ+iLHOGbS9Kn7Eb/AnKDbaU=;
        b=NDUR6V5whWK14mr3IxmNaA2FAYXQcbJTng45ERetqzQCUcBqe1pg/VU4vyx5gpDcPM
         K9Hwk6lSwN12KHwJpBDWBykPCdW15hsCX/otuFXs94LHQW2ICwdZ7vrUkp3BtDxdbwav
         s+MLBYtB47il6q0XbIowe7Ey4kIewan9/B/Q9bONYFQ4qZg9idJVhPddcuiMDp0sUGGg
         RkdKgFmCy3pndXsG7EjJNXuepArOUY8NZUzTi/eVaDBs7WHd3xFVy+wC0uV+VHPZ9E++
         F2O4yGxUZjv6mMJNHH+E9vKQN9M0TEZiY9SBeDb+a/Z2ntFExqGtiiR0FU39g4K8dCU1
         BC3g==
X-Gm-Message-State: AOAM532PfRTJLX61XUVIJO9/3gDGXwHvRsvi+LhlcpJAig22YvuEuYB2
        9ZVDlbFqhM177RCWCYnQhvxRRXRnbA==
X-Google-Smtp-Source: ABdhPJyEsMoSbHUfS5m5wluWc3+LO7RXPfW2DBN5+7zArXmzP0W1i+CjzCt36laMpFlX7kgc2K1mxw==
X-Received: by 2002:a05:6870:c987:b0:d7:3d45:6692 with SMTP id hi7-20020a056870c98700b000d73d456692mr5732970oab.34.1646347397317;
        Thu, 03 Mar 2022 14:43:17 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x10-20020a4a2a4a000000b0031bf0818df1sm1608480oox.4.2022.03.03.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:43:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] dt-bindings: DTB based validation
Date:   Thu,  3 Mar 2022 16:42:35 -0600
Message-Id: <20220303224237.2497570-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series switches the kernel's DT schema validation from YAML encoded
DT files to using DTB files directly. See patch 2 for the full reasoning
of why. The diffstat also shows this is a nice simplification (at least 
from the kernel side). Patch 1 is further reworking of how 
DT_SCHEMA_FILES works and builds on [1].

Overall, the build time is about the same (still slow) though we do save 
a dtc call for dtbs_check. Extracting the type information is not cached 
in any way, so there's some opportunity for a slight optimization there. 

Switching to DTB validation found various issues in the bindings and 
examples. Patches for those issues have already been posted and applied 
over the last month or so.

Rob

[1] https://lore.kernel.org/all/20220228201006.1484903-1-robh@kernel.org/

Rob Herring (2):
  dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
  dt-bindings: kbuild: Use DTB files for validation

 Documentation/devicetree/bindings/Makefile    | 35 ++++---------------
 .../devicetree/bindings/writing-schema.rst    | 12 -------
 scripts/Makefile.lib                          | 23 +++++-------
 scripts/dtc/Makefile                          | 13 -------
 scripts/dtc/update-dtc-source.sh              |  2 +-
 5 files changed, 15 insertions(+), 70 deletions(-)

-- 
2.32.0

