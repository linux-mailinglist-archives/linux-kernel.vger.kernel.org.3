Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4B4B65FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbiBOI0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:26:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBOI0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:26:16 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2BB715F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 00:26:02 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2639C2223A;
        Tue, 15 Feb 2022 09:25:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644913557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0NserSeedPnp6XT1u/jN/mA6g6cQ/+ctGlpC4m9TEs=;
        b=t0LI/TVPjblGgnNqw2EGOfngyuRHAW/I/9f1wXgeDYMHS1I59kGNr8oxJdbTEFS5cEz6tq
        93bZigWY7gcF0uOIpdrksDvT8On0FDra9/lEOtpDjqB6SxEE2KTBsRUUOjf+6WcgnkQ7TK
        hwjakAAmg0WsU5h55GNKyk8MGv2CZKE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Feb 2022 09:25:49 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
In-Reply-To: <d76f21dd-4038-57de-f2f6-6afa947b62cb@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
 <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
 <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
 <d76f21dd-4038-57de-f2f6-6afa947b62cb@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <c3a58de8ee39dd473483dfd0ed8a0058@walle.cc>
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

Am 2022-02-10 09:06, schrieb Tudor.Ambarus@microchip.com:
> On 2/10/22 10:04, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2022-02-10 04:08, schrieb Tudor.Ambarus@microchip.com:
>>> On 2/2/22 16:58, Michael Walle wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you 
>>>> know
>>>> the content is safe
>>>> 
>>>> Drop the generic spi_nor prefix for all the xilinx functions.
>>> 
>>> mm, no, I would keep the spi_nor prefix because xilinx_sr_ready is 
>>> too
>>> generic and can conflict with methods from other subsystems.
>> 
>> But all the other functions in this file start with xilinx_ ;)
>> 
>> I don't have a strong opinion here, other than it shouldn't
>> be called spi_nor_read_blaba() because that looks like a
>> standard spi nor function belonging in core.c
>> 
> 
> then let's prepend all with spi_nor_xilinx_*()?

I'm still not sure what to do here. Have a look at all the other
vendor modules in spi-nor. they are all prefixed with the vendor
name? E.g. there is a sst_write() which is far more likely to
cause a conflict. So should we rename all these functions? Or
do we just take our chance that it might have a conflict in
the future (with an easy fix to rename the function then). TBH
I doubt there will be a global symbol "xilinx_read_sr()".

But I care for consistency, so having some named xilinx_, sst_,
st_micron_ and some spi_nor_read_xsr sounds and looks awful.

-michael
