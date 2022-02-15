Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71254B797B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiBOVID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:08:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244286AbiBOVIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:08:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B5152FFDE;
        Tue, 15 Feb 2022 13:07:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC8D1480;
        Tue, 15 Feb 2022 13:07:51 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D5C33F70D;
        Tue, 15 Feb 2022 13:07:50 -0800 (PST)
Date:   Tue, 15 Feb 2022 21:07:44 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: firmware: arm,scmi: Add
 atomic-threshold-us optional property
Message-ID: <20220215210726.GB21915@e120937-lin>
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-5-cristian.marussi@arm.com>
 <YgwVOMyjHrToGUR4@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgwVOMyjHrToGUR4@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 03:03:52PM -0600, Rob Herring wrote:
> On Sun, Feb 13, 2022 at 07:58:28PM +0000, Cristian Marussi wrote:
> > SCMI protocols in the platform can optionally signal to the OSPM agent
> > the expected execution latency for a specific resource/operation pair.
> > 
> > Introduce an SCMI system wide optional property to describe a global time
> > threshold which can be configured on a per-platform base to determine the
> > opportunity, or not, for an SCMI command advertised to have a higher
> > latency than the threshold, to be considered for atomic operations:
> > high-latency SCMI synchronous commands should be preferably issued in the
> > usual non-atomic mode.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v3 --> v4
> > - renamed property to atomic-threshold-us
> > v1 --> v2
> > - rephrased the property description
> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index eae15df36eef..3ffa669b91af 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -81,6 +81,15 @@ properties:
> >    '#size-cells':
> >      const: 0
> >  
> > +  atomic-threshold-us:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      An optional time value, expressed in microseconds, representing, on this
> > +      platform, the threshold above which any SCMI command, advertised to have
> > +      an higher-than-threshold execution latency, should not be considered for
> > +      atomic mode of operation, even if requested.
> 
> > +      If left unconfigured defaults to zero.
> 
> This can be expressed as 'default: 0'.
> 

Thanks, I'll fix next V5 together with the warnings/errors fixes exposed
by your DT check bot (I had an obsoleted dtschema package indeed...)

Possibly tomorrow I'll send a v5.

Thanks,
Cristian

