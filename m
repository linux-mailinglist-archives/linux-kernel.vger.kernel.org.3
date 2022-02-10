Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B44B07F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiBJIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:16:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiBJIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:16:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFB109E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:16:51 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D700C2223A;
        Thu, 10 Feb 2022 09:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644481009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7m8O9Deg7PEc5nH7BFt1L+WAoZvzxBi1x9zZ6x9/wyw=;
        b=HhmM1Milpq1OFgxp15YjBaVOuBV6HH1Htrgqa/j3DjI3kC3lNqp1rOBMy9yyj+z+CqxGXx
        PLGNgW3bUBicVoIyB5s5J/lRG0qR5G+D+KZnmfSk+beDBOIjtGUPW8cjjotR9prYvDQryw
        9x+ngHfiDFlkA2WYq8EcbyZ+XszdWLM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 09:16:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v1 11/14] mtd: spi-nor: spansion: slightly rework control
 flow in late_init()
In-Reply-To: <f004399f-36b0-2099-b2a0-8ab0ecd114b7@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-12-michael@walle.cc>
 <f004399f-36b0-2099-b2a0-8ab0ecd114b7@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <ced74caa2ad507615b9cf1645d10fa87@walle.cc>
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

Am 2022-02-10 04:26, schrieb Tudor.Ambarus@microchip.com:
> On 2/2/22 16:58, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Increase readability of the code. Instead of returning early if the
>> flash size is smaller or equal than 16MiB and then do the fixups for
>> larger flashes, do it within the condition.
>> 
> 
> mm, no, I'm not sure this improves readability, I see the two 
> equivalent.
> The original version has the benefit of no indentation. Pratyush?

This is a preparation patch for 12/14, where the current version isn't
working anyway. If that is not enough reason why this is bad IMHO, I'll
give you two more.

I'd agree with you if that function was called
spansion_late_init_smaller_flashes() or something like that. But it is
a generic function valid for all flashes. And if you read it you might
get the impression there are only flashes smaller or equal than 16MiB.
You have to look twice to notice it was the intention that the
assignment afterwards are just for the smaller flashes (and you will
need to notice that there aren't any assignments for all spansion
flashes). There is no direct connection between the assignment and
the condition. Whereas with
   if (condition) {
     some_action();
   }
It is clear that some_action() was intended to only execute if
condition is true.

Also - and that is worse IMHO - it might easily be missed as someone
just add stuff to the end of the function which might goes unnoticed
but it won't work for flashes >16MiB.

-michael
