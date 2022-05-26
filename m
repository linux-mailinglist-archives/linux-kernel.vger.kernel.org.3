Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF89534A97
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiEZG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239214AbiEZG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:57:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87527CD9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:57:50 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB6223F21C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653548261;
        bh=YwbocuSneHvQq0fh/EdmbXmlfTeqDwMbby8XL3N7k/U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AVzKQVVw6TAGDLnKvunWmwYt/vuoJeWlSsWN0c6fC8Ls5GcSKlxqeKHXqxPZAigMq
         uewf8jwgt5JMG1muu29/LGH6bz6E+VkF6YiYd2xiToOOdiCtwMWzSu83+emDMaLnw/
         v9h8nC9Lw5jhtIMufDudYqzJHi9Jebb0BTAr3V7FPGmuWuHD1oCnnpRDGol+5ML8EN
         KwVzfBBmnCxM7C/z+DUfBAofjmg5fmlHA5CbZEXq0+q6C+JDTrUXviy5AfbJnunszD
         hdXu2P3o+BcVKxl4OJg3sAmJDXQ+V9mE56zTvAD3N6s3YQkvWHyObTALV0tNJc6lJO
         lQ/hmLZbP07HQ==
Received: by mail-ej1-f70.google.com with SMTP id lf18-20020a170906ae5200b006fec8de9f0cso396682ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwbocuSneHvQq0fh/EdmbXmlfTeqDwMbby8XL3N7k/U=;
        b=VGqIX2NtbA0tV3I4/HahrCIa3AezWRnPOxO7OFIMQCjl2farP3rov1tV404omKnkt1
         agH9P7qYzv3hsK5D+Ffn5PYc6cRSmRjn6he1GYFHf6uETsboSxf31Gs/tkR0KxLgbo/u
         x7z2GxoKY97FzCO3SAGQ/dOJ3g0zJt0bH2Gia/NinCHmytArv02pw+3sIp+1XlJ2qOfE
         I0PBgCeJtAZfoqi7VmEb+VzKui9iyub9jJE6acLR1t78JDospfFas/6we5A4wCvQfWfC
         /5fbCX48GRoJV/8mQCNiEeiDh2Ie+VaPK5Jm26jtE5z8uc98XRtNMISzBF6te7vvEyxA
         +Dsw==
X-Gm-Message-State: AOAM531U7vigQNPeG8lz6/BP+pjrBraIQFDvfDcfhJ4j60PtB7Jk+BK3
        ROt0rizKn30sOaYJXrYfpNNmcZVRAO1WQ7UKCkrKNgGq0QI/fq/+F2T5m8S/Ot0BKg6Z938Ho7V
        Kk5mOX/8/8/XW5STM8dpD60fIClr8KunPQGa7bPf1zA==
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr31517636edb.211.1653548261445;
        Wed, 25 May 2022 23:57:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrCbaTkwubd8CefOtFsYwzxV3AEkWN3OGRmcmHpo3yFUy4WL5kUwmf18rbGX6Kv/KSsK8d0A==
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr31517629edb.211.1653548261294;
        Wed, 25 May 2022 23:57:41 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090652cf00b006fed8dfcf78sm220906ejn.225.2022.05.25.23.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 23:57:40 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/2] powerpc: Kconfig cleanups
Date:   Thu, 26 May 2022 08:57:35 +0200
Message-Id: <20220526065737.86370-1-juerg.haefliger@canonical.com>
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

Replace some stray tabs with whitespaces and remove an extra empty
line.

Juerg Haefliger (2):
  powerpc: Kconfig: Replace tabs with whitespaces
  powerpc: Kconfig.debug: Remove extra empty line

 arch/powerpc/Kconfig       | 6 +++---
 arch/powerpc/Kconfig.debug | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.32.0

