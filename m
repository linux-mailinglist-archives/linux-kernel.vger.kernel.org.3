Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98504A9CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376495AbiBDQTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:19:35 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55400
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376476AbiBDQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:19:30 -0500
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 62C2840257
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643991569;
        bh=SA2GI74r1s2vKFFmTBz68RYXjDaJW6xo6+qC9T4Rl88=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=VuRPzO4CKBxXIg9TQLSEWf3KuGjeCgWszadL5Pq3BT61zl1XlA3T1hx9bYxN25ip8
         ZLcZOH0rETFTe4wpp4KkmAx3LQwhGZVQtHaitTUchluC7heMHXNanaMgwWVmNMLeRy
         utohYhIBF4bUDuy16gRLcHZJ3Hx0SZPJPzcKROcK2dhtaBNMlFQM+4K6lL5Vz7f/It
         fDGs6riRJ6EzEPdd4e8xKrYkWP4mIxvIqpFnE3lwewZMSquY8GBbMvuiDzuEfVrDwl
         vzaEnw7EhjG32xU5marQWnISum9z9YQVlnKseuw1pSP9CxhiyUxDumKsrOlJkv0INs
         hjotsEfubMsLQ==
Received: by mail-ej1-f69.google.com with SMTP id i21-20020a1709063c5500b006b4c7308c19so2783713ejg.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 08:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA2GI74r1s2vKFFmTBz68RYXjDaJW6xo6+qC9T4Rl88=;
        b=xanab9MieBryn9IZXw4eu+jAsdpmgpvTMoQDvP8mMvWBu3YVObcJ9uUV3C686PHCIN
         uk/SN3kRQINuU20d6xP4y9EJ+Nbc/ZjHFaqw+1NH3d03qNS82mGCUhK9CNxuIZeY52to
         uMcvUIOcDZZlW5OXcjI6RGO2hi7ynjWxiQzNdZLgBMJIQT/kv628CqGxCWX4NsuPJt6v
         Ywn2F6EXatSm4cUUVWjDUxklT01TLovJXg7TKp95xO4HxyIioV4vLcQtZU9AryDPU84y
         OZsxIsXHqDD2X8aJDSQcAANl8Pug4THIsz96UU87Fdh//QmuQnoAN8buhM7ao0veH3eX
         C26g==
X-Gm-Message-State: AOAM531qBXbajdXWUzoo0vR1gj6ItTThuF+DrEtGg8dPidoEY2b8M+0X
        Lfeb08RmFOgsHabdrwB+q/TGA/hMlgkrUlxqGlxkvv9wxN6wfjf12EEflAGmKeAu1SSTMHSHhGa
        vjDycKgs6wVBodDT3U9fpIYFfv82YhuDp2NvftFrDiw==
X-Received: by 2002:a17:907:6096:: with SMTP id ht22mr3051343ejc.611.1643991569058;
        Fri, 04 Feb 2022 08:19:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbQ81fKkhozb6vr0tFNLKJuKFnpvqMFAgH1d+q7WLhJu8H/EkVd5KWMt3yWUBheeTE4qicvw==
X-Received: by 2002:a17:907:6096:: with SMTP id ht22mr3051331ejc.611.1643991568849;
        Fri, 04 Feb 2022 08:19:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id w6sm1002195edd.50.2022.02.04.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 08:19:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH] MAINTAINERS: dt-bindings: Add Krzysztof Kozlowski
Date:   Fri,  4 Feb 2022 17:18:51 +0100
Message-Id: <20220204161851.138874-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Krzysztof Kozlowski as a second maintainer for the Devicetree
bindings, to share the Rob's workload and help in review.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

After talks with Rob.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49c897fa56af..94e697e36399 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14450,6 +14450,7 @@ F:	scripts/dtc/
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
 M:	Rob Herring <robh+dt@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 Q:	http://patchwork.ozlabs.org/project/devicetree-bindings/list/
-- 
2.32.0

