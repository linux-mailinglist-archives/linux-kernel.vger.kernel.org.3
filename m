Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6147A54EE83
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 02:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379440AbiFQAgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 20:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiFQAgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:36:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4C53C59
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:36:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso2851562pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KLXwwaez+w1CBq2L3RdXisE4PbvCnwjz3NistiIESxw=;
        b=b7HhvtORwCIAMgUHPSO07xPy9BsWtqJXn+2BVo8Zu5ZJrukA8dUOGbPmKDrw5kMHcx
         sgATkFTLs/wwF/4w2HPuZm+bVKEcXFb2mDCDLj5eLlvNPBLCXfP/b5PHle3q7mgYjDrW
         cVtcE5S1aGPNm+bQmf1OrF27z49UhlAV4eF0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLXwwaez+w1CBq2L3RdXisE4PbvCnwjz3NistiIESxw=;
        b=e7dMoO8US2tim4EbWYAl2t8HWYxuv3VUlb4SOPe1LELmKdUmlIrVXuTsalKaIMVdoF
         vHBsl/GBtk9R8jgIjEncKoOXzkiE/LXJp8UyMqyjdQ2dQ8BML6j3T83fwLefAlWjwdVD
         bHqnSxzsLWV8Ne0ZQv6h8EFNDGRBgY0zYS879ge+o084RZ1Z2QwwC5Rvnq1qLLGM/Crx
         fKzpD3xeqaVrAoAXi7OLUrubd5sMlTdP+SZAOnGJEzTi0zG7kBLUZXvJ7dKanVjTegzR
         oaIJysdu+yZmL3t6Y9kxdHS3iGo/RVCWREOzx7TJXM1fsJcMBGjz87nrq4Ivpht8EGZm
         9SWw==
X-Gm-Message-State: AJIora+JRF/0tm6Hyrfym2C5e8HuRf0zO6sm13kxnuP850WHGNz4hjKM
        dmIFJBlOuvP9u/pngI3g9S5oww==
X-Google-Smtp-Source: AGRyM1s7tf4v/toOUUNI5FljFpHp1LWzRnHlifkrkr+jYvaMeJMyAwsQLEvEV8CMX+R6hmNCCK2OpQ==
X-Received: by 2002:a17:903:244a:b0:167:74f3:7463 with SMTP id l10-20020a170903244a00b0016774f37463mr7103839pls.44.1655426175854;
        Thu, 16 Jun 2022 17:36:15 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4ef5:7e3b:63ba:fc4])
        by smtp.gmail.com with UTF8SMTPSA id y11-20020a170902d64b00b00161955fe0d5sm2176252plh.274.2022.06.16.17.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 17:36:15 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:36:13 -0700
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
Message-ID: <YqvMffveCPiKQEUk@google.com>
References: <20220609192000.990763-1-mka@chromium.org>
 <20220609121838.v22.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAD=FV=W6erE8ByabmYSL_OWJPKYGqysDMGYQX6j7_PSEYGZ4YQ@mail.gmail.com>
 <YqpprpUHmlD62YzI@google.com>
 <CAD=FV=VNDamV4+j07TrnX3cUs2-D5ySbeQ-zfU=Eef8+WagGig@mail.gmail.com>
 <Yqub17iT4O7aqFMi@google.com>
 <CAD=FV=VEztPLhsrJecZUdyHCW7ZfFTVvxyqY5CqRVv2mWyrLog@mail.gmail.com>
 <YquoSMiQS+RG8rOM@google.com>
 <CAD=FV=W81pSEUbzw2ZQgs_TJ9MLnHQHiDopZXZ6bHdS7QMzAyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=W81pSEUbzw2ZQgs_TJ9MLnHQHiDopZXZ6bHdS7QMzAyA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 03:46:15PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 16, 2022 at 3:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Thu, Jun 16, 2022 at 02:28:38PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Jun 16, 2022 at 2:08 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > >
> > > > On Thu, Jun 16, 2022 at 01:12:32PM -0700, Doug Anderson wrote:
> > > > > Hi,
> > > > >
> > > > > On Wed, Jun 15, 2022 at 4:22 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > >
> > > > > > > > +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> > > > > > > > +{
> > > > > > > > +       int i;
> > > > > > > > +       struct usb_hcd *hcd = bus_to_hcd(parent_hub->bus);
> > > > > > > > +       struct device_node *np, *npc;
> > > > > > > > +       struct platform_device *pdev = NULL;
> > > > > > > > +       struct pdev_list_entry *pdle;
> > > > > > > > +
> > > > > > > > +       if (!parent_hub->dev.of_node)
> > > > > > > > +               return;
> > > > > > > > +
> > > > > > > > +       for (i = 1; i <= parent_hub->maxchild; i++) {
> > > > > > > > +               np = usb_of_get_device_node(parent_hub, i);
> > > > > > > > +               if (!np)
> > > > > > > > +                       continue;
> > > > > > > > +
> > > > > > > > +               if (!of_is_onboard_usb_hub(np))
> > > > > > > > +                       goto node_put;
> > > > > > > > +
> > > > > > > > +               npc = of_parse_phandle(np, "companion-hub", 0);
> > > > > > > > +               if (npc) {
> > > > > > > > +                       /*
> > > > > > > > +                        * Hubs with companions share the same platform device.
> > > > > > > > +                        * Create the plaform device only for the hub that is
> > > > > > > > +                        * connected to the primary HCD (directly or through
> > > > > > > > +                        * other hubs).
> > > > > > > > +                        */
> > > > > > > > +                       if (!usb_hcd_is_primary_hcd(hcd)) {
> > > > > > > > +                               of_node_put(npc);
> > > > > > > > +                               goto node_put;
> > > > > > > > +                       }
> > > > > > > > +
> > > > > > > > +                       pdev = of_find_device_by_node(npc);
> > > > > > > > +                       of_node_put(npc);
> > > > > > > > +               } else {
> > > > > > > > +                       /*
> > > > > > > > +                        * For root hubs this function can be called multiple times
> > > > > > > > +                        * for the same root hub node (the HCD node). Make sure only
> > > > > > > > +                        * one platform device is created for this hub.
> > > > > > > > +                        */
> > > > > > > > +                       if (!parent_hub->parent && !usb_hcd_is_primary_hcd(hcd))
> > > > > > > > +                               goto node_put;
> > > > > > >
> > > > > > > I don't understand the "else" case above. What case exactly are we
> > > > > > > handling again? This is when:
> > > > > > > * the hub is presumably just a 2.0 hub since there is no companion.
> > > > > > > * our parent is the root hub and the USB 2.0 hub we're looking at is
> > > > > > > not the primary
> > > > > >
> > > > > > The 'else' case can be entered for hubs connected to a root hub or to another
> > > > > > hub further down in the tree, but we bail out only for first level hubs.
> > > > > >
> > > > > > > ...but that doesn't make a lot of sense to me? I must have missed something...
> > > > > >
> > > > > > It's not super-obvious, this bit is important: "this function can be called
> > > > > > multiple times for the same root hub node". For any first level hub we only
> > > > > > create a pdev if this function is called on behalf of the primary HCD. That
> > > > > > is also true of a hub connected to the secondary HCD. We only want to create
> > > > > > one pdev and there is supposedly always a primary HCD.
> > > > > >
> > > > > > Maybe it would be slightly clearer if the function returned before the loop
> > > > > > if this condition is met.
> > > > >
> > > > > I guess I'm still pretty confused. You say "For root hubs this
> > > > > function can be called multiple times for the same root hub node".
> > > > > Does that mean that the function will be called multiple times with
> > > > > the same "parent_hub", or something else.
> > > >
> > > > It is called with a different "parent_hub", however for root hubs the
> > > > DT node is the same for both root hubs (it's the DT node of the
> > > > controller since there are no dedicated nodes for the root hubs).
> > > >
> > > > Just to make sure this isn't the source of the confusion: the root hubs
> > > > are part of the USB controller, not 'external' hubs which are directly
> > > > connected to the controller. I call the latter 'first level hubs'.
> > > >
> > > > > Unless it's called with the same "parent_hub" then it seems like if
> > > > > the USB device has a device tree node and that device tree node is for
> > > > > a onboard_usb_hub and there's no companion node then we _always_ want
> > > > > to create the platform device, don't we? If it is called with the same
> > > > > "parent_hub" then I'm confused how your test does something different
> > > > > the first time the function is called vs. the 2nd.
> > > >
> > > > Let's use an adapted trogdor DT with only a USB 2.x hub as an example:
> > > >
> > > > usb_1_dwc3 {
> > > >          dr_mode = "host";
> > > >          #address-cells = <1>;
> > > >          #size-cells = <0>;
> > > >
> > > >          /* 2.x hub on port 1 */
> > > >          usb_hub_2_x: hub@1 {
> > > >                  compatible = "usbbda,5411";
> > > >                  reg = <1>;
> > > >                  vdd-supply = <&pp3300_hub>;
> > > >          };
> > > > };
> > > >
> > > > 1st call: the 'parent_hub' corresponds to the USB 3.x root hub of
> > > > usb_1_dwc3, the DT node of the hub is 'usb_1_dwc3'. The function
> > > > iterates over the ports, finds usb_hub_2_x, enters the else branch
> > > > (no companion hub), checks that the function was called on behalf
> > > > of the primary controller and creates the pdev.
> > > >
> > > > 2nd call: the 'parent_hub' corresponds to the USB 2.x root hub of
> > > > usb_1_dwc3, the DT node of the hub is also 'usb_1_dwc3'. The function
> > > > iterates over the ports, finds usb_hub_2_x, enters the else branch
> > > > (no companion hub), sees that it is not called on behalf of the
> > > > primary controller and does not create a second (unnecessary) pdev.
> > > >
> > > > Is it clearer now?
> > >
> > > Ah, I get it now! Sorry for being so dense...
> >
> > No worries, it's certainly not obvious and probably my commentary could
> > have been clearer.
> >
> > > So like this:
> > >
> > > Root hubs (those hubs with no parent) are all created with the same
> > > device_node, the one for the controller itself. We don't want to
> > > iterate through the same children multiple times, so we bail right
> > > away if we're detect that `parent_hub` is a root hub and we're not on
> > > the primary HCD.
> >
> > yep
> >
> > > For all other cases the primary and secondary controllers have distinct
> > > device_nodes.
> >
> > You probably mean that all non-root hubs have distinct nodes, so for these
> > the function is only called once.
> >
> > > I guess in theory that test could go before the "companion-hub" test,
> > > though I don't see any case where it truly matters...
> >
> > Yeah, I'm still wondering whether it would be slightly less confusing to
> > bail before the loop (besides saving a few cycles), it would eliminate
> > the conflation with the 'companion-hub' check.
> 
> I'm not sure how that would work, though? You'd essentially need two loops then?

Maybe I got myself confused, but I think the behavior would be the same as
now, without a second loop:

We never create a pdev if the parent is a root hub and the controller is the
secondary. Even for a hub with companion the pdev is only created when the call
comes from the primary controller.

Does that make sense?

