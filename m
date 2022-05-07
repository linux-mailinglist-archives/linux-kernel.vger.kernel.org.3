Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357A651E61B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446175AbiEGJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245217AbiEGJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:33:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BB55623E;
        Sat,  7 May 2022 02:30:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so9596514plg.5;
        Sat, 07 May 2022 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IH66vbZbF06RngXWPuWGferfai2hTglYAHaIB/T3Vs=;
        b=J6o0EL7XFklgZaYW2W6lhluSl1xQ/hUkepaxgauas/41lpIQTQCWy4Jd6B8ptYTdpm
         XWcNLVHPLBoMees5dL8pWIUeNcrgrX8cHqN0i/hYBj2z+tJHnsLfxEj/N3j+gOB6JLY1
         6wwVUGY1drziHsGyWXhIHB9Ye784g7mLyitQBKOJeHtmRJhfIO1BX52Axs8RFbSswb8h
         blVSCUo3fphYkSk954hSice4baXphc3W6ovSWFe/I7bYmdKxiDEVXq7NnUsJdZCpHHXF
         iVQPkm5m5+2CSt5A1jvDC2Lj0PZUIXV6dNfV1FIRtKQ+xa/XhvvD8E9CrACxe9SGfOLT
         C/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9IH66vbZbF06RngXWPuWGferfai2hTglYAHaIB/T3Vs=;
        b=6J5JaXfATdJUR4d786HQ+GrswFLZGxroB7z8oVl432KBWz2UQwSOv0q3nv68+uw6WV
         gveXmTQ770l1CKioAPNdVygO2E6nolMtgdQKzGOGH+n2QMLVDgwkeBaLXo64OGbG0ig7
         +guosD5MkWgV4eNjzWp6ZVd1HtzazV4NwC6KKE/i+Qrs4k96ENV7WDO3aDG8RN8+ImH4
         aRawRVUbLHj2EP/3jdjJY3isn1DycwiYnYOqkvldFTxixivGgt/qtT4JC7VXQB5EpHfe
         aPBKqbdblRfcBh6XNvRADJ+oXMKXtjsy17nplPrgTgJOYSkxqtK6FyexptgqygeCrgY7
         dHBg==
X-Gm-Message-State: AOAM533cuCtlHZRaVAkQganZqtzfO6v1udQI3H8SovbI6sSd5XY0jT5u
        2lTQRo1p19k/b4P2C4tucfg=
X-Google-Smtp-Source: ABdhPJzswRfvvUU/4+3X81Z0mzKSPwxV28i+yZQQrP7nPLUvED/1CGHWKxNtKObX4kQDGUxS4D823g==
X-Received: by 2002:a17:903:22c9:b0:15e:a8a0:2a79 with SMTP id y9-20020a17090322c900b0015ea8a02a79mr7689809plg.31.1651915800073;
        Sat, 07 May 2022 02:30:00 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b0015ee24acf38sm3212300plr.212.2022.05.07.02.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 02:29:59 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add PMIC SC27XX typec controller
Date:   Sat,  7 May 2022 17:29:51 +0800
Message-Id: <20220507092953.2273879-1-gengcixi@gmail.com>
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

Add the PMIC SC27XX typec controller for ums512.

Cixi Geng (2):
  dt-bindings: usb: Add documentation for sc27xx typec controller
  usb: typec: sprd: Support the SC27CC typec port controller

 .../bindings/usb/sprd,sc27xx-typec.yaml       |  72 +++
 drivers/usb/typec/Kconfig                     |  10 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/sc27xx-typec.c              | 554 ++++++++++++++++++
 4 files changed, 637 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml
 create mode 100644 drivers/usb/typec/sc27xx-typec.c

-- 
2.25.1

