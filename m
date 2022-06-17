Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B954FB3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383358AbiFQQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383173AbiFQQeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:34:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6945057
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:34:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y6so4341239plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nd3dN3lYUm5hDfDMm9sL27iNLS0X0KMXC7NRfgc2gmc=;
        b=BtRoGpT1FAiQfOM2DaRL5mj8HWiEU+XcteU+dczzn2p12PdzXMILEZP+inJD/DFwmq
         eVjEcsB5zg29VzXrl0PZSJ6CdyJWk7yybdTdKyEewzf/QC/pI0EUha5gWBuqawticoRp
         R3vI7YinfL/9tVRIpndb3QyQ9Q5tFe0ivkrJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nd3dN3lYUm5hDfDMm9sL27iNLS0X0KMXC7NRfgc2gmc=;
        b=6KUdCN+Q892+4gPM5I/qyjWu82Vuvn2qKEPPwll2g8wtjVhckQ5Dj2Ixkn16h8AU34
         o6Dkn1cucPKYN7Ic4kPyYdcTXbGTXnQ607f9+Jh/NRyEfvulY+5iy0db+U+I4CQujMSx
         Yz/+Xw9m+ARnFp+8vZCMtgu04HXARv+r257rQpvfuAQ6SlVKSHfkoeasKExs6k0b0uOb
         sT4HPp8NjJIE/MdO5Zc4JjVm5FUh/npRbZ83OTAGF4fxoSgWR7Z+FCKnOZP3G4QV1D/8
         FoiRrWgoanos3Yp5aXSFUzfL2uzPkz76ZGLHpWiwvPfRRGlfDxD5Gk7vfIHXjAqfbviz
         eyUw==
X-Gm-Message-State: AJIora+7ODqkO54/HpYkK76FMoWYUYdHP8oKDweHzHQZneZmB/lmeccV
        HBTor5qtNhiMXDk5RCuJDppaZQ==
X-Google-Smtp-Source: AGRyM1s37DuE8YQkC2E+E40JgbjDJaFjVTbMhmPgs01ftLRxulOfya9oQpooM0IPlrvnXJNld8+fzQ==
X-Received: by 2002:a17:90a:5409:b0:1e8:664e:41dd with SMTP id z9-20020a17090a540900b001e8664e41ddmr11525659pjh.173.1655483662543;
        Fri, 17 Jun 2022 09:34:22 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:cace:b949:b9e3:3a43])
        by smtp.gmail.com with UTF8SMTPSA id s11-20020a170902b18b00b00168c4c3ed94sm3609256plr.309.2022.06.17.09.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:34:22 -0700 (PDT)
Date:   Fri, 17 Jun 2022 09:34:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH v22 2/3] usb: misc: Add onboard_usb_hub driver
Message-ID: <YqytDNB2y4+qT8GD@google.com>
References: <20220609121838.v22.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAD=FV=W6erE8ByabmYSL_OWJPKYGqysDMGYQX6j7_PSEYGZ4YQ@mail.gmail.com>
 <YqpprpUHmlD62YzI@google.com>
 <CAD=FV=VNDamV4+j07TrnX3cUs2-D5ySbeQ-zfU=Eef8+WagGig@mail.gmail.com>
 <Yqub17iT4O7aqFMi@google.com>
 <CAD=FV=VEztPLhsrJecZUdyHCW7ZfFTVvxyqY5CqRVv2mWyrLog@mail.gmail.com>
 <YquoSMiQS+RG8rOM@google.com>
 <CAD=FV=W81pSEUbzw2ZQgs_TJ9MLnHQHiDopZXZ6bHdS7QMzAyA@mail.gmail.com>
 <YqvMffveCPiKQEUk@google.com>
 <CAD=FV=UJOStPfRR3Hq2DmRBSH-HCtZ16hAU9eVH5w6Hm=WSJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UJOStPfRR3Hq2DmRBSH-HCtZ16hAU9eVH5w6Hm=WSJRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 08:09:06AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 16, 2022 at 5:36 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Thu, Jun 16, 2022 at 03:46:15PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Jun 16, 2022 at 3:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 02:28:38PM -0700, Doug Anderson wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, Jun 16, 2022 at 2:08 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > >
> > > > > > On Thu, Jun 16, 2022 at 01:12:32PM -0700, Doug Anderson wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Wed, Jun 15, 2022 at 4:22 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > > > >
> > > > > > > > > > +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > > > > > > > > > +{
> > > > > > > > > > +       int i;
> > > > > > > > > > +       struct usb_hcd *hcd = bus_to_hcd(parent_hub->bus);
> > > > > > > > > > +       struct device_node *np, *npc;
> > > > > > > > > > +       struct platform_device *pdev = NULL;
> > > > > > > > > > +       struct pdev_list_entry *pdle;
> > > > > > > > > > +
> > > > > > > > > > +       if (!parent_hub->dev.of_node)
> > > > > > > > > > +               return;
> > > > > > > > > > +
> > > > > > > > > > +       for (i = 1; i <= parent_hub->maxchild; i++) {
> > > > > > > > > > +               np = usb_of_get_device_node(parent_hub, i);
> > > > > > > > > > +               if (!np)
> > > > > > > > > > +                       continue;
> > > > > > > > > > +
> > > > > > > > > > +               if (!of_is_onboard_usb_hub(np))
> > > > > > > > > > +                       goto node_put;
> > > > > > > > > > +
> > > > > > > > > > +               npc = of_parse_phandle(np, "companion-hub", 0);
> > > > > > > > > > +               if (npc) {
> > > > > > > > > > +                       /*
> > > > > > > > > > +                        * Hubs with companions share the same platform device.
> > > > > > > > > > +                        * Create the plaform device only for the hub that is
> > > > > > > > > > +                        * connected to the primary HCD (directly or through
> > > > > > > > > > +                        * other hubs).
> > > > > > > > > > +                        */
> > > > > > > > > > +                       if (!usb_hcd_is_primary_hcd(hcd)) {
> > > > > > > > > > +                               of_node_put(npc);
> > > > > > > > > > +                               goto node_put;
> > > > > > > > > > +                       }
> > > > > > > > > > +
> > > > > > > > > > +                       pdev = of_find_device_by_node(npc);
> > > > > > > > > > +                       of_node_put(npc);
> > > > > > > > > > +               } else {
> > > > > > > > > > +                       /*
> > > > > > > > > > +                        * For root hubs this function can be called multiple times
> > > > > > > > > > +                        * for the same root hub node (the HCD node). Make sure only
> > > > > > > > > > +                        * one platform device is created for this hub.
> > > > > > > > > > +                        */
> > > > > > > > > > +                       if (!parent_hub->parent && !usb_hcd_is_primary_hcd(hcd))
> > > > > > > > > > +                               goto node_put;
> > > > > > > > >
> > > > > > > > > I don't understand the "else" case above. What case exactly are we
> > > > > > > > > handling again? This is when:
> > > > > > > > > * the hub is presumably just a 2.0 hub since there is no companion.
> > > > > > > > > * our parent is the root hub and the USB 2.0 hub we're looking at is
> > > > > > > > > not the primary
> > > > > > > >
> > > > > > > > The 'else' case can be entered for hubs connected to a root hub or to another
> > > > > > > > hub further down in the tree, but we bail out only for first level hubs.
> > > > > > > >
> > > > > > > > > ...but that doesn't make a lot of sense to me? I must have missed something...
> > > > > > > >
> > > > > > > > It's not super-obvious, this bit is important: "this function can be called
> > > > > > > > multiple times for the same root hub node". For any first level hub we only
> > > > > > > > create a pdev if this function is called on behalf of the primary HCD. That
> > > > > > > > is also true of a hub connected to the secondary HCD. We only want to create
> > > > > > > > one pdev and there is supposedly always a primary HCD.
> > > > > > > >
> > > > > > > > Maybe it would be slightly clearer if the function returned before the loop
> > > > > > > > if this condition is met.
> > > > > > >
> > > > > > > I guess I'm still pretty confused. You say "For root hubs this
> > > > > > > function can be called multiple times for the same root hub node".
> > > > > > > Does that mean that the function will be called multiple times with
> > > > > > > the same "parent_hub", or something else.
> > > > > >
> > > > > > It is called with a different "parent_hub", however for root hubs the
> > > > > > DT node is the same for both root hubs (it's the DT node of the
> > > > > > controller since there are no dedicated nodes for the root hubs).
> > > > > >
> > > > > > Just to make sure this isn't the source of the confusion: the root hubs
> > > > > > are part of the USB controller, not 'external' hubs which are directly
> > > > > > connected to the controller. I call the latter 'first level hubs'.
> > > > > >
> > > > > > > Unless it's called with the same "parent_hub" then it seems like if
> > > > > > > the USB device has a device tree node and that device tree node is for
> > > > > > > a onboard_usb_hub and there's no companion node then we _always_ want
> > > > > > > to create the platform device, don't we? If it is called with the same
> > > > > > > "parent_hub" then I'm confused how your test does something different
> > > > > > > the first time the function is called vs. the 2nd.
> > > > > >
> > > > > > Let's use an adapted trogdor DT with only a USB 2.x hub as an example:
> > > > > >
> > > > > > usb_1_dwc3 {
> > > > > >          dr_mode = "host";
> > > > > >          #address-cells = <1>;
> > > > > >          #size-cells = <0>;
> > > > > >
> > > > > >          /* 2.x hub on port 1 */
> > > > > >          usb_hub_2_x: hub@1 {
> > > > > >                  compatible = "usbbda,5411";
> > > > > >                  reg = <1>;
> > > > > >                  vdd-supply = <&pp3300_hub>;
> > > > > >          };
> > > > > > };
> > > > > >
> > > > > > 1st call: the 'parent_hub' corresponds to the USB 3.x root hub of
> > > > > > usb_1_dwc3, the DT node of the hub is 'usb_1_dwc3'. The function
> > > > > > iterates over the ports, finds usb_hub_2_x, enters the else branch
> > > > > > (no companion hub), checks that the function was called on behalf
> > > > > > of the primary controller and creates the pdev.
> > > > > >
> > > > > > 2nd call: the 'parent_hub' corresponds to the USB 2.x root hub of
> > > > > > usb_1_dwc3, the DT node of the hub is also 'usb_1_dwc3'. The function
> > > > > > iterates over the ports, finds usb_hub_2_x, enters the else branch
> > > > > > (no companion hub), sees that it is not called on behalf of the
> > > > > > primary controller and does not create a second (unnecessary) pdev.
> > > > > >
> > > > > > Is it clearer now?
> > > > >
> > > > > Ah, I get it now! Sorry for being so dense...
> > > >
> > > > No worries, it's certainly not obvious and probably my commentary could
> > > > have been clearer.
> > > >
> > > > > So like this:
> > > > >
> > > > > Root hubs (those hubs with no parent) are all created with the same
> > > > > device_node, the one for the controller itself. We don't want to
> > > > > iterate through the same children multiple times, so we bail right
> > > > > away if we're detect that `parent_hub` is a root hub and we're not on
> > > > > the primary HCD.
> > > >
> > > > yep
> > > >
> > > > > For all other cases the primary and secondary controllers have distinct
> > > > > device_nodes.
> > > >
> > > > You probably mean that all non-root hubs have distinct nodes, so for these
> > > > the function is only called once.
> > > >
> > > > > I guess in theory that test could go before the "companion-hub" test,
> > > > > though I don't see any case where it truly matters...
> > > >
> > > > Yeah, I'm still wondering whether it would be slightly less confusing to
> > > > bail before the loop (besides saving a few cycles), it would eliminate
> > > > the conflation with the 'companion-hub' check.
> > >
> > > I'm not sure how that would work, though? You'd essentially need two loops then?
> >
> > Maybe I got myself confused, but I think the behavior would be the same as
> > now, without a second loop:
> >
> > We never create a pdev if the parent is a root hub and the controller is the
> > secondary. Even for a hub with companion the pdev is only created when the call
> > comes from the primary controller.
> >
> > Does that make sense?
> 
> Yes, looking at it with fresh eyes I think you're right.
> 
> Looking at the "companion-hub" case with fresh eyes, too, I wonder if
> that can be simpler. If we find a companion hub, do we need both the
> check for usb_hcd_is_primary_hcd() and the check to see whether the
> pdev was already created?

I was also doubting about this and concluded that it is still needed.

Let's use once more the trogdor config as example, which has one physical
onboard hub chip with a USB 3.1 hub and a USB 2.1 companion hub, connected
to the dwc3 controller:

&usb_1_dwc3 {
	dr_mode = "host";
	#address-cells = <1>;
	#size-cells = <0>;

	/* 2.x hub on port 1 */
	usb_hub_2_x: hub@1 {
		compatible = "usbbda,5411";
		reg = <1>;
		vdd-supply = <&pp3300_hub>;
		companion-hub = <&usb_hub_3_x>;
	};

	/* 3.x hub on port 2 */
	usb_hub_3_x: hub@2 {
		compatible = "usbbda,411";
		reg = <2>;
		vdd-supply = <&pp3300_hub>;
		companion-hub = <&usb_hub_2_x>;
	};
};

Let's assume we don't check for the pdev. With our change above for root hubs
the loop is now only executed for the primary HCD. In the first iteration
we encounter the 2.x hub, it has a companion hub, but that alone doesn't
tell us much, so we create a pdev. In the next iteration we encouter the
3.x hub, it also has a companion hub, but we don't know/check that the
companion already has a pdev, so we create another one for the same
physical hub.
