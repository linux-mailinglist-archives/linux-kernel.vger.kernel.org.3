Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655A5738ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiGMOcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiGMOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:32:43 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883537FAA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:32:41 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 857AF221D4;
        Wed, 13 Jul 2022 16:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657722759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duF3Y9Z02+1a67NZ+Hlfg5VSoW3ZmuWvDf5dQcHYzN8=;
        b=FO+wQKwZIzWjF3oOb7rj19/1KM4CKVAWVtrpt2+C0ESOkyPvH8W/PhlpgDHFGCM4kM1yMH
        5T8yBKYBC3J4iQzC+dUOLVh8KRWy+UHsC+a8zRU7iSpx8RXUk6oaEFsQVjFTqOO2SGyDps
        Si5SbtFEho3nmREwOiMjvfDqKatBqj0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jul 2022 16:32:38 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     clg@kaod.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, p.yadav@ti.com,
        quic_ggregory@quicinc.com, quic_jiles@quicinc.com,
        tudor.ambarus@microchip.com
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
In-Reply-To: <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
 <20220711095042.2095360-1-michael@walle.cc>
 <a42fbef2-3eff-9e88-233e-a805cfbe2376@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4972a85d04e39ebb7b4a5872f6632c45@walle.cc>
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

Am 2022-07-13 16:26, schrieb Jae Hyun Yoo:
>>> +	{ "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)
>> 
>> Please use INFO(0xef6020, 0, 0, 0) and test wether it will still
>> work correctly. We will then be able to convert it to SNOR_ID3()
>> later.
> 
> Tested it but it doesn't work with INFO(0xef6020, 0, 0, 0). I'll keep
> it as is.

Can you please look into this? I'd expect this to work if the SFDP
tables are correct because all this should come from the tables.
You can look at /sys/kernel/debug/spi-nor/spi0.0/params and see
what is changing there.

Thanks,
-michael
