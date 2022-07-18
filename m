Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A76578D04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiGRVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbiGRVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:41:48 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C71092
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:41:47 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10c0052da61so27431114fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwFMLZ5nGNucrFSwM6yJgESfML4UAN0HVzEssesyWsg=;
        b=cbk8jMcghN6CO7K9epBOigQ2O2dFNSD5n/MO0d3HjFcFz+Uhei6sY4A2y/UXtxYBHQ
         NKeNKMuS1fJrA5keekKePOposlQYpCs2DU00FTgGI8tGrzMRx13aQEr6hzdh9Wq6u+4x
         +xjiuc3NaUjifVRYirZa2+epbzfDOloSPQgvFeDwGnbfKION3IGct5KHpYudNY2XhhXz
         Hd1BYozesCJdYHgPJnjRsLGTtatWpn3SuWZnHytFi3er4NmrzO1LfKK6q3FEGiLRM0Z0
         TE3jLfPNpU4x807rNWXxcxp76T5zZ98Ktjb1yzTCR4RwGHiPxwnQUKtjQBcRunSqHeAQ
         qEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwFMLZ5nGNucrFSwM6yJgESfML4UAN0HVzEssesyWsg=;
        b=3ysF9+FREBl6KBpTPjqylKX1qnE9fianw6uFe+v7nuT6tT2hiffWzbr8YBioZulz20
         LUPVOlF/krv5Q41JROe7wRdc0CNRXrwtxidvKlXdxgAVmJho+j0VS5oWYmfUFy/9J0nU
         3PjdI6b10tMNRFIH6qHCUo9cEaaP8KZPR0oR3gCZisxCYFKF1ENFPedO7h08aknDyl9u
         Zqu0xajqD9uoOkgaq/8k0B3j+L7hdvOeTsnc27z1ddTgcA29GjHI+49LNMUrd5BY4o60
         LI2iyqnb1miHhcWcEnpF1tFO0qIQpxSDU0O6t86z7TnkY05Gh4LdCrHLy9fybzNa0Z6g
         aE3g==
X-Gm-Message-State: AJIora8KYLe8oi9jXfbUWFcOByBH6QMyYzhIPNNw7Phgc+sItIiBS8jE
        jV9G3ZxQJKs0nT2eGFih631rDA==
X-Google-Smtp-Source: AGRyM1upmic9iUN2ukbLHy5btrfdPZM97XTo8i6MG2ITNp4nedcswuclUHCJgeodCyWSUsjxGuQsSA==
X-Received: by 2002:aca:b744:0:b0:32f:4c19:cec1 with SMTP id h65-20020acab744000000b0032f4c19cec1mr14730236oif.43.1658180506276;
        Mon, 18 Jul 2022 14:41:46 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id a39-20020a056870a1a700b0010490c6b552sm6781283oaf.35.2022.07.18.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:41:45 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Chris Healy <cphealy@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH] hantro: Remove dedicated control documentation
Date:   Mon, 18 Jul 2022 18:41:22 -0300
Message-Id: <20220718214123.73275-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
References: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dedicated control required by the HEVC support
was removed, and the driver now calculates the value
internally. Remove the ad-hoc documentation as well.

Fixes: 3360755ef89ab ("media: hantro: Stop using Hantro dedicated control")
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 .../userspace-api/media/drivers/hantro.rst    | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 Documentation/userspace-api/media/drivers/hantro.rst

diff --git a/Documentation/userspace-api/media/drivers/hantro.rst b/Documentation/userspace-api/media/drivers/hantro.rst
deleted file mode 100644
index cd9754b4e005..000000000000
--- a/Documentation/userspace-api/media/drivers/hantro.rst
+++ /dev/null
@@ -1,19 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-Hantro video decoder driver
-===========================
-
-The Hantro video decoder driver implements the following driver-specific controls:
-
-``V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP (integer)``
-    Specifies to Hantro HEVC video decoder driver the number of data (in bits) to
-    skip in the slice segment header.
-    If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
-    to before syntax element "slice_temporal_mvp_enabled_flag".
-    If IDR, the skipped bits are just "pic_output_flag"
-    (separate_colour_plane_flag is not supported).
-
-.. note::
-
-        This control is not yet part of the public kernel API and
-        it is expected to change.
-- 
2.34.3

