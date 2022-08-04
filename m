Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6358A03D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiHDSI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHDSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:08:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CA6BD5C;
        Thu,  4 Aug 2022 11:08:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l5so408176qtv.4;
        Thu, 04 Aug 2022 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HZnWL59mZJXY1OjqXdSQiGllbTTKV6kYEwGMxfr+tD4=;
        b=AwZT5Cz/btl21DAfZ4h7YTITYuoQ/VN+pxVkAfcKRmHxfjKMif3G6TjXtl1f8Y1na3
         Y/Iq/psYKql9rq2oiBcdELqhcSRpGWN5ELCdDGS6K61Od9amKPaKhtdJzibSwMmpR/5d
         46HC8mKhFYUbBQXUk9/dSmqgf+PDvvTEDwt/Te/AXUlsLoqcZptfZZJFsaSueuiZZAmu
         ZDKAjei3zl/KuZc7iU4oBVpxOR2KmtY/iL0oDYYtScDRuRWInS/xoYtN6FQZEVwYBwkL
         s/KKUAQE533V3zS58VXArs1/dNlSnAo6QsAQqw4Aj78AlWof912a2/wbCQTTazez6m2x
         BpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HZnWL59mZJXY1OjqXdSQiGllbTTKV6kYEwGMxfr+tD4=;
        b=exwP3/vblANs9kujuAb5FrYPwHiymw8N32OQqADZCXaGlTpM1HimGbyIoL9A7fkqS7
         4n7SKFwH8vJKxq1VrQZmXsL2AaA8jMB37BVQwGahJJrYN9pRUflgQURIf7Q5qKjzB/03
         D9Y06nCSg2k/OdHu80uR4uCGkB6Hj2H1UWbHBH+91pj6wBQvglpi4mzd4HD7WfSpESld
         9vnx+BC3jWGqTMUb8qTRpKjk0Pv2Un/LGiQ0HxAsU6V/LLYuERPwPiM+SNy9Ui511Szj
         Wd5IW6520M0wV/1qwlpw1lZiG3Wd4qjO235lUCJQrQi2pGOakLAB5nom9vPhT1GWm7Xf
         NTxQ==
X-Gm-Message-State: ACgBeo361inlR6qt0uLxhOeGI52s5IzapLPO7BVheIXv0KPEQ5knMSlV
        d5qq+KG1BlZuBIZGcY1axK+kYvgxs74=
X-Google-Smtp-Source: AA6agR5eHgsZl7vUsB8u8ZYGxgfDPNblePwOAtf9Q5pXYZez+vM+XLqgaE+lpLurseUCCljxAxK5Zw==
X-Received: by 2002:ac8:5ace:0:b0:31e:d549:8e16 with SMTP id d14-20020ac85ace000000b0031ed5498e16mr2691854qtd.385.1659636504042;
        Thu, 04 Aug 2022 11:08:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006a65c58db99sm1174507qko.64.2022.08.04.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:08:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: bcmbca: bcm6878: fix timer node cpu mask flag
Date:   Thu,  4 Aug 2022 11:08:20 -0700
Message-Id: <20220804180820.1339785-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194754.29492-1-william.zhang@broadcom.com>
References: <20220801194754.29492-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:47:53 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> The cpu mask flag value should match the number of cpu cores in the
> chip. Correct the value to two cpus for BCM6878 dual core SoC.
> 
> Fixes: 6bcad714e173 ("ARM: dts: Add DTS files for bcmbca SoC BCM6878")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
