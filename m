Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62654EF0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379517AbiFQCCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379270AbiFQCCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:02:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8B61602
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:02:18 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b1-20020a631b41000000b003fd9e4765f4so1541080pgm.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=H3ch/skPh6OWdU3ZVapoiPf5KZK/QNqeESV3G0ohIf4=;
        b=TM8dvv8PAusNRsHX7JT7RoJzYQTc2K2Fj42aMjHDjEQDjZS+8V9H/udQmC0QADcPZU
         xOVk2MucjbnCuP/EavRFEyW8mTSlskH0SxvWksL6W6g6s6rJEz8Q9JdDqyy6/Eb72kfd
         K78HNsE2n6nSFlW7bYKMhGJ/OlS4X1gWifLR9bUGWr2jkqOx5dG1OOVmdbHngLWBnfKY
         DLTukrwmhcxvgImBimTtgy9By9TKTrgdoTUYTkjVGBvR/2ynkQ+QOkgVTqAwoGOuM5H3
         FZw5OXnp/gIkwnEPE21DNoP5CZX+NgqlJ9Z3+mrNTf3dPzhdMv/z/WaFRu6OXMmJNYlZ
         3vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=H3ch/skPh6OWdU3ZVapoiPf5KZK/QNqeESV3G0ohIf4=;
        b=QmNC6bC4o1w3RRaxkd63IDj8Ws874ndBRUywO2lzwFNWaObHEFPTbh7qCKNsLgg2UN
         APHn94OcbdVH0CUnP6jTEMXI3JoCGNB0o4eB+BGG319PuMPImYTaL0Bt4av9FW3kv+gw
         0UwRQLTm7ZERlNBi1XrWGx2MuMRkNLo8rBuG0MPh738baw1e7Pki7vq7gdhed5CpSUNr
         jOKBh1w9y/7FIJx436dZcO3yuBJ8N2kKarpi6JZhMTuKHXfknotfnf4GfjQJfafuyqBL
         DF8t8iRVCATIKl6LqRN4+IbA9nv3w7fF3yhFyx1pxI+iLK7JwdlEnRoZbQs+NBCsXt7P
         ayLg==
X-Gm-Message-State: AJIora+fSLgHtGlSxB7i+87CqfNDoQWLEbN88oXO3o7r6lP5UlwEvlYv
        Dn9Hd8TRmUw2ZkaoQFL16bfxHwDiXuCsHw==
X-Google-Smtp-Source: AGRyM1shuBG8YdgFYn+WRFakGWM0o05iu9Qupw/A5WgGLHcuw/AKAOQjLpdfXOnUOblsTmkp0Vnq0wxr1DuxVA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:4a0a:b0:1e8:5078:b573 with SMTP
 id kk10-20020a17090b4a0a00b001e85078b573mr7994165pjb.213.1655431338029; Thu,
 16 Jun 2022 19:02:18 -0700 (PDT)
Date:   Fri, 17 Jun 2022 02:02:13 +0000
Message-Id: <20220617020213.1881452-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH net] ipv4: ping: fix bind address validity check
From:   Carlos Llamas <cmllamas@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Riccardo Paolo Bestetti <pbl@bestov.io>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Carlos Llamas <cmllamas@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ff978b8b222 ("ipv4/raw: support binding to nonlocal addresses")
introduced a helper function to fold duplicated validity checks of bind
addresses into inet_addr_valid_or_nonlocal(). However, this caused an
unintended regression in ping_check_bind_addr(), which previously would
reject binding to multicast and broadcast addresses, but now these are
both incorrectly allowed as reported in [1].

This patch restores the original check. A simple reordering is done to
improve readability and make it evident that multicast and broadcast
addresses should not be allowed. Also, add an early exit for INADDR_ANY
which replaces lost behavior added by commit 0ce779a9f501 ("net: Avoid
unnecessary inet_addr_type() call when addr is INADDR_ANY").

[1] https://lore.kernel.org/netdev/CANP3RGdkAcDyAZoT1h8Gtuu0saq+eOrrTiWbxnO=
s+5zn+cpyKg@mail.gmail.com/

Fixes: 8ff978b8b222 ("ipv4/raw: support binding to nonlocal addresses")
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Riccardo Paolo Bestetti <pbl@bestov.io>
Reported-by: Maciej =C5=BBenczykowski <maze@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 net/ipv4/ping.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 1a43ca73f94d..3c6101def7d6 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -319,12 +319,16 @@ static int ping_check_bind_addr(struct sock *sk, stru=
ct inet_sock *isk,
 		pr_debug("ping_check_bind_addr(sk=3D%p,addr=3D%pI4,port=3D%d)\n",
 			 sk, &addr->sin_addr.s_addr, ntohs(addr->sin_port));
=20
+		if (addr->sin_addr.s_addr =3D=3D htonl(INADDR_ANY))
+			return 0;
+
 		tb_id =3D l3mdev_fib_table_by_index(net, sk->sk_bound_dev_if) ? : tb_id;
 		chk_addr_ret =3D inet_addr_type_table(net, addr->sin_addr.s_addr, tb_id)=
;
=20
-		if (!inet_addr_valid_or_nonlocal(net, inet_sk(sk),
-					         addr->sin_addr.s_addr,
-	                                         chk_addr_ret))
+		if (chk_addr_ret =3D=3D RTN_MULTICAST ||
+		    chk_addr_ret =3D=3D RTN_BROADCAST ||
+		    (chk_addr_ret !=3D RTN_LOCAL &&
+		     !inet_can_nonlocal_bind(net, isk)))
 			return -EADDRNOTAVAIL;
=20
 #if IS_ENABLED(CONFIG_IPV6)
--=20
2.36.1.476.g0c4daa206d-goog

