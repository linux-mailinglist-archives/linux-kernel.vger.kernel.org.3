Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8533A512B55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbiD1GUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiD1GUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:20:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F84ECC8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:17:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso38345437b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=u7wndHCcjBCq9MjMJkcDUIkWDGiU0w6bmfVGxnonv/M=;
        b=CU8+6WTyf1pgwQElEqOndsoRs3YaZpcUu6opi0AGd0maXtTGR66G7zc0icaWW+rvmI
         fNakozFmiEMeGyRPID/2ka15r4ZHFybMklZkkHG4zdTdW5QlEu9dHt4h0N5hWI0DLOA5
         0wMkkmUpd8+K/ukZh5NY1svWbqmv8GvukIeuN6F/wOrc8NwfFMRUZZzANhQCk8bBQ+XP
         ByDw5XH4oOMoc91SwKVfBjZwuefrCyfzusxwI1Fhdm3xFHDbM/J6nwyDWtUwqUeBlKn1
         R7DKon5BmObE9FeTpmkMGVfT9azOthpaUEb4/ZFCmnC/Ek5949LbpcLB9jzoqtzndJgt
         +IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=u7wndHCcjBCq9MjMJkcDUIkWDGiU0w6bmfVGxnonv/M=;
        b=XkUmvt2O5Sr4WaqBWHtts7K0OJSSnK2WB6j/z/R5G85McqD7eL4lDWnh6Z0zoR0bdg
         dW6Dfz9PljlQwlMhrF5jHnLY5nX44p7RlI47Rnn8bYjWmU5C3XiBDvkNV4jSquMixc9d
         FL97Tliib521T1imfdOe/U75/+hCYy2xzU5IEjyKAB6eZJUnV7UwW8BShG3fqSa0S1u2
         0Lw7gyNQh6HpKm0foOAzBuLTu2+0itlTk4UAvsZo/BN8oPZzHbBeuUs9rWHJRHPy0oyk
         BRYJxaUWBIMD107lPfmjQEcVxDG5Kx3V8+K4kahxi4wbNl8Y7+OIablkgs3XrnLdAlK1
         XhqA==
X-Gm-Message-State: AOAM532We7Bzy+R14ck4GSuZx9C9Ztd3221Z7mb77rmosmOAm9rhzQnd
        ZR2C7wh/vh3wn5yorJk7PDviH2PUgQ==
X-Google-Smtp-Source: ABdhPJyFLVRpkOEbdtAoedpI4qeWJmLVRCV37Z9hNxVqgKTlw13xrBWkN+DFyXvA81TiAVYfpAcbjp+Bnw==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a25:d55:0:b0:648:7008:61e0 with SMTP id
 82-20020a250d55000000b00648700861e0mr16601052ybn.282.1651126638534; Wed, 27
 Apr 2022 23:17:18 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:17:07 +1000
Message-Id: <20220428061707.768468-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v3] firmware_loader: use kernel credentials when reading firmware
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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

Previously, Android configurations were not setting up the
firmware_class.path command line argument and were relying on the
userspace fallback mechanism. In this case, the security context of the
userspace daemon (i.e. ueventd) was consistently used to read firmware
files. More Android devices are now found to set firmware_class.path
which gives the kernel the opportunity to read the firmware directly
(via kernel_read_file_from_path_initns). In this scenario, the current
process credentials were used, even if unrelated to the loading of the
firmware file.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v3:=20
	- Add call to put_cred to avoid a memory leak. Confirmed that no new
		memory leak occurs on a Pixel 4a.
	- Update commit log.
v2: Add comment

 drivers/base/firmware_loader/main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index 94d1789a233e..406a907a4cae 100644
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
@@ -776,6 +790,9 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 	} else
 		ret =3D assign_fw(fw, device);
=20
+	revert_creds(old_cred);
+	put_cred(kern_cred);
+
  out:
 	if (ret < 0) {
 		fw_abort_batch_reqs(fw);
--=20
2.36.0.464.gb9c8b46e94-goog

