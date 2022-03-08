Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F594D163A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbiCHL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCHL1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:27:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5446655;
        Tue,  8 Mar 2022 03:26:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso1221218wms.0;
        Tue, 08 Mar 2022 03:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cIWJ050d21bkpZ3eybYb0e61vkw3HZkkX+6msnmx6MU=;
        b=HHK3bdFpL7gIdoKyh9VaCVqO9lSGR43eZqTPcjtpYElw8sjemly5wGs6/jIqFTd8qK
         JjsftYTLai7Tjcd9e/ZIzWzERD0f48sQBImnhiiQpiSNJ1rlWwmgMlg3Qz+bFgs0qSRT
         HLzj/qSjSNM7UXdz1Kp3AqHYo0/MCKnZmDPaTXwv5QAFs8QtBRbWKUvj/FI2caDLJgGs
         W3xBZFRTBjz4UJdJIAzuJZ5x1mZfXrYSns2A/ORoNWBh824rOoPLcy4aY+NR+wSbun20
         94rkJ85Z3BYG4m+OV1/MMGgNtwPgY6EkNmaFyhILsYpT9wXQHAoAOBNZL9vjBqVNExZl
         yPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cIWJ050d21bkpZ3eybYb0e61vkw3HZkkX+6msnmx6MU=;
        b=5ac9G96YV5Fr3iM6B3DFDXkaCOhs0QXr0WZwHdeOt3fsZjUHxT2sLODzwXXKdirQ+e
         4f1pqAAp64J+M+vBzyhmtI+aUx5cub5qG9UpPEDC/Kq76DjgIT1LWWPcQUa3uYfT+tVR
         H2DamlRWO7zhjd43hNVmVfJ4OPF28mJgeMITDiiOddDMfc0tJsoid8qwogxXLK/vvKHz
         jVjhozB0DVkbtuSeaJcExx5ADWDYdtT4Ty0/Qzlc7fvlW5XXfs1piK1RWZJp9utL6cEh
         vmlJmtgJRqRr516k+6S1396la4pNm+/u+PJGgO8eOWBuFjEmBWVgg2UTySw8RbXnThp1
         xBTA==
X-Gm-Message-State: AOAM530/zSLkpr4+kKxEZ8EbEcNxi2yM9VNkmw1bgyaE3rNC4wVsrk0u
        HoKrPTuq1PBeeleXO3iGqB4=
X-Google-Smtp-Source: ABdhPJxx/EbY/Bm+Wp1ucslvnvQT5h2VqklVg6iZBDmXp/1ZZkznDRLtCRcNaJvKmfqH/A4PP/LLkg==
X-Received: by 2002:a1c:2bc3:0:b0:381:3dd5:5707 with SMTP id r186-20020a1c2bc3000000b003813dd55707mr3010118wmr.31.1646738808387;
        Tue, 08 Mar 2022 03:26:48 -0800 (PST)
Received: from felia.fritz.box (200116b82626c9000cc91df728b27ead.dip.versatel-1u1.de. [2001:16b8:2626:c900:cc9:1df7:28b2:7ead])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm14141215wre.22.2022.03.08.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:26:48 -0800 (PST)
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
Subject: [PATCH 1/2] MAINTAINERS: refurbish MEDIATEK JPEG DRIVER section
Date:   Tue,  8 Mar 2022 12:26:29 +0100
Message-Id: <20220308112630.546-2-lukas.bulwahn@gmail.com>
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

Commit a16ce2f33732 ("media: dt-bindings: mediatek: convert mtk jpeg
decoder/encoder to yaml") converts mediatek-jpeg-decoder.txt to yaml, but
missed to adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

While touching this section, generalize the file entry to also cover the
encoder yaml devicetree, as the driver directory also includes the encoder.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80e5867b2afa..fe3feca0b7c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12337,7 +12337,7 @@ MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+F:	Documentation/devicetree/bindings/media/mediatek-jpeg-*.yaml
 F:	drivers/media/platform/mtk-jpeg/
 
 MEDIATEK MDP DRIVER
-- 
2.17.1

