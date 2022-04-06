Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825E04F6650
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiDFRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbiDFRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:03:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA834165B94
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:26:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso2875480pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfj1GIB+si6iET8SbCUdgiY5TZkavgwCt42bdaZqDa8=;
        b=Vvm9hL/jx899S3DqVkPLQ4gKE9BtEMVtFydVbiu7k76eQunfKC3BHg1hFdx4qg1i+e
         DjUhoSjNNE92WqiwQUNMiQEratkmQr+MsduISz4ZLfGVnZkCVbaWoD+zlLsaY7dNrilj
         aUwctTARoNBM21LjlWHKUpoD5td8acnO3XNg36vQbjhMP7wYlQDhqUuKIs5tmXd9HDHu
         k2/TGe7SPoBLkU+ISiVwk0QbnxlDY6o72IjLqzih2XLGLp/uKF3nWrBo4sOv/zEdAI0S
         RoiHTeF+wHxvshyAo9XN4B3gbG6GWGQBMfPZQhrRGOKeqFTOO1GXbTMb+9N/FHmUrdSr
         tX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfj1GIB+si6iET8SbCUdgiY5TZkavgwCt42bdaZqDa8=;
        b=icLU3LnoRgXMNhKBs8w4lvGyR0zgHjLRIQiFwbg/+2UOMSWjGR59Zuc9ZI2+QXcseA
         yopqIobExFH+maz4trCS1uGEqYztNOvTLZZbEDIXrm7sSaFjutpUavIOlJZg0dl+hbk2
         cqli9NPLSA3d8biuBlawEh7eUVypeiN/k6wmoXNZ0wT8EDaPGGgnhRyRhSq30fkhY0U5
         FDsdnyF0i/Hqm+39rhoKRwWqO6LTLtUKIOAzF/G/yD//y2Mz1DrQNGdDGvfmpYSAfs+Y
         sTDBhBlkDcNhxZT63PlflKfy1mcvcZVFdz9b6/eQAeyA1TAd5JVXzPS2PwYq8V1XTSsQ
         nfpA==
X-Gm-Message-State: AOAM531RltuxoQF6n4Yr0gmfM1p1GRRRzXB4x21yg6CLOyLifmcLGX+/
        8Kuvgho3cwNPMWaQc15H4971CQ==
X-Google-Smtp-Source: ABdhPJw/oS8u3VzD9ycSvMGnTyIHEMUViuTNCy58B7lrkCZJ5lDsvskJD9wu0X6ITQ01e5SSTXqfBQ==
X-Received: by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP id c20-20020a170902b69400b001531d9a11a5mr8919433pls.151.1649255202175;
        Wed, 06 Apr 2022 07:26:42 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm16424151pga.77.2022.04.06.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:26:40 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, iii@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, greentime.hu@sifive.com,
        Eric Lin <eric.lin@sifive.com>
Subject: [PATCH 0/1] perf jitdump: Add riscv64 support
Date:   Wed,  6 Apr 2022 22:26:05 +0800
Message-Id: <20220406142606.18464-1-eric.lin@sifive.com>
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

This patch enable perf jitdump for riscv64 and it tested with v8 on qemu rv64.

Qemu rv64:
# perf record -e cpu-clock -c 1000 -g -k mono ./d8_rv64 --perf-prof --no-wr
ite-protect-code-memory test.js
# perf inject -j -i perf.data -o perf.data.jitted
# perf report -i perf.data.jitted

Output:
# To display the perf.data header info, please use --header/--header-only option
s.
#
#
# Total Lost Samples: 0
#
# Samples: 87K of event 'cpu-clock'
# Event count (approx.): 87974000
#
# Children      Self  Command          Shared Object                Symbol

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

Eric Lin (1):
  perf jitdump: Add riscv64 support.

 tools/perf/arch/riscv/Makefile | 1 +
 tools/perf/util/genelf.h       | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.35.1

