Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F54E7F31
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 06:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiCZFvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 01:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiCZFvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 01:51:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDBE210468
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:50:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qa43so19004492ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2O4yXpqsURvfM5TB1UAWHWz+8FkEHYO0gCz767gxti8=;
        b=Sod/FcT9Ks5jijNGSYWpQqzd2JM5VDQVU8LgvK+b5kJXeLJ7QA0CZcDCF05sYHAjYm
         BVFzuU76IglUwI8JQsnzAKI3cuQXLirS7G9bp1t/al+3dw/TGAiv9wUpyabRDndtCgEP
         eO4epxHuxmxlplL3zY2SC1wstRqM9gJiP1CpDnIP+s1YVx7Ynhpdr/E2brjy0fnY2Zii
         4lBi4HZmW3pg92GjJuMNzCZagWrEPEWU2emY2IFElEotn5Mrat+h2gwXe9X00yEoNYJx
         TKH0Se9JgX02mX7U7XEDoLLw6GUbFpSFdYFrw1wEbFV1onAQsWXAQD/ud+LGaASHvSeV
         YQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2O4yXpqsURvfM5TB1UAWHWz+8FkEHYO0gCz767gxti8=;
        b=mUJ5fkDBQ1JpmdSUIX7AlHWc1m2ntS1OXNZdV5Hmt9bz+Yrw4sMs8ot1O8JEGNpPHt
         DAN7Drz9pho9AoqgBWPbGR4MDyyiSbmSPiW3qmCvQIFEKCDzcTwxETIwL5qNxyq2DAE2
         luY0VA4dwhHVr4EXodbnO5mWV+2flyMhrRkLgoSvBekjApJJJTkdKpnjZ2+d+JUekJdX
         6ZJQkgsq8TTSDuePCCoJZeDrDB2sVwwNiKdE+F5qkdZXB0wpUW1w6YjXBp+Cu/n2NrMz
         VOtrgZ4KF4+wPA4PiK6WkgJcMWWIiIaCkOz0UI9qR+BUZrz12Hjnc6eL8ER1nxRECpOS
         9THQ==
X-Gm-Message-State: AOAM531Lnc+LIqRIaDtNO5a4ajyAZSCakG3NTPNAxts2BagFpKA3Xyvi
        CFNYrBNlh0rurhq/J1lxOwqvGg==
X-Google-Smtp-Source: ABdhPJz2DiccS9xVih0qkcsHHv/ejttJp0IsCc3Xakcv/Utb1G9VsI1XMGaRvbMGOYF83H//hNnB7g==
X-Received: by 2002:a17:906:9751:b0:6e0:5cdd:cabf with SMTP id o17-20020a170906975100b006e05cddcabfmr15961766ejy.38.1648273803777;
        Fri, 25 Mar 2022 22:50:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm3064171ejz.57.2022.03.25.22.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 22:50:03 -0700 (PDT)
Date:   Sat, 26 Mar 2022 13:49:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 1/4] tools: arm64: Import cputype.h
Message-ID: <20220326054956.GB20556@leoy-ThinkPad-X240s>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-2-alisaidi@amazon.com>
 <Yj4McMHsxtJ3PfKk@kernel.org>
 <Yj4bKHrmKhujZdpj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj4bKHrmKhujZdpj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Ali,

On Fri, Mar 25, 2022 at 04:42:32PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 25, 2022 at 03:39:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Mar 24, 2022 at 06:33:20PM +0000, Ali Saidi escreveu:
> > > Bring-in the kernel's arch/arm64/include/asm/cputype.h into tools/
> > > for arm64 to make use of all the core-type definitions in perf.
> 
> > > Replace sysreg.h with the version already imported into tools/.
>  
> > You forgot to add it to tools/perf/check-headers.sh so that we get
> > notificed when the original file in the kernel sources gets updated, so
> > that we can check if this needs any tooling adjustments.
>  
> > I'll add the entry together with the waiver for this specific
> > difference.
> 
> This:
> 
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 30ecf3a0f68b6830..6ee44b18c6b57cf1 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -146,6 +146,7 @@ done
>  check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
>  check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
> +check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
>  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'

LGTM.  I did the testing on both my x86 and Arm64 platforms, thanks for
the fixing up.

Thanks,
Leo
