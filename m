Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0047A6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhLTJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:23:30 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55691 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhLTJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:23:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V.B9zbM_1639992199;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V.B9zbM_1639992199)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Dec 2021 17:23:20 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 0/5] Remove duplicate context init function for sha algorithm
Date:   Mon, 20 Dec 2021 17:23:13 +0800
Message-Id: <20211220092318.5793-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is mainly for repetitive code cleaning. The sha
algorithm has provided generic context initialization implementation.
The context initialization code in the optimized implementation of each
platform is a repetitive code and can be deleted. The sha*_base_init()
series of functions are used uniformly.

Tianjia Zhang (5):
  crypto: sha256 - remove duplicate generic hash init function
  crypto: mips/sha - remove duplicate hash init function
  crypto: powerpc/sha - remove duplicate hash init function
  crypto: sparc/sha - remove duplicate hash init function
  crypto: s390/sha512 - Use macros instead of direct IV numbers

 arch/mips/cavium-octeon/crypto/octeon-sha1.c  | 17 +-------
 .../mips/cavium-octeon/crypto/octeon-sha256.c | 39 ++-----------------
 .../mips/cavium-octeon/crypto/octeon-sha512.c | 39 ++-----------------
 arch/powerpc/crypto/sha1-spe-glue.c           | 17 +-------
 arch/powerpc/crypto/sha1.c                    | 14 +------
 arch/powerpc/crypto/sha256-spe-glue.c         | 39 ++-----------------
 arch/s390/crypto/sha512_s390.c                | 32 +++++++--------
 arch/sparc/crypto/sha1_glue.c                 | 14 +------
 arch/sparc/crypto/sha256_glue.c               | 37 ++----------------
 arch/sparc/crypto/sha512_glue.c               | 37 ++----------------
 crypto/sha256_generic.c                       | 16 +-------
 11 files changed, 41 insertions(+), 260 deletions(-)

-- 
2.32.0

