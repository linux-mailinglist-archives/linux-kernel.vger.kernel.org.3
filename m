Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3AF4CD048
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiCDIlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiCDIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:40:00 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC51A41C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646383126;
        bh=VhTKKyAhQFqLXrwmbMwbMaF9x5HZIH2oU44KJBELClQ=;
        h=From:To:Cc:Subject:Date;
        b=jTTonvd+Gqp7il2o4Dt6VecIFDvZnAYQFo/HJ6MP+smS9kO/jmvGDdPGe/szxAw6X
         2HEv+6tObxoAh8co9AP3itUIdn1BIy1wQLuHIxbfxWNG3PpCKWf8PAZMWqglrTGV2s
         +PSG+RPenI0jdqDVBIGHN+htoBQQ19GM1j7IqY+A=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 9AB026B7; Fri, 04 Mar 2022 16:38:43 +0800
X-QQ-mid: xmsmtpt1646383123txww0qwx1
Message-ID: <tencent_4221FC4089F6DF01C48F192E5784038BA205@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQww2mZ0zeqm2zgwoQjyTa62EicOQuEEZvwAXJNVniFcmgXAouBPt
         X3wiozJpRIdopfA+s4aNJVEFr+kXchO9S1w/gMpl8GBJY81NBpF1wkl3jl/rdwoHRQohHP4zzKbZ
         tuxM//p0BJDkeFfMWdUMelUHQn0Ot/S1iLVUY/Bcy5300esWq2CI19ZwR89NoxQy4sD2d+W3zECQ
         pvHONYi5yLsbsEU77yc1UTwxGFXZiDyxMrankNm6MeOt69l3VUkZ0qROkq3TOpSk9/ugOA2f73Hi
         aTiLOYji3RvBdFhtpWyF1MfOsbxyhe4Oayf8Yv9FStXeNoHHpyR7YyPJQdila+OMva15SQnAG0FY
         LXEQJWnqDNZ4/iT6DnDFraJaQKrlaKHYcnomzzAa8NaunqAGZjH13DleayC+Mj+NK2+YuYi4Iqgk
         UEjWwNGun0x9FTCreEe1wxEjwN2w1mntY+y70TlIAQcQAyK2yiZb1i/pCRu2sH5sjMxRbKqIA6cz
         nLur0eB7tQ9vEWO+XmUNZ8AiPHinKv018u0eIduxJE86FBxQ7GolMSWenbcQ0EnBGjdJe4w5TrwR
         jLhEUtoUF6MF991x5j1XDSKMArrPG7ZhEo/4mdkGPv4H8MSJGtFgNGid5dfAdmEhNH9LdAvjjuiG
         w3QxYWB7EJauH0J1xxO2seXPEBRaInLmMU/OQa4CeTmdXCWvdfZScKC++sOJ+hnUXxbAHjyFCYV0
         wRAi0JvKxMR+tj3pugUwyMpTLu2PEwPQ3alD2LRPBnJfwYX6cx1D72pj/z0ENcRVvSa/KKuU8Jfv
         279RRdRL9d3L2P7VA7/RLGD0P7Gxy4VLYCixzZOGyopjLpAkg2ESRE5E9DCAUQ3QmcXOTLakJw0O
         5Dq+tYn3sFpSgG8/KgKcxtEYDTGfL0uW4ipGZ04H8Qnc6HMCZKdrspOkcIwpCoNWD0lO64bloj
From:   xkernel.wang@foxmail.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] ALSA: lola: add a check for the return of vmalloc()
Date:   Fri,  4 Mar 2022 16:38:20 +0800
X-OQ-MSGID: <20220304083820.4914-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

vmalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check the return
of it to catch the error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 sound/pci/lola/lola_mixer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index e2c8f14..6b16248 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -121,6 +121,8 @@ int lola_init_mixer_widget(struct lola *chip, int nid)
 
 	/* reserve memory to copy mixer data for sleep mode transitions */
 	chip->mixer.array_saved = vmalloc(sizeof(struct lola_mixer_array));
+	if (!chip->mixer.array_saved)
+		return -ENOMEM;
 
 	/* mixer matrix sources are physical input data and play streams */
 	chip->mixer.src_stream_outs = chip->pcm[PLAY].num_streams;
-- 
