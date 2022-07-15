Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0E575EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiGOKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGOKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:04:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD0220DD;
        Fri, 15 Jul 2022 03:04:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so11100008pjo.3;
        Fri, 15 Jul 2022 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlPe6Ti+DdI7qcqGa9UKlfYf0/Ch+okfzOOFnNrWBEs=;
        b=DSzv+yZrC+NenYJLs6s/RKYyUFlry6MPbHkjkAASa9ub3sTuL66SL5g+4B8Au9oyaa
         UasOP2MWBqcf4daJgW3woG4j+z+4lrOP3WbGZQiRA7gu63ZZd9Vw3L/JwBIkcRfeLf/5
         okjvuWikYUYaWfry2yUIsW62GUgJFeJXZ6RcdOYx/Sdp3TBfzua0t6HFSzuJm0FQlH9l
         scZcyGP6FX2Ou5q7HvvGpfh/451bar1Wg6+X0iwdt91lu+LEZn/7HzJ51K29o8meN6Wh
         eIPTGSXQ9ENwndLh4w9N50s2grc5N6l7x7UtxAZNlzMKPgi9njBIbJp30pfKsPxZOWXJ
         Gt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wlPe6Ti+DdI7qcqGa9UKlfYf0/Ch+okfzOOFnNrWBEs=;
        b=JSQBHxWP293WlEi6ZVxLGqYgDIHUFUSv/a0jpsxBKGEvhB9CE1Tweqa31oGlncnfU/
         V7e9CxGFUOPS7L8xcX07ctdSequsMcik/9YBvsraDenuLcI+ha84+dqZbItACB/36qcp
         9A94DzJEnjGVlRo7IyuXYYTo48WX9xFqiheRgQ3xwKVnMtChG7s/KBLuCiNssmoWabzx
         7l9Yzk3sbpHk+bEwRMp1x+9m+f/jMBvTGf/fTojhVketNN1J1VEEVhfnzbnGmsgIoSh0
         1Sb29lxfgE2LSE6ENNTHNNTMCCPi9hx38/sp0Jji/P69AKTM1WuDiBLL09YgPQ+ZJOuq
         u7hw==
X-Gm-Message-State: AJIora9FKym5+kGIAwt5g+QoKoUz1rlzrDIXz4SDjrN7Gr1g0YdlVckZ
        Qs6yXF8ZQmRzTAmQINhnKFxQjkkJ7AU=
X-Google-Smtp-Source: AGRyM1sKN1sRVpoDQ2wTknm1LhiKTOyhJWJxsW1ay6cgoMwO6V26jxVk26GNtdvNkysJZUk61CpNYw==
X-Received: by 2002:a17:90b:4ad0:b0:1f0:28c6:9493 with SMTP id mh16-20020a17090b4ad000b001f028c69493mr20571544pjb.142.1657879467068;
        Fri, 15 Jul 2022 03:04:27 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:569:4518:3851:6d9:846d:fbd1])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709028d8c00b0016c1948ef7esm3033791plo.296.2022.07.15.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 03:04:26 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH 0/3] usb: typec: tcpci_rt1711h: Add compatible with rt1715
Date:   Fri, 15 Jul 2022 18:04:15 +0800
Message-Id: <20220715100418.155011-1-gene.chen.richtek@gmail.com>
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

This patch series add binding document for rt1711h and compatible driver with
rt1715.

Gene Chen (2)
 dt-bindings usb: typec: rt1711h: Add binding for Richtek RT1711H
 usb: typec: tcpci: Add get cc tcpci callback
 usb: typec: tcpci_rt1711h: Add compatible with rt1715

 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml |   96 +++++++
 drivers/usb/typec/tcpm/tcpci.c                             |    3 
 drivers/usb/typec/tcpm/tcpci.h                             |    2 
 drivers/usb/typec/tcpm/tcpci_rt1711h.c                     |  168 ++++++++++++-
 4 files changed, 262 insertions(+), 7 deletions(-)


