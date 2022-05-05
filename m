Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727FA51CBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386186AbiEEWNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiEEWNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:13:01 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FAA5DE4B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:09:19 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D3AE924002A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1651788557; bh=KTIRId5INiLOEFZE9cS2PzPrI5XvgN1DeL7OKh0bXQU=;
        h=From:To:Cc:Subject:Date:From;
        b=Agvg9tXNaSmTX6uf5MMhb+M+wdVk1KF8lUF/85s4qI4Y10ZncThBJ2H+VKE3cZQjO
         6yLNbnj7zsCtP+OoQFRnpGal61JxVqe1kqOoHWLnySdikl+n8T297RYjIaXCqIOhej
         R9lEsYq2keAPesI0TweKFxrp82tFPmAgi4xBegCvWNUpKBAG8P1175AQGwOaSlRu+2
         nlpmTYaavKJ6/qaK0UFvwXPTyplXc9NI1GlZhZ6+gF4q4/vcpOf9P0tGbrcIg0g6E9
         ceKnEpKetTaPH2dxgvk1KUVMtfBV+YQcZ/Jwvaw4GllP9GCj7sXkw/DMsH3QNKIcSo
         yRIaC3Vj+rgmg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4KvSXX0fjpz6tmb;
        Fri,  6 May 2022 00:09:16 +0200 (CEST)
From:   Manuel Ullmann <labre@posteo.de>
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        regressions@lists.linux.dev, davem@davemloft.net,
        ndanilov@marvell.com, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, Jordan Leppert <jordanleppert@protonmail.com>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>, koo5 <kolman.jindrich@gmail.com>
Subject: [PATCH v3] net: atlantic: always deep reset on pm op, fixing null
 deref regression
Date:   Thu, 05 May 2022 22:09:29 +0000
Message-ID: <8735hniqcm.fsf@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d24052938345d456946be0e9ccc337e24d771c79 Mon Sep 17 00:00:00 2001
Date: Wed, 4 May 2022 21:30:44 +0200

The impact of this regression is the same for resume that I saw on
thaw: the kernel hangs and nothing except SysRq rebooting can be done.

The null deref occurs at the same position as on thaw.
BUG: kernel NULL pointer dereference
RIP: aq_ring_rx_fill+0xcf/0x210 [atlantic]

Fixes regression in commit cbe6c3a8f8f4 ("net: atlantic: invert deep
par in pm functions, preventing null derefs"), where I disabled deep
pm resets in suspend and resume, trying to make sense of the
atl_resume_common deep parameter in the first place.

It turns out, that atlantic always has to deep reset on pm operations
and the parameter is useless. Even though I expected that and tested
resume, I screwed up by kexec-rebooting into an unpatched kernel, thus
missing the breakage.

This fixup obsoletes the deep parameter of atl_resume_common, but I
leave the cleanup for the maintainers to post to mainline.

PS: I'm very sorry for this regression.

Changes in v2:
Patch formatting fixes
- Fix Fixes tag
=E2=80=93 Simplify stable Cc tag
=E2=80=93 Fix Signed-off-by tag

Changes in v3:
=E2=80=93 Prefixed commit reference with "commit" aka I managed to use
  checkpatch.pl.
- Added Tested-by tags for the testing reporters.
=E2=80=93 People start to get annoyed by my patch revision spamming. Should=
 be
  the last one.

Fixes: cbe6c3a8f8f4 ("net: atlantic: invert deep par in pm functions, preve=
nting null derefs")
Link: https://lore.kernel.org/regressions/9-Ehc_xXSwdXcvZqKD5aSqsqeNj5Izco4=
MYEwnx5cySXVEc9-x_WC4C3kAoCqNTi-H38frroUK17iobNVnkLtW36V6VWGSQEOHXhmVMm5iQ=
=3D@protonmail.com/
Reported-by: Jordan Leppert <jordanleppert@protonmail.com>
Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Jordan Leppert <jordanleppert@protonmail.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Cc: <stable@vger.kernel.org> # 5.10+
Signed-off-by: Manuel Ullmann <labre@posteo.de>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers=
/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 3a529ee8c834..831833911a52 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -449,7 +449,7 @@ static int aq_pm_freeze(struct device *dev)
=20
 static int aq_pm_suspend_poweroff(struct device *dev)
 {
-	return aq_suspend_common(dev, false);
+	return aq_suspend_common(dev, true);
 }
=20
 static int aq_pm_thaw(struct device *dev)
@@ -459,7 +459,7 @@ static int aq_pm_thaw(struct device *dev)
=20
 static int aq_pm_resume_restore(struct device *dev)
 {
-	return atl_resume_common(dev, false);
+	return atl_resume_common(dev, true);
 }
=20
 static const struct dev_pm_ops aq_pm_ops =3D {

base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
--=20
2.35.1
