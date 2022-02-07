Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30FF4AC0F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389001AbiBGOTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382266AbiBGOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:02:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC52C043181;
        Mon,  7 Feb 2022 06:02:47 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5432222239;
        Mon,  7 Feb 2022 15:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644242565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pEBILsW1LJ46qQW0Q2to5hoQF0EBb+IcTVphV3PTDhw=;
        b=Pri7Y8gNfc1RqZt0jGLDHBjREWhZYpScuRkTVQVuL8U+IwAQD0wtV3BXJymkjYX0s5O2MP
        X91GR98t2H7umXaIqIs4J/jX6I7lerglEUX1AeU1AXMW3MUDe03XonAW15H3Dq3gdajrQT
        go6OrXNNkbgG61CyH28PuL/I3uzkJBI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Feb 2022 15:02:45 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH 2/2] Revert "arm64: dts: ls1028a: add flextimer based pwm
 nodes"
In-Reply-To: <3d1328729d93daa2e6a50a4d03ec5ef0@walle.cc>
References: <20220115210907.451189-1-michael@walle.cc>
 <20220115210907.451189-2-michael@walle.cc> <20220129054209.GO4686@dragon>
 <3d1328729d93daa2e6a50a4d03ec5ef0@walle.cc>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <92eaa24876a823aa5833435f51095812@walle.cc>
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

Am 2022-01-29 11:12, schrieb Michael Walle:
> Am 2022-01-29 06:42, schrieb Shawn Guo:
>> On Sat, Jan 15, 2022 at 10:09:07PM +0100, Michael Walle wrote:
>>> The changes to the device tree look very wrong. There are now two
>>> devices with the same base address: pwm0 and ftm_alarm0. Both are 
>>> using
>>> the Flex Timer Module. It seems like this should either be one driver 
>>> or
>>> and MFD driver. Either way, there should only be one node in the 
>>> device
>>> tree. Revert the offending changes to avoid getting a broken device 
>>> tree
>>> in circulation.
>> 
>> Why not just fix the conflicting nodes?
> 
> And how would you fix it? There are two conflicting drivers. Like
> I said, maybe it should be an MFD driver, see for example
> Documentation/devicetree/bindings/mfd/atmel-flexcom.txt, which also
> have a common block which you can switch between different modes. But
> that would mean a lot of work which I don't think will happen until
> the next merge window, let alone that this is not a bugfix.
> 
> Therefore, the only sensible thing is to revert the latest changes,
> so that you don't have a broken device tree released with 5.17 and
> work on a proper support for the next release.
> 
> And TBH, I'd expect that NXP will fix this.

I've just asked Rob and it is ok to have two nodes which have the
same reg on the same parent if one (or both) are disabled.

So you can drop this patch, but someone should really sort these
nodes by address.

I still think it would have been nicer the one proper driver for
the flextimer.

-michael
