Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDF5A0535
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 02:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiHYAel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHYAej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 20:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71A78E0D9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 17:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C5D4618F4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE545C433C1;
        Thu, 25 Aug 2022 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661387677;
        bh=6rO/XxD//LiN2RORNhJRyZlrqCjCiNFU5ZqLFHkHtNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3p67HJkV0EKVu9Ql4aU6rN4FWSudcUq8hTiKSO6udZF3bH7AGH1nWFY1y5lHwjj3
         EstmZVfWlFeJzSmjMnbbfRCB84S1fglxGWbzlS4gwUTGwjHM0LFuZ+Z5ai2T7N4Wrg
         KTC+WzypNZQc4+CLSsjGf9qJRoEV4R9sUaoodN8sRM4Z2wbesK6dIYkOVTKnxwrSRO
         a91HqRTnBUa9Ov9lf2TDzKl/RPBCbztStS2gbhBAzLUYYXlwG9Yt9vh11j2qoMFMsS
         R5PCjMjwRy7qtEbL9ErJIgzvwxYUVKfu5s/S8vVRR9j2PQDTJotJs03StTU0SXMKUh
         ckM2AOQ1j2ZaQ==
Date:   Thu, 25 Aug 2022 01:34:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Message-ID: <YwbDmKyQxWHfRg97@sirena.org.uk>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-58-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kTHvGW/5bDFz7Zb"
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-58-Liam.Howlett@oracle.com>
X-Cookie: Who is John Galt?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kTHvGW/5bDFz7Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 03:06:30PM +0000, Liam Howlett wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>=20
> Handle overflow checking in count_mm_mlocked_page_nr() differently.

Our QA team found that since next-20220823 we're seeing a couple of test
failures in the check_mmap_options kselftest on arm64 platforms with MTE
that aren't present in mainline:

# # FAIL: mprotect not ignoring clear PROT_MTE property
# not ok 21 Check clear PROT_MTE flags with private mapping, sync error mod=
e and mmap memory
# # FAIL: mprotect not ignoring clear PROT_MTE property
# not ok 22 Check clear PROT_MTE flags with private mapping and sync error =
mode and mmap/mprotect memory

I bisected this using qemu[1] which landed on 4ceb4bca479d41a
("mm/mprotect: use maple tree navigation instead of vma linked list"),
though I'm not 100% sure I trust the specific identification of the
commit I'm pretty confident it's at the very least in this series.  I've
not done any analysis of the failure beyond getting this bisect result.

[1] qemu -smp cpus=3D4 -cpu max -machine virt,gic-version=3D3,mte=3Don

--3kTHvGW/5bDFz7Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMGw5cACgkQJNaLcl1U
h9CETwf+LuiyCa2vnhNkK0FYpnS/7LqL3rzOSWV7goeH7LToVBr2BjbzSjnGlxIO
BJ9L4MP6RC8a/0ss3fPm36g/IwOB/aSaHfsmseWji86aUFb6XonfAKj6qugMsNwe
LWEcjrMSj3RSLXfNfAdI0M0OLBfJ04VkFLrJABQYl48Yrb2QwMQlvgWvwSokHM84
f5QNWnlcvS1o58/QVZhwn7kk/JvFVIrX3Fuiae6L+nLSfEVPCeOwJohjyCZB9+3m
z7YIA89zBRIeVJUpDIGvGKHAX8RovKSrlMWKsW8vhbffjp4c7Td9VYG3wP7GfFAU
t3xQm17IiUShPZga22HlekJlUr+USg==
=DFuJ
-----END PGP SIGNATURE-----

--3kTHvGW/5bDFz7Zb--
