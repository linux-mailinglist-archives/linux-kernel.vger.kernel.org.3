Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52F5033D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiDPE2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiDPE2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6210E067
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso8443731pjv.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kfn9RKVykwgjxMcKUCHR5UwqEtaPGUqAfRsX4HZfzFs=;
        b=Z9ZyBG4Cj/pIIq4MSJeMAqxoSf/Bp93uhfWweWOgdeXiMIIeUQ9uQLqzcSYagoUeMy
         k9hRYmJ6n1rpVJXMQUYTyRdN55l74Gh/fipONYNB+H+6f23icNIyeoXZzUxvIWL0P7Ww
         hgjPPwJEa0GfhgXe+zwfUQ2b4xtcbG4stzyFx8Vdk5cpqGjWzkXlMMF8Q/k6omlbYEhT
         0jUT0hrNCcJJnmPWAZE4zjE/6tgQ2ipxoAzyCJwRyngLAWwV4vf01yf3dAvozSYnT5K9
         uWVt7Q7igkmhRBJmYEMoQIJeLNsdQf0KiVpWd49O0Y9Js2SbHYHZQYgRrVj2z54tlGRx
         /r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kfn9RKVykwgjxMcKUCHR5UwqEtaPGUqAfRsX4HZfzFs=;
        b=hH+RkurpG+FFDpn0Rdiu8BAa5n7SF+2T1uDrNXQzG408UZmbR5W/Ah97yyitcGSTOF
         PyUUPbeiG3V6RLm68XDJGVwEcJi8dgHKWruEiHnsN5oUoUy+O5H8ckFPqoOhtwYojLZp
         yim2nv8uV0FuiCctg9XpX6QOrTvai55rcVaGuVAa68Bxw5NWdijTrZjyFd0+pBwFpq2e
         PsRIoX1QB2lYFgz8L8dbPhOWwcdf/t61gzKN+RPICEzHwwJRaCu6P5LqvKXNFnHtxysj
         QqoD7sAO5jyyeSOY+qSzGiMgyZR+8Hkj5lh11qtv9oJ1qnioipz/YkcRxp4P2Txd2RKO
         Fu+A==
X-Gm-Message-State: AOAM533DVH/XTq70/R2iEMtbyid90Ii/loZzFBjfefLtTCgFgwkIIFwm
        2NqJRkheKtb8reeb5OuVefg7czzZ4ng=
X-Google-Smtp-Source: ABdhPJy/MpeE3ZYNpDisongynLWtcM40y6/pI46vvgbpkiKabZ73IF8B17+q7ehM49X1dLScsbg0RQ==
X-Received: by 2002:a17:90a:ca84:b0:1cb:adf4:1740 with SMTP id y4-20020a17090aca8400b001cbadf41740mr7581767pjt.109.1650083177704;
        Fri, 15 Apr 2022 21:26:17 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:17 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/6] xtensa: support coprocessors on SMP
Date:   Fri, 15 Apr 2022 21:25:53 -0700
Message-Id: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series does a bunch of small cleanups around coprocessor handling
code and adds coprocessors support in SMP configurations.

Max Filippov (6):
  xtensa: clean up function declarations in traps.c
  xtensa: clean up declarations in coprocessor.h
  xtensa: clean up excsave1 initialization
  xtensa: use callx0 opcode in fast_coprocessor
  xtensa: add xtensa_xsr macro
  xtensa: support coprocessors on SMP

 arch/xtensa/include/asm/coprocessor.h | 10 ++--
 arch/xtensa/include/asm/processor.h   |  7 +++
 arch/xtensa/include/asm/thread_info.h |  7 ++-
 arch/xtensa/include/asm/traps.h       | 11 +++-
 arch/xtensa/kernel/asm-offsets.c      |  8 ++-
 arch/xtensa/kernel/coprocessor.S      | 61 +++++++++++++--------
 arch/xtensa/kernel/entry.S            | 17 ++++++
 arch/xtensa/kernel/process.c          | 70 +++++++++++++++---------
 arch/xtensa/kernel/traps.c            | 77 +++++++++++++++------------
 9 files changed, 177 insertions(+), 91 deletions(-)

-- 
2.30.2

