Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63511547978
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 11:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiFLJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiFLJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:05:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E653619D;
        Sun, 12 Jun 2022 02:05:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so5708721ejj.10;
        Sun, 12 Jun 2022 02:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5/W6Lg7ZVRQY4aBYu6sgvVILEtgCF93h3bLCt2TIuY=;
        b=WCsRsSXipZzbMX6EyL5gU2NWxKUWCBKsmiJ0Ej8ZSiGaPdd5EQzv1nBf2CZGsfAcbP
         EQ9+FsfsKUwTGVFjHA2X+5DJuWx+ptZEm2lIn/9avOXpjB8ef8vdauJTmR830blojReI
         c6zezFcsxjGNxTaOX49ZKU9pWsMhDrUuvRo9ZfYC9MnzWSnmU8hiZHdkNNo3KzxzVLFR
         3bf8fcrQSWk5HQ/7Wy+j7RuzU0ZYX6JMErqsssQeEsxIGaSlDwTGMP1jzTK5K8tAwfSM
         am+u+/J4MIYcIO8GuaD0tBPxuzxG6QgJ6tfFgzbyuQjsIlkBDOMz+mS4YevuDJbawrN1
         RhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5/W6Lg7ZVRQY4aBYu6sgvVILEtgCF93h3bLCt2TIuY=;
        b=49eby5GRUOwVqbTiP2BFxYHORBaJE8f5i9Lzb6TzeaHazCe/R0gTqWBnaedv+6bBKe
         eUSLdcPeGSaAuzo4n9NDSRq4wjWYfcLuJlg5ldr4maeXkNpAXAN+ySnHgLM2TrRUKKLb
         6tkByKJEPpzDK6ATVSyld1wAfkeoCt0cxI7GXHlHXYgN2B1RvCAnonpdVwZcB0zYe9yJ
         o5Q58rlk+DfQjA4R1PWJ/p4LvnW+o8oJT/rhDHpl3z161zFm3xeKazx4VEmCrl+e+RIY
         TUMZri4L7yV9WBdh/bLytCUhkU/a+KqUVHyHoVkpmeQtagDfujxKUpxPYukxowZVj7qI
         ssEg==
X-Gm-Message-State: AOAM530XNnWhf7mL5ccXYRZ97jrc+cnvr59aXRuAWPph/jrBKHMwByfw
        7tAsqb750QekqRFWncRRvuI=
X-Google-Smtp-Source: ABdhPJyMTVzfqW6BTypBHblaN9sRLPDDdltQ9kcFG0ekxD+sju3JjLgGT4QAb9eHN0UYWTKGJn12sA==
X-Received: by 2002:a17:906:7791:b0:712:1c42:777a with SMTP id s17-20020a170906779100b007121c42777amr11647473ejm.68.1655024747371;
        Sun, 12 Jun 2022 02:05:47 -0700 (PDT)
Received: from strolchi.home.s3e.de (p3ee2bf2d.dip0.t-ipconnect.de. [62.226.191.45])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7c7d2000000b004335e08d6c9sm2860075eds.33.2022.06.12.02.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 02:05:47 -0700 (PDT)
From:   stefan.seyfried@googlemail.com
To:     kenneth.t.chan@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix panasonic-laptop hotkey regression
Date:   Sun, 12 Jun 2022 11:05:05 +0200
Message-Id: <20220612090507.20648-1-stefan.seyfried@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
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

Hi Kenneth,

commit ed83c9171829 broke the hotkeys on my Toughbook CF-51, this adds a
module option to make them work again.
The first patch in the series is a small cleanup to allow the actual fix
to be much more obvious.

 drivers/platform/x86/panasonic-laptop.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)


