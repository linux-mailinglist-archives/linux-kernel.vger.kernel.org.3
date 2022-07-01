Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D3563689
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiGAPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiGAPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:04:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453364E7;
        Fri,  1 Jul 2022 08:04:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ej4so3305428edb.7;
        Fri, 01 Jul 2022 08:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUvDFTNjBVAxyp0db2t+stTwZzbAcS41bhZmCtIsEYA=;
        b=f7AeqqFqzgXxtcuWRs8lLupxM0ak148PRTNyOJs6wY1XRC08iESF84RioBBBpC3s1j
         QQvFEC8UmugVqcTWv/LR9v0zxAT9PjJiXaFXFz5vBw5WkofFi7dUxh6LqDLmpMUaQg+d
         1jjgLqlSnFD6j87dLD23IVigB/I0zGyfgIqOBzgE575Klf/jdDLFWNtgKkE0wF6/yz0j
         Allbvi0Gs5WEc7KQ+hdRr6rZBG43TVtA7r2Bs3eb/UWLTeke4ArHzn2+JVpiJMEAlinT
         UQfK+E4UChKNv9c07KYiN12R6qn6Gk4tG3jJPVq/KqawRLLTnneGfjv0I/rQBosW54E2
         cIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUvDFTNjBVAxyp0db2t+stTwZzbAcS41bhZmCtIsEYA=;
        b=tyL4JFLdLhA2cAjtkKixs0jJjlNX1lAZ0+zGyxEjbB1fYIQZqnLHQvRDMcIWj0gvCG
         GjxmS/JyivHqicFgfUkIA//oK25uRxLjEwAe19Abzzzsp+y0G2LR+l2zY3epLtlqO9eE
         n5s6L6Hq4ljO9UJmHQLCiCajU9CW2KNg7qtxr4lwez46FgKV/tMlCzE7RVXpysok2+zw
         El2Jh35XG3emtIEcnUn1+vyqsyWKaGlN55Do+TheexeI1rl7tNiOScUbHcAwQ6J2n+dm
         cEslVwuV9I83s8oejwq0aRrYY7RZHau641Jnlc8AJpQcujqWzORVwICIB4dxDX7ZgUfy
         ZgsA==
X-Gm-Message-State: AJIora+ZeWljoWuO2zljOQRimk2eqmzSQCXwudIHaC1oblD6dL5liasj
        +SEqVokF8M7TKqvKMVp7RbrxtngFuJ0=
X-Google-Smtp-Source: AGRyM1swT3xgjyzB2WswlScOBZ3d9Ygbiuz/UwAl/e7SGb0i3knFLz3ydr75L1m+teiDZoGxLGukAQ==
X-Received: by 2002:a05:6402:26cb:b0:436:2173:3f7 with SMTP id x11-20020a05640226cb00b00436217303f7mr19768962edd.61.1656687874058;
        Fri, 01 Jul 2022 08:04:34 -0700 (PDT)
Received: from kwango.redhat.com (ip-94-112-17-81.bb.vodafone.cz. [94.112.17.81])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906174600b00715705dd23asm10561886eje.89.2022.07.01.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:04:33 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 5.19-rc5
Date:   Fri,  1 Jul 2022 17:04:09 +0200
Message-Id: <20220701150409.9288-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc5

for you to fetch changes up to 8692969e9164c15474b356b9898e5b9b21a85643:

  ceph: wait on async create before checking caps for syncfs (2022-06-29 18:02:57 +0200)

----------------------------------------------------------------
A filesystem fix, marked for stable.  There appears to be a deeper
issue on the MDS side, but for now we are going with this one-liner
to avoid busy looping and potential soft lockups.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: wait on async create before checking caps for syncfs

 fs/ceph/caps.c | 1 +
 1 file changed, 1 insertion(+)
