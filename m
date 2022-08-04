Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E265898BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbiHDHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiHDHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:53:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDCB65542
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:53:22 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A0EF422246;
        Thu,  4 Aug 2022 09:53:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659599600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckv7ElxHoIcu1ZfpKuLHGdeDpt8E4bw9sx38JzvDoqg=;
        b=NAj9GW9b9wgRJGt+EBIEj/nBxG+QLzgZositWNmmuOsVeiutGPxZ3OGxtVkDAuxUjlAPLw
        LKC4hiT3286M6oU8NPjnC/xIil9+Pk4f74v/3k/hPlhMtn8JFAW5QgowfKjqJ4S2Nxl3sn
        10ona0J/ZqhuezhZesVf/wphaUVb1Ug=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Aug 2022 09:53:15 +0200
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
Message-ID: <38311987be9d29959bb303be9e3121ae@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-13 14:08, schrieb Philipp Zabel:
> Hi,
> 
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
> 
> [1] 
> https://microchip-ung.github.io/sparx-5_reginfo/reginfo_sparx-5.html?select=cpu,cpu_regs,reset_prot_stat
> [2] 
> https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,cpu_regs,reset_prot_stat
> [3] 
> https://microchip-ung.github.io/lan9668_reginfo/reginfo_LAN9668.html?select=cpu,cpu_regs,reset_prot_stat

Ping. any news here?

-michael
