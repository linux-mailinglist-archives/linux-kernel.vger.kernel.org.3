Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891D4CFEF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiCGMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiCGMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:40:57 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF95943ACB;
        Mon,  7 Mar 2022 04:40:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx1-20020a17090b228100b001bf2dd26729so6768300pjb.1;
        Mon, 07 Mar 2022 04:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=dHsR3ao0+xiXYz+qySp/eO6Jeo43rF2+fndDyCDm5CI=;
        b=Rc0lOw3FgFRLAsd7u/DZJrhDJcbnYhMJ/edMTz2xVyQIeT0FJq00ihuiveFiTc8z1G
         iMfvs7k+Lw2IHVlSyq7jCRsbeTHobIFuiaEUPH0sYlNERgv/qTA+s5h/feUQVVammIqB
         jCx5gxtn0oICvoNEMKRnVgXMkKHJ6oW6Bb2VeJSOTd/Sovq6oyCc6y+Oqj3zzXX3v+UR
         R47BD4fM6PuDJtwYDSIV12jd8oSksmffC8nATaB3VogSj5Gk3PetfwqoRtbkb1H7yLHv
         tsWP8oZnkfxW8TNf8N/b8NFPdx2wmzKHhvyeir+LhwdAagZTpr9JcbUhL6/VX7znWUES
         bCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=dHsR3ao0+xiXYz+qySp/eO6Jeo43rF2+fndDyCDm5CI=;
        b=MQxj/CtAgFtSnspEPI++J7D3g03vzlRT94AaQzUA+my+5rfWxetYG0Z5YKjgN2KYrb
         s4TAe6e53bOl9u6rBQH4Oed582y5EYIt71btAOvBeFW6T2bmN2v5MpFkRQXd5e06wpsz
         D/CfnEsOQ+rjUYRCpD5ikYQVoWQoytnav+9dwt6BkkGi7YHOEh1uKcZwLy23JocbMwdZ
         azqm0wLV9JdJl1LfaehZXkQvTlSIb+hFr1MrZTvxScQyd79ZxfyTM1AKN9fpI+wkrakH
         mj542mkIgulVlKCbmuG6BcPhg2iEcpmdLhAh2XFGnZh4IAOn3R9JjSbVwc1OE4IYuTxb
         dPZw==
X-Gm-Message-State: AOAM533aq0nzDDd973I+y0oWgq+2A4HfBLjyC7TOkU38gh8r5ET4f69a
        7Z4CyFQGcvHTpoEIDNzHcFM=
X-Google-Smtp-Source: ABdhPJznGIbMiQ2zK8bIDsA3ZjDX9lSU/OOB0ngOTGlZjuFIN3Qa4EfVixbTbjo+6MMS4ZEfjCq9ZA==
X-Received: by 2002:a17:903:291:b0:150:4197:7cf2 with SMTP id j17-20020a170903029100b0015041977cf2mr11633351plr.173.1646656803121;
        Mon, 07 Mar 2022 04:40:03 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id w5-20020a17090a6b8500b001bf564e624esm4687093pjj.39.2022.03.07.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:40:02 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Helge Deller <deller@gmx.de>, Miaoqian Lin <linmq006@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Dave Airlie <airlied@gmail.com>, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] omapfb: Add missing of_node_put() in dvic_probe_of
Date:   Mon,  7 Mar 2022 12:38:12 +0000
Message-Id: <20220307123816.31888-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
index 2fa436475b40..c8ad3ef42bd3 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
@@ -246,6 +246,7 @@ static int dvic_probe_of(struct platform_device *pdev)
 	adapter_node = of_parse_phandle(node, "ddc-i2c-bus", 0);
 	if (adapter_node) {
 		adapter = of_get_i2c_adapter_by_node(adapter_node);
+		of_node_put(adapter_node);
 		if (adapter == NULL) {
 			dev_err(&pdev->dev, "failed to parse ddc-i2c-bus\n");
 			omap_dss_put_device(ddata->in);
-- 
2.17.1

