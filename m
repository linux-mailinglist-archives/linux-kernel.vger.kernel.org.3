Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65438521CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiEJOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiEJOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:38 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCBA1900C7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:03:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B5F9022238;
        Tue, 10 May 2022 16:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652191426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RneOi143x1oW2qLY0RCSAR2GeweFwG1lLPobOCmEojI=;
        b=vLyveiHk5oYcSMt7YvhXCKxnsHE30H+jVO8oHxHYIuDtA0HFM63hW0kfSUH7loksBbhzRM
        FJQEdfJhIVr80sFRLMKbDKB9Ivmuq+fpc3p568wA0kfwuXVMPgbHmEWtooLo1uhGxIEi6U
        UH6fjSq+3iO4TacK6Mq03VK9eG2JFT8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 May 2022 16:03:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mtd: spi-nor: introduce SNOR_ID3()
In-Reply-To: <20220510140232.3519184-1-michael@walle.cc>
References: <20220510140232.3519184-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <966de7ad5f563f9a29db91c5309a71c6@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[proper subject]

Am 2022-05-10 16:02, schrieb Michael Walle:
> For support which rely solely on the SFDP data, all we need to know is 
> its
> JEDEC ID. All further information should be fetched from SFDP. For 
> this,
> introduce a SNOR_ID3() macro which should be used for all new flashes 
> with
> SFDP.
> 
> The dropped information are page size, number of sectors and sector 
> size.
> The number of sectors (together with sector size) is only used to 
> calculate
> the total flash size. In case of SFDP, this is read from there. The 
> sector
> size is also used to select a proper erase opcode. We can just keep 
> that
> one zero and the selection algorithm will select the same erase opcode;
> that is the opcode for the largest erase size (which is btw rather 
> odd..).
> The page size is also taken from SFDP. There is one exception: older 
> SFDP
> tables. These doesn't contain this data. So if there will be flashes 
> with
> that, we should assume some sane value.
> 
> Shaik, could you please re-test your w25q512nwm support with this 
> patch. I
> read through the SFDP data and it should behave exactly the same as 
> before.
> 
> Michael Walle (2):
>   mtd: spi-nor: introduce SNOR_ID3()
>   mtd: spi-nor: winbond: use SNOR_ID3() for w25q512nwm
> 
>  drivers/mtd/spi-nor/core.c    | 7 +++++--
>  drivers/mtd/spi-nor/core.h    | 9 +++++++++
>  drivers/mtd/spi-nor/winbond.c | 3 +--
>  3 files changed, 15 insertions(+), 4 deletions(-)
