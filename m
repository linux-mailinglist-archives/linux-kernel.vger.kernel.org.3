Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1637950AD3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443100AbiDVBfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiDVBfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:35:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3EE49CA5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:32:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a5b0b46000000b006457d921729so2019023ybr.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=eQsf5nicRRkooM+lPXT1i7kU80hx8qfA2QKyrV7j43E=;
        b=H0TY2pwXZRgytNxh3KspS7rSXdUAuP00gjDwEB+/SKqhgFjUBskIUUXjQbQrNKOGNz
         phnFArg4RdKRUgLkURBkzIeV2JOr/h+u7nPZ+KL6T5+qd8y3GXWzRh+TWJWcreEtXGYz
         P/+lqJIKmZxxpWanOz1F1onAfVWxGeCCo2dHh88l3d3q8SVY07u/kJWxyccDWYVrgM+J
         kNh81ABIVV2VBHOpm7o00Y0kq86ENBu9KaqwLITWH4Ho5b2PoH+cQ0i9ot2ldqZcFai2
         RVYdyK4whDEPxGP4xXceor9QkTiO998n2P/as90CU3w0cjJvHddlpfYBKxweeMeTaclr
         63YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=eQsf5nicRRkooM+lPXT1i7kU80hx8qfA2QKyrV7j43E=;
        b=whVjaWYtow9dCvXfolXR0/1XhOwzzCxXR1onV0yqBSdtuRRTxoEiLJQRriYmUr5Mag
         FwENBP5ZJ3F9dtSlzIRo3XIgPemcvgYlR1otitKVZfaRsC9V+pzQBNsnVAi7kM+657jQ
         U/8UvgZ4zz2p8LGKrW4rwov3B/D+UKUb0nE5cvkUbR0gy4gAD6hvTj2nVi+10E6EtjUV
         gkOwNL2DUlSDsDYpa0rOzkuvqOKxKJAkLY7arZNpPA7L9l2/PSJTzhHzvl7rJt0NpvSI
         uKdumLe8sWG8oy3HndN0N3DO5nNWHXAHC5VyloqE9lyZw2sEXmhDyCM1xjVQYiI/v1sJ
         /u+A==
X-Gm-Message-State: AOAM5328s93z+twO1MbQ/zboQKgRe4R/7p2sT14hVbwpCUaEL2Orna0+
        rh9QxA0QsCvJ9Y4Ae+b0DRdBfczI5w==
X-Google-Smtp-Source: ABdhPJzAd9VmD7psH97oeNGynxoYxQ224gs9qO/ix+P/PSWQya4fbwYFqBTmyc1V0j9TkylV6BY2XSlLMg==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a81:d551:0:b0:2f4:e3c9:c0e1 with SMTP id
 l17-20020a81d551000000b002f4e3c9c0e1mr2458358ywj.125.1650591147043; Thu, 21
 Apr 2022 18:32:27 -0700 (PDT)
Date:   Fri, 22 Apr 2022 11:32:15 +1000
Message-Id: <20220422013215.2301793-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2] firmware_loader: use kernel credentials when reading firmware
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device drivers may decide to not load firmware when probed to avoid
slowing down the boot process should the firmware filesystem not be
available yet. In this case, the firmware loading request may be done
when a device file associated with the driver is first accessed. The
credentials of the userspace process accessing the device file may be
used to validate access to the firmware files requested by the driver.
Ensure that the kernel assumes the responsibility of reading the
firmware.

This was observed on Android for a graphic driver loading their firmware
when the device file (e.g. /dev/mali0) was first opened by userspace
(i.e. surfaceflinger). The security context of surfaceflinger was used
to validate the access to the firmware file (e.g.
/vendor/firmware/mali.bin).

Because previous configurations were relying on the userspace fallback
mechanism, the security context of the userspace daemon (i.e. ueventd)
was consistently used to read firmware files. More devices are found to
use the command line argument firmware_class.path which gives the kernel
the opportunity to read the firmware directly, hence surfacing this
misattribution.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2: Add comment

 drivers/base/firmware_loader/main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index 94d1789a233e..8f3c2b2cfc61 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -735,6 +735,8 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 		  size_t offset, u32 opt_flags)
 {
 	struct firmware *fw =3D NULL;
+	struct cred *kern_cred =3D NULL;
+	const struct cred *old_cred;
 	bool nondirect =3D false;
 	int ret;
=20
@@ -751,6 +753,18 @@ _request_firmware(const struct firmware **firmware_p, =
const char *name,
 	if (ret <=3D 0) /* error or already assigned */
 		goto out;
=20
+	/*
+	 * We are about to try to access the firmware file. Because we may have b=
een
+	 * called by a driver when serving an unrelated request from userland, we=
 use
+	 * the kernel credentials to read the file.
+	 */
+	kern_cred =3D prepare_kernel_cred(NULL);
+	if (!kern_cred) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	old_cred =3D override_creds(kern_cred);
+
 	ret =3D fw_get_filesystem_firmware(device, fw->priv, "", NULL);
=20
 	/* Only full reads can support decompression, platform, and sysfs. */
@@ -776,6 +790,8 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 	} else
 		ret =3D assign_fw(fw, device);
=20
+	revert_creds(old_cred);
+
  out:
 	if (ret < 0) {
 		fw_abort_batch_reqs(fw);
--=20
2.36.0.rc2.479.g8af0fa9b8e-goog

