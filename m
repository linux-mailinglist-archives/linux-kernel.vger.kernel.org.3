Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4A58ED98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiHJNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiHJNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883D26F1;
        Wed, 10 Aug 2022 06:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F242B81C83;
        Wed, 10 Aug 2022 13:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D7FC433D6;
        Wed, 10 Aug 2022 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660139411;
        bh=HFiCWY24vHA6gAIoM9LvCikWbleOBSOBbAj6d3rUP6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0V5q/3XLp3BlxT3sMvY0Nc5le1bNxYgptk8qWoS8vuvyMm0UavEC+sfNYN4gHB4B
         j4uWhFsNwWbmERxOJzMP46L+UYglTGBTKfkexfnXPyTNZg4ZQWDanapJdMz/qemqZp
         n+bZU1bSbKhMaZJVQ37Rec88JqhJ6xdMOYhzy6B7oQsEElCBQWwJkOiAnWOP3UmvT4
         AJSlJaOOCG6/pz5BqGOZ8/YuK/k78qOGa28JZcg5EALy0ZmUsbc1Imd4vlc9rQ/2UN
         aBz5J88Ze4p8C8LSnIgKxM8GZ+KKeBKuBi6jsT5QC73qWpCjtN2noJ7kmyBvfd4dCc
         zgXnN8TPiLnwg==
Date:   Wed, 10 Aug 2022 14:50:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Simplify clk_get()
 usage
Message-ID: <YvO3ip3LPw2QhADB@sirena.org.uk>
References: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8f7/N4iM6yxDc5OG"
Content-Disposition: inline
In-Reply-To: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8f7/N4iM6yxDc5OG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 07, 2022 at 10:18:54PM +0200, Christophe JAILLET wrote:
> If clk_get() returns -ENOENT, there is no need to defer the driver, -ENOENT
> will be returned the same for each retries.
> So, return the error code directly instead of -EPROBE_DEFER.

Are you *sure* that this is the case on Intel platforms where we don't
have a full firmware description for clocks and therefore can't identify
cases where we expect a clock to at some point to become available.

--8f7/N4iM6yxDc5OG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzt4kACgkQJNaLcl1U
h9CnPAf+JlNwgdYGY4MFDqefm1yqyuquLmEMVZPRqXlVvL9fv6ZEmm0uO+qzFLxo
dtb3FM4z4O+JKX4LZyWC1h+PpOVDJuAvLZlSRlgGg69J/tUxlRSFNgdVgPIlOSYg
COvC+whBTH2YI1fQ0lxMQznUs+HJ2OEAU4we794TmenrkSf+xiExyWu8XQ/4ncwi
LmUdCP1+uvy1qz5b+NJx+EizRT3ywpk1qvjIcInGVA1ztx1Fh4EXz5OXNQFUqGK4
5sx0ixFWxjuuS0mZvDJHFW8mZpiMkhf10lE8HfhIrrDA07beSZKcPRSVsAnFPyKK
PT7th+4gOUAw7tgszFTRTLj1r3XADA==
=rC/L
-----END PGP SIGNATURE-----

--8f7/N4iM6yxDc5OG--
