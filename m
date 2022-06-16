Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA854E883
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378118AbiFPRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378075AbiFPRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:15:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79745473A1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:15:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 129so1820997pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8iz7ZOP2b0Lu2YomGWoPhULSTDfxHvkkUN5CEYP8CaU=;
        b=ApbDEiT1anUGxolRWQpnvh/eWWi46u0atckjEWb4RvkiaIAvr5aZnD+S+CE8pBh9Ue
         Rdpxdb8HpapM2i4wnBLme8kKJb6sQYtoE4BEIjrGkPuWRCm9/6eujrfB5IdbFD4FbxFh
         vlk2TjuD/1Sg2MIO0AkpoHPXrnb4FsWtTK2vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8iz7ZOP2b0Lu2YomGWoPhULSTDfxHvkkUN5CEYP8CaU=;
        b=VHsL7NM2oBLOi7nvS2iTa86UNomQLr6LYB48R+tV8MT3krRTcnJpwZ+rn802nAw3k3
         izL6JFaI7fD2Qo5PMuXdu9+IGYJnyeP8C9FoJRLHCaPU2avAxnaCuZfJ3JOhZJ9SO85k
         lWWbrWb4XMVzJyyA3YRp9Rwb44tseNw6EMya89/bjWQCkMVNEK197HAc+vRFk8bsMKiP
         FO1k6smd5AnXmRYZpWy0PDo0Zo8QrHQkvUsMQ02gDywLwGXN37fDRmV2vIj90O3CaSd7
         nkacNWQT5AFVvVVVX4IRjF2+1y//o6IBpDAZWym0ZIljVLmdnbqhESdfKqQO4R8jwhq/
         nUWg==
X-Gm-Message-State: AJIora/hBdt5Tfv4ZuDQneAOqY/pPCgLVshJm1KsFWOs94LmqYWxXaKh
        Yqiz2fYcsxB2V/1nGiLxsnlinQ==
X-Google-Smtp-Source: AGRyM1v1gOcNbulVWr4yT4FU7oeqvsT8pT39TN0Lj/5MQsCXzknBAbpphcjXQ9hhBxZQMW11jlfYIw==
X-Received: by 2002:a65:588b:0:b0:3fe:4237:2ee5 with SMTP id d11-20020a65588b000000b003fe42372ee5mr5334297pgu.442.1655399751849;
        Thu, 16 Jun 2022 10:15:51 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4ef5:7e3b:63ba:fc4])
        by smtp.gmail.com with UTF8SMTPSA id j1-20020a170903028100b00164097a779fsm1891067plr.147.2022.06.16.10.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 10:15:51 -0700 (PDT)
Date:   Thu, 16 Jun 2022 10:15:49 -0700
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
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YqtlRQOwb3t6Xtd0@google.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com>
 <Yp5nf2w8uVZ38/XZ@google.com>
 <Yqd9IHQEj3Ex+FcF@google.com>
 <YqjLHyUVEjf7I3MI@google.com>
 <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 02:41:10PM +0530, Pavan Kondeti wrote:
> Hi Matthias/Krishna,
> 
> On Tue, Jun 14, 2022 at 10:53:35AM -0700, Matthias Kaehlcke wrote:
> > On Mon, Jun 13, 2022 at 11:08:32AM -0700, Matthias Kaehlcke wrote:
> > > On Mon, Jun 06, 2022 at 01:45:51PM -0700, Matthias Kaehlcke wrote:
> > > > On Thu, Jun 02, 2022 at 12:35:42PM -0700, Matthias Kaehlcke wrote:
> > > > > Hi Krishna,
> > > > > 
> > > > > with this version I see xHCI errors on my SC7180 based system, like
> > > > > these:
> > > > > 
> > > > > [   65.352605] xhci-hcd xhci-hcd.13.auto: xHC error in resume, USBSTS 0x401, Reinit
> > > > > 
> > > > > [  101.307155] xhci-hcd xhci-hcd.13.auto: WARN: xHC CMD_RUN timeout
> > > > > 
> > > > > After resume a downstream hub isn't enumerated again.
> > > > > 
> > > > > So far I didn't see those with v13, but I aso saw the first error with
> > > > > v16.
> > > > 
> > > > It also happens with v13, but only when a wakeup capable vUSB <= 2
> > > > device is plugged in. Initially I used a wakeup capable USB3 to
> > > > Ethernet adapter to trigger the wakeup case, however older versions
> > > > of this series that use usb_wakeup_enabled_descendants() to check
> > > > for wakeup capable devices didn't actually check for vUSB > 2
> > > > devices.
> > > > 
> > > > So the case were the controller/PHYs is powered down works, but
> > > > the controller is unhappy when the runtime PM path is used during
> > > > system suspend.
> > > 
> > > The issue isn't seen on all systems using dwc3-qcom and the problem starts
> > > during probe(). The expected probe sequence is something like this:
> > > 
> > > dwc3_qcom_probe
> > >   dwc3_qcom_of_register_core
> > >     dwc3_probe
> > > 
> > >   if (device_can_wakeup(&qcom->dwc3->dev))
> > >     ...
> > > 
> > > The important part is that device_can_wakeup() is called after dwc3_probe()
> > > has completed. That's what I see on a QC SC7280 system, where wakeup is
> > > generally working with these patches.
> > > 
> > > However on a QC SC7180 system dwc3_probe() is deferred and only executed after
> > > dwc3_qcom_probe(). As a result the device_can_wakeup() call returns false.
> > > With that the controller/driver ends up in an unhappy state after system
> > > suspend.
> > > 
> > > Probing is deferred on SC7180 because device_links_check_suppliers() finds
> > > that '88e3000.phy' isn't ready yet.
> > 
> > It seems device links could be used to make sure the dwc3 core is present:
> > 
> >   Another example for an inconsistent state would be a device link that
> >   represents a driver presence dependency, yet is added from the consumer’s
> >   ->probe callback while the supplier hasn’t probed yet: Had the driver core
> >   known about the device link earlier, it wouldn’t have probed the consumer
> >   in the first place. The onus is thus on the consumer to check presence of
> >   the supplier after adding the link, and defer probing on non-presence.
> > 
> >   https://www.kernel.org/doc/html/v5.18/driver-api/device_link.html#usage
> > 
> > 
> > You could add something like this to dwc3_qcom_of_register_core():
> > 
> > 
> >   device_link_add(dev, &qcom->dwc3->dev,
> >   		  DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOPROBE_CONSUMER);
> > 
> >   if (qcom->dwc3->dev.links.status != DL_DEV_DRIVER_BOUND)
> >       ret = -EPROBE_DEFER;
> > 
> > 
> I am not very sure how the device_link_add() API works. we are the parent and
> creating a depdency on child probe. That does not sound correct to me.

The functional dependency is effectively there, the driver already assumes that
the dwc3 core was probed when of_platform_populate() returns.

The device link itself doesn't create the dependency on the probe(), the check
of the link status below does.

Another option would be to add a link to the PHYs to the dwc3-qcom node in
the device tree, but I don't think that would be a better solution (and I
expect Rob would oppose this).

I'm open to other solutions, so far the device link is the cleanest that came
to my mind.

I think the root issue is the driver architecture, with two interdependent
drivers for the same IP block, instead of a single framework driver with a
common part (dwc3 core) and vendor specific hooks/data.

> Any ways, I have another question.
> 
> When dwc3_qcom_of_register_core() returns error back to dwc3_qcom_probe(), we
> goto depopulate label which calls of_platform_depopulate() which destroy the
> child devices that are populated. how does that ensure that child probe is
> completed by the time, our probe is called again. The child device it self is
> gone. Is this working because when our probe is called next time, the child
> probe depenencies are resolved?

Good point! It doesn't really ensure that the child is probed (actually it
won't be probed and DL_FLAG_AUTOPROBE_CONSUMER doesn't make sense here), it
could happen that dwc3_qcom_probe() is deferred multiple times, but eventually
the PHYs should be ready and dwc3_probe() be invoked through
of_platform_populate().
