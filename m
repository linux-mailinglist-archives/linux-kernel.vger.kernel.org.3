Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B580F4E7D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiCYT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiCYT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB21B36879A;
        Fri, 25 Mar 2022 12:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07E161C12;
        Fri, 25 Mar 2022 19:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014B9C004DD;
        Fri, 25 Mar 2022 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648237356;
        bh=7HqmVJ6NVxap9GlAmX1TBvBJ1P7rz3epiq/FKTPm9zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=erf2kR3CM7QGTFQYsxs+kHRxt/FOSBfXnOcDqCMfrhmw89mlBvV+TR2jYpbtFDqvV
         H60OPAhRA4aHGRY+VqIJzHnEMH/v3m/yweWiD/JnLHFUBblx/IcSdaHY0KAFecTo1H
         wl1XbYZjnnz2KTbrgaBOsa/peQiCFwBbK1S/pTofSRsGTZLYYDlOVRSwKGnMjtybHG
         6aelfqcl3/nvTV6VrEAxc0SHNMNbkjo0awwrXCVFAZwSxvn5PfDL5TH20OuAP5HIeh
         o4R2zGc7LREcCzlzjCqYAZolxblHW0HOyKOXCW2qXoMeNTlfngPTjk4OlUloakvyG2
         dM2zA/0DG6J9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABF8D40407; Fri, 25 Mar 2022 16:42:32 -0300 (-03)
Date:   Fri, 25 Mar 2022 16:42:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, benh@kernel.crashing.org,
        Nick.Forrington@arm.com, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 1/4] tools: arm64: Import cputype.h
Message-ID: <Yj4bKHrmKhujZdpj@kernel.org>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-2-alisaidi@amazon.com>
 <Yj4McMHsxtJ3PfKk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj4McMHsxtJ3PfKk@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 25, 2022 at 03:39:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Mar 24, 2022 at 06:33:20PM +0000, Ali Saidi escreveu:
> > Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
> > for arm64 to make use of all the core-type definitions in perf.

> > Replace sysreg.h with the version already imported into tools/.
 
> You forgot to add it to tools/perf/check-headers.sh so that we get
> notificed when the original file in the kernel sources gets updated, so
> that we can check if this needs any tooling adjustments.
 
> I'll add the entry together with the waiver for this specific
> difference.

This:

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 30ecf3a0f68b6830..6ee44b18c6b57cf1 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -146,6 +146,7 @@ done
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
+check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'


Cheers,

- Arnaldo
