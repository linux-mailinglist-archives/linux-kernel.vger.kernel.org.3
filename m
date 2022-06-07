Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9442F54262F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392541AbiFHB61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835732AbiFGX4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:56:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC235878
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:18:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z10so388658qta.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7/gzK+9zEAB7m+URXpWPKFV8Md7lwbStbXqUp9N1Lw=;
        b=kD7H9kmH0TOh5IRdxAaVmdhiPL9BuO0CGy9mJpJnw8mQDcrCA/O7nS9XO4O0K/Hjpc
         2VZB+xlv+DN2kYxk2NJWqLqp8xLprTQ3FjA7xiHLSbCLjUxvIpCopvsz9mAaO664Nu3e
         mJ1v72wx4cPChKaqrwmhtD7SSvRpL5N8YOXWCfw7QwyvyiAm+g/Z9FOwXAY5YPf3gzkc
         jKLBcXA30soO2y2k5vRIFLE5gJ1nsDuh7XJxwp2mqt3eUNZNREHdkEVIxjXDDVetw29Z
         Dy6R8zsmcORzvM/epQqyUn8bcIB6SNaGjDNgqzwlFWMkqIXufBR+9ch8T84OxAplWDCH
         L2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7/gzK+9zEAB7m+URXpWPKFV8Md7lwbStbXqUp9N1Lw=;
        b=xM5OKdxcnaYY1s5E8JFL1rHT66ziCXC3S/puoCMOsASj3psA7x9SIUQZgPTglziKx2
         G9Bu6XsvQ2xJs6USORteqmWKHBU9j4M+DNXau/EdJSVz2+pmaWhgUBbVB9EzzN/dd2BG
         05MGyEaiz84jp2jMwAta4B+WZSprOzcd9p/HNIoC+PJMNJIJmsYAO2VqH9ZykRwIHwiP
         OpsBWObg0HJgMZYxdXbo6IXtUkuDTvGu8JYyu5hV9Bd+hyntHvZYoyd5rZNhUI+hzlid
         p5CLrcFZVoJYIhwcZyQaBUHCllPOXovrTttqqV0nJL8k4ZjWUzBdzicRgp+FwN1oG0P6
         3Ifw==
X-Gm-Message-State: AOAM533uY0nxMHQfeNrBmqzuGH0rZPe6rKFgaW5TkCkl2reYmldaeUBd
        3W+aNyXqYffe1FkhVLGEccs3DRA0rC8PsWTR6ZwW+w==
X-Google-Smtp-Source: ABdhPJwWaEMpZd6sm7MREATgjYhP0WVx5ZHG+STuqGDMV32g2q4lA/btHLzN3suLQfbF0mlblinbGfcb3VQRH13J6mQ=
X-Received: by 2002:ac8:5990:0:b0:304:c8d6:3147 with SMTP id
 e16-20020ac85990000000b00304c8d63147mr25556691qte.370.1654643888839; Tue, 07
 Jun 2022 16:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
 <20220607213543.4057620-3-bjorn.andersson@linaro.org> <f16657a3-15e5-f7d6-1f2b-58e2ea83dddc@linaro.org>
 <Yp/VCg3UznbLKLuk@ripper>
In-Reply-To: <Yp/VCg3UznbLKLuk@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 8 Jun 2022 02:17:57 +0300
Message-ID: <CAA8EJporMU9b42cuBfCBSw4yAakUcj47d6bY5yZRLkW-2Ciq_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] phy: qcom-qmp: Add USB3 5NM QMP UNI registers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 01:43, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Tue 07 Jun 14:58 PDT 2022, Dmitry Baryshkov wrote:
> > On 08/06/2022 00:35, Bjorn Andersson wrote:
> [..]
> > > +#define USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE0     0x1b0
> > > +#define USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE1_MODE1     0x1b4
> > > +#define USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_CMP_CODE2_MODE1     0x1b8
> > > +#define USB3_V5_5NM_UNI_QSERDES_COM_BIN_VCOCAL_HSCLK_SEL           0x1bc
> > > +#define USB3_V5_5NM_UNI_QSERDES_COM_RESERVED_1                     0x1c0
> > > +#define USB3_V5_5NM_UNI_QSERDES_COM_MODE_OPERATION_STATUS          0x1c4
> >
> > These defines look completely compatible with the existing ones in the
> > QSERDES_V5_COM_ namespace. Please use them instead.
> >
>
> Can you please confirm that all these constants are exactly the same as
> the existing V5 entries?

The only difference that I see is the phy-qcom-qmp.h defining
QSERDES_V5_COM_CMN_MODE to 0x1a4, which should be 0x1a0. This is
clearly a mistake on the upstream side (confirmed by the msm-5.10).
Could you please send a patch for it?


>
> [..]
> > > +/* Module: USB3_UNI_PCS_USB3_PCIE_USB3_UNI_PCS_USB3 */
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_POWER_STATE_CONFIG1               0x00
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_AUTONOMOUS_MODE_STATUS            0x04
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_AUTONOMOUS_MODE_CTRL              0x08
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_AUTONOMOUS_MODE_CTRL2             0x0c
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS     0x10
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR             0x14
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL           0x18
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_TX_ECSTART                   0x1c
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_PER_TIMER_VAL                0x20
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_TX_END_CNT_U3_START          0x24
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_LFPS_CONFIG1                      0x28
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RXEQTRAINING_LOCK_TIME            0x2c
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RXEQTRAINING_WAIT_TIME            0x30
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RXEQTRAINING_CTLE_TIME            0x34
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2         0x38
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RXEQTRAINING_DFE_TIME_S2          0x3c
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RCVR_DTCT_DLY_U3_L                0x40
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RCVR_DTCT_DLY_U3_H                0x44
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_ARCVR_DTCT_EN_PERIOD              0x48
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_ARCVR_DTCT_CM_DLY                 0x4c
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_TXONESZEROS_RUN_LENGTH            0x50
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_ALFPS_DEGLITCH_VAL                0x54
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_SIGDET_STARTUP_TIMER_VAL          0x58
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_TEST_CONTROL                      0x5c
> > > +#define USB3_V5_5NM_UNI_PCS_USB3_RXTERMINATION_DLY_SEL             0x60
> >
> > These look like QPHY_V5_PCS_USB3, but without additional 0x300 offset. I'd
> > suggest modifying qcom-qmp-phy-usb.c to allocate another register space for
> > pcs_usb and updating QPHY_V4_PCS_USB3_foo / QPHY_V5_PCS_USB3_foo defines to
> > remove this offset.
> >
> > Afterwards most if not all constants from this header can be merged into
> > phy-qcom-qmp.h I do not think that it makes sense to split this header at
> > this moment. The QSERDES_COM/_TX/_RX/_PCS defines are common to all PHY
> > types.
> >
>
> You might be right, but I spent considerable time debugging the combo
> phy (which is version 5.0.0) and in the end it turned out that it's not
> the same offsets.
>
> I really would prefer that we stop haphazardly try to fit things into
> the phy-qcom-qmp.h with version numbers that we essentially make up
> base, when Qualcomm dumps the register layout for each generation in
> their downstream kernel.

Well... Let's come up with a better versioning/naming scheme. But I
don't think we should dump repeatable symbol headers, which are in
reality common between different PHYs. This would make things harder
to understand and harder to maintain.

-- 
With best wishes
Dmitry
