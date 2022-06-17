Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888354F6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381732AbiFQLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiFQLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:45:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E926CF45;
        Fri, 17 Jun 2022 04:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 551EDB829CF;
        Fri, 17 Jun 2022 11:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9898DC3411B;
        Fri, 17 Jun 2022 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655466323;
        bh=G02EHsP0i0hcRdjLFNd0iVg8HQg/SfUQ/ToemVQl0rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgqIzxXuf+ImZ4rEI3dxKP09dcoIV8IiXHXBXN/k0t56pc6yCwEg3N/KK1HII5Gsp
         XRN+yN3qdfqaTZ4bKG6acyLDhwQlav7x8as3HOsA4JC0QMSrKZ0942b/KADOey6suN
         37hagpMtaEunJPklqJSGldFvBP87RfrTk2xLWU0vZ0qU87BHq8bRBpq1tXestMvyAt
         hdLic6IPyk3hNXUcL9Qxq2BRHx5Q6VF1LsUXRmzV1SyIvHshV99/Y+RGnvOkgLVKws
         9d5VP/UAAuwc8hvhy4wR0S8JLfeoJYhvxTHEsqtetcvk0gT/O2ZarZnYVXP0VOnpKR
         KM95Xhnstdlmg==
Date:   Fri, 17 Jun 2022 12:45:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rockchip: Disable local irq when pio write out of
 interrupt service
Message-ID: <YqxpTqvaQb4cohTh@sirena.org.uk>
References: <20220613092744.9726-1-jon.lin@rock-chips.com>
 <YqcveggUU7yaXuk1@sirena.org.uk>
 <b97ee70c-70ee-6b15-65d6-a176125dcfd8@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CLGvc6v7On6xFTSG"
Content-Disposition: inline
In-Reply-To: <b97ee70c-70ee-6b15-65d6-a176125dcfd8@rock-chips.com>
X-Cookie: 98% lean.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CLGvc6v7On6xFTSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2022 at 02:24:10PM +0800, Jon Lin wrote:
> On 2022/6/13 20:37, Mark Brown wrote:
> > On Mon, Jun 13, 2022 at 05:27:44PM +0800, Jon Lin wrote:

> > > +	spin_unlock_irqrestore(&rs->lock, flags);

> > So this is effectively just disabling interrupts during PIO, there's no
> > other users of the lock which is rather heavyweight.  What's the actual
> > issue here?  We should also have something saying what's going on in the
> > code since right now the lock just looks redundant.

> For lock: In order to avoid special situations, such as when the CPU
> frequency drops to close to the IO rate, the water line interrupt is
> triggered during FIFO filling (triggered by other CPUs), resulting in
> critical resources still not being protected in place. For local IRQ

So essentially we're so slow in filling the FIFO when starting a
transfer that the interrupt triggers in the middle of the initial FIFO
fill?  Something that tricky *really* needs a comment adding.

Ideally we'd just leave the interrupt masked until the FIFO is filled
though, looking at the driver I see that there is an interrupt mask
register which seems to have some level of masking available and I do
note that in rockchip_spi_prepare_irq() we unmask interrupts before we
start filling the FIFO rather than afterwards.  Would reversing the
unmask order there address the issue more cleanly?

> disable: Turning off the local interrupt is mainly to prevent the CPU
> schedule from being interrupted when filling FIFO.

If it were just this then there's preempt_disable(), but what's the
problem with being preempted during the FIFO fill?

--CLGvc6v7On6xFTSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKsaU0ACgkQJNaLcl1U
h9B+Lgf/aLgqdBeHId+v7ymWQ/Ek1vdJ2rjI0CAdGbF8OAmLPqjmOXm8neX8rAJc
OSrQaiXEUmHSsWanCg2AuyX2kQ++TDePT55bA1wCTMwR8ICHSdK6GbdQaxUg7hk3
H2uyaPCZWr9bEsH0xM2//kgl26MqQ1PZhO/rirE+E3OHi0AOjeX/wSipAOn/X6+4
YNz/UW3cvbYWO+Oa8Lz5m2AB56Med0qOswwl65jp/jyF9f16UuwUfEyCbdY469/m
yUpz2PdongU1+0DVlaB8a4nUsUlOCENQzYmy+aPVIRp888Tbz4OYBq9ISjbPY2zU
WIleNV4RTnqq6TcM6o3thBpkJGuW/w==
=fIJJ
-----END PGP SIGNATURE-----

--CLGvc6v7On6xFTSG--
