Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AB52D0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiESK5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiESK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:57:43 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8FE80AF1E9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=IM2J7NHYnrpaK9J+N0RQ6liKfpIkzPdy5Vj0scWlvm0=; b=a
        hFy5lpRObySYXD8/fA9aWHSQuXau41ydyqvj6huPmdyD4vWobGeKcDMQuYxVwVFY
        YpJC4VfC2K3/XqjRvmrFcztlkmpcQ4t5PgqRpzeizZ6kvMEtcSBFrlSEB2F/vBr4
        /PVk0bv1h5V5vjcfOf/sNyNdPBL0VAjQcZg6xISHT4=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogB3fHiTIoZi47SYBg--.24223S2;
        Thu, 19 May 2022 18:57:23 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        sharvari.harisangam@nxp.com, huxinming820@gmail.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] mwifiex:  Fix potential dereference of NULL pointer
Date:   Thu, 19 May 2022 03:57:19 -0700
Message-Id: <1652957839-127949-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogB3fHiTIoZi47SYBg--.24223S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1ftw4rJr4xZFW8Jw1DZFb_yoWDCrX_K3
        97Za13Gr4UKw18Kw4jyFsxZr9Yyr43XFn7Can3trZ3CFWIv3y3ZrZ5ZFWkJrW3Cw4vvwnx
        Jr98ta4rJayUXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwELBlPy7vJhCwAFsd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'card' is not valid, then we need to check the
field 'adapter' and 'priv_num' to avoid use of NULL
pointer in function 'mwifiex_get_priv'. Fix this by
adding the null pointer check on them.

Fixes: 21c5c83ce ("mwifiex: support sysfs initiated device coredump")

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/net/wireless/marvell/mwifiex/usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 8f01fcb..c635206 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -686,6 +686,8 @@ static void mwifiex_usb_coredump(struct device *dev)
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct usb_card_rec *card = usb_get_intfdata(intf);
+	if (!card->adapter || !card->adapter->priv_num)
+		return;
 
 	mwifiex_fw_dump_event(mwifiex_get_priv(card->adapter,
 					       MWIFIEX_BSS_ROLE_ANY));
-- 
2.7.4

