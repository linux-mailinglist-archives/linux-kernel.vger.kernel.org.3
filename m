Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF79051F521
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiEIHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiEIG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:58:44 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75FE1A04AE
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:54:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [138.197.159.143])
        by gnuweeb.org (Postfix) with ESMTPSA id BB6947ED99;
        Mon,  9 May 2022 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652079291;
        bh=S02Hmy2ySu7f3PmzWcyNC62xCF6tNDxQIeCYDbJJgL8=;
        h=From:To:Cc:Subject:Date:From;
        b=G2IVrpE8mpPZ6ZJ3DtpuPGtHCD7jbj2Wp3e2vG25GZDwMwdBR+pX7u5Dxk6FSBlea
         1/Bpxki+2qV/qtRWzpfXDZJFMGgmUn/MrBcgZm5FzoIh34EzzjQrHFYIG1fmKCO/7d
         lyD9d04NrbHidiAzbde2tymzUnWR/oPaskLAtz5R1Pa4mipoFaVY8/fyDxbmJylh/O
         jgvyPXPIXrjMS0+OnqmTyvqInGQ55iYnvq8ou4m3m4lZLzc8I56Yj93qle+cpNsUSD
         yMaQmt2JU22kcqoie+4GCZePosrqvWXCZaCs6+58MZ9fN6uq0goDTaZ2AQdTAphWHS
         SUOIzcwG7tWrw==
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: [PATCH 0/1] Add format attribute to enable printf warnings
Date:   Mon,  9 May 2022 06:54:44 +0000
Message-Id: <20220509065445.3912334-1-alviro.iskandar@gnuweeb.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

When we use printf and fprintf functions from nolibc, we don't get any
warning from the compiler if we have wrong arguments, for example the
following calls will compile silently:
```
  printf("%s %s\n", "aaa");
  fprintf(stdout, "%s %s\n", "xxx", 1);
```
Those calls are undefined behavior. We can catch it at compile time by
adding format attribute to those function declarations. After this
patch, we get the following warnings:
```
  warning: format `%s` expects a matching `char *` argument [-Wformat=]
  warning: format `%s` expects argument of type `char *`, but argument 4 has type `int` [-Wformat=]
```

Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
---

Alviro Iskandar Setiawan (1):
  tools/nolibc/stdio: Add format attribute to enable printf warnings

 tools/include/nolibc/stdio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 2fbaf4ddb5e2f64a565247683093b869b5b3f792
prerequisite-patch-id: 1bcffd448f6984eee80d86560af19672cd4ae716
prerequisite-patch-id: 3e31c80bd4dd532e30b4bba76e5d98647e21184b
prerequisite-patch-id: 34e531967a67791d5b3c3e071527de7235715906
prerequisite-patch-id: 14105c6ae9dcc068ddf12a7c1bf431066199b813
prerequisite-patch-id: 4299173943ea579f538da00488fb1a7b1a690a79
prerequisite-patch-id: dd85164f2ec9eb8cea64ab801abac614f9d0c8f5
prerequisite-patch-id: 2c1b940635d1564e26b9959eb57cf9fa6983cb2f
prerequisite-patch-id: 8b1b453d855c9b8081353ffbddd03f6cfcfa2ab6
-- 
Alviro Iskandar Setiawan

