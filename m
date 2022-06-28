Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F068C55D002
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbiF1Lgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiF1Lgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:36:47 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF4326F2;
        Tue, 28 Jun 2022 04:36:46 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A8CAE22246;
        Tue, 28 Jun 2022 13:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656416204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za8uTTYx8zFPk1Ng0Xyp1mSh2osnL3ssrrojyyayo04=;
        b=lHtroMucaHy91RglKDxtz8KfYfdTkDypNHaOuDniKsEcg1oSpJakww1A9ZsQRDDzQMxmqn
        kGlVoX7XYWdcwQgQxg4NQH141viaDiZgkPsezNCgHTyKV9YVcClKgoWgrgvf3vQSDHi/UF
        ZdHhPcanYwYElIjr9YOrj78V+G+Wmj0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 13:36:44 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
In-Reply-To: <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
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

Am 2022-06-28 13:10, schrieb Andy Shevchenko:
> On Mon, Jun 27, 2022 at 02:49:51PM +0200, Michael Walle wrote:
>> Hi,
>> 
>> I tired to iterate over all child nodes, regardless if they are 
>> available
>> or not. Now there is that handy fwnode_for_each_child_node() (and the
>> fwnode_for_each_available_child_node()). The only thing is the OF 
>> backend
>> already skips disabled nodes [1], making fwnode_for_each_child_node() 
>> and
>> fwnode_for_each_available_child_node() behave the same with the OF 
>> backend.
>> 
>> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix 
>> that
>> one. fwnode_for_each_child_node() and also 
>> fwnode_get_next_child_node() are
>> used by a handful of drivers. I've looked at some, but couldn't decide
>> whether they really want to iterate over all child nodes or just the 
>> enabled
>> ones.
>> 
>> Any thoughts?
> 
> It was discussed at least twice this year (in regard to some new IIO 
> drivers)
> and Rob told that iterating over disabled (not available) nodes in OF 
> kinda
> legacy/design mistake. That's why device_for_each_child_node() goes 
> only
> over available nodes only.

Mh, but then the fwnode_for_each_child_node() is very misleading, esp.
with the presence of fwnode_for_each_available_child_node().

> So, why do you need to iterate over disabled ones?

I was trying to fix the lan966x driver [1] which doesn't work if there
are disabled nodes in between. My steps would have been:
  (1) change fwnode_for_each_available_child_node() to
      fwnode_for_each_child_node(), maybe with a fixes tag, as it's
      easy to backport
  (2) introduce new compatibles and deduce the number of ports
      according to the compatible string and not by counting
      the child nodes.
  (3) keep the old behavior for the legacy compatible and mark it
      as deprecated in the binding
  (4) move the device tree over to the new compatible string

-michael

[1] 
https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c#L1029
