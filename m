Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CACF5A185F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbiHYSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbiHYSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:08:10 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69ABD152;
        Thu, 25 Aug 2022 11:08:07 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11dca1c9c01so9010001fac.2;
        Thu, 25 Aug 2022 11:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc;
        bh=v+fUzPKTBLo/xaSs+aR0X2ElL8HrWumep9vTvCPKeLE=;
        b=TgV7/3YennBwbnxrEU3LnuAHDFnrdq+iuUirCygRY3EaIQ+sz+zJ2qrC3hOV6AfSBF
         Y3f5ii244HDqWy90X6tdjDQ/OSU+5gqE/SMHvbzHjPdqo/ioZEEonQKYwtliDKVicb4l
         YqbCRJopj9kXciuXEOhEg4z4YFAMdM2uV2HPSUUm0vr5V9soKIpAa9lU0ImL+DTH9T47
         BRFK2NOV13oYEhxooXDezNUwm8YRhMBnb5s0vrr7sX5XTT9cLS38omiRWBUoy3XDqm87
         QadHt1wWI52eohmwlJgN4D9EgwpEySHq4SJIlxHO13nDMPlA3hi9Ra7gD706GEqGwu/E
         jxPA==
X-Gm-Message-State: ACgBeo2m9+jb9mRwIka/74UyjRMkOlV6OzhexnCZ5H5DRg3YpgdhVHvv
        wTV6P6cRC374D8l5RMEOjA==
X-Google-Smtp-Source: AA6agR7V/D12+M0rcUDZwYriOVTlu4Mpyh8xu222QitGATB0iU90TF5GONbh5E0yejp8vi8K/+Sbxg==
X-Received: by 2002:a05:6870:618b:b0:11c:455e:eb18 with SMTP id a11-20020a056870618b00b0011c455eeb18mr124187oah.264.1661450886244;
        Thu, 25 Aug 2022 11:08:06 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t26-20020a0568080b3a00b003434b221a17sm5000231oij.52.2022.08.25.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:08:05 -0700 (PDT)
Subject: [PATCH RFC v1 0/3] perf: Arm SPEv1.2 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 13:07:59 -0500
Message-Id: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
X-b4-tracking: H4sIAIS6B2MC/w3LOw6AIAwA0KuYzjbB+iPeBrAICaKhkcV4dxnf8F4QLpEFtu6FwjVKvHLD0Hfggs
 kHY9ybgRSR0jSjKSfKzVg1ruh592riYfE0QivWCKMtJrvQUn5S+r4fNUeZHGMAAAA=
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Arm SPEv1.2 which is part of the
Armv8.7/Armv9.2 architecture. There's 2 new features that affect the 
kernel: a new event filter bit, branch 'not taken', and an inverted 
event filter register. 

RFC as this is compile tested only.

---
Rob Herring (3):
      perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
      perf: Add perf_event_attr::config3
      perf: arm_spe: Add support for SPEv1.2 inverted event filtering

 arch/arm64/include/asm/sysreg.h       |  5 ++++
 drivers/perf/arm_spe_pmu.c            | 47 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/perf_event.h       |  3 +++
 tools/include/uapi/linux/perf_event.h |  3 +++
 4 files changed, 57 insertions(+), 1 deletion(-)
---
base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
change-id: 20220825-arm-spe-v8-7-fedf04e16f23

Best regards,
--
Rob Herring <robh@kernel.org>

-- 
b4 0.10.0-dev
