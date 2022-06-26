Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAB55B15B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiFZKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiFZKuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:50:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9F13DFF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:50:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so13303386ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qm3saVsXQFyYF7XKRzCFxHnQjtvbQdpVuuv8fnV6oQQ=;
        b=fe1iXci9tCe6L2xFZ3P7p/kc36HTF7DyalYl7LT5YmzKnyaEtnBgqkPALfoSYHafMe
         5seSCpPDdR8BxgPRyhdnMFqxf3xe7G4yT13IqyEaN+mlk28EoUneItnD88p6ExFLvkMV
         MLTO5q9Nu7Brxsbf/CaW+QS4TqRzAUsl5UG/Ogcjdy8CNSV3tsDX0u/EoStiY42fXP59
         xWLSI3Nb67HE3r/kxb+JsRZdbZKmuNsfcQD74UeD3JknRSNoqpiT3xZlxr3mghMP0ORF
         bdc7eXZCZn4C1vKzMxHkOzBUojeGzfPOKNKXbnFD9KRfG3VJ+nEcBbK9Ccl2Bv+ZLMVZ
         EIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qm3saVsXQFyYF7XKRzCFxHnQjtvbQdpVuuv8fnV6oQQ=;
        b=JLwO/qgFhmIUrJOKKakA4IapKsGDwXRrZfBlajHI8hIKVhEq6+EFPdFam8cGmbt4B8
         hjR6Nyi2Fq2+ORdHCLpoLFjtL/VBlNGHMN8mM69qXVOuA6f+5anSOaKaywllyEmLlGBH
         +bPWRVEuA+mpWppGtCRz21BN0EKh7MJDDucQxPPe5jJREXqntk+v70gT1r3s83woa28p
         YvFnL0nZP4IS7yShEzVhs0sFvRqybLh9OcYf0eUOdYVEDVjebJfMZgfFjvwJVMbHRPRS
         Mg/YLRwyE93Ms+56Ccy1jbM3YGHSHElfXntxEk0eaontxyy+BEinHszeUSt8UW9sH/jN
         IWUQ==
X-Gm-Message-State: AJIora+KUvUpB1BMS+d0f3czYOHgNO6CzswGEdF4VhExi3O4SDJlaA8c
        2IpMXWuM7ptDitGUQjRd3KJXxg==
X-Google-Smtp-Source: AGRyM1vsckuhI5W/5/+uG8dWjoP8xYOurUPiiZq7KICxgI9Tk9qBUslJdZ7qw4SBHIubDQ+UPYVtVg==
X-Received: by 2002:a17:906:99c5:b0:6df:8215:4ccd with SMTP id s5-20020a17090699c500b006df82154ccdmr7281866ejn.684.1656240620912;
        Sun, 26 Jun 2022 03:50:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x6-20020aa7cd86000000b0043574d27ddasm5623845edv.16.2022.06.26.03.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 03:50:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     bjorn.andersson@linaro.org, mpe@ellerman.id.au, vz@mleia.com,
        robh@kernel.org, abrodkin@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        krzk@kernel.org, balbi@kernel.org,
        Sergey.Semin@baikalelectronics.ru, agross@kernel.org,
        gregkh@linuxfoundation.org, vgupta@synopsys.com,
        khuong@os.amperecomputing.com, linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, linux-arm-msm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patrice.chotard@st.com,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com,
        benh@kernel.crashing.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH RESEND v9 5/5] arm64: dts: apm: Harmonize DWC USB3 DT nodes name
Date:   Sun, 26 Jun 2022 12:50:18 +0200
Message-Id: <165624061445.7618.11344979529426500237.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru> <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 24 Jun 2022 17:16:21 +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named despite of the warning comment about possible backward
> compatibility issues.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: apm: Harmonize DWC USB3 DT nodes name
      https://git.kernel.org/krzk/linux/c/fcf036a017b251d362559cf7eb0bb6e614ccf842

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
