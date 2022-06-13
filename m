Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE154A198
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbiFMVhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiFMVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:37:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC8DA7;
        Mon, 13 Jun 2022 14:37:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f8so6153296plo.9;
        Mon, 13 Jun 2022 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9RLmP6mHqivOhQLsjVZ35Ws79nkzH1UlnUHtTKoK5k=;
        b=Shkj4PWmcClZWzV1mk6N25cP0cz4RJxAekwqIfiiYCGP+n6u0gAVAsoqxCHjyqaFwc
         zhswTk+jTyW2tN8k4uEPOVpL5ueaDIgAGIXmGwAqTUu0pFT1JGdkKubX/Y6v8jrrwiDV
         VxmYoQ44puWWuOvCiNEB/RsB5hC/Q+Q6X+1czbO3dVs9H7s+X8KCzcG9EicuJeEAFq38
         9qhkqX7yw1596SXdEO3BKwD+mBFR/bmqt2S8PHD+Kg03VSPP4PQoB+QlIeka5FwlOIYD
         BDY6GqPj+ohQVVAQQKaoXBe+kpmg03WOUlCMlPadXt6LZc67rW+hbgqoyfECmjrRI3zM
         FDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9RLmP6mHqivOhQLsjVZ35Ws79nkzH1UlnUHtTKoK5k=;
        b=zTBz9cqwntAOD13hvMcVadfqGrO0X9+4cAs6bfJjJ6k0+88aP/byAPXYjYU/4hK2ZA
         Cb4nQkIT/R0ra6M+sAU961ncx9t/HMFJTKnDVw1p1O9OR7TBbnIElmO1ifU8BedArr39
         bxgidYepKtpWrt8aJyz/pr9oOcDJYB+Qmfu6PXWGV6QPJGVm9ddQjXJfu9xP90DtvBNG
         8nP8cTdWoAhGb4bOVEOVuRihd6x8gkgX3TmJAjhe+XXwuxfDXCW8Od6WplyZyQEGP79/
         WBxdeCIfvms/+UArOWAVb5zZbNsHmMjBPey1eWU0LLH5/n9m1L2fG69uJp7Xovl0cx+V
         Volw==
X-Gm-Message-State: AJIora9/JL3kbtr5IoPtSviXiASw/Sjnon4QII7aPq5Wb+EP2VU/m4GH
        rGYrK060bTwWr6NEUYP/cHU=
X-Google-Smtp-Source: AGRyM1teiX2pTy1YaOSlBxQm6PK6FAhzwSD1ZGvK/oEgiUUak1INzHWuCQXaUEx7DUlZbS3tEjjk7A==
X-Received: by 2002:a17:902:f710:b0:167:7a06:b2ce with SMTP id h16-20020a170902f71000b001677a06b2cemr1144697plo.104.1655156244885;
        Mon, 13 Jun 2022 14:37:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i67-20020a62c146000000b0051c1b445094sm5869615pfg.7.2022.06.13.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:37:24 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: Add BCM63148 SoC
Date:   Mon, 13 Jun 2022 14:37:23 -0700
Message-Id: <20220613213723.268194-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610002113.14483-2-william.zhang@broadcom.com>
References: <20220610002113.14483-1-william.zhang@broadcom.com> <20220610002113.14483-2-william.zhang@broadcom.com>
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

On Thu,  9 Jun 2022 17:21:11 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM63148 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
