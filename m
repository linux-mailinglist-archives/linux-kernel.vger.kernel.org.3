Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE695AEEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiIFPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiIFPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D859C507
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662475282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7GYLFlANtPSZNiWZglHEjUXPEti/513uFdT3q/mqSQ=;
        b=LwFTBKOSHy8HsUFbTKy3v9Bw479+uq1QMBpo/T4r1u26T+5Jb/aSMmj1FdwBU3mBgdW8oS
        JxyaD3O6W9QTAnhFYHZAEHVBTabKvEyypZJmAElO8iN6A/DR/Q3zY1pTAl+VTv8zsr5lnX
        SexuoVGC6wjkUpimAkJVuhUbUKzXVc4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-lZWfqA01NLaDLCdU2wZvPQ-1; Tue, 06 Sep 2022 10:41:21 -0400
X-MC-Unique: lZWfqA01NLaDLCdU2wZvPQ-1
Received: by mail-qt1-f199.google.com with SMTP id cm10-20020a05622a250a00b003437b745ccdso9198620qtb.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H7GYLFlANtPSZNiWZglHEjUXPEti/513uFdT3q/mqSQ=;
        b=vNtGvdsKi7xdS1eY+z8XWemmTlkMPI7cz8JpC+IwA/mKix1gT6zD+jvQD3Q1I73iWC
         hgMtWLC/geThw+Pb0aGbff5RwN6Pm0tTvn2fVnlyuf8Gxc39zhcNrFVv6RTBRM5w+0Vl
         1L/3Rj57q3RFBVFv9xN+3b2AiIXkpvQ13nsOOogLpMf9AQj3VeLx12VJu0kl7GfBVck8
         oEO67HSJYlyKmsu4s7o7pzAizb4PKswAHVUhClHFoN3i1h/uB3WNfVva/YPFf+nqgXGd
         epx1oI9NaLbfPeMWs47GEozW8UeEThiXZOBsND9WLpOhNy3R3Y2KhMQ7ktx+6tGvxnTC
         35Yw==
X-Gm-Message-State: ACgBeo2b4T1uCObx+a7meBVAwohsFXMpARrtX9vjwXAeG43v1mIFawkf
        Iwqz5suvL3D7i93Q8NVCcWS1GkTBESZmjYxlTwrUtSF0+CEUEFBVasvl3Su0NbTUIFRLLgU2R/p
        q2VFM3KfxjgseG9eUw+C5t0Zv
X-Received: by 2002:ac8:4e8b:0:b0:344:adaa:4fa8 with SMTP id 11-20020ac84e8b000000b00344adaa4fa8mr44520403qtp.559.1662475280660;
        Tue, 06 Sep 2022 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4d8z/pjWmk/nqx7FCjeNeKKoqDyq2Y8dRLCC2VKcr8opzS5+wYVNrlqBnq7chKsJwIGT0PmA==
X-Received: by 2002:ac8:4e8b:0:b0:344:adaa:4fa8 with SMTP id 11-20020ac84e8b000000b00344adaa4fa8mr44520372qtp.559.1662475280369;
        Tue, 06 Sep 2022 07:41:20 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::a])
        by smtp.gmail.com with ESMTPSA id k22-20020ac84756000000b0033fc75c3469sm9347419qtp.27.2022.09.06.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:41:19 -0700 (PDT)
Date:   Tue, 6 Sep 2022 09:41:17 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dianders@chromium.org, johan@kernel.org
Subject: Re: [PATCH 3/3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Message-ID: <20220906144117.wyqulotg52aqru7u@halaneylaptop>
References: <20220902185148.635292-1-ahalaney@redhat.com>
 <20220902185148.635292-4-ahalaney@redhat.com>
 <de24bc67-f608-d9a0-31e7-ba291c469573@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de24bc67-f608-d9a0-31e7-ba291c469573@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 06:50:02PM +0200, Krzysztof Kozlowski wrote:
> On 02/09/2022 20:51, Andrew Halaney wrote:
> > For RPMH regulators it doesn't make sense to indicate
> > regulator-allow-set-load without saying what modes you can switch to,
> > so be sure to indicate a dependency on regulator-allowed-modes.
> 
> Hmmmm.... What about other regulators?
> 

My understanding (which very well might be wrong) is that if your
regulator is allowed to change modes, and sets regulator-allow-set-load,
then you have to describe what modes you can switch to.

But if you don't allow setting modes (for example qcom_rpm-regulator.c)
and just allow yourself to set_load() directly, then you don't need it.

So there is a more general requirement that applies regulator wide, but
I'm not sure how you would apply that at a higher level. I don't see a
good way to figure out in dt-binding land what regulator ops each
binding supports.

Hope that makes sense,
Andrew

> > 
> > With this in place devicetree validation can catch issues like this:
> > 
> >     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
> >             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> > 
> > Suggested-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> 
> 
> Best regards,
> Krzysztof
> 

