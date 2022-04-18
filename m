Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C7505772
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiDRNzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbiDRNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:30:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B11EEF3;
        Mon, 18 Apr 2022 05:56:51 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s137so18740387pgs.5;
        Mon, 18 Apr 2022 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODAyrur2uuG6LpXXHU2KctLzjDAk76d6YTt1ZAO0Ttk=;
        b=ZlVp1ObmY67pdpfEJIBhb4Gtc8gONWPpAeAZ65R65t+xXuKHjIhv7rfiTu6XtSSk6e
         jnf0lQtyup4Yyvqc4/qRJ+RozRB9NFaffvcLgQL7anfu4sIEZKVxN3WlTyLQS22Nm4qH
         ll/vRIlGniiGngEq0Ef3cyZDeiPKUljf7yPPnJea3kUeD7V/GnPioJK9S11dolGOaxXn
         zIlg3QsWEdx52Ha2gnwiYtiKMb7vc0cep4qjR/8xgB2x0b5iJmlYC1SowZgl+7qpqhfE
         k7nLOY/eaZ3CYZWG2lKku/qx7g2lRlDAweerrz46bEF8c8RSCNerthN4+immxkjWfzrK
         utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODAyrur2uuG6LpXXHU2KctLzjDAk76d6YTt1ZAO0Ttk=;
        b=0sGD8tlOqnS0Nzxh8rduHWD1DEEliztOGIojiZyk/WfIDwTcEjfGoPglKJ4bPKt+00
         iS/A1OmtzaiMSoeneWjT+QZLzmXuq2vgfsrpO6SsJzsAVI2LC0Po46/+cu3uXEHhkud4
         w9dkyFbkCRJivv/Dy1BlTqAFojUDTwH4ZTTBM5MA8HoR8fFKkhud3UerPGdDWve872ri
         RIynJ4028eqYPZ1sQeBfbux3clhNdM3kNOMtELxBNv00JDMaDoqxunWTwh3/VJtbJUUp
         x6wHNApOBONVlB0ZpyKgyY5aW8lFqErDsWfnKUEoXi+UHcdPU5jNn1y1fDoeg7+p4jtA
         NSeQ==
X-Gm-Message-State: AOAM532XKxakk43guRmdeAHQQ9K/4D97bG47jyr8Or9E1jdTMwUWIxZj
        /iW8pKB9pKQ5gQ7Mk2TeD64Idjzi3CU=
X-Google-Smtp-Source: ABdhPJzYyEiG3pNKaLYXXQ5xjcjy2jalY3a7dOwMm/JW/Gxzs17ECpSZhAvtfVP9lHEgQ+isRQXw8g==
X-Received: by 2002:a63:714e:0:b0:398:9bdc:e11a with SMTP id b14-20020a63714e000000b003989bdce11amr9721798pgn.572.1650286610963;
        Mon, 18 Apr 2022 05:56:50 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 73-20020a63064c000000b003a216524089sm11358212pgg.57.2022.04.18.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:56:50 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/3] Add ums512 clocks and relative bindings file
Date:   Mon, 18 Apr 2022 20:56:27 +0800
Message-Id: <20220418125630.2342538-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
  fix wrong indentation and hint: "maxItems" is not needed with an "items" list
  when use the latest dtschema.

Cixi Geng (3):
  dt-bindings: clk: sprd: Add bindings for ums512 clock controller
  clk: sprd: Add dt-bindings include file for UMS512
  clk: sprd: Add clocks support for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |  112 +
 drivers/clk/sprd/Kconfig                      |    6 +
 drivers/clk/sprd/Makefile                     |    1 +
 drivers/clk/sprd/ums512-clk.c                 | 2199 +++++++++++++++++
 include/dt-bindings/clock/sprd,ums512-clk.h   |  397 +++
 5 files changed, 2715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
 create mode 100644 drivers/clk/sprd/ums512-clk.c
 create mode 100644 include/dt-bindings/clock/sprd,ums512-clk.h

-- 
2.25.1

