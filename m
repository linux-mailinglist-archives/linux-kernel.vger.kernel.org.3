Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC8568F00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiGFQXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGFQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:23:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507831D0D5;
        Wed,  6 Jul 2022 09:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 042D4B81ADB;
        Wed,  6 Jul 2022 16:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B9CC3411C;
        Wed,  6 Jul 2022 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657124618;
        bh=E94CHoe4nJY8KaW5wk7Skqvv5P2Zf38aYdSKiyagHDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOyZD6X+mJZZAfd982nC3hM4EB71f6D3hD5QE5OXiAoCuBgb7nS+zDyCB/sWZgqda
         MMGW6dJi9kHb/dB+3UXiSyW1dsWnzh42NIxyqxj7g3N4i9GjiC+F9R1Y/bixvs5F1b
         6Un822/c6bbMg6wBtKyr13pjFFFFJuTnLvxIALTG+tiNh//43cq3wbb9uDA2/gytOb
         63OgU72JIeJumm0pCRw9NyjGsCepgvsjkjgH6IXHSCq0YGnoEQ8BZ3DnvcvllkYHut
         MHnsEhv32nUJMZR3z5iBKtWfRYB94ttiPmSAeXQjehBJG7Ac7TrkrwcDlfBplJjJAS
         OjALc7l3wKnLg==
Received: by pali.im (Postfix)
        id 89B9A7BA; Wed,  6 Jul 2022 18:23:35 +0200 (CEST)
Date:   Wed, 6 Jul 2022 18:23:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add value
 property
Message-ID: <20220706162335.2eewgf7l3xghdjtr@pali>
References: <20220706112828.27278-1-pali@kernel.org>
 <20220706162111.GA145516-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706162111.GA145516-robh@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2022 10:21:11 Rob Herring wrote:
> On Wed, Jul 06, 2022 at 01:28:27PM +0200, Pali Rohár wrote:
> > Allow to define inverted logic (0 - enable LED, 1 - disable LED) via value
> > property. This property name is already used by other syscon drivers, e.g.
> > syscon-reboot.
> 
> Yes, but those are potentially multi-bit values. This is a single bit 
> value, and the only value that's ever needed is 0. Why not just use 
> 'active-low' here?

Just because to have uniform definitions across more syscon nodes.

> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../devicetree/bindings/leds/register-bit-led.yaml    | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.yaml b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> > index 79b8fc0f9d23..d6054a3f9087 100644
> > --- a/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> > +++ b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> > @@ -43,6 +43,17 @@ properties:
> >          0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
> >          0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]
> >  
> > +  value:
> > +    description:
> > +      bit value of ON state for the bit controlling this LED in the register
> > +      when not specified it is same as the mask
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum:
> > +      [ 0x0, 0x1, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80, 0x100, 0x200, 0x400, 0x800,
> > +        0x1000, 0x2000, 0x4000, 0x8000, 0x10000, 0x20000, 0x40000, 0x80000,
> > +        0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000,
> > +        0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000 ]
> > +
> >    offset:
> >      description:
> >        register offset to the register controlling this LED
> > -- 
> > 2.20.1
> > 
> > 
