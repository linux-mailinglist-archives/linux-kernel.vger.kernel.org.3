Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77188577C06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiGRG53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiGRG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:57:27 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDCC165B4;
        Sun, 17 Jul 2022 23:57:25 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6D6002223A;
        Mon, 18 Jul 2022 08:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658127442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sf6PNQbhIHBDnRnau7vCcYU1WYAC0tMbQT2baM/8MoA=;
        b=L52dwrCL7c6OlpAGESjGoH7cK9TT2avA32UJDm9VCLClr/id3A5YGEPSyxsggo0Qyp8vRH
        /Ot8YydJqBgAkYy26aWK1ODFrsY2gbQI6bGJ/xK2GpsW39uwONd1ewkdm6tm05G4PWHmZe
        vXW4lURrmBEmz3uL5XES166g2e8dU8s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 18 Jul 2022 08:57:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     haibo.chen@nxp.com
Cc:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 09/11] mtd: spi-nor: macronix: add mx25uw51345g OPI mode
 support
In-Reply-To: <1657012303-6464-9-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-9-git-send-email-haibo.chen@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a21533017ffa0b6e6b0903d81d1cae0f@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-07-05 11:11, schrieb haibo.chen@nxp.com:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> mx25uw51345g has a special OPI DTR read command id, so add this
> special fixup.
> For RDID under OPI DTR mode, the dummy need to enlarge to 20 cycles,
> otherwise can't get correct ID value.

Could you please dump the SFDP data of this flash, see [1]. I wonder
if this command isn't described in the SFDP.

-michael

[1] 
https://lore.kernel.org/linux-mtd/4304e19f3399a0a6e856119d01ccabe0@walle.cc/
