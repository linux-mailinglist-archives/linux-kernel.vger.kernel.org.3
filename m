Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2C55C164
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiF0JRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiF0JQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0DA60F3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o9so12004515edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+SlY4L0zpXi1uWd8Q0lEx1CkPHXXwoeqDNBkWx8yj5k=;
        b=lXErmffp8XsnGnoP3J5rP/4dSowFB+3rJS8QdysVEpQuXbnyrqMmW54jW8aMkZMpk9
         hV2lxzEYBNZIf/ZnuHq5wGT5BpxeFoS1a7O7P5h1EMd/NxS2yHYsfT10C6Cdo4QfMP8M
         mQmJeanjHZjdsS9F2Z7mIvTQh79UcXugr/T0FmGYNkB4o69+bEVoZ6iiqWTKiU4f+pmB
         Jv0ejIA3fihJN57DHyK0mkemi+T6O8bHjeA3EVzLuyunGIsjlI61yIqwQkp7FCj44ATD
         hAzerG3oehe6KFDrVrx04fOWcS53qNHEvrEPeHT6JWJB7xiRoJJEqcxZKorEaRs9f5Gj
         5cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SlY4L0zpXi1uWd8Q0lEx1CkPHXXwoeqDNBkWx8yj5k=;
        b=wCKXDIxO89DRh783JkPDiDsJQ5KtC5tM2IOHzibleb5WUUlWhQMknDAEc9NhOSfFw0
         I2I/Dg3JSn287MjwkgELjDr77NBHP43wMLqhKWq558DpbM/exxjLsJBMT+25ReWX1tza
         0y/pxl9Fvt8umXoPYlZNuQ/LZ3XsPLYr7zTfDgODwnWLI7n7AwYgbCJml89/KH/2soKz
         j2VZl7zewEXVOagC6f0HT6PjWJnQ5nTYbFBP4inGkTtf763rlpsAjxBNwlCetPFYQZsi
         Wn7X07PKIjkLHMyodUcKSAO5EzEEH69wfHQM4QR6bODInReB5V7SLFvOQvlu/4mdXkYG
         Gfmg==
X-Gm-Message-State: AJIora/cvJoCrToSTD8OvmABw2k88CK+KILb8KclCcjGA3NZXZgQVN5E
        n2eCk6ij5pqlH0lM5wb3aQrnVw==
X-Google-Smtp-Source: AGRyM1v1cuOzIzfwAqqlsPqAvQNbtY0Bd1x/u26N7cLKyrYwNtRHfSv79bcJpnH/SezGELGkZKgLTw==
X-Received: by 2002:a05:6402:348e:b0:435:a912:355f with SMTP id v14-20020a056402348e00b00435a912355fmr14693980edc.326.1656321385411;
        Mon, 27 Jun 2022 02:16:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-kernel@vger.kernel.org, peda@axentia.se,
        krzysztof.kozlowski@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        olof@lixom.net
Subject: Re: (subset) [PATCH v3 38/40] ARM: dts: at91: align gpio-key node names with dtschema
Date:   Mon, 27 Jun 2022 11:15:58 +0200
Message-Id: <165632135506.81841.18171336719863836193.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-38-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-38-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:31 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[38/40] ARM: dts: at91: align gpio-key node names with dtschema
        https://git.kernel.org/krzk/linux/c/17413b15ed9398e5d7f01f0da0da6043bb8392c7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
