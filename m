Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D04BEAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiBUSr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:47:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiBUSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:47:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FC1086
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:46:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so28612590wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GQleP9DMTuKHf/RYSOAlqEThPxKITClJsZGQlJ/KN0=;
        b=opahrnboN3C7Ps7gy5VDL66PMAYqlJ8lAQbtKntAf2RNHnZuG9Yzco6SYdbLFzptoA
         KWwHTdhcSwEeH6VWAxz9zVuCTJJdd3W0S4KWmVnvXEDImYIBBBCizmLzVTYnna2DI0Yu
         B24QPjhmua3DRATIiVJQyo4c5TOks48oPBSkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0GQleP9DMTuKHf/RYSOAlqEThPxKITClJsZGQlJ/KN0=;
        b=dQI2EL45JieHOfcPimJVCF50K5n5NgNsKwJmVjvZ7BiGG6l6BKSsfPr4eDqB+06IBj
         GkcE+XE8hzuCwF5EMfqa40PeHUj6bpbTsXB/2DDmtLN5D1Vinv09zokqV+cOrZSYs+4u
         6la8o4t8y6vtLVYCzemYKwbUSQHQ1exMj4McC2GMN037hTWDZGLovTEyje3/1AfwyXdE
         ZaZndCiS4wBUrx4Eu7JY3uXgOo75GhIomP7DNbH3KCIQF4oAYcLhXlt1LWNvlecveoHl
         zMFx2mAhoVUE0PBUWiGf14C4z1PkC3etp92Y9IkxLnlg2E2it5eCulb2Z3XWvYeYvlm8
         8JaQ==
X-Gm-Message-State: AOAM530pulXWydZORWPfjWwZSddYFYt0lDtbwZODno/plw5roY/7MAww
        JbcpPyh1UDRLUp725CW7oGFwjg==
X-Google-Smtp-Source: ABdhPJyIysHtiOW3kwTE7nPmELPM6FrJ3zr0i8xZGHOVwuzXGZRWtgGphCHc8EotRx1+AscpPZFCGg==
X-Received: by 2002:a05:6000:178a:b0:1ea:7db1:3159 with SMTP id e10-20020a056000178a00b001ea7db13159mr1203489wrg.9.1645469195143;
        Mon, 21 Feb 2022 10:46:35 -0800 (PST)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm140637wmv.31.2022.02.21.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:46:34 -0800 (PST)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Michael Rasmussen <mir@bang-olufsen.dk>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/2] net: dsa: realtek: fix PHY register read corruption
Date:   Mon, 21 Feb 2022 19:46:29 +0100
Message-Id: <20220221184631.252308-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

These two patches fix the issue reported by Arınç where PHY register
reads sometimes return garbage data.

v1 -> v2:

- no code changes
- just update the commit message of patch 2 to reflect the conclusion
  of further investigation requested by Vladimir

Alvin Šipraga (2):
  net: dsa: realtek: allow subdrivers to externally lock regmap
  net: dsa: realtek: rtl8365mb: serialize indirect PHY register access

 drivers/net/dsa/realtek/realtek-mdio.c | 46 +++++++++++++++++++++-
 drivers/net/dsa/realtek/realtek-smi.c  | 48 +++++++++++++++++++++--
 drivers/net/dsa/realtek/realtek.h      |  2 +
 drivers/net/dsa/realtek/rtl8365mb.c    | 54 ++++++++++++++++----------
 4 files changed, 124 insertions(+), 26 deletions(-)

-- 
2.35.1

