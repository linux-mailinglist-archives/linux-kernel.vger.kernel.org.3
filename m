Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15D755CD12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiF1FcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiF1FcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:32:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65711A36;
        Mon, 27 Jun 2022 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656394321; x=1687930321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=apiE6ZqVRDttlfHw7HYKu5F6fqY2OHrTk8IJQ7nNCLc=;
  b=DSem2kWV3QQXc8Ddx5BSeWLY+sDt3H3lFCh27SX5RtU4KPJYdaDsqFvx
   viW4/rf5LH5/WB/CFwsGr9VTaJINwr51ehACQOZ1sCzHhmd30oyGYOYuz
   pdC5Lg92PLN2DtzAqzK4Zvjuzv7bXdgMxC/QiGZRlkl9J41Uh8dJlCszu
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jun 2022 22:32:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:32:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 22:31:59 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 22:31:53 -0700
Date:   Tue, 28 Jun 2022 11:01:48 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220628053148.GA21797@hu-pkondeti-hyd.qualcomm.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com>
 <Yp5nf2w8uVZ38/XZ@google.com>
 <Yqd9IHQEj3Ex+FcF@google.com>
 <YqjLHyUVEjf7I3MI@google.com>
 <20220616091110.GA24114@hu-pkondeti-hyd.qualcomm.com>
 <YqtlRQOwb3t6Xtd0@google.com>
 <20220620085415.GA13744@hu-pkondeti-hyd.qualcomm.com>
 <CAE-0n52bq9feA6BVdAp791SWQtT1Yj4M2ppg3o_KOaRFO8r+0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAE-0n52bq9feA6BVdAp791SWQtT1Yj4M2ppg3o_KOaRFO8r+0Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On Mon, Jun 27, 2022 at 01:02:49PM -0700, Stephen Boyd wrote:
> Quoting Pavan Kondeti (2022-06-20 01:54:15)
> > +Felipe, Bjorn
> >
> > On Thu, Jun 16, 2022 at 10:15:49AM -0700, Matthias Kaehlcke wrote:
> > > On Thu, Jun 16, 2022 at 02:41:10PM +0530, Pavan Kondeti wrote:
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
> >
> > Another alternative would be explicitly checking if the child device suppliers
> > are ready or not before adding child device. That would require decoupling
> > of_platform_populate() to creating devices and adding devices.
> >
> > Note that this problem is not just limited to suppliers not ready. if the
> > dwc3-qcom is made asynchronous probe, then its child also probed
> > asynchronously and there is no guarantee that child would be probed by the
> > time of_platform_populate() is returned.  The bus notifier might come handy
> > in this case. The parent can register for this notifier and waiting for
> > the children device's BUS_NOTIFY_BOUND_DRIVER/BUS_NOTIFY_DRIVER_NOT_BOUND
> > notifications. This would also work in our case, if we move to
> > of_platform_populate() outside the probe().
> >
> > Would like to hear other people thoughts on this.
> >
> 
> I'm not following very closely but it sounds like a problem that may be
> solved by using the component driver code (see
> include/linux/component.h). That would let you move anything that needs
> to be done once the child devices probe to the aggregate driver 'bind'
> function (see struct component_master_ops::bind).

Thanks Stephen for letting us know about the component device framework.

IIUC, 

- dwc3-qcom (parent of the dwc3 core) registers as a component master by
calling component_master_add_with_match() before calling
of_platform_populate(). The match callback could be as simple as comparing
the device against our child device.

- The dwc3 core (child) at the end of its probe can add as a component by calling
component_add(). 

- The above triggers the component_master_ops::bind callback implemented in
  dwc3-qcom driver which signals that we are good to go.

- The dwc-qcom can call component_bind_all() to finish the formality i.e
  telling the dwc3 core that we are good to go.

Is my understanding correct? This is what we are looking for i.e a way for
the child device(s) to signal the parent when the former is bounded.

Also what happens when the child device probe fails for any reason. i.e
component_add() would never be called so the master driver i.e dwc3-qcom would
wait indefinitely. May be it needs to implement a timeout or runtime suspend
etc should take care of keeping the resoures in suspend state.

Thanks,
Pavan
