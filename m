Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A444E3A69
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiCVIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiCVIVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:21:20 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425D5EDD7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:19:52 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B891922246;
        Tue, 22 Mar 2022 09:19:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647937190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL5MkQsCXafBeEg4aKfiJNR+gU4ZjIQei5uI3xDhyqM=;
        b=IcLe4Q6SWVwEb14ZFt+QiDGekYS+efuPr2YDmu0dM1dZ26WDIPzNzE9jAHEXvVKU/V6qZx
        ufRb3R3h4W9k/w+Q6jiCINPqdzMinTlIoBk7rPpsDg4fF0AK+HKvXKBgRR/2F2G+B1WaL+
        5zBm+Ky2Cu4ry60CQme34joM8k+T830=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Mar 2022 09:19:49 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH v2 4/8] mtd: spi-nor: core: Introduce method for RDID op
In-Reply-To: <20220322073209.26m2udmftiaxxtcq@ti.com>
References: <20220228111712.111737-1-tudor.ambarus@microchip.com>
 <20220228111712.111737-5-tudor.ambarus@microchip.com>
 <0bdbe6ad8f39996df6345bb249e4a2e8@walle.cc>
 <20220322073209.26m2udmftiaxxtcq@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <eca7100c7e6dacd9cb9e18b5bee3e2ab@walle.cc>
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

Am 2022-03-22 08:32, schrieb Pratyush Yadav:
> On 21/03/22 11:56PM, Michael Walle wrote:
>> Am 2022-02-28 12:17, schrieb Tudor Ambarus:
>> > RDID is used in the core to auto detect the flash, but also by some
>> > manufacturer drivers that contain flashes that support Octal DTR mode,
>> > so that they can read the flash ID after the switch to Octal DTR was
>> > made
>> > to test if the switch was successful. Introduce a core method for RDID
>> > op
>> > to avoid code duplication.
>> 
>> Some or all? Is that specific to the flash or can we just check that
>> readid works in spi_nor_octal_dtr_enable()? That way we could also
>> just get rid of the proto parameter for the read_id because it can
>> be called after we set the reg_proto.
> 
> It is specific to the flash. Not all flashes support RDID in 8D mode.
> And the RDID command is also different in 8D mode for various flashes.
> For example, Micron MT35XU512ABA flash expects 8 dummy cycles and 0
> address cycles. Cypress S28HS512T expects 4 address cycles and 3 dummy
> cycles.
> 
> The octal_dtr_enable hook would know what parameters to use but it is
> harder for the core to know since this information is not discoverable
> via SFDP.

Ah, I see, thanks for clarification.

-michael
