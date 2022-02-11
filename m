Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1A4B30BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbiBKWhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:37:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiBKWhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:37:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12758D5A;
        Fri, 11 Feb 2022 14:37:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk11so5296728ejb.2;
        Fri, 11 Feb 2022 14:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=foheueWuPlr0X/FqQ+1DdmvANtWzewCi/9ZqOAtm25I=;
        b=VzLyT1JCwZwA2eKoFjYtW4TZlMXVmxLV9HF6O3LCCZB4CeR5Phh9tEJ5/IHjh3ZNMf
         mpYWCtQIny2+ab2ihKyJl6OmWvMvxvu9/JM7qIro/tuGZAY7rFWD42PPK0pZV/JtH/KO
         Ree52sqBpADaK5YCldz6Y09JeMPrgltQ2Mcr3z3iWVkA9fg4sIqmA/FcVnt+O21eerAF
         lBjxrKpyc0Fpj7K+HBp57FUz4EtoSkQUHLSOoj8kgGSXlFrTGmzy5eE3Bjke989xa8O+
         WnSLheOAHRd0tCBLCDC4kVSyUR+v8N/z3wvi5GjBzTcAPgCf2440D7HF6mrL2SB2zU7S
         R/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foheueWuPlr0X/FqQ+1DdmvANtWzewCi/9ZqOAtm25I=;
        b=dK4EI+szLoiCcucQQAWSbqmU1i6cMADsZPsxvlXNJseadDH3UsV2A4RXOuZ4c5hTr2
         DUSBgR0/bMAV23nwWu3PQ9xHwLuqlv5p8W8dBwH0J4FMftKBf7GJHe2BM4MUTYhMA6vt
         DgiD54uVONSnPa1VMFvAXKppJL7sI5G6kV90zvsORDzzbWV28VCd9BFZPpYxnX5ntvbb
         6CZyU+R+t5WijGajTu5+Qh8Ddtk/LQWbpRU4mUSr2qX7vO6JW7b98zrBk5nRosX7EN2T
         HpUIPq6mBz4Cs3FBd2Z9l0m1kMphnIfBRw3zOoWXiMRnuWMaFJ3AC1FABFHU5iMDNYz+
         kIfw==
X-Gm-Message-State: AOAM5308YNJbvCUwt7KLeir8cA1WQoV1Ui5Ati8jQ9YSIT8QUY53VrXe
        DOur6Gmjd8nrM+YJHD60HMI=
X-Google-Smtp-Source: ABdhPJzTcSc16+N8cp0VYCOQ/qE9J8rZy0Dl7XrIy7DekRr7fiQAh2fB/STYOZmJ/7yrMWpc5eFuAQ==
X-Received: by 2002:a17:906:7a18:: with SMTP id d24mr3098128ejo.232.1644619019589;
        Fri, 11 Feb 2022 14:36:59 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id f19sm11370803edu.22.2022.02.11.14.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 14:36:59 -0800 (PST)
Date:   Fri, 11 Feb 2022 23:36:57 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, masahiroy@kernel.org, jolsa@kernel.org,
        rostedt@goodmis.org, bas@baslab.org, tglozar@gmail.com,
        Ast-x64@protonmail.com, viktor.malik@gmail.com, dxu@dxuuu.xyz,
        acme@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        irogers@google.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PATCH v8] kallsyms: new /proc/kallmodsyms with builtin modules
Message-ID: <YgblCSWH3g0+uy48@krava>
References: <20220208184309.148192-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208184309.148192-1-nick.alcock@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 06:43:03PM +0000, Nick Alcock wrote:
> The kallmodsyms patch series was originally posted in Nov 2019, and the thread
> (https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
> shows review comments, questions, and feedback from interested parties.
> 
> All review comments have been satisfied, as far as I know: in particular
> Yamada's note about translation units that are shared between built-in modules
> is satisfied with a better representation which is also much, much smaller.
> 
> A kernel tree containing this series alone, atop -rc3:
>    https://github.com/oracle/dtrace-linux-kernel kallmodsyms/5.17-rc3
> 
> Trees for trying this out, if you want to try this series in conjunction
> with its major current user:
> 
>  userspace tree for the dtrace tool itself:
>    https://github.com/oracle/dtrace-utils.git, dev branch
>  kernel tree comprising this series and a few other patches needed by
>  dtrace:
>    https://github.com/oracle/dtrace-linux-kernel, v2/5.17-rc2 branch
> 
> (See the README.md in the latter for dtrace build instructions.  Note the need for a
> reasonably recent binutils, a trunk GCC, and a cross-bpf toolchain.)
> 
> 
> /proc/kallsyms is very useful for tracers and other tools that need to
> map kernel symbols to addresses.
> 
> It would be useful if there were a mapping between kernel symbol and module
> name that only changed when the kernel source code is changed.  This mapping
> should not change simply because a module becomes built into the kernel, so
> that it's not broken by changes in user configuration.  (DTrace for Linux
> already uses the approach in this patch for this purpose.)
> 
> In brief we do this by mapping from address ranges to object files (with
> assistance from the linker map file), then mapping from object files to
> potential kernel modules. Because the number of object files is much smaller
> than the number of symbols, this is a fairly efficient representation, even with
> a bit of extra complexity to allow object files to be in more than one module at
> once.
> 
> The size impact of all of this is minimal: in one of my tests, vmlinux grew by
> 0.17% (10824 bytes), and the compressed vmlinux only grew by 0.08% (7552 bytes):
> though this is very configuration-dependent, it seems likely to scale roughly
> with the kernel as a whole.
> 
> This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
> set results in output in /proc/kallmodsyms that looks like this:
> 
> ffffffff8b013d20 409 t pt_buffer_setup_aux
> ffffffff8b014130 11f T intel_pt_interrupt
> ffffffff8b014250 2d T cpu_emergency_stop_pt
> ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
> ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
> ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
> ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
> ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
> ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]

hi,
I tried this version and can't see the symbols size

[root@qemu jolsa]# cat /proc/kallmodsyms | grep ksys_ | head -5
ffffffff81094720 T ksys_ioperm
ffffffff81141110 T ksys_unshare
ffffffff81160410 T ksys_setsid
ffffffff811c64b0 T ksys_sync_helper
ffffffff813213c0 T ksys_fadvise64_64

I have CONFIG_KALLMODSYMS=y, but I haven't checked if I need
anything else

jirka
