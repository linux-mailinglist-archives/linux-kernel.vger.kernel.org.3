Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0B4DD32E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiCRCoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCRCoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:44:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E444CD1CC9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:43:00 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9A6B73F1DD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647571373;
        bh=Bt5u+dqRXX5TG4kpL4NYCF0+7EST57EITnb/tm+FvLo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=h56FVk6aH8OtASMxrhjclBmbs4lUdOEsd2E0+0zqKo4YBgxJlL9+UGeIH95nH6ODK
         Fj8p7sNtXOxnncs6MaY3rPhJqlDIhs1J+PqxleYSPecKYRBvWd5asRdgP7jP6Wz9rE
         QGqpGRaAz4HcGDGR2H5RqPleTyEdurBBYly//m+oCPdW+TeyP77SE1jDkUi0wH6KZX
         7HKFGV/fbmo+rKaTzUKIoOoZvP4rutwZuqd635HH00tSq4ZyqPixwBTlQxwNABdmsY
         Mwcmi/tvnkG89Hw2wR32r4NuIsTD7nny4WEKxPZv4AQscHlc/wn83UQK1dtaneOTgw
         C5k8yUh96cutQ==
Received: by mail-pg1-f197.google.com with SMTP id q13-20020a638c4d000000b003821725ad66so1389769pgn.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bt5u+dqRXX5TG4kpL4NYCF0+7EST57EITnb/tm+FvLo=;
        b=uJaS09OvVjrKObG8ddJ9KLeR1SKlUYlWdaIKpnpNqYP1WaBRoqcFtHnxkspsaJENHv
         Iw9wiLL5orlQZ/MZTj38v1ISoUNEo8YgziPE0SpcZwirAkNwcBFL/KRRstcsaH+uVFs2
         kxISUV8vtrUyxLMzz/RzN428TvHXxIdk3zws3lswH7Wf5LLG+FK5pCkbD9QaDd9LJzUT
         mj9QOgBfspBemR5cPYmd4jcKI6wzPHwXr03vuca/DxTh95gTzyYda4+hQNDBFzEOOqil
         6AxAuJK2NC6A6viLy2GNtPo7FQuUjWrbIxipXOGsoxeb2wO2xcFLLPg5+pIqEcQNugOk
         LAlw==
X-Gm-Message-State: AOAM531BV8IJAyLBb4IGQmAPWwUvBifPGW+MwaoWdJof+TDq4BaipJK9
        f2I2AUtuvaWH8fUQgsX1S8qSV3kuUcmwrPzRSSqvIlAhqPlnAt8hhBni8DvvnoNL5SZv5Urq7sB
        na3+A2nB2MrqWUVYZ+nTTbx+PdqIetwX5jlnI2wZCNA==
X-Received: by 2002:a17:90b:4c08:b0:1c6:40e4:776c with SMTP id na8-20020a17090b4c0800b001c640e4776cmr8724577pjb.237.1647571372089;
        Thu, 17 Mar 2022 19:42:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBmgzsy0zKa9NwPy5bZZxUZZGmF1IcYkjfssmssCj9ufj7jR+nQNE2iuZ3iJhBwTgTt3sHOw==
X-Received: by 2002:a17:90b:4c08:b0:1c6:40e4:776c with SMTP id na8-20020a17090b4c0800b001c640e4776cmr8724556pjb.237.1647571371753;
        Thu, 17 Mar 2022 19:42:51 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e287-a413-5915-32ac-82c3-a966.emome-ip6.hinet.net. [2001:b400:e287:a413:5915:32ac:82c3:a966])
        by smtp.gmail.com with ESMTPSA id v16-20020a056a00149000b004f7ae2cbd3asm8191232pfu.166.2022.03.17.19.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 19:42:51 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v2 0/2] rtl8xxxu: Fill up more TX information
Date:   Fri, 18 Mar 2022 10:42:14 +0800
Message-Id: <20220318024216.42204-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The antenna information is missing in rtl8xxxu and txrate is NULL
in 8188cu and 8192cu. Fill up the missing information for iw
commands.

Chris Chiu (2):
  rtl8xxxu: feed antenna information for cfg80211
  rtl8xxxu: fill up txrate info for gen1 chips

 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

-- 
2.20.1

