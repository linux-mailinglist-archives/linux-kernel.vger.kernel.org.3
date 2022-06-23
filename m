Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABF5572DA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiFWGIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiFWGHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:07:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0264477F;
        Wed, 22 Jun 2022 23:07:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LT8tN2J1hz4xZj;
        Thu, 23 Jun 2022 16:07:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655964462;
        bh=DIECM9rabt+6+wTd58y+akkzG6KhfGCuRfy6xDMDTaE=;
        h=Date:From:To:Cc:Subject:From;
        b=Vjb8nXaI3FUenZyvhRKP/nNNKBkQWcF1uwuloyaQUJa6x0qf77R9yzI6CfRpRKdlx
         B2gfJyh1isX7i2t+MFMv/1i1j91k1Z6VFcevzHOx94MOzS7mOc0qEoQd6kf7a8CrJO
         dtSMhn26GsNM4By9LqDVhYFwgvdfi0yU4qKB19IGSfiyhPxDx5KUuWpT8nXolAk6hI
         YooH+duggbpBGbu+bPGZvLjOJXNTJG/l2oHExJyzkFUmXJoxoPwCWS2f1fuT5NMEIQ
         Xz1tUUCSNJquSaaVmn+GCSHFzMaZcjSmpoI+6ubp6YNxu/3jMmGFjioQdeYhm8Y2Ke
         Ss9Gkms52m9Vw==
Date:   Thu, 23 Jun 2022 16:07:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>, Greg KH <greg@kroah.com>
Cc:     Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220623160723.7a44b573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WGFqr7wXQvk8d+QUrjBo9mH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WGFqr7wXQvk8d+QUrjBo9mH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/radix-tree.h:12,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:12,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/energy_model.h:7,
                 from include/linux/device.h:16,
                 from include/linux/power_supply.h:15,
                 from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:28:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function 'amdgpu_reset_captu=
re_coredumpm':
include/linux/gfp.h:337:25: error: passing argument 5 of 'dev_coredumpm' ma=
kes pointer from integer without a cast [-Werror=3Dint-conversion]
  337 | #define GFP_KERNEL      (__GFP_RECLAIM | __GFP_IO | __GFP_FS)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                         |
      |                         unsigned int
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4726:55: note: in expansion of m=
acro 'GFP_KERNEL'
 4726 |         dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
      |                                                       ^~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:35:
include/linux/devcoredump.h:59:30: note: expected 'ssize_t (*)(char *, loff=
_t,  size_t,  void *, size_t)' {aka 'long int (*)(char *, long long int,  l=
ong unsigned int,  void *, long unsigned int)'} but argument is of type 'un=
signed int'
   59 |                    ssize_t (*read)(char *buffer, loff_t offset, siz=
e_t count,
      |                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
   60 |                                    void *data, size_t datalen),
      |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4727:23: error: passing argument=
 6 of 'dev_coredumpm' from incompatible pointer type [-Werror=3Dincompatibl=
e-pointer-types]
 4727 |                       amdgpu_devcoredump_read, amdgpu_devcoredump_f=
ree);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
      |                       |
      |                       ssize_t (*)(char *, loff_t,  size_t,  void *,=
 size_t) {aka long int (*)(char *, long long int,  long unsigned int,  void=
 *, long unsigned int)}
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:35:
include/linux/devcoredump.h:61:27: note: expected 'void (*)(void *)' but ar=
gument is of type 'ssize_t (*)(char *, loff_t,  size_t,  void *, size_t)' {=
aka 'long int (*)(char *, long long int,  long unsigned int,  void *, long =
unsigned int)'}
   61 |                    void (*free)(void *data));
      |                    ~~~~~~~^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4726:9: error: too many argument=
s to function 'dev_coredumpm'
 4726 |         dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
      |         ^~~~~~~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:35:
include/linux/devcoredump.h:57:6: note: declared here
   57 | void dev_coredumpm(struct device *dev, struct module *owner,
      |      ^~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  3d8785f6c04a ("drm/amdgpu: adding device coredump support")

interacting with commit

  77515ebaf019 ("devcoredump: remove the useless gfp_t parameter in dev_cor=
edumpv and dev_coredumpm")

from the driver-core tree.

I have applied the following merge resolution patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Jun 2022 15:56:22 +1000
Subject: [PATCH] fix up for "devcoredump: remove the useless gfp_t paramete=
r in dev_coredumpv and dev_coredumpm"

interacting with

  3d8785f6c04a ("drm/amdgpu: adding device coredump support")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f2a4c268ac72..9d6418bb963e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4723,7 +4723,7 @@ static void amdgpu_reset_capture_coredumpm(struct amd=
gpu_device *adev)
 	struct drm_device *dev =3D adev_to_drm(adev);
=20
 	ktime_get_ts64(&adev->reset_time);
-	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
+	dev_coredumpm(dev->dev, THIS_MODULE, adev, 0,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
 }
 #endif
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/WGFqr7wXQvk8d+QUrjBo9mH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK0AxsACgkQAVBC80lX
0GxKKggAph9gBasqfVPiZkSSFWEaS536wSbZ05kPaC3YBGfIU5aJqtrQblXFovlX
zLP+xlYTTghd5gnFIOdcfUuj8dyJoKOdCpO2Qikn6j0ycrhWsPDQ4i3FbwHEbQe5
baN2ld4WbV9WjDJA6aa5qySIBy1aaPRUcCXKdiDJmKHE2w6Zz3HIiqFvkD+i/jDJ
yFPqUJ2hZPk9Fwyi2HkE2xi5N81cq8xuzFWo9isWlLfiOnMna4Uvm2h2vnB9oWxT
92/fYO/x4LPfMGZB4HaDrdlLxoJ07TE1UscVYIZ85e5vNMisTu9wNNm/mXZSRNCY
X0xdpcRbzQpMUbDHtA5SuMmp1u389Q==
=hbFV
-----END PGP SIGNATURE-----

--Sig_/WGFqr7wXQvk8d+QUrjBo9mH--
