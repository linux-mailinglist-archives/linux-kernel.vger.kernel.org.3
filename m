Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C8958D764
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiHIK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiHIK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:27:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9F22B1A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:27:30 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DBA7122249;
        Tue,  9 Aug 2022 12:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1660040848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdyhChmoXigubLYdVjSiyhONMDXqmMU6W2M2HxVPKlA=;
        b=JNCpanx6m5lmiPZbIGE4QylQtKuJdQs/zTgdAtOvCtyMMZ0bWbqgIf2t8eZUCP9C8miuXf
        jeHRSG45ICl/mn7I1NaUETwhrRXdZi8jX73vLOcargB4eE2Fx5d3YBrviuenzEXRvuC+1R
        NPDpOC08kas0W5tzMbQnr9qwGE9fEnI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 09 Aug 2022 12:27:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
In-Reply-To: <ba44019b3c4ae9052ca6ddfa6673b7f1c71d8891.camel@microchip.com>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
 <73dc6fcedebcae098751bd093fe2d028@walle.cc>
 <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
 <595347d292ee31a9f0de031d6349f44e@walle.cc>
 <4a12868d0bffbaef9912fbc54e5998e0c50bccf6.camel@pengutronix.de>
 <38311987be9d29959bb303be9e3121ae@walle.cc>
 <ba44019b3c4ae9052ca6ddfa6673b7f1c71d8891.camel@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6c86be0e45807b86aff394026e015253@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steen,

Am 2022-08-09 12:19, schrieb Steen Hegelund:
> Sorry, but most people have been OOO (including me), so this has
> delayed the response.
> 
> The protection bit protects the VCore Shared Bus (SBA) blocks shown on
> Figure 5-1. VCore System
> Block Diagram in the Datasheet.  So in this case also the watchdog
> (which is the WDT block).
> 
> I hope this clarifies the usage.

Actually, it does not. The watchdog was just an example. I'm
questioning the use of this reset for the switch block. Esp.
as it turns out that not even microchip knows what blocks
are actually reset.

This reset was first introduced for the DSA switch, since then
more and more spurious errors were discovered and it turns out
all of these errors was because the "switch" reset had some
severe side effects, like resetting the GPIO core and thus
turning all the GPIOs to input mode which then took some
peripherals into reset.

-michael
