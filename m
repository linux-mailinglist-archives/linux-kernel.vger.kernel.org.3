Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40758C902
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbiHHNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243148AbiHHNHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:07:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC02617C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B06C3611DB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E7CC433D6;
        Mon,  8 Aug 2022 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659964039;
        bh=hiOm/4dlW+XBFQjdCIXR+EH/EX4Yp7/TtZZMg5vLPHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce40M3WhkaOmuLBQ/YQQCBIloUAEOTeU6Ni7AgCjDXXkctYRKiijN5TVZRcJm3Xbz
         vdLQKNhsktfO3XfkO6OFIeYZlsg56TDMQOnbhT7jaC7Wh83DGyjLZzSUOXVLXnSlth
         CqV/5i/NMaNjZ12tFEGN47/EAVzyUqSQWpf8MX5T3V9m17zr+CcnsNBhiBneZe8bSR
         3/JCNmln01eZptk7mhAFPD57P6ezaMWtxiQfSRsMtgsYL+gtA4gOd/PeZfn1AbBxVN
         FRL7b/g1gxDdmuEeD/C+ON1f5BgDY7zPtMcIRBB1tdCrMFTYte4XDAVJ9t1N8Vprsv
         iZNlTZ8FoQVvQ==
Date:   Mon, 8 Aug 2022 14:07:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
Message-ID: <YvEKgkhRWCKtXdD4@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A2erhOPr7Nn4VMFi"
Content-Disposition: inline
In-Reply-To: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Are we running light with overbyte?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A2erhOPr7Nn4VMFi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2022 at 11:53:17PM +0300, Andy Shevchenko wrote:
> The commit eb4a219d19fd ("regmap: Skip clk_put for attached clocks when
> freeing context") oexcluded clk_put() call on regmap freeing. But the
> same is needed for clk_unprepare() since the regmap MMIO users should
> call regmap_mmio_detach_clk() which does unprepare the clock. Update
> the code accordingly, so neither clk_put() nor clk_unprepare() would
> be called for the attached clock.

regmap_mmio_attach_clk() prepares the clock that's passed in, we should
undo that when detaching otherwise we're leaking a prepare (as we do in
the explicit detach).

--A2erhOPr7Nn4VMFi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxCoIACgkQJNaLcl1U
h9CvSwf/Qv3iitGv9EmdB0qKYwzEDy202Tge7l+lsrA4FZOETyRY1VXNMvrdPDXo
ByM7ms+IuiwZeBnTC0ccK4Esu1se1vttawYi4XzUz47amGnAJdJCjstM75/MKgbX
kRTE3BUBw7sMJJIsPCv02WsVGnTDWEudD+iF024/1Cg0tC4FuIVoQ4U/O88EHA95
AXAbeX75MlJhxF/ux2CfLrepPzVgnlkXbDKfVCoA38ctyF/jm1RnnrCiqpjpSMhv
xvi11gqHixl79EJR2PWR0/49BK0opVo7500QxBSn0H+YHM8JIahbP8/YIKtoDfpJ
KwiZtKujCvwvZAhNw4t7dfku6Uzmkg==
=A+Is
-----END PGP SIGNATURE-----

--A2erhOPr7Nn4VMFi--
