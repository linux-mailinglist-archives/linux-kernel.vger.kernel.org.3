Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A608581104
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbiGZKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiGZKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:24:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6C248FD;
        Tue, 26 Jul 2022 03:24:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so16862735pjg.3;
        Tue, 26 Jul 2022 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mKlpylo6kQhA+WMEw1iLf8gUPprV17zWXkGgtj81TCc=;
        b=FwLozWp9bxnFn/jBvCFSKBIHvE0RpS08XZqNWc2ppS9A9P0KVKbregAH3pLO6jCOqp
         nFeacjF1HX0auSIqDGOgAnysxkAYPHQdx2TtBfPB7Vn81yhzmwsQe0S1UrBbPCW1Qlwn
         Z9GLUrlgUI/953UKEJoezWsFevgrNARMn9WW3wkKNGXm8CGZTOvJVYBrRCvGJyfq+pO+
         HsIOajNynYNJ1sukIgnHqsXByAyGJruVl7ZGjg0v5pu8RHKS1m+rSga06ut2v+gFgGd9
         Bzll4tilHaVT5+MsiogVNroQnOUKJl3jx4ygsWvDThEt8F4xv5xc8t8Hn6GfbXgCWmdz
         NdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mKlpylo6kQhA+WMEw1iLf8gUPprV17zWXkGgtj81TCc=;
        b=iUOX8vCDw4ckAHXrqKk7OLiWYRTMhUj+tjmpOFFCXNn7UercabLQ3tKpHxPzfPfbel
         7ywwU2SSaziblAUX8Y+nLTz67a3NIAVI1RYjgkvMliMRTq228A/46Aos19zYxVLXt6EV
         eGcrWFosRYDkNqP6xjH0ijK7oW+DCK21OpJ+0+2dJhju3N4q2gERsbEvf6cL3qHfhbQt
         JiQtaQwjTwj/Gg3s5i1rzYf0lfYsS/l65DZf280K+YywizHdw+/IHQcLCA2RqqP/AFvy
         TAqWyA6QhFeMUdkUipDeqjKaZNdRhk84ece6qDNLoJVv59rwvuHz7ZyteBDkA/eW2mVX
         L/2A==
X-Gm-Message-State: AJIora8fIttJAH4cjr1X4L9GoUj+1KKHeJY+fRdtiVspL7q7oKwX51QZ
        KEey6pmMKpj3gxzIY6t+IOKqLLR/irL2SA==
X-Google-Smtp-Source: AGRyM1sWol8//Pl+4G7LSBHy32IBfhaj89vaezrkLFKYJwMyrrEV87Us+oUamvyPyBwLG7OaFDCYAg==
X-Received: by 2002:a17:902:a418:b0:16c:9ee2:8a02 with SMTP id p24-20020a170902a41800b0016c9ee28a02mr16066111plq.46.1658831057848;
        Tue, 26 Jul 2022 03:24:17 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090ab78c00b001ef3cec7f47sm10421753pjr.52.2022.07.26.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:24:17 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V6 0/2] Add ums512 clocks and relative bindings file
Date:   Tue, 26 Jul 2022 18:24:02 +0800
Message-Id: <20220726102404.564498-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

This patchset is add the UMS512 clocks support

v2 changes:
  adjust description and add the "sprd,ums512-glbregs,syscon,simple-mfd"
  compatibles to fix match failed logs in the dt_binding_check.
  add the property license and copyright notice.

v3 changes:
  fix wrong indentation and hint: "maxItems" is not needed with an "items"
  list when use the latest dtschema.

v4 changes:
  move the syscon bindins from clk to glbreg yaml file by pickup 
  chunyan's patch for global registers bindings
  fix the comments from Krzysztof in v3 patchset
  add the Acked-by: Krzysztof in patch v4 3/4
  fix the  warning Prefer "GPL" over "GPL v2"

v5 changes:
  Add review tags.
  fix the comments in ums512-glbreg.yaml.

v6 changes:
  No more send the patch 1/4 and 3/4 in V5 for applied by Stephen
  change GPL to GPL v2 license
  fix the lack of space in some "{" and "}"
  add check error for sprd_clk_regmap_init.

Chunyan Zhang (1):
  dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Cixi Geng (1):
  clk: sprd: Add clocks support for UMS512

 .../bindings/mfd/sprd,ums512-glbreg.yaml      |   68 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2202 +++++++++++++++++
 4 files changed, 2277 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c

-- 
2.25.1

