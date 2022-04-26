Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492B51096E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354413AbiDZUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354376AbiDZUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:07:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D4D39BD;
        Tue, 26 Apr 2022 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651003414;
        bh=dwQ/oJsstgp3sXzO0lD5phczdkjblax81CWSGX1LRCQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AMGjgK0tWjsAIT8JpKvCwz5HvtSjgvG5a8yflowv3eSJ/gLBPZxVhwSXjupcUlkgw
         VM+ShuoHvaQnI7cMjgEAlj5iUhKeEm4WPQFpBu8KjqyKtJp12BCyuusQZ7u4ovLKQ6
         5GrWWtqupvITnVSYMvdzSk3BWHfAiyt8emV1h0Iw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N0oFz-1o6s8h2c9V-00wlCY; Tue, 26 Apr 2022 22:03:34 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (dell-smm) Warn if SMM call took a very long time to execute
Date:   Tue, 26 Apr 2022 22:03:20 +0200
Message-Id: <20220426200320.399435-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426200320.399435-1-W_Armin@gmx.de>
References: <20220426200320.399435-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dFp0ZNEGgx7+jRlwf66xvqbIMjDqxrW0ksKrB4Pw0HFSg0DKlg0
 iFKOn6yK3E9CNnQdfjeILpF0ZSa1l2iylFkza5Bl1c+yi+NhvAwcxIGklADKfY2FqQc9rIv
 rsxtTj3xh+RLdKVp9radulvOIDcurd0/SdqUM27w8QNrnb3fRdY2zUOiZXNSCkza0l7toYF
 Co8wuc0HclKeG0YBVh7Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ddcqQL6Aifk=:cCulL3BZDhwyQyjUChxMFJ
 9thc0V0qIR/ktzBS3Sg3jIx1okrQWRr3B23D3p6zbP/oVy5EgFYb58KY+iTCW/MmbbyIdg9zn
 /E2czd1woN9wfTS0PpB3s2cPHLaaLJVdrY1ioA+XFNvvTk0DnVe0hBeXrIAnfRBTv/Sfx/7VX
 j+x8EBmheMb5ilVulH7GQ+TRjOpMNgEv+gni3FvrawDuFTHFKH95Qr7rN0PazDWSoxvMvXJGy
 LT2EuGhBf3wH5GTK5KqZma6uuCw8kg3L8VSw1wrKnRI7T4suT+Gyk1xFBdwfFMxPwsLWCbEf+
 CNBtmq8m1g1aAncGZq3+LVkAP6cCL96m9NztICiNGwpybYekE21s1awpQGpHP6KRjWMM1DmCg
 bAqW//odPvzE6FJjwrdulD+rcqn4xhbF+lsjWOoj1AKJyV+YoNJr93Eq+0L1YwaF7ttTem5xQ
 56X10sTHxtw5xaLfyGk0YtcQxcnSan4KmDm4BjMVXavv0NKaek8cbFWBaZTl7xjkty3WB6vTw
 uXVb1xRv7YkwIWL67eo/9AV6E3srzWJZeHjF6Ts6w2zDj4Q/34ffjf9SHnyFGEoDxaF2msq2r
 9a17uQtiKGzmIuTto0A/Z4gwAOPyljsVYkyBYswNEyt3LIlJKi/Pv9XAQeJ7UhqadKEvJr0iE
 Z+XcqeqAwVqIx7aOAhneQiJzWU+vCYGcZ9esCtay0oeqIUt8hDM5lKKmLz1Zgok1s28VHik1x
 vqyS6+IVT7KlnpWAtKs5pX7OpdoovvbwufMkW3A4VXW4ojsg8Ps6WtqhlTbF1owE+vwuep5oW
 TkozPtvwliL9M9QFmAaBomiwefU835VYmim2eZvY5UKmjUnBirH56Dch3YUndxb4kFIoZa6xQ
 jrEYSNEyndw8VzGUn7IcspN6gJsnNgCgrEgs6jnjideQs50gjJ49o5Zd1GdnWaRvCnag39lcr
 iXIyXtZrkOlGN19G63+ffU8+HOZbjdXw7aLA3B3hnL3kkEsOhsWKP4C5CwYciuG9Z7CUjvU5o
 81G0/1QYvTUy/13q2bZILDHOwMNPT3FPtLZjAGuh9gQ4Jqt/Iffb7r8eRQd4tMyFW3qH5poYn
 1AyTZWByp+nEtY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a particular SMM call takes a very long time to execute,
the user might experience audio problems. Print a warning
if a particular SMM call took over 0.250 seconds to execute,
so the user can check whether or not possible audio problems
are caused by this driver.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index f13902414615..b960330eaded 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -49,6 +49,9 @@
 #define I8K_SMM_GET_DELL_SIG1	0xfea3
 #define I8K_SMM_GET_DELL_SIG2	0xffa3

+/* in usecs */
+#define DELL_SMM_MAX_DURATION  250000
+
 #define I8K_FAN_MULT		30
 #define I8K_FAN_RPM_THRESHOLD	1000
 #define I8K_MAX_TEMP		127
@@ -239,6 +242,9 @@ static int i8k_smm_func(void *par)
 	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x  (took %7lld usecs)\n", eax, ebx=
,
 		 (rc ? 0xffff : regs->eax & 0xffff), duration);

+	if (duration > DELL_SMM_MAX_DURATION)
+		pr_warn("SMM call took %lld usecs!\n", duration);
+
 	return rc;
 }

=2D-
2.30.2

