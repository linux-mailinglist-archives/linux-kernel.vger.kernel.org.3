Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D660B517257
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385710AbiEBPTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385702AbiEBPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3F03AE67
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651504542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0PmxSPmOOMkFAuEyKaFUSMzJFbtZ7TiEfjWg6xe3gM=;
        b=Gp5j413CuAxg8aIJGMonTSHdU2JhTh04uGKpXho3GXI3oR0GUn9hIh3YFAWHmSfUYzRl7M
        X45fuaFeGhaeNtin5IXiKiFbeha/9fUtO6j8mo461D6PF9svSYSMaPW5V72wc2ST9Ajqem
        E3W22bUhZdoAWT/YOXrJ3y5FXCxCDZQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-VsAweHCwN-ulQVdd1QcV4Q-1; Mon, 02 May 2022 11:15:41 -0400
X-MC-Unique: VsAweHCwN-ulQVdd1QcV4Q-1
Received: by mail-ej1-f69.google.com with SMTP id dp12-20020a170906c14c00b006e7e8234ae2so6956596ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k0PmxSPmOOMkFAuEyKaFUSMzJFbtZ7TiEfjWg6xe3gM=;
        b=plNEgzZqEPTKyJS0obRmW59Pawo0BPprVEsUZL23Wd8KPqtbBru7+pztVIlTiYMOeq
         yNnkytT/UZqi9IIHGACBNWbJxD7im+XG249QI17VnkgcabNnRhpYAe36fgxZYVfYRP+4
         jzP89tEHK+3C+3aU8TkcAdWJTLgyGmkjC1K2Kh0I+sky3HrZHogKV7Q2Blnc8q/f3TYv
         8lmZRNHeb7O57Cal9+VMA/iEDXnIosqDVylAyJqf2ODc7PkW7/vhTRa0oPze7s9UgA2e
         baIddIqX+gQmO1wUVW+jiNK33ZmHrW+2lBER0II3kGWxS+QQMoWUC1m9zHWTuQP57kYd
         rEkg==
X-Gm-Message-State: AOAM531YFpz3t4sjNJl4WBW1fjMt37lLUWJ+DtJWG4gCjg7kHcswnHtt
        CXKawb9tcQwYJXij0iZj6sD78dKBcQYHxJ+pQYqovMwS7eLjpMz7FhJ+XCyNYG43EcY21MBIciH
        hH2jLnuoYtYsQYnQ88lYjyAsM
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr13664136edw.113.1651504540320;
        Mon, 02 May 2022 08:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Wx4u3ZHl7XBE4iREwsA0F30U0LmfGsKXoUrOxDiIE238dzfMlpndx5BLZugy4pp841JHrQ==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr13664112edw.113.1651504540096;
        Mon, 02 May 2022 08:15:40 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id dq9-20020a170907734900b006f3ef214de3sm3671912ejc.73.2022.05.02.08.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:15:39 -0700 (PDT)
Message-ID: <13054c5c-ed48-b7a2-a800-25b9b1b1ab0d@redhat.com>
Date:   Mon, 2 May 2022 17:15:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5 00/10] Introduce In Field Scan driver
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220428153849.295779-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/28/22 17:38, Tony Luck wrote:
> Hopefully this is close enough to done to begin discussion on which
> maintainer tree will take this series.
> 
> Choices:
> 1) Hans/Mark take it into the platform-drivers tree
>    Needs an Ack from x86 maintainers on parts 1 & 2
> 2) X86 maintainers take it into TIP
>    Needs Ack from Hans/Mark on parts 2-10

I've taken a quick look at the entire series and it looks good to me.

I'm fine with this entire series getting merged through the TIP
tree, here is my ack for merging the drivers/platform/x86 bits
through the TIP tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans






> 
> TL;DR this driver loads scan test files that can check whether silicon
> in a CPU core is still running correctly. It is expected that these tests
> would be run several times per day to catch problems as silicon ages.
> 
> Changes since v4:
> 
> Greg Kroah-Hartman
> ------------------
>  "Cute way to do this, but I don't see you ever have any more devices
>  added to this list in this series."
> 
>  Removed the enum, arrays, loops, and count of test types discovered.
>  Now just check for enumeration of the single test type that is being
>  deployed on Sapphire Rapids.
> 
> 
> Jithu Joseph (7):
>   x86/microcode/intel: Expose collect_cpu_info_early() for IFS
>   platform/x86/intel/ifs: Read IFS firmware image
>   platform/x86/intel/ifs: Check IFS Image sanity
>   platform/x86/intel/ifs: Authenticate and copy to secured memory
>   platform/x86/intel/ifs: Add scan test support
>   platform/x86/intel/ifs: Add IFS sysfs interface
>   platform/x86/intel/ifs: add ABI documentation for IFS
> 
> Tony Luck (3):
>   x86/msr-index: Define INTEGRITY_CAPABILITIES MSR
>   platform/x86/intel/ifs: Add stub driver for In-Field Scan
>   trace: platform/x86/intel/ifs: Add trace point to track Intel IFS
>     operations
> 
>  .../ABI/testing/sysfs-platform-intel-ifs      |  39 ++
>  MAINTAINERS                                   |   8 +
>  arch/x86/include/asm/cpu.h                    |  18 +
>  arch/x86/include/asm/msr-index.h              |   7 +
>  arch/x86/kernel/cpu/intel.c                   |  32 ++
>  arch/x86/kernel/cpu/microcode/intel.c         |  59 +---
>  drivers/platform/x86/intel/Kconfig            |   1 +
>  drivers/platform/x86/intel/Makefile           |   1 +
>  drivers/platform/x86/intel/ifs/Kconfig        |  13 +
>  drivers/platform/x86/intel/ifs/Makefile       |   3 +
>  drivers/platform/x86/intel/ifs/core.c         |  80 +++++
>  drivers/platform/x86/intel/ifs/ifs.h          | 123 +++++++
>  drivers/platform/x86/intel/ifs/load.c         | 262 ++++++++++++++
>  drivers/platform/x86/intel/ifs/runtest.c      | 332 ++++++++++++++++++
>  drivers/platform/x86/intel/ifs/sysfs.c        | 147 ++++++++
>  include/trace/events/intel_ifs.h              |  38 ++
>  16 files changed, 1111 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs
>  create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
>  create mode 100644 drivers/platform/x86/intel/ifs/Makefile
>  create mode 100644 drivers/platform/x86/intel/ifs/core.c
>  create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
>  create mode 100644 drivers/platform/x86/intel/ifs/load.c
>  create mode 100644 drivers/platform/x86/intel/ifs/runtest.c
>  create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
>  create mode 100644 include/trace/events/intel_ifs.h
> 
> 
> base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b

