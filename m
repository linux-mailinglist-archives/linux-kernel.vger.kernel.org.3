Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677C5A3627
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiH0JDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiH0JDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:03:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F0E29CA4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:03:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so1486191pjk.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=90UlM2PuWOh2i930PTJrjm9Hw09uaXewUF8YqD4wyuk=;
        b=UZT7avK2u7Igc1jSHNW5W6BqyyviOvdR6mP6igbn1yln+jQ1siSL5Tb+MV+h8L2lQs
         eeKGY7F8CR4qQ7lLvTIpw1A15s5zRadRVnzrKljONn2veUAseTe/UJqo1edF8dJpWJFY
         e93wzsKQjCal8eiEpln43OnJVl5qVGocCkgf7b4Cs7mdA9wdXQ5UOCLfSzOzeEEuDZnj
         yjclsxdbr5xmH/Ruo5ahQ7gp/ThrMpJo19S038MBFPB66JwymOpqdasZwEAw99oe224+
         +YHkEkPzFKlknen3DPuX5KI/yMTLDDdFn8t6meidzYC3pCkhCQFYLJZ7CKEPsWBR2VSC
         hZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=90UlM2PuWOh2i930PTJrjm9Hw09uaXewUF8YqD4wyuk=;
        b=eUV/g00bPYvnGNHonC8sNtdJb/t4sf0LHfO1I+OY2wgUjb+sV6kV6ALnC298cWymc/
         qL1XEIZYSig3BXkjriWOGM2dC9OZO2pFg+uiDmdychvdxyLMsv90HP8kzOXDgSCd5SwJ
         W/oKTt8sngpNzcrztkIDrFy6/ABhzo3NbcvWUlUrTvYuMKKVy6fJ8jySLg9x1BfIA2fn
         CD8MDnpOoZzB2Jv5qLrF6wCUy3ay0xiC1LtSPNvfpZXvaXdF9DKZDN/w7oMyKojdFuVZ
         DCJv795TUhKY6mIRIKaACA1kBKAnsOotIA0ZjqZaEEXBtuCTNz4iChLFiJxsIEjwwWZ5
         gKHg==
X-Gm-Message-State: ACgBeo3JSYRQsci+QV7iduGuKINSwXu3mE/01S39ZMgQpircIpCnVZBL
        vc59TJ91RVrrKa9c9glsow==
X-Google-Smtp-Source: AA6agR7jm26RfQlxhDsB8HFVODUjthl94fNCvZuO25VcQRFNig6aVaO0fULlUcZMUh5zB99+JErAJA==
X-Received: by 2002:a17:90b:3142:b0:1fa:f533:3191 with SMTP id ip2-20020a17090b314200b001faf5333191mr8274424pjb.193.1661590993285;
        Sat, 27 Aug 2022 02:03:13 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b001fb09316a26sm2943332pjj.43.2022.08.27.02.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:03:12 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 0/2] mm/damon: Simplify the damon regions access check
Date:   Sat, 27 Aug 2022 17:02:49 +0800
Message-Id: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

This patchset simplify the operations when checking the damon
regions accesses.

v2:
 -Update commit messages and fix the 80 characters warning.
 -Add the check when damon target changed.

Kaixu Xia (2):
  mm/damon: simplify the parameter passing for 'check_accesses'
  mm/damon/vaddr: remove comparison between mm and last_mm when checking
    region accesses

 mm/damon/paddr.c |  5 ++---
 mm/damon/vaddr.c | 13 +++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.27.0

