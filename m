Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E955E472
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiF1N1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiF1N0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:26:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7472CE0D;
        Tue, 28 Jun 2022 06:23:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EF04022246;
        Tue, 28 Jun 2022 15:23:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656422631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlYpkKGqhGxgtH3RgvwIlSJi7ei0NyqGbdtxd8Tr3hU=;
        b=jRiVC0Gjfp8dtLh7H2btzlEmJsz7YuW1NcwOrNk64H3z4ZWbP7wupdoDiiaHBIxryuFNzx
        wXDLij9RwDQ2OzPqZtdsMFWP2ubHzcg8v86sXDgeKFKY43uUwLVdTDYre/enR0ZxnW63/o
        v+F4rmsf1J36hW1KDt8SMX0BsLXnues=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 15:23:50 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
In-Reply-To: <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
 <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2f2d7685e0e43194270a310034004970@walle.cc>
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

>> I was trying to fix the lan966x driver [1] which doesn't work if there
>> are disabled nodes in between.
> 
> Can you elaborate what's wrong now in the behaviour of the driver? In
> the code it uses twice the _available variant.

Imagine the following device tree snippet:
  port0 {
    reg = <0>;
    status = "okay";
  }
  port1 {
    reg = <1>;
    status = "disabled";
  }
  port@2 {
    reg = <2>;
    status = "okay";
  }

The driver will set num_phys_ports to 2. When port@2 is probed, it
will have the (correct!) physical port number 2. That will then
trigger various EINVAL checks with "port_num >= num_phys_ports" or
WARN()s.

So the easiest fix would be to actual count all the child nodes
(regardless if they are available or not), assuming there are as
many nodes as physical ports.

But num_phys_ports being a property of the hardware I don't
think it's good to deduce it by counting the child nodes anyway,
but it should rather be a (hardcoded) property of the driver.

-michael

[1] 
https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
