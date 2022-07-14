Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A735745E4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiGNHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGNHhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:37:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6FC1F639
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:37:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1201A22246;
        Thu, 14 Jul 2022 09:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1657784230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sj8dYrzAUpWONlRlYvGhP0wqfCyH1Y3205lfjeCKT90=;
        b=ryPrkb2gY1Qh9i3w6MtJUKWW9WlpibTjQVNXg/M3kLzmmbTNuZLkMG4BWh3I7/pleZdGGb
        6E6OeFXtOV608dMhZHC5cMj1kMffNjgYmC+aRyh2mZDlu3zavSlOl7IrVMcdeFTaB845R/
        gpBxhDd7bTcfJgF/dq86M2n8p6CLZzs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 14 Jul 2022 09:37:09 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: winbond: add support for W25Q512NW-IQ
In-Reply-To: <20220713211210.1945044-1-quic_jaehyoo@quicinc.com>
References: <20220713211210.1945044-1-quic_jaehyoo@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4d4a2abab1508fe80e36c2e524f98ed8@walle.cc>
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

thanks for the update.

Am 2022-07-13 23:12, schrieb Jae Hyun Yoo:
> Add support for Winbond W25Q512NW-IQ/IN
> 
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Link: 
> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> Changes in v2:
>  * Refined commit message (Michael)
> 
> Test result on AST2600 SoC's SPI controller:
> $ cat
> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/jedec_id
> ef6020
> 
> $ cat
> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/manufacturer
> winbond
> 
> $ cat
> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/partname
> w25q512nwq
> 
> $ hexdump
> /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
> 00000d0 0aff fff0 ff21 ffdc
> 00000d8

md5sum of this file is missing.

For the record: there is still an ongoing discussion on the v1 of
this patch.

-michael
