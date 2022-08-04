Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896F9589F13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiHDQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiHDQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766545F11E;
        Thu,  4 Aug 2022 09:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDEBD6145D;
        Thu,  4 Aug 2022 16:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D775C433C1;
        Thu,  4 Aug 2022 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659629071;
        bh=6pGrc94dvYb2OgWsE5mEE++5cvcrDZCQ7oo+HRuQ4oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L23PPi74cYg7A9Pru0juDhfLElHtDkPcx+V+EpUZwImTPPd2BPQywkZ/tg6f6/UIi
         cPsvdH8SeVaqjV21EcFVtCh1l2PzrnexHNMIhgZliEvYjqS/9DUAq8ZSY1ZGmCsSSU
         wQbabANAhYo6LH3e42IVJMygya69z/mpdwTQjtuDlatocYjT1W1bwaPnHdCgwT/UdQ
         kAkmzJTbokswMUDmLq5GY+yFwf4lZwI7sNw+8AmxtnD11aD0NAT5gVtC5ELssJ9se1
         1wVlyWIZd5UBm6p0dpf2uuxXDMQCTnP8gFQrzOtR5KsTftcthsvCCUvk8+RU3bNLLZ
         ijcldu9P6BAXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJdLB-0006dU-0n; Thu, 04 Aug 2022 18:04:53 +0200
Date:   Thu, 4 Aug 2022 18:04:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] usb: dwc3: qcom: fix runtime PM wakeup
Message-ID: <YuvuJR0ZqSvwMSi1@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-5-johan+linaro@kernel.org>
 <YurviWfzut9sursr@google.com>
 <Yut2tLqGfu82xcDs@hovoldconsulting.com>
 <YuvnLliIKLK71wx0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuvnLliIKLK71wx0@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:35:10AM -0700, Matthias Kaehlcke wrote:
> On Thu, Aug 04, 2022 at 09:35:16AM +0200, Johan Hovold wrote:

> After enabling runtime suspend for the dwc3 core, dwc3 glue and the xHCI
> the dwc3-qcom enters autosuspend when the delay expires.
> 
> > And the controller is resumed in the wakeup-interrupt handler for the
> > runtime PM case.
> >
> > It seems to work ok, and it looks like the driver has supported this
> > since it was first merged.
> 
> With and without your patch dwc3-qcom enters autosuspend and stays there.
> USB devices like a mouse or a USB to Ethernet adapter keep working while
> the glue is suspended.

Are you sure you're looking at the right controller? And that it is
actually suspended?

If you plug in a keyboard, enable autosuspend for all devices in the
path (from glue to the keyboard device) and type away, then the
controller must remain active. Stop typing, and all devices in the chain
should suspend.

> How is the runtime resume triggered for the dwc3 glue?

Either by the host driver when it needs to access the device, or by the
device if it is remote-wakeup capable (e.g. a keyboard, but not
necessarily a speaker).

Note that the latter part is what is broken currently as the wakeup
interrupts were not enabled and those are needed to wake up sc8280xp 
when the dwc3 glue has been runtime suspended.

Johan
