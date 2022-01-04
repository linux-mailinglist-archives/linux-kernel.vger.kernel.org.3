Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF348439A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiADOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:43:19 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:37384 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiADOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:43:18 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA234501;
        Tue,  4 Jan 2022 15:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641307397;
        bh=J4Sk2W4435+FogcfPZvxBbjYrs/GiL+STwPqFqgYhRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJB57SwVYL3Hdv/KYxLfgCyZIPaormnZwkIVWljBybcCOd4SnRwN22sPwqG9/Amuf
         DPJ9ybZF6nWmfLMoBA5RFcbiZryrf7mH+40dAmSQ2NpyYe/dohArkJq/gwh0xQmCH7
         Wx/ADk8Et9Hivq351JB7ERHYtgbI9PHoX6PQRu9Y=
Date:   Tue, 4 Jan 2022 16:43:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulators: Add bindings for Maxim
 MAX20086-MAX20089
Message-ID: <YdRdAI4S0+85CuDy@pendragon.ideasonboard.com>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-2-laurent.pinchart+renesas@ideasonboard.com>
 <YdRZJWbOxkgkVgje@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdRZJWbOxkgkVgje@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for the review.

On Tue, Jan 04, 2022 at 02:26:45PM +0000, Mark Brown wrote:
> On Sun, Jan 02, 2022 at 11:11:23PM +0200, Laurent Pinchart wrote:
> 
> > +    patternProperties:
> > +      "^OUT[1-4]$":
> > +        type: object
> > +        $ref: regulator.yaml#
> > +
> > +    required:
> > +      - OUT1
> > +      - OUT2
> 
> Why are we requiring that there be machine constraints for the
> individual regulators?  There's already a problem with people just
> using the maximum possible control a regulator has as the default for
> devices without regard to what the specific system can support.

Could you elaborate a bit, keeping in mind that I'm a newbie when it
comes to the regulator framework ? :-)

The MAX2008[6789] can't control the voltage or current. The outputs can
be enabled or disabled individually, but their voltage is fixed to the
input voltage. There's overcurrent protection, with a threshold set by a
resistor and not known to the driver. The voltage (and current I
believe) can be measured, and alarms can be raised through an interrupt.

How should I modify the DT bindings to match that correctly ?

-- 
Regards,

Laurent Pinchart
