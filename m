Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFA494B03
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359645AbiATJqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:46:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359652AbiATJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:46:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1C5E1F394;
        Thu, 20 Jan 2022 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642671969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=qgmelI2EkTIKnzmErCnW3xXmYOwhrygdh8cWS2AczRw=;
        b=Vkra9RNQexMGXwrcVbwrnMdlwfgehiP0GONhnoSmCXpWlc8e3X4AGY/T5hF39dVEmyDz/7
        wOU0Y+O2KahdlSGZcTOUyiosif2iW/EGUyW7uTROV6g1xHi5M+UwetcRXK9HyUZiJUHNpJ
        eSZIXlKJExulV/iuABheWV/Uxy9qxnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642671969;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=qgmelI2EkTIKnzmErCnW3xXmYOwhrygdh8cWS2AczRw=;
        b=M2ZFCf+IYY3U3SzTWu0DBowFJ/0mGYCmiGbQ6oXZnFMZqmjHhbUbstmetZ9EdS0LJAL8Ix
        k+e2lVEUxd1dFNCg==
Received: from lion.mk-sys.cz (unknown [10.100.200.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D70C3A3C44;
        Thu, 20 Jan 2022 09:46:03 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id AC4A0603B9; Thu, 20 Jan 2022 10:46:06 +0100 (CET)
Date:   Thu, 20 Jan 2022 10:46:06 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: kbuild/cert rework for 5.17 breaks build with empty
 CONFIG_MODULE_SIG_KEY
Message-ID: <20220120094606.2skuyb26yjlnu66q@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zlp7bthohk7hfvou"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zlp7bthohk7hfvou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while testing merge window snapshots, I noticed that after commit
b8c96a6b466c ("certs: simplify $(srctree)/ handling and remove
config_filename macro"), build with

    CONFIG_MODULE_SIG=y
    CONFIG_MODULE_SIG_FORCE=n
    CONFIG_MODULE_SIG_ALL=n
    CONFIG_MODULE_SIG_KEY=""

(as suggested in Documentation/kbuild/reproducible-builds.rst, section
"Module signing") fails to build as make executes scripts/extract-cert
with only one argument (the unquoted empty string has no effect):

  ...
    certs/extract-cert  certs/signing_key.x509
  Usage: extract-cert <source> <dest>
  make[2]: *** [/home/mike/work/git/kernel-upstream/certs/Makefile:78: certs/signing_key.x509] Error 2
  make[1]: *** [/home/mike/work/git/kernel-upstream/Makefile:1831: certs] Error 2
  make[1]: Leaving directory '/srv/ram/kobj'
  make: *** [Makefile:219: __sub-make] Error 2

Should this be considered a bug or is there a different recommended way
to get reproducible builds now?

Michal

--zlp7bthohk7hfvou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmHpL1YACgkQ538sG/LR
dpXP2gf9HThoe4kKpmxYCoAAAJINNR9E2LNPlJgzbu7N47BQwYcS6hh/WDBTBoXg
Rrd6rZiiYWfteekWKbzYs/7UkSk1E8OmMg1PxjxGkjgYPlYvkvumAZcz5bTpAQo/
TwFzwWLhFVDRlT7k/FddbtJriHien79kumsm0lZtr68nra9jF7x8T6zCFrMoPQQU
QZllWyfweF1gIyW4B9VCNtvQtArriban+VhyssVKrmtn/8qwz7MQp16V2/JLIx3n
gwFvTYuNhchnM0f2wBJL6z93CnBfdHyneTTl4GNKceXSQwkLfZwjWdopWCzzDXs8
eSBtBDqnMns5jweRP4XjIzsiLXq7WA==
=MDME
-----END PGP SIGNATURE-----

--zlp7bthohk7hfvou--
