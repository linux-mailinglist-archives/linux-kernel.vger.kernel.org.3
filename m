Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A262510B62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355549AbiDZVfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355533AbiDZVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:35:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845848889;
        Tue, 26 Apr 2022 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651008721;
        bh=Mcqr/T0kmWqg4nAlzOns1D7VSNQP91XAT2oZ/smVtZg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=coZxAAm3p5l3OCIUnUP3qzKkt/u4crbDsUnOxI/vq9/YCes/7sCHhnXHv2vo4w5Dp
         tP/f1Fu9R81fCxssP6uSpnKuNsxWm3HL03YP/WE4X6c84qFmWXqFcT30FkzoiMjUPr
         3hHAJ56xU3MOE78J+sCQPi3yekWPgN83cpKdzesQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFsYx-1nemMg0KSd-00HQ3s; Tue, 26 Apr 2022 23:32:01 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: (dell-smm) Warn if SMM call took a very long time to execute
Date:   Tue, 26 Apr 2022 23:31:54 +0200
Message-Id: <20220426213154.724708-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426213154.724708-1-W_Armin@gmx.de>
References: <20220426213154.724708-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVutyZY/BCiotHB/A+1poWq9QgmxatrUFyL3SR9Mal2aDAeVzw8
 k/l3fTLlCyKGohW64XTyP4CqBoeQCNHB03/Vnz2iiRa3HwhS//VF0sNLJHEA7PFDn5MAk8H
 4qtKE9EitMbQZvK2rkD5bb4Ic0AhFJunvhDydcoRoNvy4c8e6iJW/B9u8gDjiNYGuqNg8tT
 xw3UpiysP4REs+L8nVd+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9FCWAqq+1vc=:36INr/9RMhrgYme2ZgAqBY
 AvEHpE5W1PyPQuELki3mxfdlI1JKTl0U9XPh04xIAkEww5Ii4Tchw2nwSSZFXhK4MtIDkx8eQ
 WgQYRJBbqrwBuACSHItWSettvE6c1uOces9zJw8fpLeOt9Z6n1i2aNrtP5GhbqlRE2jD68VBd
 qHNg9kB0aj+3uXTgWCfe0QZtmeGOM/uwQz6cE/v3liMv8c7wek0nx886NOkZejX3hjq8dc9jO
 HPOdtcdRicANBjzNK7wjgkv5MtvlCuL0N89d6ZNZ981FRhV4mzrVSfeMV9m1dCHhvm6rBuThQ
 46wDqKdp+yWutbfJ8K8D9cqfWl9yIQwTRD+9o55/ZmixL+JahBOubRMR+nSbzNP3mxVOkhqOS
 7+ITIvfy4tzZpDDmFK/HOfZ/T6B9AdKxuL7aq8zlafrhga38HglQSi91Tg1MheYYxTvfFYkVB
 Ir1TBBdqmlEPNQ/jUYuVAoOSE2lt0nvEswefPkxH7BAeuye3A47T+7YOBDwHQBx6jXRGu9Z4o
 HjN4KxtO5IhCDK87t39xs479RvN3wTOK9Hw5mOY7R2lUgfxZqSVsF4+TS+3IpXZO6yshTpwxI
 czywqJ8LzU7D4JchRBcQQphVzoe1puixfr18LlQN4xu5jPiT1oCuq6uCciryJ3djrZkohoQr5
 igThxe9hs7fDW1BzY4ltJeS+ExaE76yHG7N02oP6XYtJqdoT0JelNqJRAdnTDoM6N/9CPC+v9
 getWSQRlI43H3B7XCZk0zNxVRo7ceAXV2rcTdyXCBjuddGuZZ7U8PCWCglORaujyGMDNaEEW2
 9+pWl3lwrtD4m5httc0gR2+1WW8YS82VrEwRFMG6XAPp6e4Z2NSGxbSmGcEQtMjTj7szoSPJz
 peePJ399I6+WIl8Uejxqtm4usv3DbKD25iNdv++x8U+F3AHV7hCbbFg7FnpjaenL89hmSsiAx
 uwSd97WAZ+cbmv7jgc2qkd5rWw7UB5OTYJBUt6hEtHezIvC7zMZieVjNchMY07udusGqJ3+Hq
 FI3bzv87PkqaDOAaZwg0lrUlcPlQ05Y0bOa6mXsZ/iZBkeH0eMU5j7oFJMMGs4g3mn1Nv5pUv
 3ygE4FSWhV4qCI=
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
index f13902414615..071aa6f4e109 100644
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
+		pr_warn_once("SMM call took %lld usecs!\n", duration);
+
 	return rc;
 }

=2D-
2.30.2

