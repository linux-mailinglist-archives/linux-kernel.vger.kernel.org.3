Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1185237D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbiEKPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiEKPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:54:30 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733413F93D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:54:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x23so2341368pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yq+8NVE8TzoPtPDw2d7uVYhIh7kwcTL+WnUZqQp8/Zg=;
        b=A544jE1jdTMe9rrfN8ZdDhzFJSzsaDUGkABDM9EFerAvihrvGhotTw0oFkJ/MgR4Pk
         MVqu24ruuNA2Jz7aM8P43TlZt35mSbEaKcGO+kDEBI0pQmBg2yj9JzwE6Yaee9r0d4BK
         FXMdVl3CU0KS/d16Wjxe5x9DbaNtTPQ4HaDmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yq+8NVE8TzoPtPDw2d7uVYhIh7kwcTL+WnUZqQp8/Zg=;
        b=hNEldvQ53T1FrIXFgImVcC4P0bOy+dNYq3K1cI1S2r5yJZlwPmzmhB/gcSa748ht2p
         64g3i6mHGM6zLz2ugT5u4ZSnTbEEy5SJU9HAgGa727ks0Wl0AQXEITXuxr0Q4SX9/j+g
         RzHBTaZLtYbmzGr4NuRxNMwJB1+VEC4xZeN2wZtcr3oKPW4U0WPaJrpOy50B+FEy+tZc
         pPlYY13UHKBhzqKnC7pM8nBcX35KhZfdN0tmJF7qRJR4bhMvvFGkhfURv7u6fWhz/rV0
         M/mYl5FNte+/JrYLPr3Z64sCoz99J2wfkEgOLSPlJZv47wYME5bBEo4Q68NJH2STiygE
         Qr7g==
X-Gm-Message-State: AOAM531kdtw1RNvvIAbUSu2RQMexTpkD0hEVGh6drfDuEaAmwHlkEyVj
        ayDhnTPSDZFplWpFmgOZpEOPqw==
X-Google-Smtp-Source: ABdhPJx+7JYliMThOtCxTm/yr7mP3xyk5xGko+RGNTMntUQK+05+H3747B8X3nCsLHyiObebw5cQQw==
X-Received: by 2002:a65:6217:0:b0:3c6:1571:b971 with SMTP id d23-20020a656217000000b003c61571b971mr21594732pgv.124.1652284467734;
        Wed, 11 May 2022 08:54:27 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c586:bf93:e960:73b4])
        by smtp.gmail.com with UTF8SMTPSA id k15-20020a170902760f00b0015ed19cbfd8sm2043579pll.150.2022.05.11.08.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 08:54:27 -0700 (PDT)
Date:   Wed, 11 May 2022 08:54:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [v15 2/6] usb: host: xhci-plat: Enable wakeup based on children
 wakeup status
Message-ID: <YnvcMe+irsndtcV0@google.com>
References: <1651740973-7944-1-git-send-email-quic_kriskura@quicinc.com>
 <1651740973-7944-3-git-send-email-quic_kriskura@quicinc.com>
 <YnVAZSZYQvIJxOHv@google.com>
 <20220509033843.GB9170@hu-pkondeti-hyd.qualcomm.com>
 <20220511015101.GB23843@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220511015101.GB23843@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:21:01AM +0530, Pavan Kondeti wrote:
> On Mon, May 09, 2022 at 09:08:43AM +0530, Pavan Kondeti wrote:
> > On Fri, May 06, 2022 at 08:36:31AM -0700, Matthias Kaehlcke wrote:
> > > On Thu, May 05, 2022 at 02:26:09PM +0530, Krishna Kurapati wrote:
> > > > device_wakeup_path() tells if any of the children devices needs
> > > > wakeup. Use this hint to enable/disable wakeup of our device. This
> > > > helps the parent device of xhci-plat (like sysdev) to retrieve
> > > > the wakeup setting via device_wakeup_path().
> > > > 
> > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > ---
> > > >  drivers/usb/host/xhci-plat.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > > index 649ffd8..ad585fa 100644
> > > > --- a/drivers/usb/host/xhci-plat.c
> > > > +++ b/drivers/usb/host/xhci-plat.c
> > > > @@ -415,6 +415,14 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
> > > >  	if (pm_runtime_suspended(dev))
> > > >  		pm_runtime_resume(dev);
> > > >  
> > > > +	if (device_wakeup_path(dev)) {
> > > > +		if (!device_may_wakeup(dev))
> > > > +			device_wakeup_enable(dev);
> > > > +	} else {
> > > > +		if (device_may_wakeup(dev))
> > > > +			device_wakeup_disable(dev);
> > > > +	}
> > > 
> > > This code is not self-explantatory and deserves a comment.
> > > 
> > > Enabling/disabling wakeup for the purpose if signalling is a bit of a
> > > hack. It might be an acceptable hack as long as it has no side effects.
> > > However with the current implementation the wakeup state of the xHCI can
> > > be different after resuming than it was before going to suspend:
> > > 
> > > after boot
> > >   grep -h xhci /sys/class/wakeup/*/name
> > >     => xhci-hcd.14.auto
> > > 
> > > after suspend w/o wakeup capable device
> > >   grep -h xhci /sys/class/wakeup/*/name
> > >     => no results
> > > 
> > > after suspend with wakeup capable device
> > >   grep -h xhci /sys/class/wakeup/*/name
> > >     => xhci-hcd.14.auto
> > > 
> > > The hack shouldn't alter the wakeup state 'persistently', i.e. you'll have
> > > to restore it on resume, as in Pavan does in his reply to '[PATCH v14 2/7]
> > > PM / wakeup: Add device_children_wakeup_capable()' (it needs to be done
> > > conditionally though).
> > 
> > I am worried that we are not doing the right thing here. why should the
> > xhci-plat goes against the wishes of the user space policy here? Can we NOT
> > just do anything here? If some one wants xhci-plat to wakeup all the time,
> > dwc3 will be configured to wakeup the system provided that the support is
> > available. This way we don't break any existing users of xhci-plat i.e not
> > enabling wakeup from the kernel.
> > 
> Krishna,
> 
> can we please drop this patch and use device_wakeup_path() and verify the
> following cases.
> 
> 1. one of the downstream USB device supports wakeup and xhci-plat wakeup is enabled
> 2. one of the downstream USB device supports wakeup and xhci-plat wakeup is
> disabled
> 3. none of the downstream USB device supports wakeup (or disable) and
> xhci-plat wakeup is enabled.
> 4. none of the downstream USB device supports wakeup (or disable) and
> xhci-plat wakeup is disabled.

I wonder if we couldn't keep this simpler: if the dwc3 is wakeup capable keep
the PHYs/core powered, otherwise power them down. Similar to what commit
689bf72c6e0d ("usb: dwc3: Don't reinitialize core during host
bus-suspend/resume") intended, but with the additonal check for wakeup
capability. We now know that the PHYs need to be powered down on some SoCs
to allow the SoC to reach its low power mode during suspend:


  commit c4a5153e87fdf6805f63ff57556260e2554155a5
  Author: Manu Gautam <mgautam@codeaurora.org>
  Date:   Thu Jan 18 16:54:30 2018 +0530

  usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode

  Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
  host bus-suspend/resume") updated suspend/resume routines to not
  power_off and reinit PHYs/core for host mode.
  It broke platforms that rely on DWC3 core to power_off PHYs to
  enter low power state on system suspend.


With wakeup capable controllers this is apparently not an issue, otherwise
the SoC wouldn't be able to enter its low power state when wakeup is
enabled.
