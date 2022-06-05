Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F253DB4A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351056AbiFEKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFEKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:48:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175F33E36
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:48:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so8566948wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r9Y8kA9BOTqjotDV2mNar1zuSb0A2ydZEGgDX9CPjEM=;
        b=FLZNJToxPY/fFrCcKkWe23DlLTfvRfGg7qo6aLPcrKe//3rcwNFjRaUtPByggwBX8k
         rAMWAkjRKNL8HAqv1+rE3QKX2FYW1V1YQiMTpB1iudiM1PXQe2/LLXuSm6IY/N3wFpnl
         hSFm1t88mzm71f52MCrh+iNqHVJ4NKtonu3HobN6ics8RHh/3ueGy6rS+iB/vpgNuCaj
         r0rxQTb/p6l82eRP7hd1PLpUsFoUKbnz3wPzpE78HXIEYe7CKqd5drF4zTS4uu3qCsCb
         YeLS30mHS2OVncn6hqpfv+6QryISSYYf9j/dYxg5NsaMFyW89SUH4KK6SG1uquR85xt8
         Lb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r9Y8kA9BOTqjotDV2mNar1zuSb0A2ydZEGgDX9CPjEM=;
        b=ignV2hf4mvQ697pXrNuewiDSe76LM60Nuk0ajJNYbzhERzC2s6MLrHncC6+A+wP3Tt
         YEJf/FKFR+YBt9JdFkAOtb96FJewjOZNLIMG3SZ4qYY8pcUQm8T4WexGf3MkbpAH4Rw3
         MD0FvGXSTYoR74A0h0CmHrSVhn61Xl6VtXsu65sTes1OI0IGCsdNd2Mnd56uwytQsTtp
         JsV1M9QuvPLQa1C948/yDezkDwjbzREb69iy57YyVzmj+Ft+g1FmmPIvP/2mp8VM2v7a
         eLyPQf3p9E5BDL1hU8loRAd5Zi2PDhznZSjco+5e961dHG/yVZR/YaEzFLvvWHv21nbD
         mxZw==
X-Gm-Message-State: AOAM533HTz/l7INMoqwGftpx7raejU1NRwD9GjnuH7XP/+Ce1YrDprLL
        b0Y4gLICCVKKxKfPHXAambZc73KGISM=
X-Google-Smtp-Source: ABdhPJzsFGXyoQ8jgcQ/TOR3exxPM8FPT8amyEewO3ixyF9Ra3Evd7iYel0KocWlekBdVuAVyeXhnA==
X-Received: by 2002:a1c:4484:0:b0:39c:4597:1f74 with SMTP id r126-20020a1c4484000000b0039c45971f74mr7222774wma.13.1654426104651;
        Sun, 05 Jun 2022 03:48:24 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003973c54bd69sm21120580wmq.1.2022.06.05.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 03:48:24 -0700 (PDT)
Date:   Sun, 5 Jun 2022 11:48:22 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: mainline build failure due to 0a97953fd221 ("lib: add
 bitmap_{from,to}_arr64")
Message-ID: <YpyJ9qTNHJzz0FHY@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for "arm allmodconfig"
and "csky allmodconfig".

"arm allmodconfig" fails with the error:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/smp.h:13,
                 from ./include/linux/lockdep.h:14,
                 from ./include/linux/mutex.h:17,
                 from ./include/linux/rfkill.h:35,
                 from net/bluetooth/hci_core.c:29:
In function 'fortify_memcpy_chk',
    inlined from 'bitmap_copy' at ./include/linux/bitmap.h:254:2,
    inlined from 'bitmap_copy_clear_tail' at ./include/linux/bitmap.h:263:2,
    inlined from 'bitmap_from_u64' at ./include/linux/bitmap.h:540:2,
    inlined from 'hci_bdaddr_list_add_with_flags' at net/bluetooth/hci_core.c:2156:2:
./include/linux/fortify-string.h:344:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  344 |                         __write_overflow_field(p_size_field, size);


And, "csky allmodconfig" fails with the error:

In file included from ./include/linux/cpumask.h:12,
                 from ./include/linux/mm_types_task.h:14,
                 from ./include/linux/mm_types.h:5,
                 from ./include/linux/buildid.h:5,
                 from ./include/linux/module.h:14,
                 from net/bluetooth/mgmt.c:27:
In function 'bitmap_copy',
    inlined from 'bitmap_copy_clear_tail' at ./include/linux/bitmap.h:263:2,
    inlined from 'bitmap_from_u64' at ./include/linux/bitmap.h:540:2,
    inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
./include/linux/bitmap.h:254:9: error: 'memcpy' forming offset [4, 7] is out of the bounds [0, 4] of object 'flags' with type 'long unsigned int[1]' [-Werror=array-bounds]
  254 |         memcpy(dst, src, len);
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/kasan-checks.h:5,
                 from ./include/asm-generic/rwonce.h:26,
                 from ./arch/csky/include/generated/asm/rwonce.h:1,
                 from ./include/linux/compiler.h:248,
                 from ./include/linux/build_bug.h:5,
                 from ./include/linux/container_of.h:5,
                 from ./include/linux/list.h:5,
                 from ./include/linux/module.h:12,
                 from net/bluetooth/mgmt.c:27:
net/bluetooth/mgmt.c: In function 'set_device_flags':
net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
      |                                        ^~~~~
./include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
   11 |         unsigned long name[BITS_TO_LONGS(bits)]


For both the failures, git bisect points to:
0a97953fd221 ("lib: add bitmap_{from,to}_arr64")


And, reverting it on top of mainline branch has fixed both the build failures.


--
Regards
Sudip
