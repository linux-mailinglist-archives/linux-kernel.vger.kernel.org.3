Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F694ADECE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383613AbiBHRAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiBHRAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:00:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 402F6C061576;
        Tue,  8 Feb 2022 09:00:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36B411FB;
        Tue,  8 Feb 2022 09:00:33 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792533F70D;
        Tue,  8 Feb 2022 09:00:31 -0800 (PST)
Date:   Tue, 8 Feb 2022 17:00:21 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, igor.skalkin@opensynergy.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: firmware: arm,scmi: Add
 atomic_threshold optional property
Message-ID: <20220208170021.GE2535@e120937-lin>
References: <20220208154452.39428-1-cristian.marussi@arm.com>
 <20220208154452.39428-5-cristian.marussi@arm.com>
 <681e31c1-54d8-8a3e-ff0f-683cd5156685@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681e31c1-54d8-8a3e-ff0f-683cd5156685@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 08:12:39AM -0800, Florian Fainelli wrote:
> 
> 
> On 2/8/2022 7:44 AM, Cristian Marussi wrote:
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

Hi Florian,

thanks for the feedback first of all.

> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> > - rephrased the property description
> > ---
> >   .../devicetree/bindings/firmware/arm,scmi.yaml        | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index eae15df36eef..646bdf2873b5 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -81,6 +81,15 @@ properties:
> >     '#size-cells':
> >       const: 0
> > +  atomic_threshold:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      An optional time value, expressed in microseconds, representing, on this
> > +      platform, the threshold above which any SCMI command, advertised to have
> > +      an higher-than-threshold execution latency, should not be considered for
> > +      atomic mode of operation, even if requested.
> > +      If left unconfigured defaults to zero.
> 
> Underscores in properties is not usually something that is desired, and it
> might be a good idea to put the unit in the property name, how about:
> atomic-threshold-us?
> 

I was indeed in doubt if it was desirable or not to have the units
embedded in the name ... thanks for the hint about the underscores too,

I'll fix nextV following your advice.

Thanks,
Cristian
