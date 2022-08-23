Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABE59ECD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiHWTvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHWTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:50:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA692B274
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:54:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f21so14821716pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+hvao7pptwOr3qbqsTMhQzQ4Xux7plVKmyAIQ9qQXrw=;
        b=P31Z96otplQWfiXMsyQ/5+9zDtfWGPOoxwYQVgAmjdOPKi5+N3Yl6yiYRuVALCIZTS
         U3narRlWKJICIoz4l+QO5SqXhRr6DJVwLiiyKvFvM15aEePqCKgDqYICNl3RokUQS7yI
         Wvtb8JJcUIiMHh4Noulw2zl0jHMTB+zv6NthU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+hvao7pptwOr3qbqsTMhQzQ4Xux7plVKmyAIQ9qQXrw=;
        b=MAULZN3m0FcatyuHsLXJlZyKJxcOvQAyPTRVgze90qUiJQBOr76sW/c983Jz+uT+al
         I2g1XMVuJhWDwlabh10ZAuTgRmsk710+m++Dn26ALPsXrpjtAhSEouA4objJHnp371f8
         4l41HgxdzGiW1NESgS5KzYDCQ0Xw9AUFBseGdcCU503CNY6DcZBLrYPVn01aeafJt/Th
         UsdvQ3RZxJGArqWfEE/TpW0/FLLXOiGd9zbOmiMONKwqzv67FZ3w7nwbzgjZQl/ESp8e
         RJbq/A5PqSH+GDaN/GRI5fWBYdLzqhfNzKtHggoK51XFPas5aCI6T7HBFj7erjXADmXO
         xQNg==
X-Gm-Message-State: ACgBeo3ip2oMkAJIJ9rNd6+eZTow7IUah0a8iZFThq5ONnkaLhxJjeRg
        9vY2aXMq9MgTb+sW1gseImXlgg==
X-Google-Smtp-Source: AA6agR5vpr/23o9DFw09xOhWtsgRNBmIf+1QydM/1X3j+XxPOUinOav23kUN0DUJEFa2Gtv9sVKKvA==
X-Received: by 2002:a17:90b:1b42:b0:1fb:7a59:8965 with SMTP id nv2-20020a17090b1b4200b001fb7a598965mr682315pjb.140.1661280865580;
        Tue, 23 Aug 2022 11:54:25 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:fee6:a961:5d1d:553])
        by smtp.gmail.com with UTF8SMTPSA id e14-20020a17090301ce00b00171311470eesm10943906plh.8.2022.08.23.11.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 11:54:25 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:54:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>, andersson@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Message-ID: <YwUiX1PdNf1BU5UB@google.com>
References: <20220802152642.2516-1-johan+linaro@kernel.org>
 <YwOBEhViD1iY14yL@hovoldconsulting.com>
 <YwQDuXXkgwPAu55D@google.com>
 <YwS7ndGJ5cgERJhz@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwS7ndGJ5cgERJhz@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:35:57PM +0200, Johan Hovold wrote:
> On Mon, Aug 22, 2022 at 03:31:21PM -0700, Matthias Kaehlcke wrote:
> > On Mon, Aug 22, 2022 at 03:13:54PM +0200, Johan Hovold wrote:
> > > On Tue, Aug 02, 2022 at 05:26:42PM +0200, Johan Hovold wrote:
> > > > Move the USB-controller wakeup-source property to the dwc3 glue node to
> > > > match the updated binding.
> > > > 
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---
> > > > 
> > > > This one can be applied once the following series has been merged:
> > > > 
> > > > 	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org
> > > 
> > > The above series has now been merged (for 6.0):
> > > 
> > > 	https://lore.kernel.org/all/Yv56fFpuUsxCSxJ8@kroah.com/
> > > 
> > > so that this patch can be applied.
> > 
> > Please apply it together with "clk: qcom: gcc-sc7280: Keep USB GDSC power
> > domains on when USB wakeup is enabled" [1], otherwise USB wakeup won't work,
> > and worse, USB would be broken after returning from system suspend.
> 
> If you really need [1] for wakeup to work then it's already broken as
> the hack added to 6.0-rc1 that kept the power domain on in suspend has
> been reverted.

Yep, in v6.0-rc1 it is already broken, it should still work in the current
qcom tree. In any case wakeup isn't the primary concern, wakeup support for
sc7x80 just landed in a not-so-great shape, and your patches in v6.0-rc
generally improve it.

> If [1] is also needed for USB to work after resume, we either have a
> bigger problem as I alluded to in my comment to [1] (and the PD needs to
> be always on) or this is due to the PHY no longer being powered down in
> suspend.

Yes, it is apparently related with the PHYs no longer being powered down in
suspend. With your patch that reverts that [1] wakeup still works (as long as
wakeup for the dwc3 core remains enabled) and USB is operational after
resume.

So as long as the PHYs are powered down in suspend it shouldn't be necessary
to keep the GDSC PDs on. For Chrome OS we'll have to evaluate whether that
is an option (we observe high power consumption of an onboard USB hub
during system suspend when the PHYs are off) or whether sone mechanism (quirk,
kconfig option, ...) is needed to keep the PHYs on.

[1] https://patchwork.kernel.org/project/linux-usb/patch/20220823124047.14634-1-johan+linaro@kernel.org/

> Only in the latter case, does this patch need to be held of until [1]
> has been merged AFAICT.
> 
> Johan
> 
> > [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid/
