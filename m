Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5411658B701
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiHFQnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiHFQnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:43:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4CE11838
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:43:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c24so251603pgg.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u+HsotwZu4/DQTFavAntnF4A2WHcFcwiP3gL0WcyE5c=;
        b=FWM6VdtaVsuAMpkLeRcNbc8vwCZEk/GiZf/dHPxTAYpsN5Gy4A0ApRupoicqe6S1Ov
         0RiYbVtOjvQg/S6KYxG0v8tryrE2GyqNMDhRIFcM2Z53jUVsRLVEvHE9pSCmvIJwIVXy
         4q4CGHhLVK1eXp+Qk64Iw6iCquXvGOgcKMg4yKzjjdLPOC4fCAhiPFPq9HDT67r7PMzv
         VZQXDDI9qdQ9kew1jKjvgqJu2jE117M1RCYwPQLJi17DF+osG1Yy9ACD65JI7KDcEfef
         2ygaRq1fM53hQ55SOlq4GcF76457XPI8IPEsT8rO4XuIXxi9KOnMx+1iK3Yk2+XyJ/Qb
         8ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u+HsotwZu4/DQTFavAntnF4A2WHcFcwiP3gL0WcyE5c=;
        b=oiieEBprdbuY+vSpch2bc2/p5ejFsttEmwTkAvUZ9G5v/ksramBr78neJjOXx8Uk4a
         EFHVbcFTSxUpg4iJGk/lWniuuv0LrxKrwIkt+UcawT9PJ5bvayZ8aAuWw7Mpam/6/uUr
         ARTeWgbCE95WUS2J0W9SAN289l1KpsuQM/oZNajLrvID1FYHqRYQolaF5E97pe4Xc8Gm
         6wR4kaNY1WKY42UMP+fPiqszUO9RVqBoEg0amj67ES/1ZdfJD3yaO4wYawKeyhdv/Ay+
         tX4pc/6lELKxtuKy5soQ5AoTKvpeCtEZqZ6gdvcWOYBpJbgKrs/SMXHqkEjcfPnRdpAZ
         4fiw==
X-Gm-Message-State: ACgBeo2E38+BnhCaYxOM80GAi4L6gck+MGrq0esTJrUegxtQ23xEU3CR
        0qJRIpWUzoluXChRNneok87t
X-Google-Smtp-Source: AA6agR47tD0/Z5azdFhBtsRiIdc4KMhAhM/Jivkvxc+SHd4qGI7EB4Ud37m2+SNGiW2BObnn5WPjOA==
X-Received: by 2002:a63:e70f:0:b0:41c:ac9e:27aa with SMTP id b15-20020a63e70f000000b0041cac9e27aamr9545032pgi.489.1659804180293;
        Sat, 06 Aug 2022 09:43:00 -0700 (PDT)
Received: from thinkpad ([117.202.188.20])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b0016f1319d2a7sm5127785plm.297.2022.08.06.09.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 09:42:59 -0700 (PDT)
Date:   Sat, 6 Aug 2022 22:12:50 +0530
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
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/9] usb: dwc3: qcom: fix gadget-only builds
Message-ID: <20220806164250.GK14384@thinkpad>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-4-johan+linaro@kernel.org>
 <20220806141536.GD14384@thinkpad>
 <Yu6RBQNSatiwu1WV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yu6RBQNSatiwu1WV@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 06:04:21PM +0200, Johan Hovold wrote:
> On Sat, Aug 06, 2022 at 07:45:36PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Aug 04, 2022 at 05:09:55PM +0200, Johan Hovold wrote:
> > > A recent change added a dependency to the USB host stack and broke
> > > gadget-only builds of the driver.
> > > 
> > > Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > --`-
> > > 
> > > Changes in v2
> > >  - new patch
> > > 
> > >  drivers/usb/dwc3/dwc3-qcom.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > index be2e3dd36440..e9364141661b 100644
> > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > @@ -310,8 +310,11 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> > >  	 * currently supports only 1 port per controller. So
> > >  	 * this is sufficient.
> > >  	 */
> > > +#ifdef CONFIG_USB
> > >  	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> > > -
> > > +#else
> > > +	udev = NULL;
> > > +#endif
> > 
> > Perhaps the check should be moved to the caller instead? This function still
> > references "usb_hcd" struct and I don't think that's intended for gadget only
> > mode.
> 
> That wouldn't help with the build failure, which is what this patch is
> addressing.
> 

I should've put it clearly. You should guard the entire function and not just
usb_hub_find_child(). This way it becomes clear that this whole function depends
on the USB host functionality. Like,

#ifdef CONFIG_USB
static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
{
...
}
#elif
static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
{
	return USB_SPEED_UNKNOWN
}
#endif

Thanks,
Mani

> > >  	if (!udev)
> > >  		return USB_SPEED_UNKNOWN;
> > >  
> > > -- 
> > > 2.35.1
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
