Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0191C542A13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiFHI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiFHIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:55:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C03CA2E3;
        Wed,  8 Jun 2022 01:16:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y187so18239885pgd.3;
        Wed, 08 Jun 2022 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7X8u/QRqgxUL/V9jcMxjA+4GJbsgQ/MhAfz+Q/GAks=;
        b=idcQTk0OOGATPLzIp6BtHwO1GwktFgXhKZwcA2TLLV3WdvQhOaV/vpH5A8Tl2rOK3b
         lw5sv6owkS2XU0ftuq+IHeI0pVSkcW3ClJ4v7rCEAR9zG6Lc6KplFtzZ6Qy4RrK2bqk9
         7uPcClOYb+gU22RDMr+L27mNzFrowlRqYqONcg1IT/eAUIyhPfN++9820dQjqMiQypGJ
         1i+sv47EOXqvGBUxQvJZrNllgW6K+44C5CQ1JubpZJDkizcLL4ihFdiivPJaLFI2XGK5
         QSB2WuNXy3bFxe0dFE5CCvFuLX1J3uJ9yq2xCsK6lpQ2uXGecL+cz9o7/LfboEmnOrmL
         1hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7X8u/QRqgxUL/V9jcMxjA+4GJbsgQ/MhAfz+Q/GAks=;
        b=gDI3DUJRaB+aZ0omNm4/xx3BJfAMly0yV2FHdw+22rJY3FMM5TMeICqKa+7kHXd993
         4Xbb0P5UvuTdf+YZ+fi9rUeBmkTmqs0il0fMVPORu31wqSxoiwntRUv6umm6fdacDiNL
         8hqhpJCfyxOUaIeM8X4Fdu7qPjhm45mKbLANn+GGu0pTMivvKMSe5bss9SCOdwnNU7hI
         k4AVkBPeo8ienBbNOXA5bmnr55lkAuPWVf6UzCXvHgj+V5fX/71dRsXTBh6HhVLX+j6g
         DYhmr42UaG+40I784qfnRrVfzFGuvyu4c70v4QbkjevYd027H/FZ+r6G2sp5lgZTdYTY
         7+3Q==
X-Gm-Message-State: AOAM531ukwZNa3rT5vLysar8/SZcN1QFgYKG959iCJMNBtm95naFbWFS
        4cKnNbDf3TleHkg/8XbuPeE=
X-Google-Smtp-Source: ABdhPJwiCEI1XzrcNZbd9uwpwAbcgAc/0uuHxgxiO2FqanT9/T4s9RzSzltNN4aQqXgP+Mfo+DS1+Q==
X-Received: by 2002:a05:6a00:14c1:b0:51b:eed4:c571 with SMTP id w1-20020a056a0014c100b0051beed4c571mr23275118pfu.72.1654676192643;
        Wed, 08 Jun 2022 01:16:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090331c800b0015e8d4eb218sm3053543ple.98.2022.06.08.01.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:16:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     florian.fainelli@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, philippe.reynes@softathome.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm64: add bcm4912 SoC to binding document
Date:   Wed,  8 Jun 2022 01:16:30 -0700
Message-Id: <20220608081630.1450207-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528005654.13809-2-william.zhang@broadcom.com>
References: <20220528005654.13809-1-william.zhang@broadcom.com> <20220528005654.13809-2-william.zhang@broadcom.com>
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

On Fri, 27 May 2022 17:56:51 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM4912 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
