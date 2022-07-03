Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764D756445F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiGCD67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiGCD5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:52 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4540BC13
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:26 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101b4f9e825so8838989fac.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VCyTfnH8NjSlB3wEmVmV8+vhbVUl0hOr4poBEopVoGU=;
        b=ziliVqzxy9/dOwyks9UKmfls7XduSVgh+N+IrqkD3A0u3sXMbzU3JczzX6OH1WaANo
         CB72tXVOYtCU+j1mqaWhM4IPQOq+14fuPISKLGGJkjyBQvngZPGhrTEqw6dt1fXm56LS
         aVWn3H3aIyZBk4nvM0s2cdauUBXh2PHECe0oC9UWmmR538VZB94H39VvxLf18YU0eRzI
         ykK6FW5hgOffY39yEUbCQwa5SOYPzYjVXvcsfUIZHYJ0wmIVkCedfNY4pD30gV/bXtST
         kSwRIZ4S6nx90lkm4dxVMCM2kOceLEbljBQhh60YXB+yDnHL2u3w5n4MSVlabNX0euIh
         LC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCyTfnH8NjSlB3wEmVmV8+vhbVUl0hOr4poBEopVoGU=;
        b=u1cEcSrhX1HlXfeexFoGwEa0xbAWSA4vC1Mv2F3t33r43Av8oW9x23we8z+LntK5Z1
         j6ZQU0ct2rE04NIVjq15J3bbo7VEFqTOucWv4yygeHG8yoNa/C2It3yTlUVItX2dyeBc
         Q4VczXRcE7Ql7cpOo9qCV2TL16W/H0tWRHnNzwFQwVg6mIboJqXVteW3dmaNjV3Z9rCU
         8Q8IcAOaR6KP6P6whGjWthywMKeUBqsd5z1zpGbaYJRUMc984KKmqBU568LGyCb+Cmq4
         j/52mRVwn4KviUEq5JLukbnBKZCokLzhJVN9AtNnv19gbV1ZSVdkHrUMlbGm9qhpjg1/
         Mp9Q==
X-Gm-Message-State: AJIora+Cr8s90Nk/PC16XjzfefPHR6T9CkYOjg2V1XgHI23Y4pIY9AuL
        Q6vUddT6PCmwYCDtmyQGUqZJEQ==
X-Google-Smtp-Source: AGRyM1tUe+bpIIrEEtZ/9Nb0bCXCTN+7KLHFUmOrWnqm3jYRBvbR6skQvCorgt/Z+fIn6n4ArzIUHg==
X-Received: by 2002:a05:6870:7097:b0:101:229:eb1b with SMTP id v23-20020a056870709700b001010229eb1bmr14324564oae.121.1656820646368;
        Sat, 02 Jul 2022 20:57:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:57:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-leds@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>
Subject: Re: (subset) [PATCH 2/2] arm64: dts: qcom: correct SPMI WLED register range encoding
Date:   Sat,  2 Jul 2022 22:56:22 -0500
Message-Id: <165682055968.445910.9322003122830573708.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505154702.422108-2-krzysztof.kozlowski@linaro.org>
References: <20220505154702.422108-1-krzysztof.kozlowski@linaro.org> <20220505154702.422108-2-krzysztof.kozlowski@linaro.org>
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

On Thu, 5 May 2022 17:47:02 +0200, Krzysztof Kozlowski wrote:
> On PM660L, PMI8994 and PMI8998, the WLED has two address spaces and with
> size-cells=0, they should be encoded as two separate items.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: correct SPMI WLED register range encoding
      commit: d66b1d2e4afc0c8a9eb267740825240b67f6b1d1

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
