Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35D586D28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiHAOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiHAOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:43:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D873F31B;
        Mon,  1 Aug 2022 07:42:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k26so5033695ejx.5;
        Mon, 01 Aug 2022 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=h2Fh+iK1e/QXgWo5H0E1vU8kQtq/DJDwu1GYW3hBz3Y=;
        b=U1bGqNNi1488a5iQcjmUPIAFQYYL00jEn92UgvoN7kGOXtK556evaWQRjGHI6vxWty
         ZzJRqCGQz9VhJ48p+UaAhe6QFoOc1zDBUQDUs/HH8yBOAiF6xpDRPe+eiaTutbL3GkBI
         U5aRJm2f9gRSzde23vRXcOcazq/x2oqh0J56ORWu9wpnBAbDWeNpH6Ya/64EiAfklM8r
         8tqqRrrszfAE1oAoPQ1dhB9Tf1T+YfiOAxqtA1fWCyKRPLrRvoMv1/T8ccMhWBRP5p9C
         dlCdhPM8O3OdrsqifZH+Da8RPxA6SxRk+I2yUNk8ohJGpOHBqLngQvjfbDu5q0R4tuo5
         S/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=h2Fh+iK1e/QXgWo5H0E1vU8kQtq/DJDwu1GYW3hBz3Y=;
        b=Cdy+mLQ4WbjS88XC2IulXc6YKUTaVF2drFIjNUtGxGsgHCPRrxv9w/maRsIbB3wX1r
         bAiraJq7O2UeiGmN3C6hJXAiWpNzmgyJC10FX4OPNniEOQMz4xNcoq+g1BliLZO8P0X1
         fBkp9Zj904vdnlKC5JK9w8jVNufzbR2OTJQfbPvNpzCPlXkXiPOIRlFquXnT2Qeu4CCk
         18avLUrTCWhNichomhjVVMDsFHMhw7zm5r2EKWI0pBMtPcbpEqADInAuKkArNRamkyti
         0E9+8ud0xWrbazLRoZRa0CQO13Sypv87QYvFVw/bRvSn7MkTFnwpQ23eTwcpYoVZPCx6
         RusQ==
X-Gm-Message-State: ACgBeo3UoUX2Pf2Sh0Ehz4cWgt+dxmGWOZHtdlzPipsQICtGZbNmL2Fu
        JyEICeSAV06wl36FHylKHCc=
X-Google-Smtp-Source: AA6agR4rew6sHeQa75WoyFDHFnmrBC5+biAhpvP3kI83fB/IPFaMC+sxN5BhASmkuiO/lt8aR2v2/Q==
X-Received: by 2002:a17:907:2c54:b0:730:984d:70b6 with SMTP id hf20-20020a1709072c5400b00730984d70b6mr1225561ejc.102.1659364945535;
        Mon, 01 Aug 2022 07:42:25 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id e24-20020a170906315800b007246492658asm5283190eje.117.2022.08.01.07.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:42:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 16:42:22 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Perf events updates for v6.0
Message-ID: <YufmTs3WbIcjlfyV@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-08-01

   # HEAD: 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5 perf/x86/ibs: Add new IBS register bits into header

Perf events updates for this cycle are:

- Fix Intel Alder Lake PEBS memory access latency & data source profiling info bugs.

- Use Intel large-PEBS hardware feature in more circumstances, to reduce
  PMI overhead & reduce sampling data.

- Extend the lost-sample profiling output with the PERF_FORMAT_LOST ABI variant,
  which tells tooling the exact number of samples lost.

- Add new IBS register bits definitions.

- AMD uncore events: Add PerfMonV2 DF (Data Fabric) enhancements.

 Thanks,

	Ingo

------------------>
Kan Liang (2):
      perf/x86/intel: Fix PEBS memory access info encoding for ADL
      perf/x86/intel: Fix PEBS data source encoding for ADL

Like Xu (1):
      x86/events/intel/ds: Enable large PEBS for PERF_SAMPLE_WEIGHT_TYPE

Namhyung Kim (1):
      perf/core: Add a new read format to get a number of lost samples

Ravi Bangoria (1):
      perf/x86/ibs: Add new IBS register bits into header

Sandipan Das (5):
      perf/x86/amd/uncore: Use dynamic events array
      perf/x86/amd/uncore: Use attr_update for format attributes
      perf/x86/amd/uncore: Detect available DF counters
      perf/x86/amd/uncore: Add PerfMonV2 DF event format
      perf/x86/amd/uncore: Add PerfMonV2 RDPMC assignments


 arch/x86/events/amd/uncore.c      | 146 +++++++++++++++++++++++++++++++-------
 arch/x86/events/intel/core.c      |   7 +-
 arch/x86/events/intel/ds.c        | 129 ++++++++++++++++++++++-----------
 arch/x86/events/perf_event.h      |  17 ++++-
 arch/x86/include/asm/amd-ibs.h    |  16 +++--
 arch/x86/include/asm/perf_event.h |  16 +++++
 include/linux/perf_event.h        |   2 +
 include/uapi/linux/perf_event.h   |   5 +-
 kernel/events/core.c              |  21 +++++-
 kernel/events/ring_buffer.c       |   5 +-
 10 files changed, 280 insertions(+), 84 deletions(-)
