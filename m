Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3805A52A481
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348581AbiEQOOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbiEQOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:14:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAAC4F473
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:39 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E6F803F942
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652796875;
        bh=G+ZITecwHknCWdRzv1v9uet4sgjniAcjGPURy+jJTak=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=V7Ujfz+wct+6ZdDRNd/FgqRQpdvMnEhVTOJuq+yKqH7NYXyV6FKw+wb7ab/7+yAV/
         m9JtfIcIMN8GH5ZMSr8ZueSp2Tf/36NragN++di4GGm47Yw7FgUdO56AVP+p28rM9E
         TepRjno6Ik9IbjMeW7g1NLp8EGji7IlpjnV2dCSnLckp9HM6k5rd1heN/pap1NLPWn
         gIeVjHmevbz/ldH+Ywv/0i9M8JYIGK7orjqa6cCXAQymJsQE9d8vuANv8PHUzUDoGb
         Hbi3VqO3awOam+Z+II5ewTwY4lSLd0r2kJ9OPxXbxnHSkZ0xP6lp3QUzgd2rQJMKmE
         Fdu1X/i/KNqUA==
Received: by mail-ej1-f71.google.com with SMTP id ox8-20020a170907100800b006f9dc6e4a22so7438445ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G+ZITecwHknCWdRzv1v9uet4sgjniAcjGPURy+jJTak=;
        b=aMinSDHjUXquUWZPWWHzVFens0lAglswpTV+V8lGHG0A4dEOnIHGDCuL/1TeQZGfQR
         iBkdNifohtekwOhoTGpbtYcd2egBo8LnXnblcQa1D8zotjc9jhUSEfIJSWCUrL7jwHAV
         XgrxaiAea4GQtSTkNv6fIPn92wdnf5HR0SCN1W0YvWk7N8zfZn2hAQDOLfxlWWKU8MHu
         9lv8QhOD0T4KGKkYxHmrTulmfcQP33ozTs+sdQermxZBLwf0FzOamLDqYq7hT9y4ih71
         /mRy362oki4rGXPNN213r3vKfQqWEle6LBJCkpe14Mq6oPtCmJPTjlUbL20Zf/z/bjo0
         y3pg==
X-Gm-Message-State: AOAM533ETJgPhv7Iv4aT7spkafm3Myj1yimHFGjdoga1fNAmJ77bTB60
        6cuDGRLTdj/YSUPoD+J7YrcGDZSnAQxNf7kZ/ACq9giWp91LUNXIMAENiUaDX2FpeOc8Va49Avv
        aHR7kPhvuQiQtoT//y6mQ7S2n/OPXCLhlc86CmFYJqw==
X-Received: by 2002:a17:907:1622:b0:6fe:22bb:7f8 with SMTP id hb34-20020a170907162200b006fe22bb07f8mr12961527ejc.767.1652796875640;
        Tue, 17 May 2022 07:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSlf0rIkXwaOLnSToz3zXU3nCEn6EaRJtuENFuTM33VqbV+YYy/ZMrigVE6tiREzXhtEBsdg==
X-Received: by 2002:a17:907:1622:b0:6fe:22bb:7f8 with SMTP id hb34-20020a170907162200b006fe22bb07f8mr12961507ejc.767.1652796875432;
        Tue, 17 May 2022 07:14:35 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id em9-20020a170907288900b006f3ef214e4fsm1079265ejc.181.2022.05.17.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:14:34 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/3] ARM: Kconfig: Style cleanups
Date:   Tue, 17 May 2022 16:14:21 +0200
Message-Id: <20220517141424.331759-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

While at it:
  - Add trailing comments to endif/endmenu statements for better
    readability.
  - CLeanup some stray/extra/erronous tabs and/or single quotes
    and/or whitespaces.

Juerg Haefliger (3):
  ARM: Kconfig: Fix indentation and add comments
  ARM: Kconfig-nommu: Fix indentation and quotes
  ARM: Kconfig.debug: Fix indentation

 arch/arm/Kconfig       | 38 +++++++++++++++++++-------------------
 arch/arm/Kconfig-nommu | 34 +++++++++++++++++-----------------
 arch/arm/Kconfig.debug | 35 +++++++++++++++++------------------
 3 files changed, 53 insertions(+), 54 deletions(-)

-- 
2.32.0

