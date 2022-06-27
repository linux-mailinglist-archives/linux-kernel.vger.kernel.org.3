Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592F55D8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiF0JRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiF0JQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E760C5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ay16so17782146ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=t3b+jqU8GZl0EFABg0x/c17eyO7t957ugRR9BD9/610=;
        b=ClQbzClzPWCdY6KlKQ665ptjCuPobjuYbF5+PcFCTSWc8Y58h090V+C1srpISQOyU1
         sPJrDmbjuUDL+NYTY1Zxqus5iDpmAe0J9eYyV8H9uRO1fJfwPynKi7AUo+sT2Wkc3qA/
         +2XKnjINT1tBokbmhl8hVXAG6oXaKzq6e3qzv2yKgDrjeJolXV2bysPQiOL8S0Tc0gmK
         0TMHYj8jD0Ib/YplEsnPIQ1dtuKs3N+046uv7cKXSDYnijB0MbWhqm5wD6OGP1t7kTUp
         lbeWc7ffftR+zabFtI57XrwS1TLe7i40mh9AmpujJczAUWNRhTU6oLQt+PPtzfITWmvb
         oUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3b+jqU8GZl0EFABg0x/c17eyO7t957ugRR9BD9/610=;
        b=Jo3UAh1l/6NHWezDsFjY5kUNTnDMyJBick2MdS7xemBAVy7aUxUQRTjg5kRn6LXxTX
         ZiGcRLnjqiPdMwphr6Rp3TA1NkWbHJ+8moL2VM8C/Dx6wydC1Drd7x5Q4Mmw4DDg+sz+
         4tLBs2wiNXLJLY6vVGgfrahlQXcCdIqE3eNhhhnd1UISngJpgYcgrAycgHw/jBNS8O/P
         PR+OLvlqr3Zbb2NbjHHGQP/rZfE0l55XAgNE9sXJnNCjvo1LZu3gqBGSMzmchu6NaFf7
         fktASAWZ4DsllfDqVuhjljf3neCKehEPdbqYKBEOih8UExHbICkcN+Vl2RuChcvlwwVJ
         0Z2w==
X-Gm-Message-State: AJIora8suiggciZY8V8xfCOdbfqnk7sJdV7skZ29Z4OqN/UEQtwB4Rf9
        yfEMhjlhNM4upOlehuS1bve/cQ==
X-Google-Smtp-Source: AGRyM1seK6am1qPGVlXKvE26Oe7a/3cikFyA5HjSozFlnKf4dp0lSN28TvTzTIbIHajj45li1fV+Dg==
X-Received: by 2002:a17:907:969f:b0:726:94a0:26fd with SMTP id hd31-20020a170907969f00b0072694a026fdmr8304630ejc.234.1656321379246;
        Mon, 27 Jun 2022 02:16:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, robh+dt@kernel.org, olof@lixom.net,
        bjorn.andersson@linaro.org
Subject: Re: (subset) [PATCH v3 23/40] arm64: dts: qcom: sdm630-sony-xperia-nile: drop unneeded status from gpio-keys
Date:   Mon, 27 Jun 2022 11:15:53 +0200
Message-Id: <165632135505.81841.3584331837885550426.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-23-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-23-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:16 -0700, Krzysztof Kozlowski wrote:
> Nodes do not need explicit status=okay.
> 
> 

Applied, thanks!

[23/40] arm64: dts: qcom: sdm630-sony-xperia-nile: drop unneeded status from gpio-keys
        https://git.kernel.org/krzk/linux/c/aa30ba37ebb4c66c9d0e6b6bddbeda7f84ac806e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
