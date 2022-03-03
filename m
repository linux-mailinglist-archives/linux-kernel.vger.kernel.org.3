Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414B34CC8CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiCCWYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbiCCWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:24:30 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C06A6521
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:23:43 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id l25-20020a9d7a99000000b005af173a2875so5865471otn.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=84N9C6KvyMy2P8CDxkMygU4c2ZXeXw9ZduzWrJT2etE=;
        b=cFzFuK9Te+gPYjsQw43HWd+lX0dK75cQbikvF+GotiKMkoC7n3D5HmUVNLnEV8gBpH
         oBKM8lXnCJMovyZOcmMwSfRGp7xNWHY4XVb/EDVU5NpxUfncr25dJ5uqjKdGZG8y9hif
         ATRmIFWvL8nT6Fxu9sp/brC8rt8gRB/WUcYRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=84N9C6KvyMy2P8CDxkMygU4c2ZXeXw9ZduzWrJT2etE=;
        b=m1MO/8y9pw8IhgFQXOTGamrSnFxG+QfjFPNXZWm//x3yHoMpL4ZhS6JwqYrO3zYbCi
         /r0IKOa6RFOtIvRVhBpbFnpRx5OVGDcTrreX79yBMGsWelw3dQ/qcfzPIR5GZ5AysVOi
         xfxEQysgbYSLVYjHGlpdwZuGr/3I8emWyuI4FiMo7JTmGefWGL+JkcQVvVcOVPAkx4VG
         e/mn7kymZPEQ17QZcbClz0WQySVpia+WrM0V/8J5y0uS1U/FWoDHODKYfqBa2fOm//yL
         N2LiOEGQG9+uoaFlrWZ271ZV6T5L2vNNkntTw8M+psIYyIQWbmjhJ9FwuHtL+1hnqNJ3
         HxTw==
X-Gm-Message-State: AOAM531ZJfe0s+H8X71GTYfxOsGpIeoB7ZcZH1LgL2TExbO3pTQWA9B9
        Rfcp/O/Y6Vk2sXf8TGWC2UWKP2JIL3JwlsO9ghzPaQ==
X-Google-Smtp-Source: ABdhPJx96sN+CrROFdnLq4TVFnKH2FvrwIjYkI+NMasfcx0/cQZZuTxmSn4ziMWwpGM1lI9t0aITlvtBXJxVU5Cw/Xc=
X-Received: by 2002:a9d:22e9:0:b0:5ac:1754:342c with SMTP id
 y96-20020a9d22e9000000b005ac1754342cmr20034277ota.159.1646346223173; Thu, 03
 Mar 2022 14:23:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Mar 2022 14:23:42 -0800
MIME-Version: 1.0
In-Reply-To: <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
 <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com> <b793195b-1d3d-63b2-19d2-72ae2aec8c0f@canonical.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Mar 2022 14:23:42 -0800
Message-ID: <CAE-0n53xT1OaDLg+o1g_DXO5CHOZ=YC1C=2weeET-6cvbSKXPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-03-03 07:59:22)
> On 03/03/2022 07:13, Sandeep Maheswaram wrote:
> > Add device tree bindings for SNPS phy tuning parameters.
> >
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> >  .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 125 +++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> > index 0dfe691..227c097 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> > @@ -50,6 +50,131 @@ properties:
> >    vdda33-supply:
> >      description: phandle to the regulator 3.3V supply node.
> >
> > +  qcom,hs-disconnect:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      This adjusts the voltage level for the threshold used to
> > +      detect a disconnect event at the host. Possible values are.
>
> ':', instead of full stop.
>
> > +      7 -> +21.56%
> > +      6 -> +17.43%
> > +      5 -> +13.32%
> > +      4 -> +9.73%
> > +      3 -> +6.3
> > +      2 -> +3.17%
> > +      1 -> 0, Design default%
>
> Use "default:" instead. Here and in other places.
>
> > +      0 -> -2.72%
>
> In current form this should be an enum... but actually current form is
> wrong. You should not store register values in DT. What if next version
> of hardware has a different meaning of these values?
>
> Instead, you should store here meaningful values, not register values.

+1

To emphasize one point, meaningful values typically have a unit of
measure, like Hz, ms, mV, etc. What are the percentages adjusting from?
Is it a percentage decrease from the input voltage?
