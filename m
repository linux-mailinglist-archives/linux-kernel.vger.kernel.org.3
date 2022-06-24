Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB55595E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiFXI7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiFXI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:59:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229D633D;
        Fri, 24 Jun 2022 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656061144; x=1687597144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ljZR3kvR/OGEYgbIV1wxUkEznb8b1nQMhgYJxvhzmJI=;
  b=WaAMVSipUXLHgmM40ys/0n9r0hhy3mdqyTLE++/AUZJACnB/HHGCTTMB
   um7DRJNF0mu4BWWJks75j2pfwOJy5/tkNK1jLLDt2MPJP/lmu+h7wRaxR
   lAAQ2SbsiTTBPy1kD/Kx7PaWGdIcnv+/n20JDFXNvmOO94AQGjl+QCnYF
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2022 01:59:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 01:59:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 01:59:02 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 01:58:56 -0700
Date:   Fri, 24 Jun 2022 14:28:53 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Krishna Kurapati" <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220624085853.GA11991@hu-pkondeti-hyd.qualcomm.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com>
 <Yp5nf2w8uVZ38/XZ@google.com>
 <Yqd9IHQEj3Ex+FcF@google.com>
 <YqjLHyUVEjf7I3MI@google.com>
 <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
 <YqtlRQOwb3t6Xtd0@google.com>
 <20220620085415.GA13744@hu-pkondeti-hyd.qualcomm.com>
 <YrSzDhgAvMx4TwD2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrSzDhgAvMx4TwD2@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:38:06AM -0700, Matthias Kaehlcke wrote:
> On Mon, Jun 20, 2022 at 02:24:15PM +0530, Pavan Kondeti wrote:
> > +Felipe, Bjorn
> > 
> > On Thu, Jun 16, 2022 at 10:15:49AM -0700, Matthias Kaehlcke wrote:
> > > On Thu, Jun 16, 2022 at 02:41:10PM +0530, Pavan Kondeti wrote:
> > > > Hi Matthias/Krishna,
> > > > 
> > > > On Tue, Jun 14, 2022 at 10:53:35AM -0700, Matthias Kaehlcke wrote:
> > > > > On Mon, Jun 13, 2022 at 11:08:32AM -0700, Matthias Kaehlcke wrote:
> > > > > > On Mon, Jun 06, 2022 at 01:45:51PM -0700, Matthias Kaehlcke wrote:
> > > > > > > On Thu, Jun 02, 2022 at 12:35:42PM -0700, Matthias Kaehlcke wrote:
> > > > > > > > Hi Krishna,
> > > > > > > > 
> > > > > > > > with this version I see xHCI errors on my SC7180 based system, like
> > > > > > > > these:
> > > > > > > > 
> > > > > > > > [   65.352605] xhci-hcd xhci-hcd.13.auto: xHC error in resume, USBSTS 0x401, Reinit
> > > > > > > > 
> > > > > > > > [  101.307155] xhci-hcd xhci-hcd.13.auto: WARN: xHC CMD_RUN timeout
> > > > > > > > 
> > > > > > > > After resume a downstream hub isn't enumerated again.
> > > > > > > > 
> > > > > > > > So far I didn't see those with v13, but I aso saw the first error with
> > > > > > > > v16.
> > > > > > > 
> > > > > > > It also happens with v13, but only when a wakeup capable vUSB <= 2
> > > > > > > device is plugged in. Initially I used a wakeup capable USB3 to
> > > > > > > Ethernet adapter to trigger the wakeup case, however older versions
> > > > > > > of this series that use usb_wakeup_enabled_descendants() to check
> > > > > > > for wakeup capable devices didn't actually check for vUSB > 2
> > > > > > > devices.
> > > > > > > 
> > > > > > > So the case were the controller/PHYs is powered down works, but
> > > > > > > the controller is unhappy when the runtime PM path is used during
> > > > > > > system suspend.
> > > > > > 
> > > > > > The issue isn't seen on all systems using dwc3-qcom and the problem starts
> > > > > > during probe(). The expected probe sequence is something like this:
> > > > > > 
> > > > > > dwc3_qcom_probe
> > > > > >   dwc3_qcom_of_register_core
> > > > > >     dwc3_probe
> > > > > > 
> > > > > >   if (device_can_wakeup(&qcom->dwc3->dev))
> > > > > >     ...
> > > > > > 
> > > > > > The important part is that device_can_wakeup() is called after dwc3_probe()
> > > > > > has completed. That's what I see on a QC SC7280 system, where wakeup is
> > > > > > generally working with these patches.
> > > > > > 
> > > > > > However on a QC SC7180 system dwc3_probe() is deferred and only executed after
> > > > > > dwc3_qcom_probe(). As a result the device_can_wakeup() call returns false.
> > > > > > With that the controller/driver ends up in an unhappy state after system
> > > > > > suspend.
> > > > > > 
> > > > > > Probing is deferred on SC7180 because device_links_check_suppliers() finds
> > > > > > that '88e3000.phy' isn't ready yet.
> > > > > 
> > > > > It seems device links could be used to make sure the dwc3 core is present:
> > > > > 
> > > > >   Another example for an inconsistent state would be a device link that
> > > > >   represents a driver presence dependency, yet is added from the consumer’s
> > > > >   ->probe callback while the supplier hasn’t probed yet: Had the driver core
> > > > >   known about the device link earlier, it wouldn’t have probed the consumer
> > > > >   in the first place. The onus is thus on the consumer to check presence of
> > > > >   the supplier after adding the link, and defer probing on non-presence.
> > > > > 
> > > > >   https://www.kernel.org/doc/html/v5.18/driver-api/device_link.html#usage
> > > > > 
> > > > > 
> > > > > You could add something like this to dwc3_qcom_of_register_core():
> > > > > 
> > > > > 
> > > > >   device_link_add(dev, &qcom->dwc3->dev,
> > > > >   		  DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOPROBE_CONSUMER);
> > > > > 
> > > > >   if (qcom->dwc3->dev.links.status != DL_DEV_DRIVER_BOUND)
> > > > >       ret = -EPROBE_DEFER;
> > > > > 
> > > > > 
> > > > I am not very sure how the device_link_add() API works. we are the parent and
> > > > creating a depdency on child probe. That does not sound correct to me.
> > > 
> > > The functional dependency is effectively there, the driver already assumes that
> > > the dwc3 core was probed when of_platform_populate() returns.
> > > 
> > > The device link itself doesn't create the dependency on the probe(), the check
> > > of the link status below does.
> > > 
> > > Another option would be to add a link to the PHYs to the dwc3-qcom node in
> > > the device tree, but I don't think that would be a better solution (and I
> > > expect Rob would oppose this).
> > > 
> > > I'm open to other solutions, so far the device link is the cleanest that came
> > > to my mind.
> > > 
> > > I think the root issue is the driver architecture, with two interdependent
> > > drivers for the same IP block, instead of a single framework driver with a
> > > common part (dwc3 core) and vendor specific hooks/data.
> > > 
> > > > Any ways, I have another question.
> > > > 
> > > > When dwc3_qcom_of_register_core() returns error back to dwc3_qcom_probe(), we
> > > > goto depopulate label which calls of_platform_depopulate() which destroy the
> > > > child devices that are populated. how does that ensure that child probe is
> > > > completed by the time, our probe is called again. The child device it self is
> > > > gone. Is this working because when our probe is called next time, the child
> > > > probe depenencies are resolved?
> > > 
> > > Good point! It doesn't really ensure that the child is probed (actually it
> > > won't be probed and DL_FLAG_AUTOPROBE_CONSUMER doesn't make sense here), it
> > > could happen that dwc3_qcom_probe() is deferred multiple times, but eventually
> > > the PHYs should be ready and dwc3_probe() be invoked through
> > > of_platform_populate().
> > 
> > This is a generic problem i.e if a parent can only proceed after the child
> > devices are bounded (i.e probed successfully), how to ensure this behavior
> > from the parent's probe? Since we can't block the parent probe (async probe is
> > not the default behavior), we have to identify the condition that the children
> > are deferring probe, so that parent also can do that.
> > 
> > Can we add a API in drivers core to tell if a device probe is deferred or
> > not? This can be done by testing list_empty(&dev->p->deferred_probe) under
> > deferred_probe_mutex mutex. The parent can return EPROBE_DEFER based on this
> > API return value.
> 
> That could be an option.
> 
> > Another alternative would be explicitly checking if the child device suppliers
> > are ready or not before adding child device. That would require decoupling
> > of_platform_populate() to creating devices and adding devices.
> 
> It might require a new API since there are plenty of users of
> of_platform_populate() that rely on the current behavior.

Agree. A new API is needed. we also have to consider multiple children
scenario, where one child is ready but others are not etc.

> 
> > Note that this problem is not just limited to suppliers not ready. if the
> > dwc3-qcom is made asynchronous probe, then its child also probed
> > asynchronously and there is no guarantee that child would be probed by the
> > time of_platform_populate() is returned.  The bus notifier might come handy
> > in this case. The parent can register for this notifier and waiting for
> > the children device's BUS_NOTIFY_BOUND_DRIVER/BUS_NOTIFY_DRIVER_NOT_BOUND
> > notifications. This would also work in our case, if we move to
> > of_platform_populate() outside the probe().
> 
> If I understand correctly the outcome would be a probe() in two stages. The
> first does as much as it can do without the dwc3 core and leaves the device
> in a state where it isn't really functional, and the second stage does the
> rest when BUS_NOTIFY_BOUND_DRIVER is received for the dwc3 core device.
> 
> A concern could be the need for additional conditions in some code paths to
> deal with the half-initialized device.
> 
> Why would of_platform_populate() be moved outside of probe()?
> 
> To avoid the half-initialized device probe() could block until
> BUS_NOTIFY_BOUND_DRIVER is received. Probably that should be done with a
> timeout to avoid blocking forever in case of a problem with probing the
> dwc3 core.

Right, we have to split the probe() into two parts. The second stage which
runs asynchronously should wait for the dwc3 core probe to happen. if at all
dwc3 core probe is falied (in which case also we get a notification) for any
reason other than EPROBE_DEFER, we have to undo the first stage.

Thansk,
Pavan
