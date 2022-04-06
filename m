Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FE94F6791
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiDFRaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbiDFR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:27 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513D182AFF;
        Wed,  6 Apr 2022 08:32:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaP017647;
        Thu, 7 Apr 2022 00:30:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaP017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259039;
        bh=ndm1WDAbt9/rjEylpsXuA9cyn3z2PfelOFyCYEZ9OVI=;
        h=From:To:Cc:Subject:Date:From;
        b=HsCXPe29MYtetJOqJFbTKiHB2uKifL2Sv8/kGjmWg+otp4IawIVwbHZQ6IMmENN27
         tExikjqx6gJHVaL4nK2yY2G5EeeAL8HEndlytK+wDrCxVHmjxGdS3C3vd41D9iIHAd
         z1fGZTg05gRU+hW5dgj0E/6qmjWqttzgm+M6Kpuu2yVGOyzBe9nII/cVb5V/PxPBKZ
         QnPN9dRvv74WFHW2V4cSc6TuIcn25D717SckK7fEdD8IYAeb9/o3nUSIau/GbKBp6O
         MqN1+MHf2Uhap5PFIWd7LOpa+ZzGyQ9S3iapIc0BR/+kF4RRmSsPogKp7uHs7IpBP1
         YvpHGr2n3EFdg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH 0/7] kbuild: more misc cleanups
Date:   Thu,  7 Apr 2022 00:30:16 +0900
Message-Id: <20220406153023.500847-1-masahiroy@kernel.org>
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


I sent the first batch of cleanups:
https://lore.kernel.org/linux-kbuild/20220405113359.2880241-1-masahiroy@kernel.org/T/#t

I took 01-06, 09-10.
I dropped 07, 08.

This is the second batch.



Masahiro Yamada (7):
  kbuild: reuse suffix-search to refactor multi_depend
  kbuild: make multi_depend work with targets in subdirectory
  kbuild: reuse real-search to simplify cmd_mod
  kbuild: split the second line of *.mod into *.usyms
  kbuild: get rid of duplication in *.mod files
  kbuild: make *.mod not depend on *.o
  kbuild: read *.mod to get objects passed to $(LD) or $(AR)

 .gitignore                  |  1 +
 Makefile                    |  5 +++--
 scripts/Makefile.build      | 31 ++++++++++++++-----------------
 scripts/Makefile.lib        |  6 +++---
 scripts/adjust_autoksyms.sh |  2 +-
 scripts/gen_autoksyms.sh    | 18 +++++++++++-------
 scripts/mod/sumversion.c    | 11 ++---------
 7 files changed, 35 insertions(+), 39 deletions(-)

-- 
2.32.0

