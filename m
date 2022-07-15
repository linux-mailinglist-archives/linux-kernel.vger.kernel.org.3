Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD35761D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiGOMhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGOMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:37:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C9170985
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE8F0B82B4B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D6C34115;
        Fri, 15 Jul 2022 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657888633;
        bh=nAEOH0Vx7WLWFiSQ+URXsr8ICrc+WJkk0tMki0ehFdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxHS+//ProyW3VmElxOlZxXusWlbOSps2YzEaKxCP0/tPcyq74VALg3YU8raJpoxD
         dBNgx0wY5nGjX0e+oTsvzjrcoJ6DNcdI3d78nsvPKGXnK+0ezB/ayE9T/1i/VL2uOU
         TouEjWC1koOjT/VsqFH1ZinWTF8sxdKU592mowGzWf+MVkjn8GzsfQXZs0Kl8fQk9Q
         +evfkfVqsztQSZxY+jbYVJs/Qns1R7uiXT5mZHduk/rMrYnEGf0Q1PapR9/21VV8c7
         cK++XF02i0MOE97a4PIvQvn3n9tzojtRc3f+6UkV+/pwZ9gxWCqN3L8l8GT9MZbcmg
         SLpfhtbKj0/sA==
Date:   Fri, 15 Jul 2022 13:37:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, madvenka@linux.microsoft.com,
        will@kernel.org, qperret@google.com, tabba@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
Subject: Re: [PATCH v4 01/18] arm64: stacktrace: Add shared header for common
 stack unwinding code
Message-ID: <YtFfcLD4Gj9xFk2B@sirena.org.uk>
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2+hyWNvuSRJtqBHc"
Content-Disposition: inline
In-Reply-To: <20220715061027.1612149-2-kaleshsingh@google.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2+hyWNvuSRJtqBHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 11:10:10PM -0700, Kalesh Singh wrote:
> In order to reuse the arm64 stack unwinding logic for the nVHE
> hypervisor stack, move the common code to a shared header
> (arch/arm64/include/asm/stacktrace/common.h).
>=20
> The nVHE hypervisor cannot safely link against kernel code, so we
> make use of the shared header to avoid duplicated logic later in
> this series.

Reviewed-by: Mark Brown <broonie@kernel.org>

--2+hyWNvuSRJtqBHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRX3AACgkQJNaLcl1U
h9BVZQf9Gh9p8FOQCvidAwUkm4bCEP9LkLi2Gz/z9ntsnTSvkw2yP2NjlxWBBNY+
U6N+yQtcjQBz1taXq3g+d6mcxkSGHAhKMd4OvF/VqBUUX4vf5oaYHmsfvKukOu9Z
ZUHQAE/o/cYg0kAvwcMjlG55m82YtkRkdc6VgdZQSbvmauSFRIhamDv+Fizlubab
eWoO1h5asWZKw6c/ih0jTHIxvNKsf4CmIj407zUnIlC2Z8psya13VuXLWTOBEvfT
K2ECgj2yxg9HNtNxMpTDBQqMGO6zEjASSh6Cmuga9xgsFFFp04YWXg2a+EzBz+wS
Sm5qFShdBLDGtU0YgbhW2DXzTLEV5w==
=54bK
-----END PGP SIGNATURE-----

--2+hyWNvuSRJtqBHc--
