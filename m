Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BAB4F8FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiDHHon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiDHHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:44:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5EE1B60C5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:42:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so5540064wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHMATotH/7GH36y4JV3UnVZN/1YVFDx1H+DptS3+PWc=;
        b=mu/sVZgEh6+wr0/vA8nHityCIOLvTeBafSpMxYQg0Ho/GexTByIYESg54GUWecIReL
         Y5sFAnvh5Q3VphOaUxz5yeVAuVd8RjGVzh/WundduB03NIeJATZ/Ev+TguQMVev7rt0r
         XAINJGkAohkGxKSwgUuPPcd0urmt1yqaw047ssYtI8GaW0Nuo9azgC7MUM/XlDZdZJBF
         5Od84ntYjv3Rhvpn6BLuJb6zxuk+v6YsXIFoQWDXRIbLjoXAHSQ/9f+DWyifn0xA7PiG
         qg6ieRl9nCgahuy8ePNmpLqFzahtcBr4rApLtfKP8svON0SgHt8iptL0upMYU46x5Z1N
         NAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHMATotH/7GH36y4JV3UnVZN/1YVFDx1H+DptS3+PWc=;
        b=7pc4Wa/eBYDaVddDeLSJcigGN0iwuBbRAZd53v0nZRz3/GmYbpZoNnDFRWCoKnMApz
         64gbrJ9RN572gle9NrtX7kdGyw32+1AIMKMSUATSDDMOcGeg/n3Yk3cYk36o6aDrRj3U
         QYZyytPxWHb0vgFRMI5D27giL3a4N61pBzB3ypyxfhmF/2XVsSV5AbAN4JffVN1dgZq6
         UsWbJPJWueRdjmOzi4ELxyHzPQQCx+qaulwZDCvFrJnd+308tRxIvbLj+jLl9nuhfAYA
         Nfa65vrwMPfaJcgvcT/E+1pvyZPualo6PYmdy5QjbD1y7G7/IPSGBsOAMpWpb1yWBt3J
         7q4A==
X-Gm-Message-State: AOAM533sMIcyneLMeWlD+KpYgqtlzPQ8W4Hm6h5XeJ/zpCX/czNeiMgR
        1IpoQYfYvJqIQKIvaVwVZRnx2g==
X-Google-Smtp-Source: ABdhPJxvN2y8IaSXW8095VaZadvE9+99TAQdw3rmhA3hdG8AgGca4W0iH4zucfGoysujnM+oIij5eg==
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id bh14-20020a05600c3d0e00b0038c9b5e52c0mr15289652wmb.3.1649403753807;
        Fri, 08 Apr 2022 00:42:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm9241164wmi.17.2022.04.08.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:42:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson: align SPI NOR node name with dtschema
Date:   Fri,  8 Apr 2022 09:42:32 +0200
Message-Id: <164940374766.3650310.16771762331635334011.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
References: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Apr 2022 16:21:58 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

[1/2] ARM: dts: meson: align SPI NOR node name with dtschema
      (no commit info)
[2/2] arm64: dts: meson: align SPI NOR node name with dtschema
      https://git.kernel.org/amlogic/c/8771ce5eadb5b73daab190c2451172e43e16ae41

-- 
Neil
