Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7173558C209
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiHHD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiHHD0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14770FD01
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659929163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/5BnEPTRt6rS3Pj2Ddzn8CoW9Kgy2sGXbJADgHzxAY=;
        b=ejLGOXcoqtGo/Jj2Fva7CtPynsEx4+wBtsR9f9W76WINDC7ly2ujLrODUCQ7yVyTWIkO8g
        BkEum496BJ5xMvTQobXWTQmwpHLMhp6TGYDda5KTGpaGM4MzgBsVkufVvQiXoBF6ZXhnMQ
        B4L+9zGB57+Gf911HUJ6Bz+0vGXZoxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-eQ--1pkLO5-dLCOb0V4QhQ-1; Sun, 07 Aug 2022 23:25:51 -0400
X-MC-Unique: eQ--1pkLO5-dLCOb0V4QhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16D2F80A0BF;
        Mon,  8 Aug 2022 03:25:50 +0000 (UTC)
Received: from localhost (ovpn-12-221.pek2.redhat.com [10.72.12.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6610994561;
        Mon,  8 Aug 2022 03:25:48 +0000 (UTC)
Date:   Mon, 8 Aug 2022 11:25:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Message-ID: <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721181747.1640-2-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> The use of __weak is being eliminated within kexec sources.
> The technique uses macros mapped onto inline functions in
> order to replace __weak.
> 
> This patchset was using __weak and so in order to replace
> __weak, this patch introduces arch/*/asm/crash.h, patterned
> after how kexec is moving away from __weak and to the macro
> definitions.

Are you going to replace __weak in kexec of arll ARCHes? I don't see
your point why all these empty header files are introduced. Wondering
what's impacted if not adding these empty files?

> 
> No functionality changed, yet.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/arm/include/asm/crash.h     | 5 +++++
>  arch/arm64/include/asm/crash.h   | 5 +++++
>  arch/ia64/include/asm/crash.h    | 5 +++++
>  arch/m68k/include/asm/crash.h    | 5 +++++
>  arch/mips/include/asm/crash.h    | 5 +++++
>  arch/parisc/include/asm/crash.h  | 5 +++++
>  arch/powerpc/include/asm/crash.h | 5 +++++
>  arch/riscv/include/asm/crash.h   | 5 +++++
>  arch/s390/include/asm/crash.h    | 5 +++++
>  arch/sh/include/asm/crash.h      | 5 +++++
>  include/linux/crash_core.h       | 2 ++
>  11 files changed, 52 insertions(+)
>  create mode 100644 arch/arm/include/asm/crash.h
>  create mode 100644 arch/arm64/include/asm/crash.h
>  create mode 100644 arch/ia64/include/asm/crash.h
>  create mode 100644 arch/m68k/include/asm/crash.h
>  create mode 100644 arch/mips/include/asm/crash.h
>  create mode 100644 arch/parisc/include/asm/crash.h
>  create mode 100644 arch/powerpc/include/asm/crash.h
>  create mode 100644 arch/riscv/include/asm/crash.h
>  create mode 100644 arch/s390/include/asm/crash.h
>  create mode 100644 arch/sh/include/asm/crash.h
> 
> diff --git a/arch/arm/include/asm/crash.h b/arch/arm/include/asm/crash.h
> new file mode 100644
> index 000000000000..385646957d60
> --- /dev/null
> +++ b/arch/arm/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM_CRASH_H
> +#define _ASM_ARM_CRASH_H
> +
> +#endif /* _ASM_ARM_CRASH_H */
> diff --git a/arch/arm64/include/asm/crash.h b/arch/arm64/include/asm/crash.h
> new file mode 100644
> index 000000000000..ec8870c1ea49
> --- /dev/null
> +++ b/arch/arm64/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CRASH_H
> +#define _ASM_ARM64_CRASH_H
> +
> +#endif /* _ASM_ARM64_CRASH_H */
> diff --git a/arch/ia64/include/asm/crash.h b/arch/ia64/include/asm/crash.h
> new file mode 100644
> index 000000000000..02a457cccda3
> --- /dev/null
> +++ b/arch/ia64/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_IA64_CRASH_H
> +#define _ASM_IA64_CRASH_H
> +
> +#endif /* _ASM_IA64_CRASH_H */
> diff --git a/arch/m68k/include/asm/crash.h b/arch/m68k/include/asm/crash.h
> new file mode 100644
> index 000000000000..ba6e412a1267
> --- /dev/null
> +++ b/arch/m68k/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_M68K_CRASH_H
> +#define _ASM_M68K_CRASH_H
> +
> +#endif /* _ASM_M68K_CRASH_H */
> diff --git a/arch/mips/include/asm/crash.h b/arch/mips/include/asm/crash.h
> new file mode 100644
> index 000000000000..35872522c574
> --- /dev/null
> +++ b/arch/mips/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_MIPS_CRASH_H
> +#define _ASM_MIPS_CRASH_H
> +
> +#endif /* _ASM_MIPS_CRASH_H */
> diff --git a/arch/parisc/include/asm/crash.h b/arch/parisc/include/asm/crash.h
> new file mode 100644
> index 000000000000..96833b727179
> --- /dev/null
> +++ b/arch/parisc/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PARISC_CRASH_H
> +#define _ASM_PARISC_CRASH_H
> +
> +#endif /* _ASM_PARISC_CRASH_H */
> diff --git a/arch/powerpc/include/asm/crash.h b/arch/powerpc/include/asm/crash.h
> new file mode 100644
> index 000000000000..40ce71e56ac1
> --- /dev/null
> +++ b/arch/powerpc/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_CRASH_H
> +#define _ASM_POWERPC_CRASH_H
> +
> +#endif /* _ASM_POWERPC_CRASH_H */
> diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
> new file mode 100644
> index 000000000000..24f3aea99707
> --- /dev/null
> +++ b/arch/riscv/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_CRASH_H
> +#define _ASM_RISCV_CRASH_H
> +
> +#endif /* _ASM_RISCV_CRASH_H */
> diff --git a/arch/s390/include/asm/crash.h b/arch/s390/include/asm/crash.h
> new file mode 100644
> index 000000000000..0db16ad4c75f
> --- /dev/null
> +++ b/arch/s390/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_S390_CRASH_H
> +#define _ASM_S390_CRASH_H
> +
> +#endif /* _ASM_S390_CRASH_H */
> diff --git a/arch/sh/include/asm/crash.h b/arch/sh/include/asm/crash.h
> new file mode 100644
> index 000000000000..f54e12f88cae
> --- /dev/null
> +++ b/arch/sh/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_SH_CRASH_H
> +#define _ASM_SH_CRASH_H
> +
> +#endif /* _ASM_SH_CRASH_H */
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..cb0f1916fbf5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -6,6 +6,8 @@
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
>  
> +#include <asm/crash.h>
> +
>  #define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
>  #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
> -- 
> 2.31.1
> 

