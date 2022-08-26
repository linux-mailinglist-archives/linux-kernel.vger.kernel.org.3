Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EF5A26F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbiHZLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiHZLhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:37:40 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCADB7E9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:37:39 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id C04588390;
        Fri, 26 Aug 2022 13:37:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1661513857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d97NfSPeWxwcueUWPJv125kGVseFeqIVjuK7yR6hQHU=;
        b=z40hiH4OYEPM8sUa/FAJRCPUbP1j34N3omHj1GmEMS8IRefQSs4+573nEX4zQXpETddu6P
        HsDw67+JNtd7IFW58fZ1GWT/mCBc84tTW3ohU6ZW09/AuUTktjG91PFRUHQCA0TEv8ldmI
        8VuA+NNiyZ6S0QIQm3+tXvGjfrhRVXIyLcKHdytEF0cXfpqy8C0bQ5Yd7AIUefcqR5wOMI
        MuBWqw72m6JoB+m1jY2zHhVMRry2+X72BqiJLmA4bY2AZTGwT075sW84zwWntZF5iLOHBP
        BPHmeWwQ171+sdioJs62z/P5h9oEmiF/aKhXv+7ohzhiCo5rvSl4sS27f3Xc8A==
MIME-Version: 1.0
Date:   Fri, 26 Aug 2022 13:37:37 +0200
From:   Michael Walle <michael@walle.cc>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Steen Hegelund <steen.hegelund@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ge?= =?UTF-8?Q?r?= 
        <clement.leger@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH] Revert "reset: microchip-sparx5: allow building as a
 module"
In-Reply-To: <4a12868d0bffbaef9912fbc54e5998e0c50bccf6.camel@pengutronix.de>
References: <20220713084010.168720-1-p.zabel@pengutronix.de>
 <73dc6fcedebcae098751bd093fe2d028@walle.cc>
 <ba905391f3258c2d780677e09e4f89192df7bc31.camel@microchip.com>
 <595347d292ee31a9f0de031d6349f44e@walle.cc>
 <4a12868d0bffbaef9912fbc54e5998e0c50bccf6.camel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <acddd598716d2d9e9903c425a3b54257@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-07-13 14:08, schrieb Philipp Zabel:
> On Mi, 2022-07-13 at 11:52 +0200, Michael Walle wrote:
>> [+ Horatiu, I missed you earlier, sorry]
>> 
>> Hi Steen,
>> 
>> Am 2022-07-13 11:40, schrieb Steen Hegelund:
>> > I am afraid that the exact list of affected modules is not available,
>> > so using the
>> > RESET_PROT_STAT.SYS_RST_PROT_VCORE bit is the best known way of
>> > resetting as much as possible, and
>> > still continue execution.
>> 
>> Mh, you are designing that chip (at least the LAN966x) no? Shouldn't
>> that information be available anywhere at Microchip? ;)
>> 
>> Anyway, it looks like almost the whole chip is reset
>> except some minor things. So the driver has actually a
>> wrong name. Until recently only the switch driver was the
>> sole user of it (at least on the lan966x). So, my question
>> remains, is this correct? I mean the switch driver says,
>> "reset the switch core", but what actually happens is that
>> the the entire SoC except the CPU and maybe the io mux is reset.
>> What about the watchdog for example? Will that be reset, too?
> 
> If [1-3] are to be trusted, RESET_PROT_STAT[VCORE_RST_PROT_WDT], which
> protects the watchdog from soft reset, is not set by default. So yes?
> 
> There are also AMBA, PCIe, PDBG protection bits against Vcore soft
> reset in this register, depending on the platform.

*But* this also prevents it from reset by the watchdog. I don't know
if we want that?!

I.e. what happens if one sets RESET_PROT_STAT[VCORE_RST_PROT_WDT] and
the watchdog does a reset? OTHO, I guess it is also bad to reset the
watchdog during boot.. IMHO this reset logic doesn't look that well
designed.

> [1] 
> https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?select=cpu,cpu_regs,reset_prot_stat
> [2] 
> https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,cpu_regs,reset_prot_stat
> [3] 
> https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html?select=cpu,cpu_regs,reset_prot_stat

-michael
