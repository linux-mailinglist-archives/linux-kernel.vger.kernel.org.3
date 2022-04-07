Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2094F7C80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiDGKPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiDGKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:15:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0AA46143;
        Thu,  7 Apr 2022 03:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649326398;
        bh=NzbJ6LCovM7vad+GoSqmD1yRVSeHyd9Cr+QnKLRutCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UHTLyZknjq/Lwysg1lfr1ofEeO/1/nQYoI09NvqfynS06FGp1kE4sMsluuYH7279I
         hWBQbrci3PyLV7qf6yz3pbmkvg/aAmONviwB9PoTQ9LhVdWObNXC8nDf1sXE2T1nX+
         w7rjYHCeqyKyAM9mT2xJK1qQ4wY6o9uzsWi3yc9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MDhlf-1njneT1zPj-00AjHx; Thu, 07 Apr 2022 12:13:18 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     zheyuma97@gmail.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (adt7470) Fix warning on module removal
Date:   Thu,  7 Apr 2022 12:13:12 +0200
Message-Id: <20220407101312.13331-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ovxuFu8CEf0F/03MIBREb5S34SEezFsSkmtGRm0P10lTl2Oeu5
 XbexovcfCSCv/9/3le3RFlkFuN95u0B01kzYugjm8KH8K0tVaSzPBIn0Nw4kNWFJtvT/DNK
 2t1cKD0dF3dO1j7VjpVMdnYFbN38b1db8CCuP/7XoY7ZNDSdw03jR6hZPm8hjkhZOrc+ITB
 WrAnpEs5Ks7Aeo3ivfpcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ic4wrSCOd88=:lTToyKaCXOpBWmB1zpEV1l
 +BoD+IgPTXSM3xxgJHGQKpT89Yw5DH4411051A09xNtIwtpGUcfqlZ8noywCCqyiZtH8BUgHw
 6pfx5OJ6JBgSu2PlmShYAR3s/ze4BsOWxHnlW8QdVEPMoMmVjCbVrTXY1EQ8lrZM45AQ4k8Dy
 RA6vN7EO9xuanqNTBtFnILoAN11RfKCvx/41pR87l5KsYGgKdq/piySYOt+SHvcinnTK+4k/V
 pl54w7b1jv+u5FVRaq9CvZjJsulcrmzqubaICZomijRKeAfk6of0bagCbFw6fuQdqXypLo2k4
 g6hqpghhbHw1lAlEY4SPhWbI33vxs3oN4GX2cxlp2YAPkfeTHosS80B7VODMpQX77eurVWlPD
 SFtHQeiH1rBGSEuOY0jiFHkGJbKuOEFe1uucliHcGG3PK0v+/wunOm6xOVC/g2Y+B2q1Skq58
 QXCI1CuA5+k7Iq1j+Ajfytrg9GsVoiwR9Qlq6+FNKCQjvawwJewjCRG5OIthhzd7W8dVcykWT
 1lsOzoAg7/iYNk0uH6mie1e74Sa0tDDK3/2qi3eKL5BlmzqIOi2MO6RXNQ667wkMyULSCmSeC
 phC6F58CVv+yhvmJiaI9Z6SXyJ2OaAZJFT8e2JW0tUx0hZAw4v+g1xRphs2tpSjoQqNuC0MPw
 NTwPX1OzoJfM3/hsSxEEzE32AV5QQqYLUyvLXbqdIRtIsmdVKhNeSlF6fxnVzCPWwCFvz2DPH
 iYID2qfW5lWT9udET+PiEurk56qUPxR2AtwXMQ2CQNRmgfmB2ewjZUsSZPB3yOjs6ybP+O+jw
 odtVYkOJ2/q+tq/OgPYCofgUNR3TV2CdLtW6Xgp8HFNjJZ8wED5ryV5GSNtuA08LocaseyDHP
 4s8vhFAQ8QyFnKeE36UVYif7LFjclw0N58tY3z+urilmTkQgN2KXLA92dznJIGOWcCgnNZqI7
 24ziY+E2FCRnRziC3V/6alAVAN1wZSJKMlPLTPI5reMYbxroIDUziW+cBfmwGlLEbUNS8X0Gz
 lzuCc0SG4QKwfNlvBDkowrOMWlp3JvkiSc9ncPENLxINv3AvHcfrZaCW4OBBu97qcPZTYlZ0v
 555ROtZojEwM8I=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the adt7470 module, a warning might be printed:

do not call blocking ops when !TASK_RUNNING; state=3D1
set at [<ffffffffa006052b>] adt7470_update_thread+0x7b/0x130 [adt7470]

This happens because adt7470_update_thread() can leave the kthread in
TASK_INTERRUPTIBLE state when the kthread is being stopped before
the call of set_current_state(). Since kthread_exit() might sleep in
exit_signals(), the warning is printed.
Fix that by using schedule_timeout_interruptible() and removing
the call of set_current_state().
This causes TASK_INTERRUPTIBLE to be set after kthread_should_stop()
which might cause the kthread to exit.

Compile-tested only.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Fixes: 93cacfd41f82 (hwmon: (adt7470) Allow faster removal)
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/adt7470.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index fb6d14d213a1..c67cd037a93f 100644
=2D-- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -19,6 +19,7 @@
 #include <linux/log2.h>
 #include <linux/kthread.h>
 #include <linux/regmap.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/util_macros.h>

@@ -294,11 +295,10 @@ static int adt7470_update_thread(void *p)
 		adt7470_read_temperatures(data);
 		mutex_unlock(&data->lock);

-		set_current_state(TASK_INTERRUPTIBLE);
 		if (kthread_should_stop())
 			break;

-		schedule_timeout(msecs_to_jiffies(data->auto_update_interval));
+		schedule_timeout_interruptible(msecs_to_jiffies(data->auto_update_inter=
val));
 	}

 	return 0;
=2D-
2.30.2

