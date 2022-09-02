Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2B5AB601
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiIBP4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiIBPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A1533427
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b16so2836554wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f3juMO/QwGZ+BjBeOfHfdqcLNOZRF7cyhCYwluCkxeQ=;
        b=l6ZMiuaH2GBS48BynCtAjlqvYjt+j0meLlxoqtvlQIy2VFUyzHDqSj7S0QuCQG9bYf
         +eNClJ+N3e/bqFwgs5VFwMpE5BKjK+k1GNj69Vth/U+SUC0IP2w2QsdZYlPp9yVuft/L
         iosNY3HcYryovoH1KnjgnrO0uc3x/K3kjq74Ej4QTvzz/fzMszyyswCX5HRIpB/3TbaG
         cDFE0sa0RbmCOjybqV02ZRezr2vXaHJFEvZJlrS20ErLKDXmGdElFWS6f9+04pgIr9CO
         hzhv+QhL9ksiKW5G4Mok2vxDfVR4K/XYO+Uh2XifS+55yw9RfkoC2EDXyE7VhfpYq1Mz
         FdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f3juMO/QwGZ+BjBeOfHfdqcLNOZRF7cyhCYwluCkxeQ=;
        b=WkI3jqoEYQ249NDZ4a+FitfWPK5my30jEf0cnY4YMxws6i6s5v/AwxNbWpNhgFKd9+
         KNZBnQfyKY+mhigUYOEHdx4Dana0b5d7zRYJLrM6AYTTIGf567nSjOpm1VIh/4GKuLZl
         uqpxYh0xZ/BGVSMOQKl0OrsfgXYcvrJb+OQIMDnPEgi7JPvBrUm6kOW0h9xX6w7F5AVT
         eef1DqVIRyeZboObN2bZg960dH+HRAtDaeBtc6Ve/TcsRkWODoIcAvMlwWTQhVnmBrlp
         5TewUacZspXSS9Ue+jL5m4oMawfJUJaZt0fPSRY0sVli5Hy6kgD0KbMxCbtsReNN2mBJ
         1JXA==
X-Gm-Message-State: ACgBeo2rJGNFNpBh+9foWYe6NBYGrv00UWLtV/V8N7wqBH1G+vXsYE9p
        Z61n0kcTf8dEj63xkjqxWjZBKQ==
X-Google-Smtp-Source: AA6agR67PrNtPxy6XyYWdGT3MvB/MdDSK3BWUvCd3mqVMFpV0l+bZKI/hbR5S2TOWliiUndMK9aNPg==
X-Received: by 2002:a5d:64e1:0:b0:226:db58:868b with SMTP id g1-20020a5d64e1000000b00226db58868bmr14746743wri.79.1662133769552;
        Fri, 02 Sep 2022 08:49:29 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:29 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 05/10] misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
Date:   Fri,  2 Sep 2022 18:48:55 +0300
Message-Id: <20220902154900.3404524-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the kref_init right after the allocation so that we can use
fastrpc_map_put on any following error case.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6730aa324e10..5eececd9b6bd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -745,6 +745,8 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&map->node);
+	kref_init(&map->refcount);
+
 	map->fl = fl;
 	map->fd = fd;
 	map->buf = dma_buf_get(fd);
@@ -771,7 +773,6 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
-	kref_init(&map->refcount);
 
 	if (attr & FASTRPC_ATTR_SECUREMAP) {
 		/*
@@ -801,7 +802,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 attach_err:
 	dma_buf_put(map->buf);
 get_err:
-	kfree(map);
+	fastrpc_map_put(map);
 
 	return err;
 }
-- 
2.34.1

