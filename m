Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358CF58B716
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiHFQww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiHFQwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:52:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C3DEAC
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:52:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso10933067pjq.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tbINJ7QsOYoYb8ZFX+exoUH6wh4ff1wK54fBzhvpouw=;
        b=JOLyQbC/YMjp6EweqOCx5ld/GN+PK4jwMP0XxvuVyYh9wO2unrHYuKJF32mfYXhGV6
         F0WYdaUb9qRQjhplg92+CUn3PP6MCZuDcMUXJvXJOfXDb6QIyELTbxDl9FuJCr5UiAol
         h8gW2GFN+ikLlDIYzwq5jlVhbZdxOwqBKSmrNKjeVpVctmFPUwkYw4dfiNqMQeX3Jso/
         +fI8v5+eIyaYd45EsqVtHuP3xFVt4fiZdmj7d3CACYAjvxdymM0aTyLY0F7c6VEZZnG4
         pQ7A5reXVmP8cMlHc8ch57dHzBzfAugQyLfDx0DZKi+NuY1WzXQKCLEDkj0m7DRKdfHZ
         HDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tbINJ7QsOYoYb8ZFX+exoUH6wh4ff1wK54fBzhvpouw=;
        b=OjFRHozzXUYYA3pF1MChQ2oirP5gaeYVzslaOQufiA5u9VuzO4vmRJ9GDA/iDbr/Rq
         n/vRsAoUrydc1gzeO2B+ee6u68XoJX0xFiUEKlZXeaMD/FKZdzxlAPftcMJhQkq/u+ek
         JcRGvblBRC1uo8Gs6lDxg24aqMt4/rG165zbebynJCw8Uq7ETcng8pqYVQCYU4xjqHEB
         EjnxXSzWna1z7PPNSCz6+fXmZstNi9jCI/lTLKO9hwuZ1Kieak+w2IpBGay4JgKVZndU
         pN6reL0esqdz60hiP8dioRSV0XvM4BidNaJXXh0D6UyVNq/NpM3Hfx43DZ+9g9RZv4bz
         WzOA==
X-Gm-Message-State: ACgBeo3xpW4Gy30IPnvpNlvoF3YsaWjaJ6/bzyYc8gMj70MCbuPIxXRd
        0CDuGnWh3emu5w7YgI0jHdHm
X-Google-Smtp-Source: AA6agR49CnysaV2RsOmCz8D4Gvyz4ZIECUCvGu6eXfolX5aecwTuqZ6ew8l7Y094y5DPffBRTAE4yw==
X-Received: by 2002:a17:902:8d8a:b0:16f:21fb:b97a with SMTP id v10-20020a1709028d8a00b0016f21fbb97amr11712794plo.160.1659804768082;
        Sat, 06 Aug 2022 09:52:48 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id u14-20020a62790e000000b0052d78e73e6asm5189736pfc.184.2022.08.06.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:52:47 -0700 (PDT)
Date:   Sat, 6 Aug 2022 22:22:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: usb: qcom,dwc3: add wakeup-source
 property
Message-ID: <20220806165238.GM14384@thinkpad>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-8-johan+linaro@kernel.org>
 <20220806150848.GH14384@thinkpad>
 <Yu6ZwePzzkl7tewV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yu6ZwePzzkl7tewV@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 06:41:37PM +0200, Johan Hovold wrote:
> On Sat, Aug 06, 2022 at 08:38:48PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Aug 04, 2022 at 05:09:59PM +0200, Johan Hovold wrote:
> > > Add a wakeup-source property to the binding to describe whether the
> > > wakeup interrupts can wake the system from suspend.
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > 
> > So this is based on the fact that Qcom glue wrapper is supplying the wakeup
> > interrupts. But isn't it possible that on other platform, the DWC IP can supply
> > wakeup interrupts?
> 
> Yeah, possibly, and that's why Rob suggested keeping the 'wakeup-source'
> property also in the core node.
> 
> > In the driver, the wakeup-source parsing has been moved to the Qcom glue driver.
> > But this contradicts with the binding.
> 
> That's irrelevant. The core driver does not implement wakeup support. It
> was just added as a hack for the Qualcomm driver, and you won't get
> wakeup-capability for other platforms by just parsing the property in
> the core driver.
> 
> When/if wakeup support for such a platform is added, then the core
> driver may need to look at the property again.
> 

My point is, the platform drivers are free to add "wakeup-source" property in
the DWC node. Then in that case, the DWC driver should handle the capability,
isn't it?

I know it is broken currently, but moving the wakeup parsing code is not
helping either.

And... I'm aware of the fact that the binding should describe the hardware and
not the limitation of the driver. So perhaps we should document it in the
driver as a TODO or something?

Thanks,
Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
