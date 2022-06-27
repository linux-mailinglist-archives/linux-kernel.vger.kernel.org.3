Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB56B55E107
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiF0JQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiF0JQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437C60FD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so17708391ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=J382b09Gy+M7In3AXxVr1HynOuoCthcKPC6LWQWBGuA=;
        b=eiII9wLch/0wRV343K1z0ZxD/xLZmkSZQ6bLRS6om2fmc8NYGp1NieXOsdqoPyQvb/
         1/5734G4qG8UwRyFYNuUvXfwV04suu+pmq46SYsDIIwwPLsdBBz5Vt3z46Al3FzfA3UI
         sLqbPpgG3yjTbK5fUnD5Oo4GX/ZtLC/W5R3JqEhTEkMbfHCGtLlNC8wByvKmJHMeDesN
         PYX2wR02VxFXyQUmMDV+w44OGOscvGpwz5DHxPYl4yWVOaM+iNMkzcjU95N+P8VaI+5l
         YJfNzLVV/sLqSGhdvYomKcviRdDEKq3LhK5uOXEs/vLq4OrKUwPP0ubYX+QjJ8YjXQyp
         soZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J382b09Gy+M7In3AXxVr1HynOuoCthcKPC6LWQWBGuA=;
        b=pHHFeeVnAjb2pnWsp8Cchpy0nmsY68jZQrFGxB8D+6b0bMwEaihrpEo7HK95tb5QaK
         4ubHKWZE0rW4f/BT5dy0bkDZOyvGXqkjS3gkxTwoyps7wluXy8tWWEM45d2aPZe0z4jf
         k7zSbWM4UWEDObZB/A8KaHngAu9pzDDfAZOLtHVsdkFpGmNAjPeebiM5l4EcHK7K6MDO
         Rpi6gEdVGFKy/R7nv21LvzKqX/rb4BCC5ZS37iTOKNHVA903ttUxls77QnGyWbE0KeH5
         08hlhO+1Zmvt2YouwfXCT8ZQWIlo6Jqze2vegFento/kyDcpBn/ER+OxqOPahASQAlR6
         exQg==
X-Gm-Message-State: AJIora+Cdq3spQE2vEAhwD1Njs+txFh1PlLML2Lgi1Q69TJVJoKR7nyq
        nmiKF6owbzLuUhWL2vm/2nrQIQ==
X-Google-Smtp-Source: AGRyM1uBxlvrB86FXKr2FmRwpKwYpWC6jRXM+cjqgv/D0nUsT690uX55EzWf3UMkk+aOLB5y/Tl4hQ==
X-Received: by 2002:a17:907:1612:b0:722:e1b9:45d0 with SMTP id hb18-20020a170907161200b00722e1b945d0mr11939301ejc.439.1656321375835;
        Mon, 27 Jun 2022 02:16:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     gregory.clement@bootlin.com, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: Re: (subset) [PATCH v3 14/40] ARM: dts: marvell: correct gpio-keys properties
Date:   Mon, 27 Jun 2022 11:15:50 +0200
Message-Id: <165632135505.81841.1554820360329646345.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-14-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:53:07 -0700, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> 

Applied, thanks!

[14/40] ARM: dts: marvell: correct gpio-keys properties
        https://git.kernel.org/krzk/linux/c/8b0848f57769ae9ee4b8104a5ba7c7ee98d1fd35

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
