Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E357653E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiGOQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiGOQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C6564CA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264D7621E3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F61C34115;
        Fri, 15 Jul 2022 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657902508;
        bh=BgkSm8ui6rjbUv6iNSa5punER/Qz+CqOKXdmy3/Q5Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bS63rWU0NNEq8GgAhPoUTIF4TaSeMLUPtMXX4Q5TcPwIwpcfjJnoGXbTIRH9dvpDo
         ONX1Mi6klhF31IXgT2IpZ4syjjBi5aB2NTgRoLHOEIOd4Pim4WkoEWED70jBBmuPT5
         D860o6Ehy0W6StTs7IzaqiUb/y4AEuHEu4h3Nlaj1DrxKPWeoyin6uZT/kE9nv4Ygs
         etDSueGf5tmYiDu5O3C8byoBKkZrFzy6YGs+YScWCxpW88h/5j8rzeUKMoUZuZgokl
         bdiYOr27R1isPI28rh9Jrn/PBTZmLLkL3WJT2IJBKhJea+gpOXmumgYlbwkWWwdXD6
         0MC7+081vYyzA==
Date:   Fri, 15 Jul 2022 17:28:19 +0100
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
Subject: Re: [PATCH v4 02/18] arm64: stacktrace: Factor out
 on_accessible_stack_common()
Message-ID: <YtGVo8yNHmwdAvnC@sirena.org.uk>
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-3-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jo+NRiUeE5EvKTfv"
Content-Disposition: inline
In-Reply-To: <20220715061027.1612149-3-kaleshsingh@google.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jo+NRiUeE5EvKTfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 11:10:11PM -0700, Kalesh Singh wrote:

> @@ -56,7 +56,6 @@ static inline bool on_overflow_stack(unsigned long sp, =
unsigned long size,
>  			struct stack_info *info) { return false; }
>  #endif
> =20
> -
>  /*
>   * We can only safely access per-cpu stacks from current in a non-preemp=
tible
>   * context.

Random perfectly fine but unrelated whitespace change here.  Otherwise

Reviewed-by: Mark Brown <broonie@kernel.org>

--jo+NRiUeE5EvKTfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRlaMACgkQJNaLcl1U
h9CDzQf9EKWHL6a0nLbiAdh1O+G742JT9aXWLoDUXGo6+8nJQIAum9G4ur5zJ8KK
iUdKSLtS+9JOT0VxYqKyDN3wIcTeGSJTFDtVwJcHPZG3gxHHOlC4ab6I2e7jJyVO
4qK2hnz477HSGecXoIvLTKj6odbzX7u5kgkH7BaAJ7HkB3Mqjw4lK0PpmuC9B79T
93RlV4yaoo9muDvYXxQJLFCLcSZo9zQhBxZj22jujagqeeQnhMWvHPEt5Nyicqcu
8S4NQvuCihHUr7azWql8GmkQIwZK7TDG+NjR0qv4Hu6aMqW374I6fm78A8dG3+i5
Gk8IemJTPZfQeZ6AKfuDq1emsbl4BA==
=E0Ab
-----END PGP SIGNATURE-----

--jo+NRiUeE5EvKTfv--
