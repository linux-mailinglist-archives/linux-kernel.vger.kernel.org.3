Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C25267BB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382222AbiEMQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381536AbiEMQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:59:46 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C84D15729
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:59:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y41so8161021pfw.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AgZWiDnfccUKA3OwEQAKus4Qo+rKb2hQK1i7GLxmw8=;
        b=CVYmgNe+9a+uCaaCVsW9H7CyjyFhEwNUa7ihbudBQHfG162jKe8sMPtnieG2d1QtxE
         l9vlBM1YtcicmqU6GjKySVfe+mPRtn0SCwtJLo+toUJqvs7j/D7iCrg9eHIsDleczjUH
         6aUG1WgB8ISEBE1nwN56kqY7Xqa4CdD3gbgUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AgZWiDnfccUKA3OwEQAKus4Qo+rKb2hQK1i7GLxmw8=;
        b=XbS1nh2NigaEhF7JS83IhkknD/ODn1I72UyYkeA8nZQTZLXYf0Un2Vt9RhfXAIUqkk
         slfBLenPzxUihsBSoIHvntfTXNogcQUmMRbg0JD5TpL2xt4URlVG+DC1yvG6PKbPAbfv
         aLduiztOAapLT1eC0c5LpUC4Tlp99hzFyC1Nn6PT/19eOTUn0QQrC8FusmArUOTiJ5KS
         2Xb3kxiZBccS2f5cfOuXDG9An/p0w92CQUe+GwOQtNmFwibPpdsKk68fJPqdhbamd57L
         E4CgvgEBYYzNTGSpdcegP8kyXtDC7BrJ80JdwxNK9HTInVTnKeAns/nnf4Kle/aMUmyV
         1zLw==
X-Gm-Message-State: AOAM532q4BojT9yDy0IZak9tZQJx+QpOolpe6RYbNLTV0WIgRZaByG39
        W72jdd8XBZCOeUI9t1svWZOeCA==
X-Google-Smtp-Source: ABdhPJzVWTA20vEKV9V4QJx2ATY9c+mQdG4XnARJDOapEYmFZYnd1atbSyOTCeenauGwT063N08BzQ==
X-Received: by 2002:a65:6e8b:0:b0:3ab:a3fb:e95a with SMTP id bm11-20020a656e8b000000b003aba3fbe95amr4713189pgb.433.1652461184707;
        Fri, 13 May 2022 09:59:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f334:6f80:82ed:5653])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a7f8100b001d97f7fca06sm1824548pjl.24.2022.05.13.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:59:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: Document how Chromebooks with depthcharge boot
Date:   Fri, 13 May 2022 09:59:17 -0700
Message-Id: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents how many Chromebooks pick the device tree that will be
passed to the OS and can help understand the revisions / skus listed
as the top-level "compatible" in many Chromebooks.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Document how Chromebooks with depthcharge boot") new for v2.

 .../devicetree/chromebook-boot-flow.rst       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/chromebook-boot-flow.rst

diff --git a/Documentation/devicetree/chromebook-boot-flow.rst b/Documentation/devicetree/chromebook-boot-flow.rst
new file mode 100644
index 000000000000..84aeb0a17ee4
--- /dev/null
+++ b/Documentation/devicetree/chromebook-boot-flow.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Chromebook Boot Flow
+======================================
+
+Most recent Chromebooks that use device tree boot using the opensource
+depthcharge bootloader. Depthcharge expects the OS to be packaged as a "FIT
+Image" which contains an OS image as well as a collection of device trees. It
+is up to depthcharge to pick the right device tree from the FIT Image and
+provide it to the OS.
+
+The scheme that depthcharge uses to pick the device tree takes into account
+three variables:
+- Board name, specified at compile time.
+- Board revision number, read from GPIO strappings at boot time.
+- SKU number, read from GPIO strappings at boot time.
+
+For recent Chromebooks, depthcharge creates a match list that looks like this:
+- google,$(BOARD)-rev$(REV)-sku$(SKU)
+- google,$(BOARD)-rev$(REV)
+- google,$(BOARD)-sku$(SKU)
+- google,$(BOARD)
+
+Note that some older Chromebooks may use a slightly different list that may
+not include sku matching or may prioritize sku/rev differently.
+
+Note that for some boards there may be extra board-specific logic to inject
+extra compatibles into the list, but this is uncommon.
+
+Depthcharge will look through all device trees in the FIT image trying to
+find one that matches the most specific compatible. It will then look
+through all device trees in the FIT image trying to find the one that
+matches the _second most_ specific compatible, etc.
+
+When searching for a device tree, depthcharge doesn't care where the
+compatible falls within a given device tree. As an example, if we're on
+board "lazor", rev 4, sku 0 and we have two device trees:
+- "google,lazor-rev5-sku0", "google,lazor-rev4-sku0", "qcom,sc7180"
+- "google,lazor", "qcom,sc7180"
+
+Then depthcharge will pick the first device tree even though
+"google,lazor-rev4-sku0" was the second compatible listed in that device tree.
+This is because it is a more specific compatible than "google,lazor".
+
+It should be noted that depthcharge does not have any smarts to try to
+match board or SKU revisions that are "close by". That is to say that
+if depthcharge knows it's on "rev4" of a board but there is no "rev4"
+device tree that depthcharge _won't_ look for a "rev3" device tree.
+
+In general when any significant changes are made to a board the board
+revision number is increased even if none of those changes need to
+be reflected in the device tree. Thus it's fairly common to see device
+trees with multiple revisions.
+
+It should be noted that, taking into account the above system that the
+depthcharge has, the most flexibility is achieved if the device tree
+supporting the newest revision(s) of a board omits the "-rev{REV}"
+compatible strings. When this is done then if you get a new board
+revision and try to run old software on it then we'll at pick the most
+reasonable device tree. If it turns out that the new revision actually
+has no device-tree visible changes then we'll not only pick the most
+reasonable device tree, we'll pick the exact right one.
\ No newline at end of file
-- 
2.36.0.550.gb090851708-goog

