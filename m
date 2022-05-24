Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147935324A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiEXH7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiEXH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:58:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C44F7E1C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:53 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 102C53F157
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653379132;
        bh=VDNNLnApwc8rQNr4eAC6zfgA2KUx0NhL3U0vjL4J/2s=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QJKUjVQozmBhrZd/s8HkWAefcu9YbwrHHxs8K4mGlAWOlfDJUuLqD3IEjrPQute2U
         VuSgeEl8EI8eC1nSvvB8aWmVJjNROnFbs22jiSRyWoQcrSkEeVUfH0bPcqeZMN2qgR
         mRgRIKYEn0AVy6l33C8yOUEfRsTiGaNfOFG0jw4INccI+aXloyL4wVpvKNIRDR3ine
         kR+EOCz3x09jtANRAMXoSdEed5gICMZZRIi9IQGOoSbv7dLx8j07tOpPVpxM6HlOUI
         uVRr+nGYsA+/JGfIB6DACvc3iiY2AS1/omZ6CqzNw375YWrYT8OYLlipx4wA0J7QdP
         swER48ymtSZ1Q==
Received: by mail-ed1-f70.google.com with SMTP id bc17-20020a056402205100b0042aa0e072d3so12229204edb.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDNNLnApwc8rQNr4eAC6zfgA2KUx0NhL3U0vjL4J/2s=;
        b=ImoputXJSnUA2qun1F+RD6DAu+g/pqpVr9zP9bUgclistMeX6Zm7MGAp8PMxtiMFcl
         7vZiilBOYxQNpqK9X1LyKiyrleStsAQZRtzM31BuriCTtpYBpZWizZHGTwZKD3A5/yk5
         6KunpNm9umtoHpxledKNPhuw7vaY69g1OpReu4huiOitpUiOI+Ybmbep38LHSFsAuE0Z
         ToeM6qZXC/7lZBvBplhfFOsM3lBEO3zHbx4L1AyLfsQuNLDt53jK04S9N5JTFT4e2HEo
         i0jhT13f/PdSf4MTa0tUrVjGpOQQCapd/v4uUsUn2TbIGTVsSurDpMfUW3zJ76aZ+gQW
         oKbA==
X-Gm-Message-State: AOAM530cUdWrCPI3j/YzO7k6BtmjcmfFkkJ93xpcMmoEGGM84A+j2GoE
        ncZLmzFKsBi9FamAMqg9MMjGze40FPIBBs8+EtkDmp6VQ5wAKkXvWabgcw6R4GVSdDuHCYKY6m3
        7CmCEFUVdQxmytUWoHj2vn880DbionA3Ml7hHxx+tfg==
X-Received: by 2002:aa7:d5c2:0:b0:42a:a9bf:a646 with SMTP id d2-20020aa7d5c2000000b0042aa9bfa646mr20804904eds.321.1653379131818;
        Tue, 24 May 2022 00:58:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8OsoZI9oxyQnPCxQ7fwhh9KZPz4jaRo2clVqgihgcBQ/sa876cZ4AbBy8lUIP7MpR8lTlLw==
X-Received: by 2002:aa7:d5c2:0:b0:42a:a9bf:a646 with SMTP id d2-20020aa7d5c2000000b0042aa9bfa646mr20804896eds.321.1653379131597;
        Tue, 24 May 2022 00:58:51 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0042abf2affebsm9142442edv.67.2022.05.24.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:58:51 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/3] m68k: Kconfig: Style cleanups
Date:   Tue, 24 May 2022 09:58:45 +0200
Message-Id: <20220524075848.21684-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

While at it, replace single quotes with double quotes, add missing endif
comments and squeeze multiple empty lines.

Juerg Haefliger (3):
  m68k: Kconfig.cpu: Fix indentation and add endif comments
  m68k: Kconfig.debug: Replace single quotes
  m68k: Kconfig.machine: Add endif comment

 arch/m68k/Kconfig.cpu     | 7 +++----
 arch/m68k/Kconfig.debug   | 6 +++---
 arch/m68k/Kconfig.machine | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.32.0

