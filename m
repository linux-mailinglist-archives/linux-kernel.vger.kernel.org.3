Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7154A155
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbiFMV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352146AbiFMV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:27:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA701DA51;
        Mon, 13 Jun 2022 14:18:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z14so1990001pjb.4;
        Mon, 13 Jun 2022 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njQUs4WLg/tZ3t8xvzsqGh4iIGBm2t8S2b1i9sg/WfE=;
        b=ik1u/qh5X6+xXXy2kU64Cuq2LyBSI6nt5l9ZmJ2rw7u8kSyz+qbixJv6bkflYGCVAe
         0J1vCbSU0SSngH1KhSKF6bBq0kVt82gFRfSMqElSda0DNiN6S4szVB2Le+x9OG6hx5vv
         xTHuuTbWzeS6a/9kYkWUsbhORe+vsRX7oTlx1Z9cTbr3G6s0q3IwXP9pxoTl8Hu443lV
         tEgKpjzCArz/SjuNsuTE8oJS8q/9mXL2RSuuD5yBpvzycjfmCJ8WzLEd9c1LT90rdbHB
         9EaoY3RoPwKS7Hxk2T61IKjm6jgl37yXqxBrOMIxUQX1K6QPtTqw4SPvkk2HzMUYTpb5
         aFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njQUs4WLg/tZ3t8xvzsqGh4iIGBm2t8S2b1i9sg/WfE=;
        b=5fuBSnd9xKFavIs9MsPiY7c9O+3v9+ELtWXD9e26fV6BE8owGI9tqEh8DizXz+kCYh
         blSxBAK/KWzj6G0y46swrM68NRf4KShjjAtU2SB8qMEwTJfhYnou2LUwzGbdw70Ycdab
         8ZOo8OFeJ4x4E6kgtboWZxYa5TUmuyEphA2K6FVP9wA30dVPNXqa1PWdF1SBIZ1FRCEG
         wC1FAkmdhmEO5MUxo3LGCTxetQG19bRpfpjwpJhfmODdHHYw3BahKi/KGhwx2PqMI3QH
         m5WtdzgEnBD+XukTJAu6jvjHE65ixVF7GsoZsWi0tQx8goBUzpiC+cGgjXLayX9leYmK
         tgGg==
X-Gm-Message-State: AJIora+dYH8tg99CFaCLak7ORUYHJ91AR8kBlIyaBs3moM9zbhaYKfDP
        MahbO3xSHS3fnQwvjBSDcAI=
X-Google-Smtp-Source: AGRyM1tj7L9ldCQI9Mre1KP949pz19+o72+lF5RZJH0rUd/m8kuxHn2Ij7wZ4c14EXr/RzPOoOhi9Q==
X-Received: by 2002:a17:903:1206:b0:168:e5af:469d with SMTP id l6-20020a170903120600b00168e5af469dmr1216287plh.55.1655155106158;
        Mon, 13 Jun 2022 14:18:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a63b40b000000b003fbdf7cc750sm5917979pgf.89.2022.06.13.14.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:18:25 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     samyon.furman@broadcom.com, dan.beygelman@broadcom.com,
        tomer.yacoby@broadcom.com, philippe.reynes@softathome.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM6856 SoC
Date:   Mon, 13 Jun 2022 14:18:24 -0700
Message-Id: <20220613211824.259406-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608180437.31971-2-william.zhang@broadcom.com>
References: <20220608180437.31971-1-william.zhang@broadcom.com> <20220608180437.31971-2-william.zhang@broadcom.com>
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

On Wed,  8 Jun 2022 11:04:35 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6856 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
