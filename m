Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F651E956
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387002AbiEGTQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEGTQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:16:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE128980;
        Sat,  7 May 2022 12:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5DD57CE0DA3;
        Sat,  7 May 2022 19:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B27C385A5;
        Sat,  7 May 2022 19:12:11 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-doc@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, devicetree@vger.kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Dave Young <dyoung@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, Baoquan He <bhe@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Zhou <zhoufeng.zf@bytedance.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v24 0/6] support reserving crashkernel above 4G on arm64 kdump
Date:   Sat,  7 May 2022 20:12:09 +0100
Message-Id: <165195066216.355842.15333560704698747541.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220506114402.365-1-thunder.leizhen@huawei.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 19:43:56 +0800, Zhen Lei wrote:
> Changes since [v23]:
> Do two minor updates:
> 1. Change the value of CRASH_ADDR_HIGH_MAX from memblock.current_limit to (PHYS_MASK + 1).
> 2. The 'high' and 'low' are only take effect when crashkernel=X[@offset] does not exist.
>    If the value of crashkernel=X is invalid, the reservation of crash fails, even if 'high'
>    and 'low' are configured correctly.
> 
> [...]

Applied to arm64 (for-next/crashkernel), finally ;). Thanks!

Only patches on top please for the fall-back implementation.

[1/6] kdump: return -ENOENT if required cmdline option does not exist
      https://git.kernel.org/arm64/c/2e5920bb073a
[2/6] arm64: Use insert_resource() to simplify code
      https://git.kernel.org/arm64/c/e6b394425c61
[3/6] arm64: kdump: Reimplement crashkernel=X
      https://git.kernel.org/arm64/c/944a45abfabc
[4/6] of: fdt: Add memory for devices by DT property "linux,usable-memory-range"
      https://git.kernel.org/arm64/c/fb319e77a0e7
[5/6] of: Support more than one crash kernel regions for kexec -s
      https://git.kernel.org/arm64/c/8af6b91f5834
[6/6] docs: kdump: Update the crashkernel description for arm64
      https://git.kernel.org/arm64/c/5832f1ae5060

-- 
Catalin

