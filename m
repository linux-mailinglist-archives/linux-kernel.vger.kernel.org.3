Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23E4D4E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiCJQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiCJQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:06:19 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC1186450;
        Thu, 10 Mar 2022 08:05:17 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so7265316ooh.8;
        Thu, 10 Mar 2022 08:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHOh1tFTpZ72EOY45qvqoUGU19btyFxldg3XwohTYjw=;
        b=okojP/q9PZRQHrL5SRK3+3edzw7tqvM1EzU+HReCfuK+BNABmvs3tpWw6HobKh3qdV
         bRYzGQOAtJw9u49AsVxucygRdvoY7TWruJuZpKxE1AZGhMch45zrMMIDoxtfwR+wcKSc
         /zoreda4J6QRdmljm37ZnRA/zhaZZZfI0OtA7Lv6mh0R3qx6rSGVM2N3+PGL7U9mwAWF
         IdH8JrM7nkaZRShu1FDKHTRboEDb52k4jidCzFdpXAczQ+uyoWCUNv1Ul1jZKz3cC8F2
         LleNR2vyfzIwdW93jHOK/BYb3G45ckOpFQLWo1uhd7HPReox13GwoR60R8sRcaZbu2Hf
         FrsQ==
X-Gm-Message-State: AOAM532iBJBB2rmypCzUDYjexCmGueyntz1L8O1/ANY8rDBYDxSE5xoZ
        ycZpkBpJtQSS2m/s3pM9Ww==
X-Google-Smtp-Source: ABdhPJwevnkYX4shC9l3+fWIszfKypg3G3ZaXEvSfGmIk+8JDUxapbf+Gd7AcW0GUE1Eg7b+0t0uyQ==
X-Received: by 2002:a05:6871:95:b0:ce:c0c9:614 with SMTP id u21-20020a056871009500b000cec0c90614mr8753286oaa.102.1646928316351;
        Thu, 10 Mar 2022 08:05:16 -0800 (PST)
Received: from xps15.. ([2607:fb90:20d2:449c:e413:94ed:2767:f2c4])
        by smtp.googlemail.com with ESMTPSA id s21-20020a056870629500b000d9a2291d2fsm2395413oan.30.2022.03.10.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:05:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2 0/2] dt-bindings: DTB based validation
Date:   Thu, 10 Mar 2022 10:05:11 -0600
Message-Id: <20220310160513.1708182-1-robh@kernel.org>
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

v2:
 - Drop processed-schema.json dependency when building 'dtbs' 
 - Don't allow override of DT_TMP_SCHEMA

Rob

[1] https://lore.kernel.org/all/20220228201006.1484903-1-robh@kernel.org/


Rob Herring (2):
  dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
  dt-bindings: kbuild: Use DTB files for validation

 Documentation/devicetree/bindings/Makefile    | 35 ++++---------------
 .../devicetree/bindings/writing-schema.rst    | 12 -------
 scripts/Makefile.lib                          | 25 +++++--------
 scripts/dtc/Makefile                          | 13 -------
 scripts/dtc/update-dtc-source.sh              |  2 +-
 5 files changed, 16 insertions(+), 71 deletions(-)

-- 
2.32.0

