Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA595AE69E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiIFLa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiIFLay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77931218;
        Tue,  6 Sep 2022 04:30:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC34B60C61;
        Tue,  6 Sep 2022 11:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC2C433D6;
        Tue,  6 Sep 2022 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662463851;
        bh=bm9uW+36QU1xAHJ+oVynEAhF11CfOTIcYyIVCyIxWQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuWAOZpABzQWjhRFEGlEzovAMjqYP5gbx2CfPPN4+oWWFfy/3GWDEANvJUy53gZkq
         VWJVDLrAxbVlvcJZu3UwkmlK8PraTgk99sLgZfP+p27zMLLBLQ6/fEH6sFM8hFK2sH
         bUpyrIumm8r+LCVMCjEFEgQHOC3MxsYb1cgL9cjZLg8IVjnnqkxPPoTaUzoS4itTQJ
         AOZQpg7aJK2Gp1UyXQS7aGuZafIND20w87iIoGU1OEMTSR+KE65l/32oDQUpr0yT+a
         s525IDq+7dqQ/gbrXrGJA8wonnoHLr7bNBRSSpbXpcOxpvqjz9P64BmKzTpJVzkA/y
         XXjMl/V2ztJWw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oVWn8-0001e0-0d; Tue, 06 Sep 2022 13:30:54 +0200
Date:   Tue, 6 Sep 2022 13:30:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
Message-ID: <Yxcvbk281f/vy4vb@hovoldconsulting.com>
References: <20220906104805.23211-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906104805.23211-1-jslaby@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
> This series introduces DEFINE_UART_PORT_TX_HELPER +
> DEFINE_UART_PORT_TX_HELPER_LIMITED TX helpers. See PATCH 2/4 for the
> details. Comments welcome.
> 
> Then it switches drivers to use them. First, to
> DEFINE_UART_PORT_TX_HELPER() in 3/4 and then
> DEFINE_UART_PORT_TX_HELPER_LIMITED() in 4/4.
> 
> The diffstat of patches 3+4 is as follows:
>  26 files changed, 191 insertions(+), 823 deletions(-)
> which appears to be nice.

Not really. This is horrid. Quality can't be measured in LoC (only).

The resulting code is unreadable. And for no good reason.

[ And note that you're "saving" something like 20 lines per driver:

	 12 files changed, 84 insertions(+), 349 deletions(-)
]

NAK

Johan
