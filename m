Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A356C3E4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiGHVKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbiGHVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:10:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80426D572
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:10:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso2810819pjj.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMmp67crMhq7PWWgYC+oDhvsTdKYOIxkTFPZEODBIXc=;
        b=V6+rubc2RgfxmFafvlgEYRMyNK7pQjM9CyUyqwmXU4mu2VolWpJ+8H0H6f984MwZq0
         xp+GBCAwIXA2/Wt4+K1y0VlfnggWGPM80T4eCbsq1powQ7s/SELrMKKokoyZ214ZqfH9
         IvcEM4R6qW47/P1u53kn9zz1VLfbnNPZICG4uErOD7bI+wbo5dR2pCCC5bHcQl9qfEeQ
         eSXD4ClctFcsaEvuxzPg3MTUHh5fTj1hQBcjmKMtXvkcD+0vhTtmEVlrjKT+oWzTf1bm
         4vyjNe4Xpk9ErxOY1jBxqOBHuRAdp8LQpd0ZYLjwmxApr+XlTYef8Hcen8VlsiIlEfhp
         F14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMmp67crMhq7PWWgYC+oDhvsTdKYOIxkTFPZEODBIXc=;
        b=yCSajoA+55Zq47YTHfHt48iujPJFDaSYkIdojKBT+i4wILswUhFocdKT/xHKn3Bg6E
         6HKq+OnLNGSWNWmtg6S9t07eANxJjRliwa+hACFnJJZf3PsnkteBBr9AujeIEqhuik4q
         Kz7bm9bE6Hj5NlhHOde7wjUm7xeRGyeAVdH9VGMkfa6YMGLo59ESoIZWJ1EmLHeDYI0M
         YfqVfcTt8NRx7mdMeGDCjqTeq+P/beZy0EM0sP8RsfskSHQpKvaJyygoEugttb+4Ex2g
         hxnCWGR2X5tSYMkzaYhP4kVl9XOrcIs368Oa6Fn60K5HhMT0pd7dvsb8OWP5oWEIgVyN
         Hmig==
X-Gm-Message-State: AJIora/Gw24AbXI4eUa6FIF9sHSMBprIzBIZzMQ8W6uPw15B3lQvmcdX
        h44hkdkahajD9jwQlSUtRds=
X-Google-Smtp-Source: AGRyM1uxeKx7gaOfdIL+u6yF6SPE91AaQ2/VL4LqgQj+efcRTMx0j7H5cxNrg67yxye8CdwlHBZu0w==
X-Received: by 2002:a17:90b:38c5:b0:1ef:a7ad:ebb9 with SMTP id nn5-20020a17090b38c500b001efa7adebb9mr2086742pjb.110.1657314603373;
        Fri, 08 Jul 2022 14:10:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902f68900b0016a111c83cdsm1848957plg.119.2022.07.08.14.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:10:02 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Vinod Koul <vkoul@kernel.org>, Al Cooper <alcooperx@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [RESEND PATCH 6/8] phy: brcm-sata: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Fri,  8 Jul 2022 14:10:00 -0700
Message-Id: <20220708211000.2661166-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-6-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-6-william.zhang@broadcom.com>
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

On Wed,  6 Jul 2022 23:57:57 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> PHY_BRCM_SATA depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
