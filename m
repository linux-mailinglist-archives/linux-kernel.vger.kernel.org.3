Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1839F52B252
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiERGbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiERGau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90612DFF49
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652855447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HiUpgPTTlKwXv4we5H4dCAID8KOjBHxi0Xtt24lk5jI=;
        b=gCsHJ7NndDTq3S/1d08gvXS7/f26u1OZae55U4+tKOZk/cUE830XQzmkeBZn+cwygdqQOO
        cQnmKgr1rAYk+GzmpxX6XfHaCTr7IAwNPdq6/Ap6NNyMqxFJ/koEMWj30aY0PRdIddnvw2
        asO63bqc3EgI/nzK5JObFFKB4/O0nFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-guaH5da3M3KxDG2S8TfNzQ-1; Wed, 18 May 2022 02:30:42 -0400
X-MC-Unique: guaH5da3M3KxDG2S8TfNzQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 472348032EA;
        Wed, 18 May 2022 06:30:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D72E6492C3B;
        Wed, 18 May 2022 06:30:41 +0000 (UTC)
Date:   Wed, 18 May 2022 07:30:40 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Kirill Tkhai <kirill.tkhai@openvz.org>
Cc:     qemu-devel@nongnu.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        hreitz@redhat.com, Xie Yongji <xieyongji@bytedance.com>,
        sgarzare@redhat.com
Subject: Attaching qcow2 images to containers
Message-ID: <YoSSkOQaGL0sBNOI@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VxVmuJGtHcUMbdkL"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VxVmuJGtHcUMbdkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kirill,
I saw your "[PATCH 0/4] dm: Introduce dm-qcow2 driver to attach QCOW2
files as block device" patch series:
https://lore.kernel.org/linux-kernel/YkME5ZS2CpXuNmN6@infradead.org/T/

There has been recent work in vDPA (VIRTIO Data Path Acceleration) to
achieve similar functionality. The qemu-storage-daemon VDUSE export
attaches a virtio-blk device to the host kernel and QEMU's qcow2
implementation can be used:
https://patchew.org/QEMU/20220504074051.90-1-xieyongji@bytedance.com/

A container can then access this virtio-blk device (/dev/vda). Note that
the virtio-blk device is implemented in software using vDPA/VDUSE, there
is no virtio-pci device.

As a quick comparison with a dm-qcow2 target, this approach keeps the
qcow2 code in QEMU userspace and can take advantage of QEMU block layer
features (storage migration/mirroring/backup, snapshots, etc). On the
other hand, it's likely to be more heavyweight because bounce buffers
are required in VDUSE for security reasons, there is a separate
userspace process involved, and there's the virtio_blk.ko driver and an
emulated virtio-blk device involved.

Another similar feature that was recently added to QEMU is the
qemu-storage-daemon FUSE export:

  $ qemu-storage-daemon \
        --blockdev file,filename=test.img,node-name=drive0 \
	--export fuse,node-name=drive0,id=fuse0,mountpoint=/tmp/foo
  $ ls -alF /tmp/foo
  -r--------. 1 me me 10737418240 May 18 07:22 /tmp/foo

This exports a disk image as a file via FUSE. Programs can access it
like a regular file and qemu-storage-daemon will do the qcow2 I/O on the
underlying file.

I wanted to mention these options for exposing qcow2 disk images to
processes/containers on the host. Depending on your use cases they might
be interesting. Performance comparisons against VDUSE and FUSE exports
would be interesting since these new approaches seem to be replacing
qemu-nbd.

Can you share more about your use cases for the dm-qcow2 target? It
could be useful for everyone I've CCed to be aware of various efforts in
this area.

Thanks,
Stefan

--VxVmuJGtHcUMbdkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmKEkpAACgkQnKSrs4Gr
c8hBOggAjwLYdNLqHIo1rQgUfb93kau+ER5YddjUvSxG65CLZGYWeB86JOUfT+rR
hVi2bBGX1OkL1a66tWLK2Tcbakc6XfQXQ6JCbzJUoKCTI9gIA9i3ztjqrQEzoagn
liMWkk89XmdrLE8gsA7MOKHdFELKRiFds8JKU0Pny/VDJkOlYO/6gcqCw5fcXkrv
58PTohwKlOgOVdQ1wzlkFGRtTPtc5/JeFzJOIUs4i+GnqtjubKl4VfbjRiAoqTEj
uOO5gsJ9mdTHyWd1lugxiSqttqVVZZb6VEQvsnZUwFUoNkB/KHoILTcMWd9GWRn0
HNO2R2xD/zhG2j+x7dw6n7RBczgUdw==
=Wa4Q
-----END PGP SIGNATURE-----

--VxVmuJGtHcUMbdkL--

