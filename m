Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5813F48A135
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiAJUzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343664AbiAJUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:55:41 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E3EC061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:55:40 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:f8d5:1373:c8a9:137f] (unknown [IPv6:2a02:a03f:eafe:c901:f8d5:1373:c8a9:137f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id A1D7528F802;
        Mon, 10 Jan 2022 21:55:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1641848138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05Wm7IsW2OK3i/K0GGEWXtV4uuj8mj2saAgcwkb9NBQ=;
        b=zhQZPz3WCwxpQpnkYmZGHzG/K/uxkqwZ/Ruyi5CttLubi7TCzuE93BBuaZ3IzyCjnu5Kuy
        yTxrMR5tjhuCW1VCUBxbBC2QfVOMoyBwirIBiIQd6nsu286bzY4qJBKYBgWLzYQQKx6XNW
        inZdxWC/RiwerU0PZ3x5vn/CP6sCQUzqaI/YSKjqmxA+W5W05OphUBMpp9CbeeC4LuhUw3
        W5QUf7Gf6OEhto8gyx5UYlZjcKj7GbtaACawsWpGeg7McH3/792+RiyXxoZpQ40VkJZyC6
        cKW35hyy599QHiu4WC4dedOKBzNtB6iqbifgArP4murCyCyKi0P5gsg4rKqiUw==
Message-ID: <41a6c9cde0351cefaa6b060b7f7ccf5484d4e00b.camel@svanheule.net>
Subject: Re: [RFC PATCH v1 2/3] dt-bindings: power: reset: gpio-restart: Add
 -ms suffix to delays
From:   Sander Vanheule <sander@svanheule.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 10 Jan 2022 21:55:36 +0100
In-Reply-To: <YdyZSu4eoYuKQvx1@robh.at.kernel.org>
References: <cover.1640887456.git.sander@svanheule.net>
         <35e4da34fb7e18ea7e3af2405db4c5a2a7ba2dfe.1640887456.git.sander@svanheule.net>
         <YdyZSu4eoYuKQvx1@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 2022-01-10 at 14:38 -0600, Rob Herring wrote:
> On Thu, Dec 30, 2021 at 07:06:02PM +0100, Sander Vanheule wrote:
> > The delay properties are expressed in milliseconds, so the property
> > names should have a -ms suffix. Add the suffix, and deprecate the
> > original properties.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> >  .../bindings/power/reset/gpio-restart.yaml    | 27 ++++++++++++-------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > index 6a1f4aeebf49..13827fe7b395 100644
> > --- a/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> > @@ -62,17 +62,26 @@ properties:
> >              restart handlers
> >  
> >    active-delay:
> > -    $ref: /schemas/types.yaml#/definitions/uint32
> > -    description: Delay (default 100) to wait after driving gpio active [ms]
> > +    $ref: '#/properties/active-delay-ms'
> 
> While 'active-delay-ms' has a type because '.*-ms' has a type, you just 
> removed the type for this property. Now 'active-delay = "foo"' is valid.

Good to know, I would've expected the type to be inherited.

> While it would be nice to change this, we're pretty much stuck with it 
> forever. I don't think supporting both versions in the kernel is worth 
> it.

Figured as much. I'll just keep patch 3/3 then.

Thanks for the feedback!

Best,
Sander

