Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307E24FBA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbiDKK5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbiDKK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:57:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D43B2AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:55:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g12-20020a17090a640c00b001cb59d7a57cso4800374pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBbu++vBSNayZTILSoy+5ZJkZ1mpzPQD8VHz8a8sGvY=;
        b=XFXMbOusHesZHA6gwQAvFU7HTZpIvsbKmvIEG8F8zrsAIuW4QppeuRRX/AH70+9QbL
         wwH+qqogb2oMVb58vJkBeFBKHZ87O4PwsLqWNAh2mxVWPHAdRUBquqmy/W2JBWlzSra6
         ICrpFGApKTkyVje52v+ODM1+IMky3gMRw/OSVx3bjEl4uYyBO90j5ZcOQantpEpWEScl
         bexqOzHRAKyG2ue79HiOBCWz0ql6Pxg/jh32KvzbeQWVKoeyxv7OhjAKiQhccBAJF5/8
         5YXJ/541f6GllOEL2FtGZ28uWkTPPVdLoB3o3zn6SW+Lu/2MwAhiGjqS8ntRBr+3Y8jy
         QCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BBbu++vBSNayZTILSoy+5ZJkZ1mpzPQD8VHz8a8sGvY=;
        b=akhf1QoYYT8JhpN/xmYZfbSctiTY/sYhV9IqYwLkjHaVXcxQUv3SjjjkyoJgFhVzk0
         xWr+EsLsVnAnA7qFeU+Bj7oa43zW2r8NKVItOLCsLfh1abvducHn0okqvTYtBdHYK7TR
         9udSnTEa53SLhA2e2o+EqTHU/+v2hh7JHDDBNAXACSIIK97pwF3gJMqt3x43Rhe4+NSv
         WTgKJC2PHJmFk7BcKxNrCaiROceXJ0kc4/5lFC+4j9JcP0ihrPjVxIasjrmT5W8ga3+x
         nviQS6aj+P6eLV7pysLUGLwslHYjtIzxkYIsAhyqqLc0j1f/VEQNHYXjf7juT0bMQsz2
         mPvw==
X-Gm-Message-State: AOAM5308Zo2cWqI1WMh4hTpxG5WzMtSuMHyMVmIjaefaedthrdtwP2/g
        LhoosRhKrSertGaD1QpTbzciFw==
X-Google-Smtp-Source: ABdhPJwARghM2rwkZJdJicDl1OJ5uhAhOFscb86n6xacLMoXCE0Z28GOKLMOOp6KjpmRJb30QFSQ4A==
X-Received: by 2002:a17:902:ab8b:b0:156:16c0:dc6d with SMTP id f11-20020a170902ab8b00b0015616c0dc6dmr31826900plr.147.1649674539339;
        Mon, 11 Apr 2022 03:55:39 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b00505bf88a17bsm3496127pff.214.2022.04.11.03.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:55:38 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, iii@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, Eric Lin <eric.lin@sifive.com>
Subject: [PATCH v2 0/1] perf jitdump: Add riscv64 support
Date:   Mon, 11 Apr 2022 18:54:37 +0800
Message-Id: <20220411105438.21366-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable perf jitdump for riscv64 and it tested with V8 on qemu rv64.

Qemu rv64:
$ perf record -e cpu-clock -c 1000 -g -k mono ./d8_rv64 --perf-prof --no-write-protect-code-memory test.js
$ perf inject -j -i perf.data -o perf.data.jitted
$ perf report -i perf.data.jitted

Output:
 To display the perf.data header info, please use --header/--header-only options.

 Total Lost Samples: 0

 Samples: 87K of event 'cpu-clock'
 Event count (approx.): 87974000

 Children      Self  Command          Shared Object                Symbol

....
     0.28%     0.06%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal6WasmJs7InstallEPNS0_7IsolateEb
     0.28%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal10ParserBaseINS0_6ParserEE22ParseLogicalExpressionEv
     0.28%     0.03%  d8_rv64          jitted-112-76.so             [.] Builtin:
InterpreterEntryTrampoline
     0.12%     0.00%  d8_rv64          d8_rv64                      [.] _ZN2v88i
nternal19ContextDeserializer11DeserializeEPNS0_7IsolateENS0_6HandleINS0_13JSGlob
alProxyEEENS_33DeserializeInternalFieldsCallbackE
     0.12%     0.01%  d8_rv64          jitted-112-651.so            [.] Builtin:
CEntry_Return1_DontSaveFPRegs_ArgvOnStack_NoBuiltinExit
....

Changed in v2:
 - Rebase on tag v5.18-rc2
 - Show perf jitdump commands and dump in the commit message.

Eric Lin (1):
  perf jitdump: Add riscv64 support.

 tools/perf/arch/riscv/Makefile | 1 +
 tools/perf/util/genelf.h       | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.35.1

