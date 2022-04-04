Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF054F0F18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 07:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbiDDFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbiDDFsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 01:48:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE49326D3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 22:46:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i16-20020a170902cf1000b001540b6a09e3so2966466plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 22:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=7OKq+V4z+/z7bE/KfbCOq7/YDmk7SsCN1GtNgHHkIig=;
        b=AtyjSLuY+l6HPOeH/KuqQffpRiID3JGX0i/TDY0yvoxMAh9n2YwfYGd9O+mOSnlRhk
         wyw8XpPe5n77k93t2vlcShIfIRTk6NfQ/f26eDb+3fmcewm90TZ5wsj8MgM7D+r6OB/F
         RhdRW4G1C0rNDW+P/X+mYSmJzTShZF/pB+RG89EpnKdDJMCKOkcJPT8P8RM8JOQO7lal
         FwGk9ljHm6NCwphOHqNhXUC+4FHRTQIN7r1S0p6XEJDiQGV0md6FRDq+GvdLUiZnWu54
         4CNWEQ6SXJ1wNRvmuvGMEKxGt6Hwzi84hpiFjjFQ7RCcd7sc1DJZeuov4Yq3ipbJTPtq
         oYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=7OKq+V4z+/z7bE/KfbCOq7/YDmk7SsCN1GtNgHHkIig=;
        b=tiWah8JPOXWFdbbsY5HrO+y4aaLQvvvrcjNaY8QLTb3ZTFrLa7m0A/ZIqAC4K5HwQG
         CYIGie9lM7slCAMXCVAJat4g/mAtJtLaYPUKdFu+BRVfjEyCRAFLfYgDy4CLkOxz/bIZ
         rnJIvlecDctiFIHiN+o12Zrf7PKefnodBZmHy0wcHOeueTCkI5aReiZAIvnxadh3GAF0
         WHPatdJlRzxr+dThZQs9E24oRNAt7hQm2BAaw7znYsUMWGHeZW02oNKm8OFI4Fn+1hyk
         xvb5zqHi+0kcSWSEUlGRgK6NJBDKA3Jgt0npWh8IoUM3SoJsRU8wgs/VRWltTJ64JQQ1
         VDvw==
X-Gm-Message-State: AOAM531ruOljLROFkjd9TrEZmzPiC3TbQ9IUmERi49pNMLQIipL8s7W4
        BnM3N+VhqpFDFg8ihuXhWTRn0ddz8Q==
X-Google-Smtp-Source: ABdhPJyDkBXV2hdGWgExw6NUIdWYovinEwjXG7uGzSLjZuFmR+EpaFyCINBtAii5P7vrtAMbZ8S3RPu5hg==
X-Received: from tweek-sin.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2bfd])
 (user=tweek job=sendgmr) by 2002:a17:90a:db48:b0:1ca:ab67:d75 with SMTP id
 u8-20020a17090adb4800b001caab670d75mr61873pjx.1.1649051214731; Sun, 03 Apr
 2022 22:46:54 -0700 (PDT)
Date:   Mon,  4 Apr 2022 15:46:42 +1000
Message-Id: <20220404054642.3095732-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] firmware_loader: use kernel credentials when reading firmware
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/base/firmware_loader/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_lo=
ader/main.c
index 94d1789a233e..416ee3cc6584 100644
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
@@ -751,6 +753,13 @@ _request_firmware(const struct firmware **firmware_p, =
const char *name,
 	if (ret <=3D 0) /* error or already assigned */
 		goto out;
=20
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
@@ -776,6 +785,8 @@ _request_firmware(const struct firmware **firmware_p, c=
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
2.35.1.1094.g7c7d902a7c-goog

