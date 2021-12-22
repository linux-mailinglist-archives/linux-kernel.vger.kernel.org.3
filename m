Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7547D442
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbhLVPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbhLVPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:31:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34A2C061574;
        Wed, 22 Dec 2021 07:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B980B81D06;
        Wed, 22 Dec 2021 15:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AC9C36AE5;
        Wed, 22 Dec 2021 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640187093;
        bh=8R1VPxJ5QwjV34tj5ioukTe83BRaxGqqbl3UNmqWFGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/2ngNYaHbEQpP1Fz90Q6XNOfqV9+2kwOlS+9XNFPTRxfOdxH75CTlSV1VZlVNI5Z
         kxpefZqkKzqiv0DdW9mBq3sWpkdKt11CuAWD5CUg93ciO31w+ULbFA8xCnVK7kcnc7
         1pg/cfpisstVN/iDm5zP5L4Y0GerIps8CCkHpljvh6eZEJnJaX/VZUPkW7gRjdU4Fk
         fqVpwZfUNSmLY2SeTvdj32L9Kuxg5Rvz0E/uoCWVPd5C7/WMeXdZatcQEbzHPbORTA
         tJcPvyarp8dAz/Y4HcbfiAiPGxEeKEDKGNQT18IJIK09oBTwaH8GKCtf+Mj9icxe3W
         +Kj775ieQDVvA==
Date:   Wed, 22 Dec 2021 15:31:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 1/3] spi: dln2: Propagate firmware node
Message-ID: <YcNEz2MaigJp0UAe@sirena.org.uk>
References: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ynu3iQ1U5jvIgvu1"
Content-Disposition: inline
In-Reply-To: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
X-Cookie: I've only got 12 cards.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ynu3iQ1U5jvIgvu1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 22, 2021 at 03:54:21PM +0200, Andy Shevchenko wrote:
> Propagate firmware node by using a specific API call, i.e. device_set_node().

This breaks at least an x86 allmodconfig build:

/mnt/kernel/drivers/spi/spi-dln2.c: In function 'dln2_spi_probe':
/mnt/kernel/drivers/spi/spi-dln2.c:691:32: error: implicit declaration of function 'dev_fwnode'; did you mean 'dev_of_node'? [-Werror=implicit-function-declaration]
  691 |  device_set_node(&master->dev, dev_fwnode(dev));
      |                                ^~~~~~~~~~
      |                                dev_of_node
/mnt/kernel/drivers/spi/spi-dln2.c:691:32: error: passing argument 2 of 'device_set_node' makes pointer from integer without a cast [-Werror=int-conversion]
  691 |  device_set_node(&master->dev, dev_fwnode(dev));
      |                                ^~~~~~~~~~~~~~~
      |                                |
      |                                int
In file included from /mnt/kernel/include/linux/platform_device.h:13,
                 from /mnt/kernel/drivers/spi/spi-dln2.c:10:
/mnt/kernel/include/linux/device.h:854:64: note: expected 'struct fwnode_handle *' but argument is of type 'int'
  854 | void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
      |                                          ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
cc1: all warnings being treated as errors

--Ynu3iQ1U5jvIgvu1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHDRM4ACgkQJNaLcl1U
h9Cc/Af/d9JjkEomKALiEA6zxjzRhFaLXJ/kKKq3b/2D8I4QyCNBU76MNCA6uIGJ
W9pD+LKXKLIwW6lZ+LBs0DEfBzduWI8vL1rX0EGuOaIepTt4F0oZR15UNUKSwwdY
XgJzmCt+Qfq5GQe1UhBzYc+GL6ExtrFisWBJbSxzuTDdQvki4fpQdvyGmxL/sqrL
NS5MQZjVOULcFxuNFJrznATQB9yxBM24KGVR9wat2AX8gDspsdSHjwJEKxBsJkww
uAms0atbNg7bTAi8mmX9mkND1NV3bbYh7xonEdCHm24iexGxrSae5qtpfw8bfMbb
KoGK0Z7b2DWzDADhxHVy4wS4d52wdw==
=Wwd+
-----END PGP SIGNATURE-----

--Ynu3iQ1U5jvIgvu1--
