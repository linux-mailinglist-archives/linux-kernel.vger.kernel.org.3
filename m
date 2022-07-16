Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE7576CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiGPJM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGPJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:12:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5872C1D0FF
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 02:12:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p6so8033532ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 02:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3QZVtFqHuiCcgoTBA6HrO6NXKNNvRGFtA2MSu5wIdn4=;
        b=dbbs3X4fgMBMXFvWiNCEDftamKZ1RI3KOuv75zfbBp1d8JFb8UxgsU1xs5xJLewqku
         4dXIjgzUHwELozlQ2KlIGII7KGxu/+lcUbcCNlaGk1UXPlr5OP/nVV09iWKZ7aC2NalV
         kzu7gpUkPLOy5sq6SaGf6GMaFN2Sd/9kfLlXGaicexa++GWAYVhvYXOOw0lsllaeC9El
         wOYXN6oMtMxSPylytkP3IGB+2Kq9de8n/nUtn9aCMkkxJ+CWg+j5rjW0zbH0tYg++9sU
         ufMK1zHELV//6pLiRjw2wOxoQ4hSBdKZEvIF+SeAI6o0UykrIFGA1SDYr+hkhzIsSvXz
         dEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3QZVtFqHuiCcgoTBA6HrO6NXKNNvRGFtA2MSu5wIdn4=;
        b=hcy19mqHBFuK7eMs3iw6FdARMaHgSIa1WKy8znbhvBhHalBPeV6boQftJRikj+0WwQ
         GsHtH4Uj0C80hgiwRsEVXyS4QjUG4sqkeM+Z57bRlny/idVdMnzEzs5SiIWekGjSj8Ni
         9elTutNMTRo6qrsWfvynTw+WP5dIcORm/GkWDB7tCA/UPAHb1Yv3DUX315+AetFxkxam
         EIRyh7kCi1oFyQaI7zZipZFvyDwo2PS9YNTMivKUNVE0onVOqulRdVgCcx6KwPOsETOF
         uXS/w8hHRprMdPLcCO1VzEVOguX1qC7PpOGxEY9AysdHgJOSlkBNyqnkgZjsellE7+0O
         YP6w==
X-Gm-Message-State: AJIora8d/UoEduhHE+LK+kpv14voPI/bBlfdAky8dv8OkC4FxJs2G9WW
        faeO9yInh99ecMcj5b4SFa+Wl8JldPftr6Fe/w==
X-Google-Smtp-Source: AGRyM1upNDloBaniyi/j3Rv19qKaeBnKgqtHrM/AqseVD7CcIUvnnXp3WdY2eHY/m7wN8RPHsF1KnDpdMNxFXSKG9PE=
X-Received: by 2002:a2e:bc17:0:b0:25d:50b7:74fa with SMTP id
 b23-20020a2ebc17000000b0025d50b774famr8666342ljf.444.1657962769637; Sat, 16
 Jul 2022 02:12:49 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sat, 16 Jul 2022 17:12:38 +0800
Message-ID: <CAMhUBjm2KOZZj=M3=yLvLm4QcNYpOTa+2_dPcHr7nHm4GE73DA@mail.gmail.com>
Subject: [BUG] ASoC: nau8821: Found a bug when removing the module
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        wtli@nuvoton.com, steve@sk2.org, Vijendar.Mukunda@amd.com
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the driver nau8821.

When removing the module, I got a warning:

[   64.226442] nau8821 0-0010: remove
[   64.227621] ------------[ cut here ]------------
[   64.227918] WARNING: CPU: 5 PID: 243 at kernel/irq/devres.c:144
devm_free_irq+0x80/0x8c
[   64.235307] Call trace:
[   64.235501]  devm_free_irq+0x80/0x8c
[   64.235746]  nau8821_i2c_remove+0x28/0x3c [snd_soc_nau8821]
[   64.236982]  i2c_device_remove+0xcc/0xf8
[   64.237173]  device_release_driver_internal+0x208/0x368
[   64.237406]  driver_detach+0xd8/0x12c
[   64.237583]  bus_remove_driver+0x90/0xd0
[   64.237768]  driver_unregister+0x3c/0x6c
[   64.237952]  i2c_del_driver+0x54/0x74
[   64.238127]  cleanup_module+0x1c/0x1d0 [snd_soc_nau8821]

regards,

Zheyu Ma
