Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458B74B2CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiBKSQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:16:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343636AbiBKSQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:16:37 -0500
X-Greylist: delayed 194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 10:16:35 PST
Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com [17.58.63.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C3D4F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603394; bh=5BSwyJv82sZwTHNuaRP1rRbMvUJ08vkgvnKFa9JwMmo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=vDt/4C0ud2P9NGxudzEpnpHDu4gk/4DOHCttYSCmvYtwAw4mejZYGJFoYp1d74kKI
         bWQBL1BU4b7ZVwuTEAi/D9JjCge+j3/e1s/ecy+pcthLny0yiI0eU7BGu6binG/v0b
         5CgYSmeIG+g1/JBgWUhI0K9gcW/b4UtzKt6yEWIIJ68t7K/v/EdlpfsUxXRmf9HRoT
         z+MuwWXYYB+i0Y3WXlGk7K148ko66cwr2x2VE4MOnbZaZ23gOHDDDrDQHSQF7Zge8d
         b2MAswppuCMqwWQtpIItMZAcKZb41kl0TbVcNVc7uuU7jBneubnYDjvJlQRWv+EEie
         vSOB6q0wYboFA==
Received: from localhost (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id A651E5A05C3;
        Fri, 11 Feb 2022 18:16:30 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 0/7] ARM: dts: sti: various DT fixes to avoid warnings
Date:   Fri, 11 Feb 2022 19:16:07 +0100
Message-Id: <20220211181614.683497-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=534
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2202110099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A first serie to correct a large amount of DT warnings seen when
building with the W=1 option and mainly due to having several time
the same reg property (clock) or having unnecessary reg value.

The first 3 patches related to clocks require that recent serie [1] of
clock drivers improvements be first merged.

[1] https://lore.kernel.org/linux-clk/20211202072850.194314-1-avolmat@me.com/T/#t

v2: squash together several patches from the previous serie in order to
    avoid compilation issues

Alain Volmat (7):
  ARM: dts: sti: ensure unique unit-address in stih407-clock
  ARM: dts: sti: ensure unique unit-address in stih410-clock
  ARM: dts: sti: ensure unique unit-address in stih418-clock
  ARM: dts: sti: move some nodes out of the soc section in
    stih407-family.dtsi
  ARM: dts: sti: remove delta node from stih410.dtsi
  ARM: dts: sti: move usb picophy nodes out of soc in stih410.dtsi
  ARM: dts: sti: move usb picophy nodes out of soc in stih418.dtsi

 arch/arm/boot/dts/stih407-clock.dtsi  | 101 +++++-----
 arch/arm/boot/dts/stih407-family.dtsi | 262 +++++++++++++-------------
 arch/arm/boot/dts/stih410-b2120.dts   |  16 +-
 arch/arm/boot/dts/stih410-b2260.dts   |  30 +--
 arch/arm/boot/dts/stih410-clock.dtsi  | 100 +++++-----
 arch/arm/boot/dts/stih410.dtsi        |  52 ++---
 arch/arm/boot/dts/stih418-b2199.dts   |  22 +--
 arch/arm/boot/dts/stih418-clock.dtsi  | 101 +++++-----
 arch/arm/boot/dts/stih418.dtsi        |  38 ++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |  22 +--
 10 files changed, 351 insertions(+), 393 deletions(-)

-- 
2.25.1

