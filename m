Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BFF4A2D92
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 11:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiA2KMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 05:12:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55343 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiA2KMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 05:12:24 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id AEEBD2222E;
        Sat, 29 Jan 2022 11:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643451142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bTFobhSnwQNPOaag8vS347YtdM25w69ZBcIttP57mQ=;
        b=sRWp07p65Zd+Q67lWy2J9Zc5nVq1ssiClmTrU0KjFS9As8pT7VToxQn98FWa2jB0z0wNrj
        N9pIPR6J9qLq6gp+SoLAf/fRViIn0Egkv3vqlHKCQN5OPsQrf2qu1i6ljCrguwE7lExLab
        rGhIah2J/YTUM6rtwPyAPT3n9KhTttg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Jan 2022 11:12:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH 2/2] Revert "arm64: dts: ls1028a: add flextimer based pwm
 nodes"
In-Reply-To: <20220129054209.GO4686@dragon>
References: <20220115210907.451189-1-michael@walle.cc>
 <20220115210907.451189-2-michael@walle.cc> <20220129054209.GO4686@dragon>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <3d1328729d93daa2e6a50a4d03ec5ef0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-01-29 06:42, schrieb Shawn Guo:
> On Sat, Jan 15, 2022 at 10:09:07PM +0100, Michael Walle wrote:
>> The changes to the device tree look very wrong. There are now two
>> devices with the same base address: pwm0 and ftm_alarm0. Both are 
>> using
>> the Flex Timer Module. It seems like this should either be one driver 
>> or
>> and MFD driver. Either way, there should only be one node in the 
>> device
>> tree. Revert the offending changes to avoid getting a broken device 
>> tree
>> in circulation.
> 
> Why not just fix the conflicting nodes?

And how would you fix it? There are two conflicting drivers. Like
I said, maybe it should be an MFD driver, see for example
Documentation/devicetree/bindings/mfd/atmel-flexcom.txt, which also
have a common block which you can switch between different modes. But
that would mean a lot of work which I don't think will happen until
the next merge window, let alone that this is not a bugfix.

Therefore, the only sensible thing is to revert the latest changes,
so that you don't have a broken device tree released with 5.17 and
work on a proper support for the next release.

And TBH, I'd expect that NXP will fix this.

-michael
