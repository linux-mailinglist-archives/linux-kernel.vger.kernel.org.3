Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354704F996E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiDHPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbiDHPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:30:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7310FDFB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:28:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 66so8033601pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1wXlO1/OweZPaHt8M+nzEA7n6raTEZFPMqSrFHsFy68=;
        b=MBHgOKWhgWG5n/O1LvUP1gmEucefc1d1UqihpPPHc/YMi20+QGU9jlYs+Ar+BKo2xv
         eHZucs1INCirCqPZj+jXdPX9MPIRwIM+glwQqYAcMfsFXuGsSSy1Y47RsD2i8YaTYESx
         GJtd11a1lGhywBBavZolL1ht9fgER0kt0gB1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1wXlO1/OweZPaHt8M+nzEA7n6raTEZFPMqSrFHsFy68=;
        b=TRd3cuCEbbu+h/O0cb7+6nxvQ1uEqRCWJ7TQI7Jy0fTzuOf/0vivSi7ogCxGStx3F1
         UitakavNPcXb0lcFYn1HHfTfBoFOjAmV5mKDnVCAI/F/lOTTZUYJv5JegdL/b4//PhyV
         0iyPKyi3rZtESibvQBcVneRYZhGBYmtdXqp/94HySfV0mftSP4e/vhfh4WnUY3NmpwOy
         221MRhMLOIbXcxCmZTzAtWkLokA+tiXR1N5Cpw1VtrmiF+ytz2N8n0dEOevDAj8YlKvU
         NJqm2reWTKqgRTeIoB9JhiWs13PVS0/0x+DnUZJeMi7Uxv5Hg9qwdAKNrPR6HBSGdl56
         WAsQ==
X-Gm-Message-State: AOAM532zx0DLUZWTADn7Q8HaBlGjG0Cckir8PDY08Xgru1UeV0MBQohV
        dyL7URfLDMSCJ9GKeX9DL+j8Lg==
X-Google-Smtp-Source: ABdhPJw94w7jXnsvHlrKirC7rL9BHIBOthUmugLehPK83vyxfXwhKk6v5pdfs8vieWoC8xjP1vdL0g==
X-Received: by 2002:a05:6a00:1a49:b0:505:7ab3:e5c7 with SMTP id h9-20020a056a001a4900b005057ab3e5c7mr4404001pfv.62.1649431690633;
        Fri, 08 Apr 2022 08:28:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5944:d1ca:a1fe:33cc])
        by smtp.gmail.com with UTF8SMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm28018059pfc.111.2022.04.08.08.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 08:28:10 -0700 (PDT)
Date:   Fri, 8 Apr 2022 08:28:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_kriskura@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH v12 6/6] arm64: dts: qcom: sc7280: Add wakeup-source
 property for USB node
Message-ID: <YlBUiBZv6Hhsxn3C@google.com>
References: <1649321104-31322-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649321104-31322-7-git-send-email-quic_c_sanm@quicinc.com>
 <Yk8oMI3zifzFpJmW@google.com>
 <20220408020239.GB26536@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408020239.GB26536@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:32:39AM +0530, Pavan Kondeti wrote:
> On Thu, Apr 07, 2022 at 11:06:40AM -0700, Matthias Kaehlcke wrote:
> > On Thu, Apr 07, 2022 at 02:15:04PM +0530, Sandeep Maheswaram wrote:
> > > Adding wakeup-source property for USB controller in SC7280.
> > > This property is added to inform that the USB controller is
> > > wake up capable and to conditionally power down the phy during
> > > system suspend.
> > > 
> > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > index f0b64be..046262a 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > > @@ -2916,6 +2916,7 @@
> > >  				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> > >  				phy-names = "usb2-phy", "usb3-phy";
> > >  				maximum-speed = "super-speed";
> > > +				wakeup-source;
> > >  			};
> > >  		};
> > 
> > Not all SC7280 boards may want to enable wakeup from USB, so this is
> > probably best configured on a per-board basis.
> 
> This wakeup capability is provided by the SoC. If a particular
> board does not want to support, ideally it needs to be disabled from
> user space. The capability is always there but some platforms choose to
> disable it.

I guess 'wakeup-source' is a bit of an edge case between hardware capability
(which is certainly required to make wakeup work) and policy.

arch/arm64/boot/dts/mediatek/mt2712-evb.dts and
arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi are two example where
'wakeup-source' is set at the board level for a USB controller.

It's also true that user space can disable wakeup as you said, and a board
could also delete the property in its device tree if desired.

With that I agree that setting 'wakeup-source' at the SoC level provides
more flexibility and is more in line with the DT as hardware description.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
