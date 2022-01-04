Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3E483AAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiADCpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:45:36 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44599 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiADCpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:45:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JScRd0s4cz4y41;
        Tue,  4 Jan 2022 13:45:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641264334;
        bh=jECdWm5a2bm08cn1xeEt3cseg+eth5mPMHvM+B6Yyks=;
        h=Date:From:To:Cc:Subject:From;
        b=F0BD8TTEcCTjHKJRgEAIW2aoD7Zo+rExfGSrvHEwoR7eXRhCsxJigcivECu+krBZn
         /uSRqKiHq2PrXv4yAvGAac5YfMP94e/DI7xivQd6VCuMeETPSH3rWCJutkhMePoa8N
         31Z9qqEEFOaCFEbH5ZL9pW4Yz0NBq5NGf3WD66r7GZrg2jBN2a/JdNvXmTR10LTNNr
         vixMa7I+VXtaDNBT1pHwhOcVniA6VUNd0GAYF1YRH4XOu/279KLvP7F5ksmN+m8wzj
         CGdKToeMLIIeSwmQYkCYajROseXKMRIv1MAE7tq2W2qGfNd/ffxSpoL5QoqbkMwPN9
         HUU3dQPNbUu+g==
Date:   Tue, 4 Jan 2022 13:45:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20220104134531.6f6ded30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LVpyCBuhysS46Hv+6fagQ62";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LVpyCBuhysS46Hv+6fagQ62
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c

between commit:

  26a7993c93a7 ("net/mlx5: Use first online CPU instead of hard coded CPU")

from Linus' tree and commit:

  7451e9ea8e20 ("net/mlx5: Use irq_set_affinity_and_hint()")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 163e01fe500e,54fb67cec544..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@@ -398,8 -398,8 +398,8 @@@ irq_pool_request_vector(struct mlx5_irq
  	cpumask_copy(irq->mask, affinity);
  	if (!irq_pool_is_sf_pool(pool) && !pool->xa_num_irqs.max &&
  	    cpumask_empty(irq->mask))
 -		cpumask_set_cpu(0, irq->mask);
 +		cpumask_set_cpu(cpumask_first(cpu_online_mask), irq->mask);
- 	irq_set_affinity_hint(irq->irqn, irq->mask);
+ 	irq_set_affinity_and_hint(irq->irqn, irq->mask);
  unlock:
  	mutex_unlock(&pool->lock);
  	return irq;

--Sig_/LVpyCBuhysS46Hv+6fagQ62
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTtMsACgkQAVBC80lX
0Gw+kwf9E7bT47f2dejb/SXw3fEwv9dgmt+DbZm2ziRredG/RLH6C7soNQxl2bkr
XXR1cmVg6HCm0kh0s5hxVu81HiQ46SSHK6o0Dbz8OrDQ9ATYuRENK5H3g9X3qZFU
HBAF18DAWcGOG00hwMqqHbG1Pm2ftSZ+Gs50XDdQi2sMFUVLef8ZKm+XjqEOhh9h
q8TovKpMonmM/ez9GwB30hD7wY46VigNqtFjfIEf1X7WQ+FuqZDS57ynAD86OliL
BzT9pnRDakaUPi8lSSykYTWzZZJpEgu2bSAdKjoCfBcqZBOv0Xr3cJ+yItzKeNS4
M21iH6ZPmGhC2VQ9XggCmTUh4SrZXQ==
=39wO
-----END PGP SIGNATURE-----

--Sig_/LVpyCBuhysS46Hv+6fagQ62--
