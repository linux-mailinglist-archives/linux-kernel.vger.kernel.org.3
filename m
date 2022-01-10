Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE160489E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiAJR2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:28:51 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43691 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiAJR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:28:49 -0500
Received: by mail-oi1-f180.google.com with SMTP id u21so19588952oie.10;
        Mon, 10 Jan 2022 09:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZsxrSJKAlL12zoGr617hjEfztTw9El7OEQAesnFjPV8=;
        b=qLM/G5/vApXoF8rMv3ZK7t/Y2d9hQECZ24nz0VNILFwYzprrTfhImjXjnwWcKsdyJE
         yTHGMNmHdvGNMc6P5JXEgRiNA4fTFD/PaUelhIpB0sa/NRHoKwPoA62wK5wok24tPYo6
         ZJqeJ+QRmpIC289iEnJp9icAx/kmkNXn1kjc5JxnWLoTPweZf97Nf92y3jiT/pL3ma2I
         GOGS3MCjtfObpTxF4APiXjrsN2BKAkI5mKqCq9TKYC8s+lbVUJiaA1qTIMUKf8wqWNuC
         UqQ3nuIztczSW/9YDkbRfK4S6ca4aqoaAIJBaY3QSHMAogjn/EbhUbgGDoQt5pYMqrgs
         DyYA==
X-Gm-Message-State: AOAM530MfjCjn5lwl47Z6dB3jL2fGD0JaFAZ2ZcYYgBhzyZhobH7gj53
        87fXVqcg02gIj7Ig/fBF6Q==
X-Google-Smtp-Source: ABdhPJzUnBjoClx0LWUB/b4sUdkJ3H7i9huwtIYYvV+Ne/HFhaTqEu0dY9davPLBP0VtCD2hQZWX/w==
X-Received: by 2002:a05:6808:228e:: with SMTP id bo14mr8728255oib.55.1641835729226;
        Mon, 10 Jan 2022 09:28:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n19sm1573634otq.11.2022.01.10.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:28:48 -0800 (PST)
Received: (nullmailer pid 1122976 invoked by uid 1000);
        Mon, 10 Jan 2022 17:28:47 -0000
Date:   Mon, 10 Jan 2022 11:28:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rajeev Nandan <quic_rajeevny@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean@poorly.run, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, quic_kalyant@quicinc.com,
        quic_mkrishn@quicinc.com, jonathan@marek.ca, airlied@linux.ie,
        daniel@ffwll.ch, swboyd@chromium.org
Subject: Re: [v2 1/3] dt-bindings: msm/dsi: Add 10nm dsi phy tuning properties
Message-ID: <Ydxsz+XSreBKFNcr@robh.at.kernel.org>
References: <1641819337-17037-1-git-send-email-quic_rajeevny@quicinc.com>
 <1641819337-17037-2-git-send-email-quic_rajeevny@quicinc.com>
 <CAA8EJprrRZK+ocW9zDY_eyeo_m_xbu+KmfWf8QmTYscAh5SxLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJprrRZK+ocW9zDY_eyeo_m_xbu+KmfWf8QmTYscAh5SxLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:06:03PM +0300, Dmitry Baryshkov wrote:
> On Mon, 10 Jan 2022 at 15:56, Rajeev Nandan <quic_rajeevny@quicinc.com> wrote:
> >
> > In most cases, the default values of DSI PHY tuning registers should be
> > sufficient as they are fully optimized. However, in some cases where
> > extreme board parasitics cause the eye shape to degrade, the override
> > bits can be used to improve the signal quality.
> >
> > The general guidelines for DSI PHY tuning include:
> > - High and moderate data rates may benefit from the drive strength and
> >   drive level tuning.
> > - Drive strength tuning will affect the output impedance and may be used
> >   for matching optimization.
> > - Drive level tuning will affect the output levels without affecting the
> >   impedance.
> >
> > The clock and data lanes have a calibration circuitry feature. The drive
> > strength tuning can be done by adjusting rescode offset for hstop/hsbot,
> > and the drive level tuning can be done by adjusting the LDO output level
> > for the HSTX drive.
> >
> > Signed-off-by: Rajeev Nandan <quic_rajeevny@quicinc.com>
> > ---
> >
> > Changes in v2:
> >  - More details in the commit text (Stephen Boyd)
> >  - Use human understandable values (Stephen Boyd, Dmitry Baryshkov)
> >  - Do not take values that are going to be unused (Dmitry Baryshkov)
> >
> >  .../bindings/display/msm/dsi-phy-10nm.yaml         | 33 ++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> > index 4399715..d0eb8f6 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> > @@ -35,6 +35,35 @@ properties:
> >        Connected to DSI0_MIPI_DSI_PLL_VDDA0P9 pin for sc7180 target and
> >        connected to VDDA_MIPI_DSI_0_PLL_0P9 pin for sdm845 target
> 
> Generic note:
> I think these properties should be prefixed with "qcom," prefix.
> 
> >
> > +  phy-rescode-offset-top:
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +    minItems: 5
> > +    maxItems: 5
> > +    description:
> > +      Integer array of offset for pull-up legs rescode for all five lanes.
> > +      To offset the drive strength from the calibrated value in an increasing
> > +      or decreasing manner, use 6 bit two’s complement values.
> 
> dtc should support negative values, google hints that <(-2)> should work.

Yes, but the schema checks don't check negative values correctly yet. So 
you can use 'int8-array', but just don't use negative values in the 
examples. I'm working on changes that will fix this issue.

What does 6-bit mean? 0x3f is negative? Just sign extend the values and 
specify the valid range instead:

minimum: -32
maximum: 31

Rob
