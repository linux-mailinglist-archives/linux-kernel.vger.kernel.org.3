Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB15AC4EA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiIDPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiIDPR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:17:26 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC133427
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 08:17:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g14so4730840qto.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Qg14KAR5yRWmPJdHFs0q9bs6+kIlvmZZHVh2Rc+wcyI=;
        b=hLerUNWGni6uy5HPrDFGAuE984Edt/VTpgZ4+IdB3VoufOHO84YGjkXKqb68D9+QUg
         9a6JUdyUXw7sg4f7zMga5xGgdyWNhwd3CafYG8renw4Oz3vbi28vJz92xAVY3qJBRjhR
         B5duACaBzo+98yQ0MwORO6vJSlDasjiI2BtpwJpfuINrwYpWJV2n3Q6XNq0YjW4ND/BQ
         /Ej1+JI4i87VL6OC3dcuR3ccFxKstyFlamA6sXvk5n4GwCsUB5Gvmw2z6kYvwScdQdyp
         8Yxr/l3qoDe6c13LjwzupEpBRQdkKnRnmpjv5+4bhmY6TH362l7d9aPmSUd1gMgXF7Ei
         7LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Qg14KAR5yRWmPJdHFs0q9bs6+kIlvmZZHVh2Rc+wcyI=;
        b=pIsZPGnKencXGAmXyy8IngSbI9RLDHlnEkXDQrrZpqBK41biSc4HSSmIh3e9mV5qT8
         0t9DNlInOZ0j1J+8+atfktoDoNKkm6OVEAyCxW5p0SpyjEESvKRpME+r+rfNqzNesoqE
         onqQ7vvJw4rzDvq8S/dbHxwPZO3gMyN0nEDv77z5X9WZ+Ns33VsiMfmRl2NAaIdjQ9s5
         QmXnraiz1Zlz4KSyDIcMU1/miD36dNH06zQ4K+yKeT6DnUVins5toNqqPfuzRmChkEZO
         Ym2JHvmJwVPKe9C4viGLVAUAphWFRsBbArFTEjik2c4WnAeALNYQQ8KPtvN6IpatoDnq
         SwNg==
X-Gm-Message-State: ACgBeo2w8NODN++oeoYj8fC6EXd+e4/2vyFIYtvfyufytfy33tyMRZ3C
        mVxBVS0Ja963j1vMXiuoX3wwU3PLLoDbVNm86nw=
X-Google-Smtp-Source: AA6agR493lqpsKu6OMermHc+Fep3qhLapB8A+58D+zuwIRHd4cSiG5wacJPv7VbYKRGi4R55ZQ6TVUZl70hK+qM5dGg=
X-Received: by 2002:ac8:7e8d:0:b0:344:7e3a:3da9 with SMTP id
 w13-20020ac87e8d000000b003447e3a3da9mr35416922qtj.37.1662304644398; Sun, 04
 Sep 2022 08:17:24 -0700 (PDT)
MIME-Version: 1.0
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sun, 4 Sep 2022 23:17:13 +0800
Message-ID: <CAJRQjofRCF7wjrYmw3D7zd5QZnwHQq+F8U-mJDJ6NZ4bddYdLA@mail.gmail.com>
Subject: [PATCH] pstore/zone: Use GFP_ATOMIC to allocate zone buffer
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a case found when triggering a panic_on_oom, pstore fails to dump
kmsg. Because psz_kmsg_write_record can't get the new buffer.

Handle this by using GFP_ATOMIC to allocate a buffer at lower watermark.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/pstore/zone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 017d0d4ad329..2770746bb7aa 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -761,7 +761,7 @@ static inline int notrace
psz_kmsg_write_record(struct psz_context *cxt,
  /* avoid destroying old data, allocate a new one */
  len = zone->buffer_size + sizeof(*zone->buffer);
  zone->oldbuf = zone->buffer;
- zone->buffer = kzalloc(len, GFP_KERNEL);
+ zone->buffer = kzalloc(len, GFP_ATOMIC);
  if (!zone->buffer) {
  zone->buffer = zone->oldbuf;
  return -ENOMEM;
-- 
2.25.1
