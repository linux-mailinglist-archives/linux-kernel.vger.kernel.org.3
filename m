Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586FE4A4F82
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377071AbiAaTcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:32:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:34937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376841AbiAaTcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643657517;
        bh=M8VxZrM69T8fzVT7HtYVnghJWaulQqQeYn5dd1DXrAA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bF86srVel9qMm4UJ+cyEqgH/yBbxUdgo0HwK7MVyXWou73CBq43PL8hUgHCEb+BAk
         55bzcMFeKSrVRJlmsEJpOl7couN7p4YG/rr53tu++P690IB1DKy5rM3TofBQQVGdT4
         fGNuw4ge1EibMvS3hRMF5Q8/J+3XDrZYa6RLE8Go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5wLZ-1n8oqc2lh5-007UBB; Mon, 31 Jan 2022 20:31:57 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] hwmon: (sch56xx-common) Replace WDOG_ACTIVE with WDOG_HW_RUNNING
Date:   Mon, 31 Jan 2022 20:31:37 +0100
Message-Id: <20220131193137.3684-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131193137.3684-1-W_Armin@gmx.de>
References: <20220131193137.3684-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EVlEM/o2j4ih3tYP1AEJiMC8rIk32vvZTCzjpa4NBx1+hZB4vtx
 JJTBBoW3yuerS1F5Deib520NoWkps9QX9scjB3TEkU6xAfgCER8L7EHtcfsICirVLYi7wJx
 OEluf1hYsFD3ifbSgSlqxpSd9Pk6/OYpRpYoGA0EKVb8rQYKpgekWHPUpVW8czorIMYlOzX
 8RuPS5rHY6Nj5ci6+vnXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJ61MFJziLA=:kP4t8y1BzCOAu5fBJHUWF/
 YEcsVMbkXuSeEd1yIuc3ehKVFnYhiuP8oDeSkrm9rKPlAFHYOboSZGN1h+aZtg237Rw8mCKO0
 BUNw7AmS2cPks/3kCwJeXtKJ5I1tmPPTr9VYm5foeNg4o2Rb4PDAkLfQTfqtKaPH0Y5iIS300
 lACUQc3CiPMVldyhDvnlc8ElKMsnp36cf/5o9NUY2VMWvoWlgrlY+8RTIwJylQ8fbjCyuJUDA
 a3tMHLMkNhQZKDFooYBZtPvB/plJiA5iyTMMjmBac0sVNSjp8xwBKzUQd+eGYcJs9JwldBuxd
 c8tsl3X9YXpc9/rK/0YF2fS6aPZTeHSHwPie8Q66PUGZmX+0anNZx+c4dROAxepNqAparRIUc
 jO9HqzcpxIqwOi9PsNAvdjMagldkX2QysKKXIFoY6Hhpfcqzg1WddGmPsDr4zBzctsHf/ZWeO
 IhWj5jxaYGWAw23PmpWBew1tzqBsMAG4cmlaxwbUpV374DmE7arffL7PvBL9f5MUstjbGDg0R
 nC2RYoEJM2ollX8pvuCsMEPYlIxT7IHw0vWKer5dNUlO7BSZ3QBxS4H7YMZGHW2NxPP1PSL4E
 Ls3RiMNQntyYWHOglrRCJIoTGx4thm1aH9P3V6zxzDUAA0BJvBUlb2ihiTPQPZ9Zs0avfV5d4
 BU6Sv0WjOvmKjUYGUsMUjzHUvK3wCR3WdxIjM8kS/07vVgpeJ9FNna+yfMXuz1La7/Mi4Quj+
 cBdnu6aBRdP9cTwvM6+QQLJp2/lwu7ng6Hp/F8DKs36aNEKVoqrjoVEWg2YnfC05Nvn+Zidkr
 kdG2T+Q7I/Ts0sR68/em3UtOwPhouwOXLrPHTaUGbyV/8PF+Rd+i8N7wcKsrDV0kr++IVclAQ
 1Gbhu593ZO4j3FkaXrXanr5osAZTnHxXxCGTsdKD8iXyF6Hv/IqbM5VoGZJefgD2IzaUgMQoq
 hEHGSz8rVZLYULsAvKxpSBykWMvggLgEtNwgbXkgXVYcXUjqnAhG5ZTnVYsVRF3mzBur31UJL
 zxzZUh8l/9Eg+Glp4vJBb0bXfdY4KVeEicVv1az7+Jq59OiDn3mDfPRexW5+W+051X7XL9eSq
 iRGPdIJboreXpY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the watchdog was already enabled by the BIOS after booting, the
watchdog infrastructure needs to regularly send keepalives to
prevent a unexpected reset.
WDOG_ACTIVE only serves as an status indicator for userspace,
we want to use WDOG_HW_RUNNING instead.

Since my Fujitsu Esprimo P720 does not support the watchdog,
this change is compile-tested only.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: fb551405c0f8 (watchdog: sch56xx: Use watchdog core)
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index f66e1ed4b1aa..2cd146fd0562 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -427,7 +427,7 @@ void sch56xx_watchdog_register(struct device *parent, =
u16 addr, u32 revision,
 	data->wddev.max_timeout =3D 255 * 60;
 	watchdog_set_nowayout(&data->wddev, nowayout);
 	if (output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)
-		set_bit(WDOG_ACTIVE, &data->wddev.status);
+		set_bit(WDOG_HW_RUNNING, &data->wddev.status);

 	/* Since the watchdog uses a downcounter there is no register to read
 	   the BIOS set timeout from (if any was set at all) ->
=2D-
2.30.2

