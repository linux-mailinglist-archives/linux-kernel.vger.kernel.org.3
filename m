Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F73514A79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359778AbiD2N2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245140AbiD2N2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2DC867E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702F96226B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F392C385A7;
        Fri, 29 Apr 2022 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651238686;
        bh=9+eEncYlwkaV6r7GtViKcetUKKSK0ecyfUig/hEuNnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pd8vtQRrdIPSpq1EqtjnJq0eFGUCemeJ8qRCc6/mp1U4semEJtdCm+6dxfmJgfSZE
         8u7QiQi9R1yTxU0m4zWQzNZjprqJigsVkbBRrny13IoxZt/oHP8cQ3H55LiEkdZY5m
         LNLh9sa4jUjgqVAcIQ1pHpNwq76ytrX+aLafrTUyJhRdL7lpMAqwrdBcKd3s22xHn2
         /l1M6zW3wVAhafuQwVIWzyd+pDd7ipu4LClnblpstPSt13CEIwENngNKl0mUFg9adD
         pMcM97FQ48W7QNV/QV5j6IbeHpKDLMuyhivJgo7g+LxfszKPs1wjSS+zUpUc/Nu8j+
         2Eg0ccvi2Z2HA==
Date:   Fri, 29 Apr 2022 14:24:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: arm64: Unwind and dump nVHE hypervisor
 stacktrace
Message-ID: <YmvnFuAIBjQxQfqM@sirena.org.uk>
References: <20220427184716.1949239-1-kaleshsingh@google.com>
 <20220427184716.1949239-5-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KmavymclFYg5AbyJ"
Content-Disposition: inline
In-Reply-To: <20220427184716.1949239-5-kaleshsingh@google.com>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KmavymclFYg5AbyJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 11:46:59AM -0700, Kalesh Singh wrote:
> On hyp_panic(), the hypervisor dumps the addresses for its stacktrace
> entries to a page shared with the host. The host then symbolizes and
> prints the hyp stacktrace before panicking itself.
>=20
> Example stacktrace:
>=20
> [  122.051187] kvm [380]: Invalid host exception to nVHE hyp!
> [  122.052467] kvm [380]: nVHE HYP call trace:
> [  122.052814] kvm [380]: [<ffff800008f5b550>] __kvm_nvhe___pkvm_vcpu_ini=
t_traps+0x1f0/0x1f0
> [  122.053865] kvm [380]: [<ffff800008f560f0>] __kvm_nvhe_hyp_panic+0x130=
/0x1c0
> [  122.054367] kvm [380]: [<ffff800008f56190>] __kvm_nvhe___kvm_vcpu_run+=
0x10/0x10
> [  122.054878] kvm [380]: [<ffff800008f57a40>] __kvm_nvhe_handle___kvm_vc=
pu_run+0x30/0x50
> [  122.055412] kvm [380]: [<ffff800008f57d2c>] __kvm_nvhe_handle_trap+0xb=
c/0x160
> [  122.055911] kvm [380]: [<ffff800008f56864>] __kvm_nvhe___host_exit+0x6=
4/0x64
> [  122.056417] kvm [380]: ---- end of nVHE HYP call trace ----

This will be really helpful!

Reviewed-by: Mark Brown <broonie@kernel.org>

--KmavymclFYg5AbyJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJr5xYACgkQJNaLcl1U
h9AKIwf+L8bCCODKWgL1wYrEellpME7cjpfW7uY6BxNZBEZJ6V+CuQxbHx7shY1D
qc/lcT1/R3JS7INc3mLr0Nw1K5UxC3jHXujCFw0LezQtuC5243YayR1J+v20WtHu
dia7rJkm6qSPMBbfkJ0IFAn2jCioXZJjeEUld6Q601dktI5CgD0P3gWdm7SoZ/SB
ORt2nNPMVhH571i+HBAeVN5lkk5Y7d8XnlNkqGsnhDiMhZPkg1qrgvcFivsu9HOW
ub+n9WLPOLK0PrZhttDvYnOCiUhNsFI6k3wfujbF0ulDN7GO7giLr6z9dVTq+HFg
G4mI/GfeiPZigTdZ3Uz6dGuiirqvTg==
=x5xf
-----END PGP SIGNATURE-----

--KmavymclFYg5AbyJ--
