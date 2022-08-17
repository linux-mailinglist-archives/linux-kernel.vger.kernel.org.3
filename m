Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB065979DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbiHQXAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiHQXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:00:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46235AB07D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:00:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c20so270qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KmcDPCTn5Uzlzd24cj71xEvkhoV/UHar1ZZ8d/hlYtw=;
        b=UXGJYiIfxhnj/i4hpUL58NerxcbgE4DPs09FN2Bp1xIgmF7zfmwl6sp0oBJ6i9tRXR
         apjEyQ33bUqxLV7phYZCuNREmUTAtNpbDir3oWp5HE8X4cZRcXVvHlukIAU8NUFppWP7
         k4hX9AEB7gxfRIIa+efvFdUxTzRMfMO2PyQ7G+4c4SK5SvaI6/oMKboQbIMM9cmxUIYs
         b+1gmyLLc/MuVTSTQ07PPn39NPzbQdk2Usuv64g4pcXXshP7X2TMAeS6ZMfhcTjsPV2t
         ahu5m+NtFUaiCgtN2NOTamEZIyIHhHixKdynuMDcJ5kvLS89882lYBN7hrisv1/mzsiE
         NPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KmcDPCTn5Uzlzd24cj71xEvkhoV/UHar1ZZ8d/hlYtw=;
        b=PcUSOBYh+oKD58rL+SWdwAqp0Bx1ULQpWd4OUjlKljkJUNdn9SBDoeO2B8ch7PRA34
         CXgL1o/1r1RQYtDXoObXXKiXqld00DitOCaHYH2cRnFw9fgSVvl1x+K61KgWyW2tJZHQ
         JKP+D9qev7pmhv5uEuJ0yTtRyY8N08SkOshdDfnvlzoWVORGbv9zb6jo+thpfRbNc+Pf
         8w0J8SFBRvcVBLA+Lqp6mo1bNR1cCdSxtbi0W2O+abcSeQRhIwrEbMYouNdYXpww6QRQ
         Eh0msE30eNXHNB6PX2PGJgWHu0XfB2yg8x3QK04ptGJG5/d3CHGpcDWFMrNgixDOGn8W
         bPeQ==
X-Gm-Message-State: ACgBeo0zYmqnzBAITppQ3gbKQvdQ4cc6JO21LMQLSZHg62QCZyT/JV4j
        SQvykbLFrZC7CpWxu+codfeN0A==
X-Google-Smtp-Source: AA6agR7zkcNjo5wCvzg1zEw4M2g5sH48XKxof4jlgqH5nSn6g2uQsUSOv+Ai5LsMqinWj19C6hDm+A==
X-Received: by 2002:a05:622a:447:b0:31e:ea5d:34c2 with SMTP id o7-20020a05622a044700b0031eea5d34c2mr441099qtx.604.1660777209319;
        Wed, 17 Aug 2022 16:00:09 -0700 (PDT)
Received: from baldur ([2600:380:7852:c2c2:200:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id u7-20020a37ab07000000b006b9bf03d9c6sm78625qke.104.2022.08.17.16.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:00:08 -0700 (PDT)
Date:   Wed, 17 Aug 2022 18:00:05 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <Yv1y9Wjp16CstJvK@baldur>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814210104.GA690892-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 14 Aug 16:01 CDT 2022, Rob Herring wrote:

> On Thu, Aug 11, 2022 at 12:14:48PM +0300, Krzysztof Kozlowski wrote:
> > On 10/08/2022 23:47, Bjorn Andersson wrote:
> > > Introduce a binding for GPIO-based mux hardware used for connecting,
> > > disconnecting and switching orientation of the SBU lines in USB Type-C
> > > applications.
> > > 
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 77 +++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > > new file mode 100644
> > > index 000000000000..7d8aca40c7ca
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > > @@ -0,0 +1,77 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: GPIO-based SBU mux
> > > +
> > > +maintainers:
> > > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > > +
> > > +description:
> > > +  In USB Type-C applications the SBU lines needs to be connected, disconnected
> > > +  and swapped depending on the altmode and orientation. This binding describes
> > > +  a family of hardware which perform this based on GPIO controls.
> > 
> > +Cc few folks.
> > 
> > This looks familiar to:
> > 
> > https://lore.kernel.org/linux-devicetree/eaf2fda8-0cd6-b518-10cb-4e21b5f8c909@linaro.org/T/#m39254b7f8970b3e1264f9d1a979557bb46ab162c
> > 
> > Rob and Stephen had several concerns about that approach.
> 
> My overall concern is a bunch of one-off bindings with no one thinking 
> about a variety of USB-C h/w. I need h/w diagrams and corresponding 
> bindings. The key part being more than 1. I'm not all that familiar with 
> the former to help on the bindings.
> 

This is the setup that we're dealing with:

                     +------------- - -
 USB connector       | SoC
 +-+                 |
 | |                 |   +-----+
 |*|<------- HS -----|-->| HS  |
 |*|<------- HS -----|-->| phy |<-+   +--------+
 | |                 |   +-----+   \->|        |
 | |                 |                |  dwc3  |
 | |                 |   +-----+   /->|        |
 |*|<------- SS -----|-->|     |<-+   +--------+
 |*|<------- SS -----|-->| QMP |
 |*|<------- SS -----|-->| phy |
 |*|<------- SS -----|-->|     |<-\   +------------+
 | |                 |   +-----+   \->|            |
 | |                 |                |     DP     |
 | |    +-----+      |                | controller |
 |*|<-->| SBU |<-----|--------------->|            |
 |*|<-->| mux |<-----|--------------->|            |
 | |    +----+       |                +------------+
 +-+                 |
                     +------------- - -

The dwc3 controller is connected to the HS phy for HighSpeed signals and
QMP phy to be muxed out on 0, 2 or 4 of the SuperSpeed pins (for
DP-only, USB/DP combo or USB-only mode).

The DisplayPort controller is connected to the same QMP phy, for and is
muxed onto the same 0, 2 or 4 of the SuperSpeed pins (for USB-only,
USB/DP combo or DP-only mode).

The SuperSpeed pins can be switched around within the QMP phy, to handle
the case where the USB Type-C cable is flipped around.


The AUX pins of the DP controller are connected to the SBU pins in the
connector. These signals needs to be disconnected while DP mode is not
negotiated with the remote. The DP controller does not support swapping
the two lines.
The disconnecting and swapping thereby needs to be performed by an
external entity. For which we have a few examples already, such as
fcs,fsa4480.

Lastly, in USB Power Delivery, the hot-plug signal found in a physical
DisplayPort or HDMI cable is communicated as a message. So the USB
Type-C controller must be able to pass this onto the DP controller.


I model the usb-c-connector as a child of the USB Type-C controller,
with the following representation of the connections:

connector {
  compatible = "usb-c-connector";

  ports {
    port@0 {
      reg = <0>;
      endpoint {
        remote-endpoint = <&dwc3>;
      };
    };

    port@1 {
      reg = <1>;
      endpoint@0 {
        reg = <0>;
        remote-endpoint = <&qmp_phy>;
      };
      endpoint@1 {
        reg = <1>;
        remote-endpoint = <&dp_controller>;
    };

    port@2 {
      reg = <2>;
      endpoint {
        remote-endpoint = <&sbu_mux>;
      };
    };
  };
};

This allows the USB Type-C controller to:
1) Perform USB role switching in the dwc3 on port@0
2) Orientation and muxing of the SuperSpeed lines in the QMP phy on
   port@1:0, implement a drm_bridge for signalling HPD back to the DP
   controller on port@1:1
3) Orientation and muxing (connecting/disconnecting) the SBU/AUX lines
   in the SBU mux on port@2.

The SBU mux in several of these designs is a component that takes a
power supply and two GPIOs, for enabling/disabling the connection and
flip the switch (which is used to swap the lines).

I hope this helps with the bigger picture.

Regards,
Bjorn
