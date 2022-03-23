Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30FD4E5640
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiCWQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiCWQXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:23:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1966E8E2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 155FDB81FA0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE22C340E8;
        Wed, 23 Mar 2022 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052524;
        bh=Uo0i4i4i2xbxwNsCMR2BRGClWi9I6/uRfjIoHuPEja8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fdw1Aza3MZ/b/LZNSvKRTVCPfyWNT/1XogaOiF3JSFxqfWUKNzQ86b/ZJflc0pwsG
         SNVvhD8U0+6qCGptSAUFvBve3+4sG+LoPj6E0OcF/gBKe1KR593JmJ6uPF1ItdCzVZ
         v4l/XQNmvw07TbRlKumjRaa0fXcPxE8Zk3YbUjjU6NUwpxKpk36/iXf6Yi8vev+QDd
         xvjfaE90DwTDWgB8EbnX9wq+SpKxkOdlVso0q+a7CieYS+RNSFp6zfx9mBth6qn2Mu
         0rXpflo2KoyML99T4DdivPNfeR/tqoLjqT108H7IS4A7T3pAoKXp9uWRlaj4GccXU/
         zhBsOW/t6//Rw==
Date:   Wed, 23 Mar 2022 16:21:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, ckeepax@opensource.cirrus.com,
        tanureal@opensource.cirrus.com, cy_huang@richtek.com,
        pierre-louis.bossart@linux.intel.com,
        drhodes@opensource.cirrus.com, pbrobinson@gmail.com,
        hdegoede@redhat.com, lukas.bulwahn@gmail.com, ricardw@axis.com
Subject: Re: [PATCH -next] ASoC: tlv320adc3xxx: Fix build error when GPIOLIB
 is not set
Message-ID: <YjtJJvHeslMokYEE@sirena.org.uk>
References: <20220323141737.211198-1-zhongbaisong@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/hNKK5MSDdSwIhvh"
Content-Disposition: inline
In-Reply-To: <20220323141737.211198-1-zhongbaisong@huawei.com>
X-Cookie: Nice guys get sick.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/hNKK5MSDdSwIhvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2022 at 10:17:36PM +0800, Baisong Zhong wrote:

>  config SND_SOC_TLV320ADC3XXX
>  	tristate "Texas Instruments TLV320ADC3001/3101 audio ADC"
> -	depends on I2C
> +	depends on I2C && GPIOLIB

This is bogus, the device clearly doesn't require GPIOs to be useful and
so there shouldn't be a dependency on gpiolib which normally stubs out.
In general for APIs with stubs adding a config dependency is not the right
thing to do.

I suspect it's just a missing header.

--/hNKK5MSDdSwIhvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI7SSUACgkQJNaLcl1U
h9A/QQf9HthQ+od5c57RtcMoI2FTFI050WaVHrS5j+q94FcxpF04tiiy/T6TAcL4
Jdhhuj+9uCiradP0kN2Iir+vdEg0C1/UzlGRnVKOCE3xTD0WlYbXjpj5nkkl1Htn
FwPuRgypVqIQ1ye5ErNQ/78heHPWk4Xb6lKzHlFHQOMusxoaTKyGjhNCPTo7Nkai
exdjk/u5/bz+JMj6jHSzYzPB6zm8pWYeoiKk8FVN/zIEEdmW2hqPR7Uf3rO5BYOQ
1WVs8SSn4pa5GDUvZLEHkBWSEal6UCR8JDPb1cqKy7W+u9voq043IDmLkTyZR42C
mnfZMVSNFHTWMH9/pwStF0BbDM6+5A==
=qPXX
-----END PGP SIGNATURE-----

--/hNKK5MSDdSwIhvh--
