Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA85E57B7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiGTNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGTNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:49:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA19A61D8D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:48:51 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5FC752223E;
        Wed, 20 Jul 2022 15:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658324928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SDELbFZivHkdGyHGF1nop4U3jMBC/a0ONji2ciT+Qc=;
        b=FcfZdyDefl/Euo7ImCUcqieYhONzoiD2qLyGJh5kPiPNtfzkEB03vTNFgxrGMtsRIwWbuH
        JraLrzdm1V6pCcJSrb5biunhS+MokJDcTYNYiTDcvt7oKVyo6RHhO69AX8Nb0saEk5LT65
        T853AvIgyG+uP0L8HfSeQD6QsLiAStQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jul 2022 15:48:41 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com
Subject: Re: [PATCH v1] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
In-Reply-To: <43041ef1-2b1b-5729-9611-00964d617f63@microchip.com>
References: <20220304185137.3376011-1-michael@walle.cc>
 <43041ef1-2b1b-5729-9611-00964d617f63@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f86d847fe61bbcd832c64ce1d636774e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-19 06:57, schrieb Tudor.Ambarus@microchip.com:
> On 3/4/22 20:51, Michael Walle wrote:
> 
> Hi!
> 
>> While the first version of JESD216 specify the opcode for 4 bit I/O
>> accesses, it lacks information on how to actually enable this mode.
>> 
>> For now, the one set in spi_nor_init_default_params() will be used.
>> But this one is likely wrong for some flashes, in particular the
>> Macronix MX25L12835F. Thus we need to clear the enable method when
>> parsing the SFDP. Flashes with such an SFDP revision will have to use 
>> a
>> flash (and SFDP revision) specific fixup.
> 
> This is equivalent to clearing the default QE method for all those 
> flashes
> that support SFDP, with implications for those that support SFDP Rev A.
> If I continue the logic, I could remove the default QE method from
> spi_nor_init_default_params(), but I don't think I would like that.
> You could use a post_bfpt hook without explicitly clearing it here.
> 
> Would you please explain more why is clearing the default method better
> than using a wrong default one, and why you chose to do this just for
> the Rev A SFDP flashes and you didn't include the no-SFDP flashes as 
> well?

Honestly, I don't care too much about this flash. I can't remember
any details from this 4 months old thread. Sorry. I guess it is
fine to drop this patch. If someone cares, she or he can
resurrect this one.

-michael
