Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5125231D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiEKLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiEKLfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:35:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A63721A959;
        Wed, 11 May 2022 04:35:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j6so2010600qkp.9;
        Wed, 11 May 2022 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2dieohjKJl3LRE3v0qEPyCNFBVg0n7LQ+TeFcHI+fU=;
        b=JLISchbWbGmgePFdtjCGDZEIifvBjm7I2Nx32rbSTcMIy3DXwdp6bvLxRowwcaRGxn
         MuqAjFikGzI5MArfUMGNkFDB+2+X8SsHbDKXrl8Fqa30LF75JxCBJ8GG1VPyzPS06YVW
         tO7s4D+AXuTZ/j5s1wNiCeSD5QxVE049VdGgxLTsiX4lP39Zc75M9ThwMYfc2FqEMS5W
         H5BND9luFZHGweAfMY/+GtFaHv+XJLxB4G3cQcLx1qNK/TQ2Wqvz15ZRRT5vCgumwZCD
         7sqo8XL54qD2EHxiQN0K2Ik1MFb1jFKgtuwC2ZQI4Y6AQYBW7RW2vIeKZ0l+FxsaPKcB
         rotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2dieohjKJl3LRE3v0qEPyCNFBVg0n7LQ+TeFcHI+fU=;
        b=7dFHtxztu/5ExIFlNejTmqdMOI0EFXXV94HDYBfreE5LVuNVjOBBR36jPYa/ruA8iJ
         y8yqJ2H0Md+cV8iZo3lNrAKxc7cJVrsaoE5ujNR1Z0I9HcEJOh0Jui2dwZeyeIw30ecx
         gHOb1X2Untv+H6LnjDcYgYrNLYNJEIv2+UM/kJoKR2KPTw4vQGG0jIR2Jo/JKIMulv9N
         RkUn9olmCh79PKQlN+XEE6ngBX9vLdk1z6z4/zFpG8LJPbIWyjrPQFxCmfGHTr38Qh93
         BJE/1LLpL3lvz71MBVq+9VQVqQOwUKn5zCF6ZU5M1A3N3pf+6W+DWlb9+QpohsxozZg6
         2F3g==
X-Gm-Message-State: AOAM5329F9LFHK3sHSClS4+a32dXkIi1qNFWNvvNxWy2GKWRxb1Csb63
        PtTqIgon++adnH05mte8A9E=
X-Google-Smtp-Source: ABdhPJzL+T1CaXI7PLHaqwNmp5VdAf/xHGHpPqT6b/rkgiogHkmm9AYlEj1W+JT7TF0qhCvUdXzqqA==
X-Received: by 2002:a37:9ace:0:b0:69f:b424:25b4 with SMTP id c197-20020a379ace000000b0069fb42425b4mr18428024qke.250.1652268920787;
        Wed, 11 May 2022 04:35:20 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id bw26-20020a05622a099a00b002f39b99f6basm953377qtb.84.2022.05.11.04.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:35:20 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: display: panel: feiyang, fy07024di26a30d: make reset gpio optional
Date:   Wed, 11 May 2022 07:35:14 -0400
Message-Id: <20220511113517.4172962-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511113517.4172962-1-pgwipeout@gmail.com>
References: <20220511113517.4172962-1-pgwipeout@gmail.com>
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

Some implementations do not use the reset signal, instead tying it to dvdd.
Make the reset gpio optional to permit this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/feiyang,fy07024di26a30d.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
index 95acf9e96f1c..1cf84c8dd85e 100644
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -35,7 +35,6 @@ required:
   - reg
   - avdd-supply
   - dvdd-supply
-  - reset-gpios
 
 additionalProperties: false
 
-- 
2.25.1

