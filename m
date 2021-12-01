Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF54645FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbhLAEgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:36:13 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35140 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhLAEgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:36:12 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B14WeWP115419;
        Tue, 30 Nov 2021 22:32:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638333160;
        bh=rZPqJytt32wU6cmUQOi71craqET7VqU3GbUSl7qQQyA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YJKaB21+Jcr+EUnnOKEwM2H59V3+3uiPme/eAIy1El3FEObw1WYl4flXBp7g/T7Mb
         KhzuJXA3YAfqyL+fRaSuTU+XPVb1aijRBVuCxsY3D1MF9U0ydscrhKTdFet14OTXf7
         ZXcO4Qhl6bDI2WHdOkSpfn3L9pVggi8p74FLoqEE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B14WeML087916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 22:32:40 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 22:32:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 22:32:39 -0600
Received: from [10.250.232.185] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B14WbKE119719;
        Tue, 30 Nov 2021 22:32:37 -0600
Subject: Re: [PATCH 1/2] dt-bindings: mux: Document mux-states property
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com>
 <20211130121847.11112-2-a-govindraju@ti.com>
 <YaaGMtE6n0yZNpAI@robh.at.kernel.org>
 <6e1474bc-038c-43ec-4814-63ad3eca888c@axentia.se>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <247912b5-e68a-1e97-60c7-0ba21448d3b4@ti.com>
Date:   Wed, 1 Dec 2021 10:02:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6e1474bc-038c-43ec-4814-63ad3eca888c@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 01/12/21 2:18 am, Peter Rosin wrote:
> 
> 
> On 2021-11-30 21:14, Rob Herring wrote:
>> On Tue, Nov 30, 2021 at 05:48:46PM +0530, Aswath Govindraju wrote:
>>> In some cases, it is required to provide the state to which the mux
>>> controller has be set to, from the consumer device tree node. Document the
>>> property mux-states that can be used for adding this support.
>>
>> I having a hard time understanding why you need this. One consumer 
>> configures a mux one way and another consumer another way? How do you 
>> arbitrate that? Please elaborate on what 'some cases' are and why it's 
>> required.
>>
>> Can't you just add a cell for the 'state' allowing for 1-2 cells 
>> instead of 0-1?
> 
> A mux controller can control several muxes. That happens e.g. when the
> same gpio lines are connected to several mux chips in parallel. When
> you operate one mux, the other parallel muxes just follow along. If
> these muxes are then used orthogonally, coordination is needed. The real
> world case I had was I2C and an analog signal connected to an ADC that
> went through parallel/dependent muxes like this. It is simply not
> possible to freely mux the I2C bus and the analog signal, they are tied
> together and dependent and must coordinate their accesses.
> 
> The addition now is that Aswath wants a mux control client to "point
> at" a single state instead of the whole mux control, and I see that as
> a usable addition. It seems like a natural place to specify a single mux
> state that some driver needs in some circumstance.
> 
> But, since a mux control is inherently a shared resource (see above),
> one consumer might need a specific state and some other consumer might
> need the whole mux control and manage the states as e.g. the existing
> i2c-mux-gpmux binding is doing. So, you need to be able to specify both
> ways to point at muxes; either to a single mux state, or to the whole mux
> control.
> 
> While you could make the extra cell optional, that does not work for
> the mux/adi,adg792a binding, since it is using the #mux-control-cells
> property to determine which mode it should operate its three muxes in.
> Either with one common/parallel mux control, or with three independent
> mux controls.
> 
> So, that binding is already in the 0-1 territory, and adding an optional
> extra cell makes it 0-1-2 with no way to determine what is intended when
> the cell count is 1 (three independent mux controls OR one mux control
> and a state). I see no way to add the extra state to that binding, short
> of adding an extra property somewhere for that driver, but I simply did
> not want to go that path because it would get inconsistent when trying
> to add that in a backwards compatible way. Or rather, that was my
> conclusion.
> 
> Suggestions welcome...
> 


In addition to what Peter has mentioned, I would like to elaborate on my
use case for adding this feature. I am trying to implement this feature
in the TCAN104x transceiver driver, for selecting the mux state to route
the signals from CAN controller to transceivers on the board. The state
of the mux line to be set, can change based on the design and this is
needs to be provided from the device tree. Hence, I am trying to add
this support for providing the state to be set to the driver from the
device tree node.


Also, one more question on regarding DT check errors, may I know what
should be the order in which the patches need to be posted in order to
not get the error? This is because mux-states would be a new property to
be added in the TCAN104x bindings and I thought that it would need to be
posted after the patch for the changes in mux-controller are merged.

Thanks,
Aswath

> Cheers,
> Peter
> 

