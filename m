Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB9516915
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356427AbiEBAyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379420AbiEBAxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:53:50 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83811115A
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:50:22 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id bj12-20020a056a02018c00b003a9eebaad34so6223510pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 17:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FOMU61QtLNIhCcO443IaAbPythoovtkrDMR8bH0Vhu8=;
        b=H/HLblGgD5zGZse8AT1acfVSeM49QjDg79wsGCl7L9/XBqXSNg3gxiHjZgEG6HpQ8q
         aLNKL7jPld9jWS5findWpdmJJfvyxQ8xz6bEgteN1jSTAbP2tOpaFN+Hc+1xSAPtUztJ
         wrA75uF5O0XKkM1LYMsmUUkvXmbZRRU5b/1UWvKM1ZuiE8DAc2PuhbTXRbgoTmzKq8lY
         H39d6lX/9SnLCKOlxd+IrkhPKOkaD1UZWZuov5ADI/UqKCsHZvyTBMuxWWjDrfWJ9x0k
         4oJOWcjxbsxuTi5hBNDLfd2BDE1U7eVN03avaJjXaJAEtdpIonXWl4+A2QlaUt/64b/+
         ZR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=FOMU61QtLNIhCcO443IaAbPythoovtkrDMR8bH0Vhu8=;
        b=GjNOlhxSp+XhUR0y0t8pxZjhZNdd+/rL2Q9+u7P5qdbOMKKCmu/kqSCPyCoVfu8Flp
         wz76wN3ZGfO1dD8m5NxxLnWTTNqD9NHQAddcexjxAB2XHTZDTrxPFIdwcCTcfi+EpacD
         VSWtxxSccAX7xuQJm6Xoc39DTtNETb8wynJWPvqbfVRF3N9piLVn9iqPwN8QitQn7tiP
         Z+vBi1O43bXcSx6VzDGbrOy1YvoxJV1rIFZiwn5vCON0XscbijhQ/ziUCMm6BlIObsTJ
         KJROxlMN9Ae025bJok3K1mELYblpmNn9J2xdF5eL1MlS6IQa3xTAqhPyinMtgBTXR1/6
         2JNw==
X-Gm-Message-State: AOAM530sn3xIPTB1IV94/wosICEdJuOiVBM8vdjOrt5h145bSodkFT77
        qJaYacSSAUSB1rZHWSqzlsSlOcLG/g==
X-Google-Smtp-Source: ABdhPJwSd2rb9tf3DwgKCKN7b010akS/OEJ9N3Mh3m5C9KDQB9QenIfe6km5KgRs4wnXspScktDrWXynGg==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a17:902:f28b:b0:15c:5c21:dc15 with SMTP id
 k11-20020a170902f28b00b0015c5c21dc15mr9690735plc.16.1651452621491; Sun, 01
 May 2022 17:50:21 -0700 (PDT)
Date:   Mon,  2 May 2022 10:49:52 +1000
Message-Id: <20220502004952.3970800-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4] firmware_loader: use kernel credentials when reading firmware
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        John Stultz <jstultz@google.com>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: <stable@vger.kernel.org> # 5.10
---
v4: Add stable to Cc
v3:
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

