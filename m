Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CE45A5355
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiH2Rik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiH2Rij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:38:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF699A9EC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:38:38 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id x14so2379058qvr.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XY9inKqmVaCLls92mXVTAi16MJ9qjkEsAoCtccx3XYs=;
        b=ZgGzNEuh8kwaXZ7+bX5dJ+ebmYCW2loFE6sB5WfSKPAh4GTFIbpGlGjOH67eiRaX2u
         aXkEuv88e7lf6p0OD0t5p11b9FDMGrXcalkPPPFBGyzQbzHwVK231yH86M7mGh0TDLOh
         iqnqcwUaFMg2oZNtys1ZZfqMmvEN9LqGiLQMNia53E1CxBDLTwsXll4OL8VtmF0ye8fx
         dCGsGsD056uYehjUPiK8YTbyQI8Y9diyDP5oxA+Pcg0SPGss/dBUv8URnzqmYHF7Y39x
         hSFgjZp4ou7JSSFvt99h4kshad4Adz90yFrV1+X2g4iurupXx0lQzY80uOUJcRQVkBck
         DkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XY9inKqmVaCLls92mXVTAi16MJ9qjkEsAoCtccx3XYs=;
        b=w0zO+O7z5pH+TYXvUeaoIbLKQa/RTOcy2RfqY43W6V7SUxViBD0/5ysViNrVKEj6eS
         o0JdAhtlJQzfu17wm0+ybvnDCJbJVJ6dDCn9P5fXOrJkJ5+88wBNBqz70XPvbXQyejBw
         1ui5gLOhfLAnLyVtHyuIY1oZKVPO9CTrQX5w0vGIsLHbgkFSOfNprfgyE+wmImFXsq+T
         7bIAJuU5WimFQZHmTzDOkSCv573pFNhynBWovfJdpqbAzWnBisvqG/hMf5B7ANh5zzkv
         gwbWFsErm73ijH7exYcq00dYKmJAw/HyMIYitpWj7NsThE698OSGYikuArgT6IBE8U0V
         nsTg==
X-Gm-Message-State: ACgBeo1bBpHtK6eyicAHSnYKV757X0fKKFZGa7qUivc4VKAhay4EmSQ6
        T7vXuqVbJiqq4FgBGcY1mBQ=
X-Google-Smtp-Source: AA6agR5EG+2/B/XlRzJpQwEhw5REbLQvUei/i1it83b7qs9gYftcNmpsLIg8nZePBJcTxOEp3g8dXg==
X-Received: by 2002:ad4:5cc5:0:b0:499:2b4:8909 with SMTP id iu5-20020ad45cc5000000b0049902b48909mr4832773qvb.127.1661794717714;
        Mon, 29 Aug 2022 10:38:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a288800b006bb7ccf6855sm6543583qkp.76.2022.08.29.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 10:38:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     soc@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        krzysztof.kozlowski@linaro.org, arnd@arndb.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        william.zhang@broadcom.com, anand.gore@broadcom.com
Subject: [PATCH v2 0/2] arm64: Kconfig.platforms: Group vendors together
Date:   Mon, 29 Aug 2022 10:38:27 -0700
Message-Id: <20220829173830.3567047-1-f.fainelli@gmail.com>
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

This is a follow up from:
https://lore.kernel.org/all/20220712164235.40293-1-f.fainelli@gmail.com/

such that we have SoCs from the same vendor grouped into a menuconfig to
be visually nicer and assist in selecting the specific SoCs.

Florian Fainelli (2):
  arm64: Kconfig.platforms: Re-organized Broadcom menu
  arm64: Kconfig.platforms: Group NXP platforms together

 arch/arm64/Kconfig.platforms | 52 +++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
2.25.1

