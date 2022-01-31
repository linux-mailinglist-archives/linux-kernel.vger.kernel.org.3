Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB464A3F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiAaJer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:34:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:37759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237213AbiAaJen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621667;
        bh=mJxsPYb64pkiiR8ddTh3vIBADHaclB5tW+tmgCYuZ4E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lYQxqt9bQ6Cop3NuANiaRG+yian7UOUkXziN2OVmUKywYC6SXBEeDc6UEJ1sv9Rmk
         rsN3yOft2uh0QMZXt06lG6jbMSassMyfYfMWd2UIBHqm4T24iTcoKOG/AtYPXCQ86T
         +P09HjjYLMPuM3QzEr2Mob49p83fHpUEib7AUxI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MhD2Y-1maCeH1RHG-00eOtj; Mon, 31 Jan 2022 10:34:27 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] hwmon: sch56xx-common: Replace msleep() with usleep_range()
Date:   Mon, 31 Jan 2022 10:33:54 +0100
Message-Id: <20220131093355.4151-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093355.4151-1-W_Armin@gmx.de>
References: <20220131093355.4151-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tA6BvuD4UvBVFdOvitVnF1aeASTSfEN/LrkIoxpwrpsrY01xZ8Z
 p2JojdpHEyOY15D5jYlaHy4B4gHzPinD1KfLLqVCGbOSUqbFBaHDavq/8T0vwjZV1d6UAlC
 116Pn0EHQKT8nNmWdZS2mLk8ZiiAGq6am1epBdUSDguLwBBXGhxOiyGFvVdOWRNoaJ5puuh
 l5t3M9DpRuBEX2h2gJzWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h+RcR6NF9xE=:9zOJKpdegMOmhWOwsv5kEi
 eAIJwMtPlyGRPi7bHGVl1mg3MOLeTYpBQzVt7GjIaJ9vBdlFg/qEX1clF20/mPnlHcDgtYyaq
 sNyINp8TrT/8FiWjcwe85VcVEPzOm1gg6GiAyS+nSVvwDSFJ32r/i95LImqW6wQUBuMM3jQW2
 uWYNtRwVYVmzz0zXlJBMI8zUy1L1qsLY6h7qn6R7Y00steQoTrz2r5oFiPjt/EIy7A1t93ZT4
 2w9sSVWOd9pbwUKIzbcvmX1ttvfPETtCy3gGCmrX/neBpXZ2iD3+4Kh/HW9zfCPQChAVSSZkv
 a1GuL+hS+LTNp6gKtWyJwvqYbhGa+SUO8JOqcs+LMInDWD1L8a84moceW6M07WXpMtk7TsgP9
 jhuVDIT2qmKAUBVL+BCs/aaA41X+34va8r/xG8T8Dl+iDhjV3qxY70G5c75Rixgks30AIQS4p
 JEOVzT+bJWFjFHv+irJQKKJO11YYRjLZI8t8dTUrI7uC0u1h9KP/11u2tN9VPzC07NEVMu/zk
 gUCjwzi06rL+OvjgZ8VL8dWlelT/0R0Dg/fEO5MtZftgCpd4/sXGo55gCm919ZbHc9QDaxaMo
 TADKSAQ9k7Nvf8+mIrrfvky4f0k6qcUiTXh+vhgJqqmzKWl2p9hM1PGESZMVnbIjEMPJeRiyX
 jmZoDdziWkVWjuXVMLvq0rEPUgomMH+hBNg3u8K/tmgpLyL7U3ztebdFwV89rQmtlY5Utlzss
 DRIKqBhWRFt0v0gJVbrSHcxL0TSPwBBItV39Jp5XJe+v3JZhMzVZrjOGw1uAbOTELEsLXhRdL
 sj4eS58HvZ8diGwt6tKKEkiOsfipZI5Sfak/+iM+2CTQJjf/TP+92beHnSVa2cxtTT+t0JjpX
 HOB4brbORmq/suFNDQFgQSdVWIhK0M8tomhyZP44kMGIh1OIxhlYN4PHd/sILDUUU6Bzmh0x9
 ypkT1Kgqs69eWoFHoGW7TxRmTNMwYHRqW5pDLJcXECggY0PuFMkIRqVkwszjnyJ5wo9/oBOdo
 2OZFk7sayAHQhzC34/3XkGAbmn+Fmweo38i5K0B9OBIZ8x8yEI22OjDIU7xkdIfUPHjISUQ4r
 qrkmd8MffvWfbw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msleep(1) will often sleep more than 20ms, slowing down sensor
and watchdog reads/writes. Use usleep_range() as recommended
in timers-howto.rst to fix that.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index 0172aa16dc0c..f66e1ed4b1aa 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -139,7 +139,7 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg,=
 u8 v)
 	/* EM Interface Polling "Algorithm" */
 	for (i =3D 0; i < max_busy_polls + max_lazy_polls; i++) {
 		if (i >=3D max_busy_polls)
-			msleep(1);
+			usleep_range(1, 2);
 		/* Read Interrupt source Register */
 		val =3D inb(addr + 8);
 		/* Write Clear the interrupt source bits */
=2D-
2.30.2

