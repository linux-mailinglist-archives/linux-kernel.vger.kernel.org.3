Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1985C4FE15D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354595AbiDLM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355259AbiDLMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579FE182;
        Tue, 12 Apr 2022 05:27:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1640751wme.5;
        Tue, 12 Apr 2022 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLvVbLpUjvsfKSztwqWxtk+rzLoCKyXGmMrwcG6R1+w=;
        b=PtWpGo2MP8zsRtwrr2OcbpzydQpqm9MnCeYYuuT7TR/jLj8P2qgHnA7LO+zT/JrMqb
         TFlBPjuoFabV1C0ujaxUowZmq8dBHc80XQr7HZizm5UewNQRLGiDwgBq/3pwWcDsdNCF
         txswzsV6FwpNVS7A2QdxrL5cTHQ4lqR7N5V6p2GW/Gqqx6Jum8juD+r59uynz9wiiPAT
         A9YRMHg5GiJdJltoO941lbAFOqL/qh2wBcZWBkC7ZA+jt3BrSQpBQqzhpYiXRAjjDyDJ
         MUsz+nUERc+OmXjMllqSbFeqzipSDHxc++lkkoIyTPxA34vMvDjPM3ZxS1eRjb7Gbbol
         p88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLvVbLpUjvsfKSztwqWxtk+rzLoCKyXGmMrwcG6R1+w=;
        b=F7sH9dMmxpwSUrfqgX0QV17GcQOQ56s3eRehAqmecl3ZgE2MRWV/wPZrVTZqTRqvlc
         kWvxRW461FbrdZGXyOlVh3qlH9UwqnNp95CV/Pco0dJxw4GE8fhDBjJPyYf6C9NO910D
         8XrIL2t4jSYxXmJmS6qWT47Kzj1DUbuFGw8UbPmINIS9cr1OSiEz46wcAfhnEy+FTVbt
         9IuHBafo9cXDVOhCluUG7IM+h7BT+cyXvDvLy45XRiN7Jhf89Lg9zOBKLq0sA7UjjOr1
         gTMdbcNxRI01fxSd1VLBmxtc9+OYaP4rEhY/PW1ucl85Gt/dkiOXp80jh3EMuOujn5ge
         iajQ==
X-Gm-Message-State: AOAM530SZC0/PfnkhfhzQWAufF8xiA2vjWOGOaGGGS+uus7r4wwhMl43
        pDb3jDnCr9UNsoeVivKVnQ+KvIjzhmA=
X-Google-Smtp-Source: ABdhPJwty/6hk/+kjAvmRWBC4Ymn+Sv+ZBmECvJhvpCjaY05GnKzIf0wXjuCG071bxGt0dOoGMW/RQ==
X-Received: by 2002:a1c:f604:0:b0:38c:8ffd:dbb6 with SMTP id w4-20020a1cf604000000b0038c8ffddbb6mr3893960wmc.43.1649766438868;
        Tue, 12 Apr 2022 05:27:18 -0700 (PDT)
Received: from localhost (92.40.203.131.threembb.co.uk. [92.40.203.131])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b0038eb596ab10sm2296064wmq.2.2022.04.12.05.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:27:18 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, krzk+dt@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH v5 0/2] Fix missing TCU clock for X1000/X1830 SoCs
Date:   Tue, 12 Apr 2022 13:27:48 +0100
Message-Id: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5: fix use of uninitialized variable reported by kernel test robot & Dan Carpenter
v4: resend of v3 with some minor changes
v3: https://lore.kernel.org/linux-mips/20220224150326.525707-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (2):
  mips: dts: ingenic: Add TCU clock to x1000/x1830 tcu device node
  clk: ingenic-tcu: Fix missing TCU clock for X1000 SoCs

 arch/mips/boot/dts/ingenic/x1000.dtsi |  5 ++--
 arch/mips/boot/dts/ingenic/x1830.dtsi |  5 ++--
 drivers/clk/ingenic/tcu.c             | 35 +++++++++++++++++++--------
 3 files changed, 31 insertions(+), 14 deletions(-)

-- 
2.35.1

