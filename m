Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D45A436A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiH2Gx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiH2Gxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:53:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4215C422D8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:53:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p18so7073829plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=oNF3DLPEKA26Di+mpF1fWdN9sKEfroJeBJj0DtHKDGY=;
        b=dkqetvSqnaceCbhc1F0YyhJTZ4pds6WUrC6W87UpV7KTJ0hI4mBsTa1gfvooDAZPiZ
         clU+xYbSMQdPA21yWdd7/izK/QQ9qQIBuB5uhoT3xPBP9bCGb0Sz6L9hcuJGtzjT+YtW
         qPzqr67f4an9pfC5Oy+jHh79ZuSaTs6DTWC1JfF31K/xXr5Pj0OZjxXNkQCM1LaAKFyV
         cgCl6F1Ky7esI5WJvet0wby4O9zDOhFo7pzD5HxbW03nqY2DMyZt65FxnOZa4X0kEDfm
         19t7wYB8F4KLyRz5UN175PivAb1J5640k8lce3i7RSk5g8qCKIc1fuyAY15cW5Na83p0
         clZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=oNF3DLPEKA26Di+mpF1fWdN9sKEfroJeBJj0DtHKDGY=;
        b=XnuQlhJpUH2IhdPFP2q516zkFWECMeLxlPp1qFRc9cYnP7hn7rJ/Melhmbf7mXZH6z
         18eznHcHqnl5+bs0DsDI6PiGCzGrWYVy/d2buUZRhsFzBtlXjqC4Wy1rLdHU6cW8FxVT
         ng/aQJoPCDUGalGugKdd3SCDYdtCd7UNfZztp3zK3ei5zA2NRQ2L1ZBVCD2mJ59lZXlw
         SrK83p4N9QmDxyvBDGw4SZweYTkzwEjJzg9ti3dsnq7X8HyUU9u12c8fizasyEINr166
         uo2MU3pUpvhFembTSUdKeyUXUYA1KN0f9pTzRcjM49XdfPwLInEK0FmlINo7pYhjMJi9
         Fj5Q==
X-Gm-Message-State: ACgBeo1DFqlzLS62oq8T25yO5cBHXhWfcUJn3JINRy8fa4csfYbuqWXy
        LIxn8EYpRwxYxE7UxIj6BDS4RA==
X-Google-Smtp-Source: AA6agR4EYLnKQyPXSeugxtSppIBJwCo/YTsNTMCQBiXve4UMYXufSVevVA8IRSIfdhYj71sFJx2XHg==
X-Received: by 2002:a17:90b:1b49:b0:1fd:dccc:91f7 with SMTP id nv9-20020a17090b1b4900b001fddccc91f7mr1922381pjb.200.1661756032840;
        Sun, 28 Aug 2022 23:53:52 -0700 (PDT)
Received: from archl-hc1b.. ([103.51.72.9])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b00537d4a3aec9sm5687314pfp.104.2022.08.28.23.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:53:52 -0700 (PDT)
From:   Anand Moon <anand@edgeble.ai>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>
Cc:     Jagan Teki <jagan@edgeble.ai>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: rockchip-dwmac: add rv1126 compatible string
Date:   Mon, 29 Aug 2022 06:50:41 +0000
Message-Id: <20220829065044.1736-1-anand@edgeble.ai>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for RV1126 gmac, and constrain it to
be compatible with Synopsys dwmac 4.20a.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 083623c8d718..346e248a6ba5 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -26,6 +26,7 @@ select:
           - rockchip,rk3399-gmac
           - rockchip,rk3568-gmac
           - rockchip,rv1108-gmac
+          - rockchip,rv1126-gmac
   required:
     - compatible
 
-- 
2.37.2

