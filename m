Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6F4D163B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiCHL15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346497AbiCHL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:27:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B421443E6;
        Tue,  8 Mar 2022 03:26:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1290853wmf.0;
        Tue, 08 Mar 2022 03:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oUGbKpyqaCA2lCo6XjUtMOfHtbuoF0WQ8BNTKgdnnC4=;
        b=O97GZllgNql+6jG2sVdKquf4hAQ98Q3UPAp3d4uyEU/cl9pgKfhlLsSyrryN9WHySq
         FcbdvyQg7WXXhBOU4lLcPRfGQkciOHE27HzrKbfY0TnDDOIlGvcRXXZGdCp12/oVXSc7
         JpJADbtGAp5dl3YcLrD0oM0RwqxDhuU78ttplK/6tV7G1JZLH/wEHD51nPuNxKp79toD
         g5/FwL20+dltcuz8woBQ/9qbRUD4dR7f73jn6DHAt7aIqesDn3v2GWTlAELJaZ2XzPIV
         8lFn4Yd/pFPf3CR56jjSCK5T7aXk3VDdlWgiVYNaVO7NR8zFLvByB+PgrXtshfeyDZEy
         jVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oUGbKpyqaCA2lCo6XjUtMOfHtbuoF0WQ8BNTKgdnnC4=;
        b=R8/Af1lBm88jsCt1iAGfTk8AzvZbNhOQmbuWCI54gAbuQXwdAo/qxlOl+s0ayR8mBS
         eQUd4kPAjJihra280rohUl+xfhE1FHnE9pHwP2vtCyoRUeHqiewiuz0w0hYU+UTfZ5vC
         Edyy1eZF5y6ux21eTmSlTmMmhA/48VvZ+XqvXjPfH0HWRhOfHtblzcqm0lPip8+CkAew
         3xPZHNN14+8kXUzyyhzNcjOjVzHqroWXhVKTHf1y4tLYETWK/oOPHsVjLF/wb0R4XT0j
         3NLMFBJ2TkvEesoqEUT8ZGDgG1OXBqUzjtOS5ySo9f4zgHhLIBmaLxqM/c4RhL7dLp8A
         sp7Q==
X-Gm-Message-State: AOAM533EaKqA1NkpMVGOxaVWt83Gb4QTB2LPrX6lrJc6Cd8P2g8d6b8f
        OdTT1shiuZ0tk9dN0kH6jzg=
X-Google-Smtp-Source: ABdhPJzO7+HQKorna2n6eyt+kiKIZsP6vwIUDvvQdcH7sAyPNFz0ZKI7kb8KQwQRv6eAcMn6tj2Utg==
X-Received: by 2002:a7b:c3d5:0:b0:389:a49f:c7e6 with SMTP id t21-20020a7bc3d5000000b00389a49fc7e6mr3155985wmj.99.1646738811975;
        Tue, 08 Mar 2022 03:26:51 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm14141215wre.22.2022.03.08.03.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:26:51 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: rectify entry for MEDIATEK MEDIA DRIVER
Date:   Tue,  8 Mar 2022 12:26:30 +0100
Message-Id: <20220308112630.546-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308112630.546-1-lukas.bulwahn@gmail.com>
References: <20220308112630.546-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9cdd70ceb6fa ("media: dt-bindings: media: mtk-vcodec: Separate video
encoder and decoder dt-bindings") converts and splits mediatek-vcodec.txt
to mediatek,vcodec-{de,en}coder.yaml, but missed to adjust its reference
in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in MEDIATEK MEDIA DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe3feca0b7c6..38cdf9aadfe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12353,7 +12353,7 @@ MEDIATEK MEDIA DRIVER
 M:	Tiffany Lin <tiffany.lin@mediatek.com>
 M:	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+F:	Documentation/devicetree/bindings/media/mediatek,vcodec*.yaml
 F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 F:	drivers/media/platform/mtk-vcodec/
 F:	drivers/media/platform/mtk-vpu/
-- 
2.17.1

