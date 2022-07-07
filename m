Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CF56A59C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiGGOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiGGOi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D42A7;
        Thu,  7 Jul 2022 07:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94DFE62298;
        Thu,  7 Jul 2022 14:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592CCC3411E;
        Thu,  7 Jul 2022 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657204704;
        bh=i8fYnZIejHVPksn/Brc81DmBtAz/Ur4g3vOWTh81cjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eyEwpAkvrTU+wzW1NXSGwQfQzygom3hnvbD0INgFt+4QU/nOtpLdy3vRNoi+rtRVk
         4yv9LCwSaOEiZ8vi0/TASYt5Y+APJnI3+aQXe2X/N99S2/TSnFKU8634D8c6FJoYPO
         pHqjiXC1M+Zct0yvUPiqFqCfiiZCEK5/mRsMzmuhJM31G8OqElZsDyUMcZA7iMbKqU
         JBf3v2KZmlNfSJLuhnDCeGa9q89I8u6MChy47DluEfAeJfzq7Q2LVYGCbrtGRRx0V7
         tZxc4LWz37BTJbYknTHY4fE3p5XSkZSXVJdpJP9CDKIer/A/7CcblzcaTTKGmLURNg
         f3KvoG6bG9x/g==
Date:   Thu, 7 Jul 2022 16:38:18 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] ARM: dts: mvebu: Add definitions for PCIe legacy
 INTx interrupts
Message-ID: <20220707163818.620ccb95@dellmb>
In-Reply-To: <YsX2Wvtz7hEpJ6X+@lunn.ch>
References: <20220706183114.30783-1-pali@kernel.org>
        <YsX2Wvtz7hEpJ6X+@lunn.ch>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 22:53:46 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Jul 06, 2022 at 08:31:03PM +0200, Pali Roh=C3=A1r wrote:
> > This patch series add definitions for PCIe legacy INTx interrupts into
> > every DTS file used by the pci-mvebu.c controller driver. =20
>=20
> What you fail to explain in the commit message is Why?
>=20
>      Andrew

Hi Andrew,

this is required for example in a scenario where a driver requests only
one of the legacy interrupts (INTA). Without this change, the driver
would be notified on events on all 4 (INTA, INTB, INTC, INTD), even if
it requested only one of them.

Marek
