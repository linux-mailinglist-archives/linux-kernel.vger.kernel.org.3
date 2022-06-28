Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3574B55EF84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiF1UYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiF1UV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:21:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73A3DA4A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:19:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id p8so18720510oip.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4K1yIyRlfarxdrcJIzjiuU7hE/FjddqU64uWG9lU5uE=;
        b=lbQqjU431Wi9OuZDFQyx7Bl/jXktkn19UGNRQGHrPqTpTVbR/33SCwCPq47m5ZEth9
         BCG6LofI/0ryNHTqyqT2+EgPR9o27P8CYHE5JEl8RPKLAsB3cps5rDl5RGEwEtdzgDAf
         qD3BY8oda35aPIcwoTO6gkviHFXrbPRgMzmp0T4faq5A6hISzUiyh3tOJdSrh7yrwIFU
         K2bo+zS2ZVb3EF0SlOhM/VlsBDLevDVJ6QyVl9Q1XHfJBJJsM5fsQBn7saBG3WqnBw22
         OS4C56JVs7ozuprOV5qjJW75+SKUHikTQcwrJcvGjbOzmq+Ot8Ccpk6EDmIT3Yr0aXpI
         9gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4K1yIyRlfarxdrcJIzjiuU7hE/FjddqU64uWG9lU5uE=;
        b=yaOKx3O0ld1w90ykUh2SziF99z4hnPJrNKxW52gAjAivSMEPP6T5Tn3rHSFG8S4cBi
         66r3uM94hOvpXFQYXab606pbJ5iCaQErrBYaD28A/dTm/KbJ0KptrXjJjefjeybvhig8
         MDv/V5QAJjtrxtjTVbQvGRnRpg0nrurH37DFh4EkGOJJwiI1efk6Lo68AX2zySp9a75h
         oNbNslzWp51dHtaDKsR7OIfdAu7PGiGvKScpJYf3QTOCET9TrjBxrvJidJIBBE0RB4ij
         olbjlqLGC8Fn1QTw9jwqIZH2ggU9gJIaXHO006Cjh8i8ujLPSn98OnZohr3FNPemwyNX
         TwNA==
X-Gm-Message-State: AJIora8nvJan5ASd4kNkqiQ8/sBgxr14V4qCtjm3dfkEesGYDI3lig2r
        u5cc8m6BuwYI8ZMLUk0oTGO34g==
X-Google-Smtp-Source: AGRyM1sV/uc5rapmEnvedSYRD9dxwsr83iT1JIXKk5etidOjlOK90qhSAkEX8h2nVT5NhEsf1HGvWQ==
X-Received: by 2002:a05:6808:d50:b0:333:415e:2ca5 with SMTP id w16-20020a0568080d5000b00333415e2ca5mr948193oik.53.1656447586121;
        Tue, 28 Jun 2022 13:19:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:19:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: (subset) [PATCH v2 0/4] Devicetree updates for Interconnect, USB3 and PHY support
Date:   Tue, 28 Jun 2022 15:19:12 -0500
Message-Id: <165644753307.10525.4732064519492926832.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 14:36:31 +0530, Rohit Agarwal wrote:
> This series adds the devicetree nodes to support the interconnect, USB3 and PHY support.
> 
> Changes from v1:
>  - Addressed Krzysztof's comments.
>  - Rebased on top of 5.18-rc5.
> 
> Thanks,
> Rohit.
> 
> [...]

Applied, thanks!

[1/4] ARM: dts: qcom: sdx65: Add interconnect nodes
      commit: b456b5e7d1df276a4e1050680eec86ccb99d8a82
[3/4] ARM: dts: qcom: sdx65: Add USB3 and PHY support
      commit: fbb6447deba87dc409e274d9d6d90d9c79851fb7
[4/4] ARM: dts: qcom: sdx65-mtp: Enable USB3 and PHY support
      commit: eeaec4f2b926ffcb35a9c1c4af549ac9f7a6ce56

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
