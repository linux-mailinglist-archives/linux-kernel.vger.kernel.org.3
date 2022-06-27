Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F5F55CB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiF0Mt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiF0Mtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:49:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EFB09;
        Mon, 27 Jun 2022 05:49:53 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B749222247;
        Mon, 27 Jun 2022 14:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656334192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ky/YEE8/Nax/z6D/NLRsoblA0XrDLZZ3MT3wri++z0s=;
        b=EZlV9XYuwjSSjTD4vcMDKxNItUFcwmSa4+ywkQUpJRonO6FWNfV90VZzTQPTW11ojuPjLD
        YhaFWklUZ6FwEkR611YWP5Jhb/DOv/PCS5X0GD3AC1kiUsYCjT4Kkbi1A6Ndu9/8cbE9HA
        JuCs42esQXcRIA3ynGergI960Am9G+A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jun 2022 14:49:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: fwnode_for_each_child_node() and OF backend discrepancy
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
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

Hi,

I tired to iterate over all child nodes, regardless if they are 
available
or not. Now there is that handy fwnode_for_each_child_node() (and the
fwnode_for_each_available_child_node()). The only thing is the OF 
backend
already skips disabled nodes [1], making fwnode_for_each_child_node() 
and
fwnode_for_each_available_child_node() behave the same with the OF 
backend.

Doesn't seem to be noticed by anyone for now. I'm not sure how to fix 
that
one. fwnode_for_each_child_node() and also fwnode_get_next_child_node() 
are
used by a handful of drivers. I've looked at some, but couldn't decide
whether they really want to iterate over all child nodes or just the 
enabled
ones.

Any thoughts?

-michael

[1] 
https://elixir.bootlin.com/linux/v5.19-rc3/source/drivers/of/property.c#L960
