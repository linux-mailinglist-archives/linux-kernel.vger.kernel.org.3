Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C675605AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiF2QVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiF2QVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:21:16 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB37A34BB9;
        Wed, 29 Jun 2022 09:21:15 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 25TGD56V017150;
        Wed, 29 Jun 2022 11:13:05 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 25TGD3U2017144;
        Wed, 29 Jun 2022 11:13:03 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 29 Jun 2022 11:13:03 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ash Logan <ash@heyquark.com>, krzysztof.kozlowski+dt@linaro.org,
        paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org,
        devicetree@vger.kernel.org, linkmauve@linkmauve.fr,
        linux-kernel@vger.kernel.org, rw-r-r-0644@protonmail.com,
        joel@jms.id.au, linuxppc-dev@lists.ozlabs.org, j.ne@posteo.net
Subject: Re: [PATCH v3 02/12] powerpc: wiiu: device tree
Message-ID: <20220629161302.GG25951@gate.crashing.org>
References: <20220622131037.57604-1-ash@heyquark.com> <20220628133144.142185-1-ash@heyquark.com> <20220628133144.142185-3-ash@heyquark.com> <c760e444-57c3-0e1a-0e4d-f79d6ae9867a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c760e444-57c3-0e1a-0e4d-f79d6ae9867a@linaro.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 11:58:18AM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2022 15:31, Ash Logan wrote:
> > +	model = "nintendo,wiiu";
> 
> It's not compatible, but user-visible string, e.g. "Nintendo Wii U"

The "model" property in OF is documented as:

---
“model”                                                                S
Standard property name to define a manufacturer’s model number.

prop-encoded-array:
  Text string, encoded with encode-string.
A manufacturer-dependent string that generally specifies the model name
and number (including revision level) for this device. The format of the
text string is arbitrary, although in conventional usage the string
begins with the name of the device’s manufacturer as with the “name”
property.
Although there is no standard interpretation for the value of the
“model” property, a specific device driver might use it to learn, for
instance, the revision level of its particular device.

See also: property, model.

Used as: " XYZCO,1416-02" encode-string " model" property
---

> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		/* TODO: Add SMP */
> > +		PowerPC,espresso@0 {
> 
> Node name should be generic, so "cpu". Unless something needs the
> specific node name?

This is how most other PowerPC firmwares do it.  The PowerPC processor
binding is older than the generic naming practice, so CPU nodes have
device_type "cpu" instead.  This is a required property btw, with that
value.  (There is no requirement on the names of the CPU nodes).

There is no added value in generic naming for CPU nodes anyway, since
you just find them as the children of the "/cpus" node :-)


Segher
