Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915344E537D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiCWNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244477AbiCWNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A14E013EA3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648043171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2ArAPXvrv/TTXw/O+6dULKaF/VEo7lLXu9ib9rAig8=;
        b=W1vfZgOOh1gVfjv72Bachv283YjdRNe//c8ObNeCqBSS7N/zN+638wT7Dc5FhYm34G2OQc
        YvX3pVYRy1IgLje8UurtA3LGtDhWLkhUJQU84af3v+JvoUEZT+D/LeAqUyGVdbonLxlKvm
        FmBslAEGtIE1LKS/89c8jXVRH6/8TDM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-8o8tsRP4MC2v1RG4MwKmcg-1; Wed, 23 Mar 2022 09:46:08 -0400
X-MC-Unique: 8o8tsRP4MC2v1RG4MwKmcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 738921066543;
        Wed, 23 Mar 2022 13:46:07 +0000 (UTC)
Received: from localhost (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16012778A;
        Wed, 23 Mar 2022 13:45:47 +0000 (UTC)
Date:   Wed, 23 Mar 2022 13:45:47 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 3/3] vsock/virtio: read the negotiated features
 before using VQs
Message-ID: <Yjski+9n4i2yO6Y7@stefanha-x1.localdomain>
References: <20220323084954.11769-1-sgarzare@redhat.com>
 <20220323084954.11769-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ESZNlMKuoNvVk3FN"
Content-Disposition: inline
In-Reply-To: <20220323084954.11769-4-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ESZNlMKuoNvVk3FN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2022 at 09:49:54AM +0100, Stefano Garzarella wrote:
> Complete the driver configuration, reading the negotiated features,
> before using the VQs and tell the device that the driver is ready in
> the virtio_vsock_probe().
>=20
> Fixes: 53efbba12cc7 ("virtio/vsock: enable SEQPACKET for transport")
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ESZNlMKuoNvVk3FN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmI7JIoACgkQnKSrs4Gr
c8gQjQf3XP5ygWafG+PULHBzIbODxXHMVdsbdByn8Vs7iFXLFZgffOrT6fOd00fy
x+bBG0sfrh6i4ziAVbttjUElrWbypPpAq3dHdq+SATGbffeICKTG7lpbJD1jtNAl
jS0al9PKbdCSwFoGjincI7vjn2lPclN7kxpftZq3LfZVTbSfSektQVPmTMYvx9gI
LjKsZxB/3iNdfO+xgR1P0fd0tBbDW6VT3PURtkRh6itzvz38d26oO98YcfIStE8T
aUZv2Zjsh/96htGWRHd+QAP0KlKXVtDPpNPQ7yrXsZJDTGhkeAmlmb4ZzCVIjIe2
SZzyEJ1EhRIV0re1X49ARKqQ8hM0
=O+3Q
-----END PGP SIGNATURE-----

--ESZNlMKuoNvVk3FN--

