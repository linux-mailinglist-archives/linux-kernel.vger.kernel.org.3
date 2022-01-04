Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84921484B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiADXor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:44:47 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55469 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiADXoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:44:46 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 021401C0006;
        Tue,  4 Jan 2022 23:44:44 +0000 (UTC)
Date:   Wed, 5 Jan 2022 00:44:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     Srinivas Neeli <sneeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Michal Simek <michals@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: rtc: zynqmp: Add clock information
Message-ID: <YdTb7IixX6JsUtJ4@piout.net>
References: <20211130055541.2789-1-srinivas.neeli@xilinx.com>
 <SA1PR02MB8560D9A6A6C90DC1A90A2364C7679@SA1PR02MB8560.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR02MB8560D9A6A6C90DC1A90A2364C7679@SA1PR02MB8560.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srinivas,

On 30/11/2021 06:37:45+0000, Radhey Shyam Pandey wrote:
> > -----Original Message-----
> > From: Srinivas Neeli <srinivas.neeli@xilinx.com>
> > Sent: Tuesday, November 30, 2021 11:26 AM
> > To: a.zummo@towertech.it; alexandre.belloni@bootlin.com; Michal Simek
> > <michals@xilinx.com>; Srinivas Goud <sgoud@xilinx.com>; Shubhrajyoti Datta
> > <shubhraj@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>
> > Cc: linux-rtc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git <git@xilinx.com>; Srinivas Neeli
> > <sneeli@xilinx.com>
> > Subject: [PATCH V3 1/2] dt-bindings: rtc: zynqmp: Add clock information
> > 
> > Added clock information and deprecated calibration support.
> 
> Better to also add some background for this change.
> > 
> > Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> 
> Please add Rob and DT mailing list.
> 

I'm indeed waiting on Rob's review...

> ./scripts/get_maintainer.pl <.patch>
> > ---
> > Changes in V3:
> > -New patch
> > ---
> >  .../bindings/rtc/xlnx,zynqmp-rtc.yaml         | 20 +++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> > b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> > index bdb72d3ddf2a..7e87bc1ef9df 100644
> > --- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> > @@ -26,20 +26,19 @@ properties:
> >    interrupts:
> >      minItems: 2
> > 
> > +  clocks:
> > +    items:
> > +      - description: rtc_clk is the operating frequency of crystal.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: "rtc_clk"
> > +
> >    interrupt-names:
> >      items:
> >        - const: alarm
> >        - const: sec
> > 
> > -  calibration:
> 
> What about existing users for this property?
> > -    description: |
> > -      calibration value for 1 sec period which will
> > -      be programmed directly to calibration register.
> > -    $ref: /schemas/types.yaml#/definitions/uint32
> > -    minimum: 0x1
> > -    maximum: 0x1FFFFF
> > -    default: 0x198233
> > -

I think this needs to stay to mark it as deprecated.

> >  required:
> >    - compatible
> >    - reg
> > @@ -60,6 +59,7 @@ examples:
> >          interrupt-parent = <&gic>;
> >          interrupts = <0 26 4>, <0 27 4>;
> >          interrupt-names = "alarm", "sec";
> > -        calibration = <0x198233>;
> > +        clock-names = "rtc_clk";
> > +        clocks = <&rtc_clk>;
> >        };
> >      };
> > --
> > 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
