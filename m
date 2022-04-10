Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706CC4FAF43
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiDJRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiDJRUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:20:40 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C760DA6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:18:28 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C1C9F2800A278;
        Sun, 10 Apr 2022 19:18:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B5498324E0; Sun, 10 Apr 2022 19:18:26 +0200 (CEST)
Date:   Sun, 10 Apr 2022 19:18:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        =robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, p.rosenberger@kunbus.com
Subject: Re: [PATCH 5/5] tpm: tpm_tis_spi_slb_9670: implement set_reset and
 unset_reset functions
Message-ID: <20220410171826.GB24453@wunner.de>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407111849.5676-6-LinoSanfilippo@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 01:18:49PM +0200, Lino Sanfilippo wrote:
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_spi_slb9670.c
[...]
> +int slb9670_spi_unset_reset(struct tpm_tis_data *data)
[...]
> +int slb9670_spi_set_reset(struct tpm_tis_data *data)
[...]
> +static const struct tpm_tis_phy_ops slb9670_spi_phy_ops = {
> +	.read_bytes = tpm_tis_spi_read_bytes,
> +	.write_bytes = tpm_tis_spi_write_bytes,
> +	.read16 = tpm_tis_spi_read16,
> +	.read32 = tpm_tis_spi_read32,
> +	.write32 = tpm_tis_spi_write32,
> +	.set_reset = slb9670_spi_set_reset,
> +	.unset_reset = slb9670_spi_unset_reset,
> +};

0-day is complaining that slb9670_spi_set_reset() / slb9670_spi_unset_reset()
are not declared static:

https://lore.kernel.org/all/202204081357.8SfjQosI-lkp@intel.com/

Thanks,

Lukas
