Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF35E54D026
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbiFORj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244729AbiFORjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:39:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4352B3E;
        Wed, 15 Jun 2022 10:39:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 187so12057057pfu.9;
        Wed, 15 Jun 2022 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5/V956sTxH14N5WfQvdhuuD83UaRrnJTRkjjl46oig=;
        b=QQxr/HV2Xq+o2keHb2P9sbONd3hshCUCGKrbI4IH74HH91fGQbBT4nSiFnnMh6eiXL
         9RgN2+ZcrGVxdq101fCKPiDj2bUwu1um4flN/aXufprtQKVsqXgmUSGTbb5Zcfg45gvT
         a+cYmo/vKOzC4rhL2N85QMY9QE+MpATZXcq+ZPRreMQBFUtYoYFT+25tPtSs2DlyYi4A
         j7JlMVXDmRvmwzKoqyy0l6ujecb8y7gxHuwuoj3KfowWPs7BilG5XIvMs1eAMj1TQy0V
         PKv33SBIHJ/Kv0gbBNw8LOwyY7LS9BSff21GDIUeMKnpRgi15wdjMEU4StMeoRiAm43W
         q8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5/V956sTxH14N5WfQvdhuuD83UaRrnJTRkjjl46oig=;
        b=oFK/2LBRTjA45lMuV3a9Z+7MMch2uyoiS/GdF4XxwX8NweG5fYXMoPrYnWhfQgguNL
         VE8xr0He+RJT8Vm2jRDjE5Yu36ThZ3WQbJVA672mbV4iCG/LJUF+cV2mCiIY2o1lvBiI
         +un8QDHj0Awfv0afqs0e3RuS2S8Yku+SLGv0kvQ6ITwhSIeBEX+1nQV0mQAQHcaIgZQF
         ML0jQadz1uxaW+nL7BBV1lHEsQyVejb0OFxD7T+glSFdNSH494SZkPOmzSZSYPfEbG2x
         MexU6A5MLqK5b5rTx0BEtjssrhv1Kos37DiO8Sdv14ToB1ou7LH5iSfVTRGAXERMLqIp
         qoIA==
X-Gm-Message-State: AJIora9bg9RRTHtpZLHdFOJieuZdddo+gLzFxH8FaSvieGIWYd9xM9lZ
        6mwAZafZxvGqvSgvcvnIZKlHIFloeyU=
X-Google-Smtp-Source: AGRyM1uiwP2cE1rNpILNRZ+HagwzlwEGLBZecc2WxRPoIGxYYANuDSl5kEt4iqixaVRIGYdLwkut3w==
X-Received: by 2002:a63:5703:0:b0:408:b2c3:8df9 with SMTP id l3-20020a635703000000b00408b2c38df9mr755123pgb.247.1655314763709;
        Wed, 15 Jun 2022 10:39:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001e67e01158fsm2107461pjx.30.2022.06.15.10.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:39:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, samyon.furman@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM6813 SoC
Date:   Wed, 15 Jun 2022 10:39:22 -0700
Message-Id: <20220615173922.1991276-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610001534.14275-2-william.zhang@broadcom.com>
References: <20220610001534.14275-1-william.zhang@broadcom.com> <20220610001534.14275-2-william.zhang@broadcom.com>
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

On Thu,  9 Jun 2022 17:15:32 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6813 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
