Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51F550A08
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiFSLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFSLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:11:22 -0400
Received: from forward100o.mail.yandex.net (forward100o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F85DF59
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:11:19 -0700 (PDT)
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id D16D952AB867;
        Sun, 19 Jun 2022 14:11:17 +0300 (MSK)
Received: from vla1-d53b4f396d89.qloud-c.yandex.net (vla1-d53b4f396d89.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:b8c:0:640:d53b:4f39])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id CBDB0BF00002;
        Sun, 19 Jun 2022 14:11:17 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla1-d53b4f396d89.qloud-c.yandex.net (mxback/Yandex) with ESMTP id mqFByjOn38-BGgmRKmn;
        Sun, 19 Jun 2022 14:11:17 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1655637077;
        bh=x2SLVKj3Y2z4qT7CkEW4It9dIWFbakpMlebj5eIZY/w=;
        h=Date:Subject:Cc:To:From:Message-Id;
        b=jvV+F265YM61bUvgAJy4kqOtsdtLOX+3w2s90+Hdf68rMSLF+U7/5vu2CNK0IFsQt
         5dBVYu/XLnMIHT9r/dX9AdpkHtbg6c1Ov78oSl9eGJTbOFmmlWlnk2KZlHNCrPGzOf
         cyUHrvHm3jhXM5apOo1mEjk5pgty41pvouynsqME=
Authentication-Results: vla1-d53b4f396d89.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id VrXAFig42r-BFNq83H4;
        Sun, 19 Jun 2022 14:11:15 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>
Cc:     =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/1] RISC-V: Create unique identification for SoC PMU
Date:   Sun, 19 Jun 2022 14:11:10 +0300
Message-Id: <20220619111115.6354-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nikita Shubin <n.shubin@yadro.com>

Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
"devices/platform/riscv-pmu/id" sysfs entry.

As per Will Deacon recomendation i am splitting the original series in parts,
first one is to provide a reasonable id for RISC-V SBI PMU. Events for Unmatched,
general RISCV and SBI Firmware bindings will be added later.

We can provide the PMU id as is marchid, mimpid, mvendorid as string, separated by a coma:

cat /sys/devices/platform/riscv-pmu/id 
0x70032,0x70032,0x0

In this case we are providing them as is as given by SBI extension.

Also i've added a string allocated on probe with pmuid, to avoid excess ecalls.

Atish would do you think about this ?

Sunil, thank you for reporting issue with 32-bit, i decided to make another approuch to problem.

Link: https://patchwork.kernel.org/project/linux-riscv/list/?series=648017
---
v3->v4:
- split series
- fix DEVICE_ATTR to use octal permissions
- use string for pmuid, instead of incoding some magical numbers
---
Nikita Shubin (1):
  RISC-V: Create unique identification for SoC PMU

 drivers/perf/riscv_pmu_sbi.c   | 41 ++++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |  1 +
 2 files changed, 42 insertions(+)

-- 
2.35.1

