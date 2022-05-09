Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4251F457
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiEIGVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiEIGS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:18:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D06DEABA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:14:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks9so18311075ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKE00xKtnFNkbeCVoGYYRVm7iAh7GIr8S8mN+9hlKZc=;
        b=eTC143Rx70nULYaWFFTH50Yw+io756fmNbIRN7RJyuegYnBBWkDXAqxToGanOF7wCC
         5c0nTVwUlQ0Tiku55dQrc5MOIcRsAgDpLLS7nKy3rZk72BQpD9+SC4PWdd3iCZ8zP/K+
         spRKBq0csSHXGBDLl4sKBgxZ4E/ZTxinTAqSFpJv1DCCBRllF4nS/4nEpgGCOeigpuSW
         QCiUEX4gnJunw8TXAIXRle6woCCYeny+6u+JCZjK4NXoqukHjPVPqtISi6UpYNNmI6/e
         hGWWD/CGVhnWBI/ZmWPMDnOvbeJ7s06OCRyXMFKxnvzcZkhfRgrkP5QcQlPWqpVz2GI/
         B3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKE00xKtnFNkbeCVoGYYRVm7iAh7GIr8S8mN+9hlKZc=;
        b=HJEqt/HFvOvKbXcxDXGhkBDn36Iz8tSnVpDQ35HTxjFy1Q548BYhlP87ngfnT/xZiM
         55zDvkuRKJZzk1JolhrlfRzNP5v0L6qbxd4kcd89L5qGWTRr8rtofnlWdNJJF4t2p/YV
         cRbCZjKXXJf26u7q58Gnw2u0k28vghUAi9+oOZpHtjwgtTPCWsWQtw72yH3hQQarQPRg
         UE4EtA5LwnAQc92mzPh9WWWy4sWrC7UI1VUxSZs4FHBpCE4+isRKq1wQhTtg8u3zjsqn
         OaPZ5bQBPDcT3ar2DV+zm/LFKP5e/7xG/0cAsjARME0XGa2k0c40zzn4xExsvXD1j63N
         nBeA==
X-Gm-Message-State: AOAM533ptJEfSwu68W8dll5xGtOqjtR5XgNpRWlB0y5Vfq/BnwCTCuOQ
        k+eGHElG18bwrt29wzWgd1A=
X-Google-Smtp-Source: ABdhPJxdeOtpnsP8bTbQru68NuHOAIaJzV4MJzdNdqY3OEmoWmjSLJAgSkNUvZZLL2x9867MoAgTAA==
X-Received: by 2002:a17:906:7b82:b0:6f3:ee8d:b959 with SMTP id s2-20020a1709067b8200b006f3ee8db959mr13725009ejo.458.1652076870913;
        Sun, 08 May 2022 23:14:30 -0700 (PDT)
Received: from leap.localnet (host-79-53-109-4.retail.telecomitalia.it. [79.53.109.4])
        by smtp.gmail.com with ESMTPSA id er9-20020a170907738900b006f3ef214e70sm4698682ejc.214.2022.05.08.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:14:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 09 May 2022 08:14:27 +0200
Message-ID: <4710227.GXAFRqVoOG@leap>
In-Reply-To: <202205090835.NEUQ3VKB-lkp@intel.com>
References: <20220508200755.24586-1-fmdefrancesco@gmail.com> <202205090835.NEUQ3VKB-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 9 maggio 2022 02:25:00 CEST kernel test robot wrote:
> Hi "Fabio,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.18-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Frances=
co/fs-ufs-Replace-kmap-with-kmap_local_page/20220509-040920
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
linux.git e3de3a1cda5fdc3ac42cb0d45321fb254500595f
> config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/
archive/20220509/202205090835.NEUQ3VKB-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/
sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/
e73d9919e2725b216318d5d02b8a184876ab3b11
>         git remote add linux-review https://github.com/intel-lab-lkp/
linux
>         git fetch --no-tags linux-review Fabio-M-De-Francesco/fs-ufs-
Replace-kmap-with-kmap_local_page/20220509-040920
>         git checkout e73d9919e2725b216318d5d02b8a184876ab3b11
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cro=
ss=20
W=3D1 O=3Dbuild_dir ARCH=3Driscv SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> WARNING: modpost: vmlinux.o(.text+0xa76c20): Section mismatch in=20
reference from the function rtc_update_irq() to the variable=20
=2Einit.text:.LVL13
> The function rtc_update_irq() references
> the variable __init .LVL13.
> This is often because rtc_update_irq lacks a __init
> annotation or the annotation of .LVL13 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0xb35ab4): Section mismatch in=20
reference from the function btintel_send_intel_reset() to the variable=20
=2Einit.text:.LBE19058
> The function btintel_send_intel_reset() references
> the variable __init .LBE19058.
> This is often because btintel_send_intel_reset lacks a __init
> annotation or the annotation of .LBE19058 is wrong.
> --
> >> WARNING: modpost: vmlinux.o(.text+0xc53984): Section mismatch in=20
reference from the function neigh_table_clear() to the variable .init.text:
$x
> The function neigh_table_clear() references
> the variable __init $x.
> This is often because neigh_table_clear lacks a __init
> annotation or the annotation of $x is wrong.
> --
> >> WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in=20
reference from the variable .L0 to the variable .debug_str:.LASF936
> FATAL: modpost: extable_entry size hasn't been discovered!
>=20
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in=20
reference from the function rtc_update_irq() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in=20
reference from the function rproc_exit_sysfs() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in=20
reference from the variable .L0 to the variable .debug_str:.LASF1567
> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in=20
reference from the function rtc_get_dev_attribute_groups() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in=20
reference from the function ir_raw_get_allowed_protocols() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in=20
reference from the function ir_raw_event_prepare() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in=20
reference from the function ir_raw_event_free() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in=20
reference from the function ir_raw_event_unregister() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in=20
reference from the function btintel_enter_mfg() to the variable=20
=2Einit.text:.LBB19521
> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in=20
reference from the function rtc_update_irq() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in=20
reference from the function rproc_exit_sysfs() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in=20
reference from the variable .L0 to the variable .debug_str:.LASF1567
> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in=20
reference from the function rtc_get_dev_attribute_groups() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in=20
reference from the function ir_raw_get_allowed_protocols() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in=20
reference from the function ir_raw_event_prepare() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in=20
reference from the function ir_raw_event_free() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in=20
reference from the function ir_raw_event_unregister() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in=20
reference from the function btintel_enter_mfg() to the variable=20
=2Einit.text:.LBB19521
> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in=20
reference from the function rtc_update_irq() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in=20
reference from the function rproc_exit_sysfs() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in=20
reference from the variable .L0 to the variable .debug_str:.LASF1567
> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in=20
reference from the function rtc_get_dev_attribute_groups() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in=20
reference from the function ir_raw_get_allowed_protocols() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in=20
reference from the function ir_raw_event_prepare() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in=20
reference from the function ir_raw_event_free() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in=20
reference from the function ir_raw_event_unregister() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in=20
reference from the function btintel_enter_mfg() to the variable=20
=2Einit.text:.LBB19521
> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in=20
reference from the function rtc_update_irq() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in=20
reference from the function rproc_exit_sysfs() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in=20
reference from the variable .L0 to the variable .debug_str:.LASF1567
> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in=20
reference from the function rtc_get_dev_attribute_groups() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in=20
reference from the function ir_raw_get_allowed_protocols() to the variable=
=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in=20
reference from the function ir_raw_event_prepare() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in=20
reference from the function ir_raw_event_free() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in=20
reference from the function ir_raw_event_unregister() to the variable=20
=2Einit.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in=20
reference from the function btintel_enter_mfg() to the variable=20
=2Einit.text:.LBB19521
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>=20
I cannot understand this report. All the functions listed here seem to have=
=20
nothing to do with my patch. Can anyone explain how these errors are=20
related to my changes?

Thanks,

=46abio



