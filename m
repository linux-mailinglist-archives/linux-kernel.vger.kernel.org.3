Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D644F609A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiDFNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiDFNck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:32:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850FA67C7E8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:32:27 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9A43922238;
        Wed,  6 Apr 2022 12:31:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649241082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teRjar+QxUq3g1wf45P3zQIoOzFA3FHoJkTKj33N6VI=;
        b=B3ohjPB3uUOpuA+Cx2WNqILMHe80lLNb4or7/isCZTcTXr0NobDkMaYjPWcXcb+zG7wA29
        U5/VwKQuSBZRMpZbVh4Qle3XWk4EToIwtV9E6G6CjL59OTpPS8zOlb5DJnE5zjxVKqwxYL
        Tq93ygyKkXDSYCpfnmFTllqKPDat3Fo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Apr 2022 12:31:22 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor.Ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: sfdp: Keep SFDP definitions private
In-Reply-To: <20220405193111.pnekaivbsj7hronp@ti.com>
References: <20220309144215.179449-1-tudor.ambarus@microchip.com>
 <20220309144215.179449-5-tudor.ambarus@microchip.com>
 <20220401200133.gyyvoe7xdbsww7cv@ti.com>
 <ed093fa5-b514-b0a6-166f-ecf117582b0b@microchip.com>
 <20220405193111.pnekaivbsj7hronp@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1fa079c4a0341ffe6ad7bdebd3cb8958@walle.cc>
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

I didn't follow the series closely, so I might miss something.

Am 2022-04-05 21:31, schrieb Pratyush Yadav:
> On 04/04/22 06:19AM, Tudor.Ambarus@microchip.com wrote:
>> On 4/1/22 23:01, Pratyush Yadav wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> >
>> > On 09/03/22 04:42PM, Tudor Ambarus wrote:
>> >> Keep the SFDP definitions private and expose just the definitions that are
>> >> required by the core and manufacturer drivers.
>> >
>> > I am not so sure about this. Since the post_bfpt hook passes in the bfpt
>> > table to flash drivers, they might end up wanting to use these for some
>> > checks like issi.c does for DWORD 1. They would have to move them back
>> > to sfdp.h for that, which just causes extra churn, and also puts some
>> > BFPT related defines in sfdp.h and some in sfdp.c.
>> >

It's not the extra churn, but also git blame doesn't really work. In
fact, it is already really hard to follow all the commits in spi-nor/
with all the code moving around. So what is the actual adavantage of
having this stuff private? One clear disadvantage is that you need to
move it from sfdp.c to sfdp.h once you need it. And potentially, you
might need all the defines.

Also, if you pass the SFDP data to any fixups, the drivers are expected
to use them.

>> That's correct, but I think exposing just the public defines in sfdp.h 
>> is
>> the path to follow. We should keep private all the definitions that we 
>> can
>> private in sfdp.c and expose publicly in sfdp.h just the ones that are 
>> shared.
>> Flash collisions, and implicitly the need of public SFDP definitions, 
>> should be
>> an exception, so I expect sfdp.h to be short in size.
> 
> I disagree. I think we should keep everything in the same place. And
> since we need to expose this to manufacturer drivers, that place is
> sfdp.h. Who is going to cast the tiebreaking vote here? ;-)

I'm leaning towards Pratyush opinion unless there is a clear advantage
to move the defines.

-michael
