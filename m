Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68235533CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbiEYMkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbiEYMkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:40:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555DF7A821
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:21 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 793823F044
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482415;
        bh=iyJ1o3EKMPaP9U9I8uxiOxxTU+2g3bHGq6iXs/oFCNA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=voPXEwGnHf0i3Pp7JHn3osGA4M9rEiS2PVVxjhXNOkEi1/f0PVQOPuQ9p1Y8crB1c
         Azqdn3X1VkvQ3lDh8UNOcS22rqOjLjvQcJ+wh0bWy11NVmqozxCxgr/A3sZTkBGfnT
         RyZIlsgWq+qnb4Y0qKe+UGYv6THifAH5prW9i4HnQIPa1AQrYkNDDPR4IKsMlfU0rh
         1nBFKa+zKFiUoNkruFMCKzf+jtS40kGXSfHaFnU4sDile0FAiqJFyC2HhIM0Xtft1R
         YAlQBWJ4l3RnwfjIyl6+haFBEZRFBPqohr4fBmFyA6yCR3fDem/90fSUUGAYqZbYjO
         K+FzDEFapAaGg==
Received: by mail-ed1-f71.google.com with SMTP id ay24-20020a056402203800b0042a96a76ba5so14825840edb.20
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyJ1o3EKMPaP9U9I8uxiOxxTU+2g3bHGq6iXs/oFCNA=;
        b=RmOXFVgHZhc3XICC+wSoNbiL5170NJ2pWt/PTLocUfOm3DzcFYgb8DGOQi1rnAbvla
         vVAgfjBJrUON+BdrPsllRgI6xb3lEJY0/4y7wU3rll3axT3IhZzLxVI8SOFa1h+UyVsv
         CRMHFDiCcEoJhrEacIguKpcUz8danGbQPrOnb5B+9nQL9M2qKC6rM6oyQ/9ONB6lqwFL
         WEOTsQw5uzHxNQ2JV4IcwLdZUTDPLoAdGg5A+BRRxEp00ZAPcOAcqBdqk6wt4sTYBFk9
         3wmCC4rq4t/WlWEvTWumpJRjK2F5l57P4hOkc2OR24Tr0ig1M+i94xZdaETIRUZvbM5u
         rheg==
X-Gm-Message-State: AOAM5312TbQ80Gp+ki/HGJ22WAJquVNXEmEeipELzVNpX+kGyQNhdNwX
        X9q/QrQPM43XzxlqHoAXYRHqTzc8Hy7b70xXKOOfUy5N9zlnw0MoOTxwYFLihrVERCdXjqHTTKv
        jT9iVoY+F8nDTpfxHOaFg7D1d3VwYTsTllylR5yEDBQ==
X-Received: by 2002:a17:906:7953:b0:6fe:dcc0:356f with SMTP id l19-20020a170906795300b006fedcc0356fmr14554446ejo.75.1653482414692;
        Wed, 25 May 2022 05:40:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx83tUQ8lAH/eJDzSXN4oqG7jrKL0YqzLNVQoUp9dVB4Penplu8F9OeFkvKXkIq0sU0eOIrMg==
X-Received: by 2002:a17:906:7953:b0:6fe:dcc0:356f with SMTP id l19-20020a170906795300b006fedcc0356fmr14554432ejo.75.1653482414484;
        Wed, 25 May 2022 05:40:14 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:13 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/4] sh: Kconfig: Style cleanups
Date:   Wed, 25 May 2022 14:40:03 +0200
Message-Id: <20220525124007.45328-1-juerg.haefliger@canonical.com>
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

Juerg Haefliger (4):
  sh: Kconfig: Fix indentation
  sh: Kconfig.cpu: Fix indentation
  sh/boards: Kconfig: Fix indentation
  sh/mm: Kconfig: Fix indentation

 arch/sh/Kconfig        | 24 ++++++++++++------------
 arch/sh/Kconfig.cpu    |  2 +-
 arch/sh/boards/Kconfig | 12 ++++++------
 arch/sh/mm/Kconfig     |  6 +++---
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.32.0

