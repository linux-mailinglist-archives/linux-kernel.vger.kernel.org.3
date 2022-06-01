Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D604F53ACB3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356594AbiFASWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiFASWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:22:33 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 11:22:32 PDT
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF7D4B1CB;
        Wed,  1 Jun 2022 11:22:32 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 251IJkAQ014364;
        Thu, 2 Jun 2022 03:19:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 251IJkAQ014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654107588;
        bh=1RpBGGftTVY4f1Th6jTQ5+KvJS9jZPLe7SVIWfT+mGI=;
        h=From:To:Cc:Subject:Date:From;
        b=xTkhr0bxDTEhtAk049KwrvCmJ8PmfLMOvfNqYQv6N1GGs+1JIoRe9bq32+GbKo7xo
         6xLmO4yTpuIDczaOmrBiVYnxsQX9ze7wx8Xihc/Tcx23X8J3wMoBdOJCUFP9eFDmhC
         FLqI2bfsMUORfZV3101r6VtWVpZsDX8rnIxwYLBvY03REIrUkBZWLcQCswwMBRrxRd
         Xlh6JNyLIDBImFMen49QIfM1KpjSpV3QeKr+FWvAAUiMgafbPC1fcdl62ZM7GFbGW1
         Z9hnHTrCa+k2Ll6r9C5vBROZCNUUBwBNzl0fbSRa81NuSX4cPQOeHO//MqIg9pzNBW
         5PwU3IW5gfyUQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Christopher Ferris <cferris@google.com>,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 0/3] asm-generic: fix misconversion of {uid,gid}_t
Date:   Thu,  2 Jun 2022 03:19:38 +0900
Message-Id: <20220601181941.3706832-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I accidentally broke android binder.h:
  https://lore.kernel.org/all/20220601010017.2639048-1-cmllamas@google.com/

I checked my previous conversions, and found some more.
(at least, the sparc one seems fatal.)



Masahiro Yamada (3):
  mips: use __kernel_{uid,gid}32_t in uapi/asm/stat.h
  powerpc: use __kernel_{uid,gid}32_t in uapi/asm/stat.h
  sparc: fix mis-use of __kernel_{uid,gid}_t in uapi/asm/stat.h

 arch/mips/include/uapi/asm/stat.h    | 12 ++++++------
 arch/powerpc/include/uapi/asm/stat.h |  4 ++--
 arch/sparc/include/uapi/asm/stat.h   |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.32.0

