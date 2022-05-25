Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD057533CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbiEYMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiEYMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:40:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9AA84A36
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:25 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B26BE3F804
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482423;
        bh=Nbms1BIDguDm1zi7ndfMJ73ax9St3z++nLzQuG5Ak/k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=h83PqifpICLBRcCHtysig4O8HrEwgGKeaxeJacR/MECGlPckdqNzQAI60HfgyLGck
         IpzSrtCqkotPWf2/fTpKeyrXa2PWe/WYl/OSOt3b7L+rAV+w/EQDrbCHgw1OYe1Qxb
         RFvmJ4SpUFIL5NsEEujkCG78HKy+07+XW+Hk8q6Z21doHN9BZdT0/LFPVp9sEN15rQ
         gW8PCZ6x0adGjiZZDcBbNwlqYTH960KGINkH/Yb+tfc20B4O453LyI9jVeAtjvoI2g
         LRe/EZwDoZ2xXYGCVTRKOWHhLyzmuh9H31z3YidJAesl+5gQAKMZPsY4kPBCgTWHLb
         k8/+YsjeBDenQ==
Received: by mail-ej1-f72.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso9452464ejc.18
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nbms1BIDguDm1zi7ndfMJ73ax9St3z++nLzQuG5Ak/k=;
        b=KW7HtwnBuby8HnOOzU78gkJkxWZvHzZxsZuMRK/5D5vCk5JeOZjR99JLkql++u8eeS
         StS8p3E3rfBqupsuTdftxOlTe2TorkknY+pWsXFCpCXciAg4akWM6yCyWufOVg18c6H1
         cEC7osaqzL0b/E0KBx5bU92z/lCsFVV2pUUsW+YY3RECxd3WWl0gWTaDvoM0clFZUHSI
         eW2F6K2Qz4nprR/jMZ3RbIs6agS7HS71g/SOnEFXDCtKBCXv/DycjEAV52626PXhkAmF
         n6XGa1hGY4NuBSK1AcGctbs5bkXvUnqPWMH1Ue43txvWmbn5X8nF39C/WJLz7tw7hTup
         AlKg==
X-Gm-Message-State: AOAM532C+Nu8LrzKW1wmqw/K/4fNANVrdb2qSTDhU9m+3J03zQlF6H2Y
        rSPicCluuyVjDP5J3WcbxGw+fhkzwvO6c+wjbUjddRC3LmrMj2bx/L2cjghOKGgkE/EtYvSuKty
        w1FyXfet/Hi77aT/Udfg9XwlICnu4z6hcnuamc0SpIA==
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr27457556edb.211.1653482416487;
        Wed, 25 May 2022 05:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSVRDBpKldg6LggqgxHhGIYnN9PDBOldp7DiB44jJIK1opWpXyqEqjmjKfjqbVJ1rQegRXTA==
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr27457536edb.211.1653482416298;
        Wed, 25 May 2022 05:40:16 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:15 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/4] sh: Kconfig.cpu: Fix indentation
Date:   Wed, 25 May 2022 14:40:05 +0200
Message-Id: <20220525124007.45328-3-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525124007.45328-1-juerg.haefliger@canonical.com>
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index fff419f3d757..7b0bea483eab 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -2,7 +2,7 @@
 menu "Processor features"
 
 choice
-	prompt "Endianness selection" 
+	prompt "Endianness selection"
 	default CPU_LITTLE_ENDIAN
 	help
 	  Some SuperH machines can be configured for either little or big
-- 
2.32.0

