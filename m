Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E64FAD08
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiDJJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiDJJQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 05:16:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282795E17B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 02:14:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so15647370pjn.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WDPfrzxoEqoQc1/eGWlrbqzJhsvrBmHHWTvNKjsYkJM=;
        b=QkEh1cbcPct4JczcOnXh+aKqtrHGkH6NNm7c3AONE1RhylRzyBpeOLzvd7XWaCm6XH
         0w+5Wx7u/vA05q6JUyqN7PQhtlbPVEysyU/yzh0BQULuiFdn8agGYwB+505VhLt4peSN
         4TQqL0CwpNkLD+pXkok19uXrGYOz1aLuv2SoKOxiG7XXzfYrJOFdAFlZPt91JtvjVucl
         8meujpcl/phahG9kPygAXIHfghNcXE4SYZgupB24Crh1GdY5Wp3W4DUMacPMraqYwDHG
         Ihs0My6BDesqs2JDr04owaQwiBUL40bYC6Zr0GgT47YsCjoM5Q8dxiknldQpzfe+gFOU
         BG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WDPfrzxoEqoQc1/eGWlrbqzJhsvrBmHHWTvNKjsYkJM=;
        b=Jy1+XMGi48StMbCh5kbkW2JcdPfW5RlCGsU3na9K+7dtFskwvBAklJUhNkZOI6WzQn
         U1HsnJ+9i6XahC8GQeVYtgeYL33DSIoReES7NXb+JCtq5rWKGlrV+ECK01upBacB2+0J
         uUj33LVCCrHDog8wqzJg2mlvD4B6yM5KqvtEl5BY08AaHIWQJyy9OfR8jFJOhCaC+T61
         YJgA6cQW6RgdG51MdiReAoFI0lCn7+knzKP+Vsnoio083CsQR8gxI9SyC61X77EPWXJX
         sSXlBgQV/sZC6nlvjiSf2QvhzejTyTGbu7chDOHuHVU2lMk5gAUd19QhjE2xwkRexXZJ
         N2BQ==
X-Gm-Message-State: AOAM531gpOXdoR6f/N+PgpnRe9NtFLHTL8DnN0DWhpVkq3x1yGrZwfa7
        Sxpr4YcdusNg9OqT7dfvUWyTJidGzMrjLrXOxaKQzBEyzzG6ar8=
X-Google-Smtp-Source: ABdhPJxlVIb0T0CZqME8DQnXouztNp0D0cA7yEivwZdQ+Mrtmiv3y7hyXAvfEkrS8G4zaFx+aG1mH3vaE5zcmg+cO7w=
X-Received: by 2002:a17:90b:915:b0:1ca:b584:8241 with SMTP id
 bo21-20020a17090b091500b001cab5848241mr30853251pjb.46.1649582046260; Sun, 10
 Apr 2022 02:14:06 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 10 Apr 2022 17:13:55 +0800
Message-ID: <CAMhUBjm2AdyEZ_-EgexdNDN7SvY4f89=4=FwAL+c0Mg0O+X50A@mail.gmail.com>
Subject: [BUG] ALSA: echoaudio: warning when the driver fails to probe
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in echoaudio.c.
When the driver fails at the function snd_echo_create(), it should
release resources requested before, otherwise we will get the
following warning:

[    3.262866] remove_proc_entry: removing non-empty directory
'irq/21', leaking at least 'snd_indigodj'
[    3.263577] WARNING: CPU: 3 PID: 261 at fs/proc/generic.c:717
remove_proc_entry+0x389/0x3f0
[    3.267098] RIP: 0010:remove_proc_entry+0x389/0x3f0
[    3.269976] Call Trace:
[    3.269979]  <TASK>
[    3.269988]  unregister_irq_proc+0x14c/0x170
[    3.269997]  irq_free_descs+0x94/0xe0
[    3.270004]  mp_unmap_irq+0xb6/0x100
[    3.270011]  acpi_unregister_gsi_ioapic+0x27/0x40
[    3.270017]  acpi_pci_irq_disable+0x1d3/0x320
[    3.270025]  pci_disable_device+0x1ad/0x380
[    3.270034]  pcim_release+0x566/0x6d0
[    3.270046]  devres_release_all+0x1f1/0x2c0
[    3.270057]  really_probe+0xe0/0x920

Regards,
Zheyu Ma
