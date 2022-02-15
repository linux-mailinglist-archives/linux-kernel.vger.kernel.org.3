Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094C04B7845
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiBOTMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243398AbiBOTL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:11:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77254657B7;
        Tue, 15 Feb 2022 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952289;
        bh=SxVO8kVjsQIgzNAhMuQrTyZ/nhGltRDfeyl32VMM+ys=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XoJLEzbUAF0JQ0YeIcPYMUiopaRbrvPRYHJKrTvkgLoHbSNezoI5dhP1S+r1Qf07A
         tFwxsrcY1d6Rc5sFpDnRJUb+Obvqxkkbu4PuIFybhVpneFXoahp3EwrjUP4FKT4P2z
         wFGdL4qMGfdOOJK1aWzywUI7/NIdrmGPiBKQt9yg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MowGa-1o4bOR0HlO-00qUcS; Tue, 15 Feb 2022 20:11:29 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] hwmon: (dell-smm) Improve temperature sensors detection
Date:   Tue, 15 Feb 2022 20:11:10 +0100
Message-Id: <20220215191113.16640-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jnoIJaV3BwZeEXCRHEY0Vv+6tBpjG7Kw+ZxDd1+5f9mfGaY/KVt
 BY1ekcT/jpYqnddZrXw1SasIt5w/ceBanLqocKRLl9VUbPEIwScpnoXJxWYnEU9/qpaYO+5
 WSMutac4ciXooQMH0hc5Qg5wfsdheTWBgoGB6XYI/8LEZnFNG4FRkAvgo6L0ZpzC+f8Rc4n
 sOUsumkU+4d/1cPUIP/eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:taQVSqRsvBU=:naGTMuA3uzqaFLbAoWj5UZ
 MPjEWMfBIt9ZtLfnMlQKhimUE8bjQ9rx2vo7q7taWK/vTy/AwEGb/2B5f1ZVFSYWH9Tyd4VTI
 P8ECuI5Jll2LTgrDZk/Vfnm/tcE13urv0L54l0XfpaJBKazPay16f3zg8f2sfrHM1GPkQB3oy
 K7kIalbimCverIOd0mPi7YgemCzIiCb0ABtUDhHM2F+cleRO9HRjqct1PR4XOJkElAMIC1Mrg
 S6eNPyoD0fJP6S+nwI+3b74LElpWY/TQzJI1gj4mbYb+qruy6VVt3/t3yWBELb0zCOuoYBpkJ
 evU402fqgaRYQrAvYDdPBNFZAvTOrudCcSfZfXWzPTgPx9diLES/aDMv/qYf8mSsEv15HFbsM
 mv2pQFqiz6Zz0+NytRpVkDc6+Lxd1U0U0NfcnhCGtm4HiguElhqoQzUJzHLuMZEEM0ODob18z
 CNROzD/nyt9Kv2qPQ9iWzbW20fqBCCf9fT4Lv1cojakOy05KdPc6FbITEMHP6LGCuV0jC+PJz
 BNnhSjuNoxmdlzrlOcbdXb2PWe4zQoq13nk8r7Up70hImo4IKoL4cE8j5YIHAyfB1U+nE5QA+
 58iSBfNX7tm0TI8GcTmP4pFnuhe8WTbZz392yy5dp2CxvHP0QG+4XZCbHuqSsQI5bdbm8ahx+
 t8jQSdYwSgOn/nnEHXAz8LAMP+7Jb8CqgCPZget+q3tZtX5ppZtk4VPi3NmT/PQqLPqBmBBmg
 5ZYYO6vMNRskEk9GGuFvQVv+Z9waHGnlPrAyF7O6Vs2EyDZ+4zifIMCF6cEzZPsm/EThjFhtu
 fkWV5GHsYjbrae13RGDKl/k+dsI0FPZFW85bZF23qAnMkWQ4fiJzGaZhChMRModtNJcITmUpT
 UUdK4uijaldfeBzJsAfqC3vi3iZmskm+4Foy+QnuhKhDxByTSTjvLPbjmapmqlJW9neLbmkUq
 iY+HO8BF/wVQNz8DTxUrDLLGxlsJyDP3tMSFNKEv75OfbjyxKrozx9as1Sy/FV6zbEvWMgT4s
 7tFGh/eA54F8kOqvuj76JClMWgvhnT5HUE93ga4W4jOs56hne9igIEvbtmHY27DwZldPf+G81
 IMch1fXbqnwx4c=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Dell Inspiron 3505, three temperature sensors are
available through the SMM interface. However since they
do not have an associated type, they are not detected.
Probe for those sensors in case no type was detected.
_i8k_get_temp() is used instead of i8k_get_temp()
since it is sometimes faster and the result is
easier to check (no -ENODATA) since we do not
care about the actual temp value.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index a102034a1d38..b7016971bb2e 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -655,6 +655,11 @@ static umode_t dell_smm_is_visible(const void *drvdat=
a, enum hwmon_sensor_types
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
+			/* _i8k_get_temp() is fine since we do not care about the actual value=
 */
+			if (data->temp_type[channel] >=3D 0 || _i8k_get_temp(channel) >=3D 0)
+				return 0444;
+
+			break;
 		case hwmon_temp_label:
 			if (data->temp_type[channel] >=3D 0)
 				return 0444;
=2D-
2.30.2

