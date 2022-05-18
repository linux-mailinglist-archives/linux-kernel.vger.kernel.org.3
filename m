Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B379E52C400
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiERUF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiERUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:05:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFF1611DB
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:05:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ev18so3085392pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uY7r6BcoDSx62NZ7KSs3GFbZpaq00XO9AOPbKWIwUog=;
        b=aaO9Eoo5FXcvFsA+Z68mjU+dWI8UNdEzSqiv+jXGNMVxzj4XPzkzoaIOn+bUlpXqIv
         7M4xfjKeyopEgDgOmz7X3MSxsbF9ztZfNSx9NuDGtg69/9KLn5iNwrl77hEgW1KdbKk0
         INB4D0gbITs3bUWTJI1oKEaaJn98Xy2A69d+e8Cf3vTHKdSyIE3LMXeHRmss9XNTOiz0
         D65dQ5qljEt/e2b336wqF9M2EdHj5Cds3fbbi4Bqa6mX+x23hC2BTyTEmcTwZwmN26tm
         jlk05EtvZ1qYbCTn78yN//4K4NjLCJZTpNBmu2uxr0bGp0+oxNYIgdwCHH/s/0A6O+oB
         +g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uY7r6BcoDSx62NZ7KSs3GFbZpaq00XO9AOPbKWIwUog=;
        b=vgN0PMWjHnBhX3SQelmQZ+Yl5psrwryHYA5XTSW5eRiUEInJubzB+BcbEUnjJw8z6S
         eZH3lQkrQLQznS9gAABLPw6hZj/hZ/LvjbvGegCnhfIszyn328Ue1w4XPV1WV7uQy0TM
         nwDYSUwOXLep9hg+gr4jK+sc6gD5WB+QIbgrClDZFS6sZmWqKB8RcQs6VfgBBzD5jH4n
         YN6xZiIzlQjqTbeQKJTC40PMP6yRjtAsprECp7SYxOS6RmB+meqGaYd4O40Q/SMtZAxJ
         wCgtoUp1FOWcs2b/NiZTGIr45dN33FPucRXWHSaieiTKFUbf93PDGuEa7CSMMTOSijpD
         LuYA==
X-Gm-Message-State: AOAM530AzA0b0MGMN+MsxyJ88nmWXltRwqp4ow1cnYti9KHMfiwmZYJh
        psMtVCIjhHtLgwImdCRgASM=
X-Google-Smtp-Source: ABdhPJxhmzBiPOPXMg6x4ZJ7plPSZSFYPC10B6h1ATp+rcCcHyaaqpNoIe10JTUJg2e7bQRsF3zJIg==
X-Received: by 2002:a17:90b:4d11:b0:1dc:ec4f:a19c with SMTP id mw17-20020a17090b4d1100b001dcec4fa19cmr1710927pjb.117.1652904322464;
        Wed, 18 May 2022 13:05:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b00161d8153d56sm103527pls.148.2022.05.18.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:05:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, florian.fainelli@broadcom.com,
        joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, philippe.reynes@softathome.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: bcmbca: add arch bcmbca machine entry
Date:   Wed, 18 May 2022 13:05:20 -0700
Message-Id: <20220518200520.324132-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514232800.24653-3-william.zhang@broadcom.com>
References: <20220514232800.24653-1-william.zhang@broadcom.com> <20220514232800.24653-3-william.zhang@broadcom.com>
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

On Sat, 14 May 2022 16:27:57 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add ARCH_BCMBCA config for Broadcom Broadband SoC chipsets
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
