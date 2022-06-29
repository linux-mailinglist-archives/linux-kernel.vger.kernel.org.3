Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46262560AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiF2USU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2USS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C4D61A3BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656533896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T0mox+cZBa8xwfwYuYJx+Qa0zDUEAbigaM/mBFWN0C8=;
        b=R11959VoduQlp/oDTi7XFnJ+1OOtHBP7H0SMBEvKafow6g+IMEeIsV+Kdv8mQIieTDNUKh
        sGyybcpHZXLGbmSDHV7gdBVarLaZTvikY9kkcpxkT+0Pu0qw3ubyRQin0iczZ3GJZpXgG5
        rflxexOzOmvZlE9oc82IETwYZYAIb3I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-CwLaI2wfPa21lvf0UM8qhw-1; Wed, 29 Jun 2022 16:18:15 -0400
X-MC-Unique: CwLaI2wfPa21lvf0UM8qhw-1
Received: by mail-qk1-f199.google.com with SMTP id q184-20020a378ec1000000b006b14460be35so2489056qkd.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0mox+cZBa8xwfwYuYJx+Qa0zDUEAbigaM/mBFWN0C8=;
        b=Mk3PobcQ++DgVz3WrEFa63bQwvmqZPGBj123O/uYOO7y5Q5zmWkHN6BMQaYYLahmaB
         Pcuu47ASbj17Fhn7/5B1dgm2QVqu1tP1qB7KVIMydyMrLUROQea9s6GD0FnwWvBKDb1I
         US7/vBsK8alKkNqRxgWdVmmP+4D22KMbY0UEwjrru9zXJhIRdCNlcbxkXI9LzuNKm5YX
         WfWA2FugOwqTYlUNw8YjjjwoB8g0Cb64qaPaUQcWiokJFmt4mQ5to6UzqhHxUIeZPap0
         J84yAskCC8VtCGn40hfLMDRgwQc5CjtXcsHdrTaoWeHcGN7IvBPaJamkkC4aaqK+m2l/
         CY/Q==
X-Gm-Message-State: AJIora9ZyTwXfwzEtdU7Lteuz7DATjJd2bR4aEldsd3KKytrNheAFKaD
        SzKNMJaEwlJa4WMGMNddoE15A4Qw2Gg9OW5AdFblZuHboMZwEI3xDcKujiEU0ewcWPI74cTe273
        T9I9eAvvnZVlOs5aY8PgmRaig
X-Received: by 2002:ac8:588e:0:b0:318:88fe:1959 with SMTP id t14-20020ac8588e000000b0031888fe1959mr4303783qta.71.1656533894800;
        Wed, 29 Jun 2022 13:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slW7VD3ZQGeed3+3fKdmGDpjVcX9mn4+bPEdb315aSnZv/k9kpPrgsLRzmOnT9bZdoU9+nHQ==
X-Received: by 2002:ac8:588e:0:b0:318:88fe:1959 with SMTP id t14-20020ac8588e000000b0031888fe1959mr4303766qta.71.1656533894587;
        Wed, 29 Jun 2022 13:18:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003177f0fb61esm10874582qtn.75.2022.06.29.13.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 13:18:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: samsung: change neo1973_audio from a global to static
Date:   Wed, 29 Jun 2022 16:18:11 -0400
Message-Id: <20220629201811.2537853-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
sound/soc/samsung/neo1973_wm8753.c:347:24: warning: symbol 'neo1973_audio' was not declared. Should it be static?

neo1973_audio is only used in neo1973_wm8753.c, so it's
storage class specifier should be static.

Fixes: e26a2abcc246 ("ASoC: samsung: neo1973: turn into platform driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/samsung/neo1973_wm8753.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index c98b68567a89..e9f2334028bf 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -344,7 +344,7 @@ static int neo1973_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(dev, &neo1973);
 }
 
-struct platform_driver neo1973_audio = {
+static struct platform_driver neo1973_audio = {
 	.driver = {
 		.name = "neo1973-audio",
 		.pm = &snd_soc_pm_ops,
-- 
2.27.0

