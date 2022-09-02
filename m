Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BA5AB3DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiIBOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiIBOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:41:56 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F5517F6A5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:02:34 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 426D9216B;
        Fri,  2 Sep 2022 16:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1662127296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAwDC+ZGNEoPxSWgUlrI5jj7H9smOzKu5zWicRxfk50=;
        b=zluc78GHr8brCngTJtcQTa2rPxwNrKKDUQhKENNFnSV5m+0WfG9zhi0Ib39upNLHQw4lnp
        FLOtloAKdpdkLMgbV2EbEN1DrCvP4OgdPwFk69E6S1bZR1DVZo7NDbwXZIAAlSTV8ra7/i
        1U1ugFa0cnnSbyTREqUTPUCVi8P57qMXyWoxK2fSFHRUI4o16BlSG2WGEbmM4iBTnvL+4r
        uC6/c5Xp0NZtfhBPABMwkvA0NX9k+2X1D3w1FfM7EJcOAMqGs2OEHZs0/lc3xwDVP49tC3
        OzbQ7xnabN2KChxSZ4ON7e2cZOnBu1c5JeaLTS5ZL53K7vcGnfGB+9MZ55Kqfg==
MIME-Version: 1.0
Date:   Fri, 02 Sep 2022 16:01:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable <stable@kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix memory leak when using debugfs_lookup()
In-Reply-To: <20220902133724.278133-1-gregkh@linuxfoundation.org>
References: <20220902133724.278133-1-gregkh@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bcd0cc5153457fb52566519a76e7b5b4@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-09-02 15:37, schrieb Greg Kroah-Hartman:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  Fix this up to be much
> simpler logic and only create the root debugfs directory once when the
> driver is first accessed.  That resolves the memory leak and makes
> things more obvious as to what the intent is.
> 
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: stable <stable@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mtd/spi-nor/debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/debugfs.c 
> b/drivers/mtd/spi-nor/debugfs.c
> index df76cb5de3f9..3aab595e82d1 100644
> --- a/drivers/mtd/spi-nor/debugfs.c
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -228,11 +228,11 @@ static void spi_nor_debugfs_unregister(void 
> *data)
> 
>  void spi_nor_debugfs_register(struct spi_nor *nor)
>  {
> -	struct dentry *rootdir, *d;
> +	static struct dentry *rootdir;
> +	struct dentry *d;
>  	int ret;
> 
>  	/* Create rootdir once. Will never be deleted again. */
> -	rootdir = debugfs_lookup(SPI_NOR_DEBUGFS_ROOT, NULL);

IIRC I had that one and it didn't work with spi-nor as a module.
Wouldn't it try to create the root dir twice if you remove the module
and load it again?

-michael

>  	if (!rootdir)
>  		rootdir = debugfs_create_dir(SPI_NOR_DEBUGFS_ROOT, NULL);
