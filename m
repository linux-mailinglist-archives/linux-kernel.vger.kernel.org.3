Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13044FB655
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiDKIwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiDKIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:52:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24467EA6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:50:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so3662366plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sus1ijjnwPPCnYQ+nnL26keJCikVTpXCEs0tGfvDY+c=;
        b=m87SqfcXEo1wITNT0zsEMApqinJ/eME2w9uxi3fBMnAgFLeUvFE89erTEVKqTM+5Zh
         jOfOx0MfB01iEc/YOMYt42WFNzOWIRKA7TxVVmbHS/cOO+BoOJ16P9OwI3ERjF9ZPJna
         Jfid7p3vxTRNERj/EFBoT2HZMO1e2Q+Crq22/mcaO7fILST0bpBHt0XB/H8hkQjFkxat
         kX7h5aZOu9nJiFXpkDpuFEqE5QGNdwC0K++U5lgIKO+pQKc3aNQHWqr6zhporcOuFaYO
         eWTR/zFWJxBBq8wyrLoxmxAAxL2ikJpeBWz5iflukpR/0wTUlpJ+Qbbm587hUQsypbed
         5jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sus1ijjnwPPCnYQ+nnL26keJCikVTpXCEs0tGfvDY+c=;
        b=G92dh+NHPGnxbt3cSCnIJpDVVNuHkTUJs900DhhlpwYH+OJad2RACSzSotxK23SRDp
         krKdOHgSHTdb85LX+RibU4MJFGApRemGpsdk0UOey8uAavqFyl7hgMaib+JSJG04aQJ+
         +TCrneD44R4ZRJ8h8R5YRKNYP5gGZKM1QydRmOKrEVViYGOVb+oeWbtCeFwMfV51J2aq
         NBqfibEzJjqo+iN9+7T8VsO4NhEPv943oZdSZ1Y4Ip0f8dEmwqizqyMHV8w97wzewRSF
         9HebB5qJJRw732cj9N4QrpfEXlUHhKaMDbr938g806IEPbvfNv2te9L7jvCyc2fVYDt2
         IUgA==
X-Gm-Message-State: AOAM531oF3J5pq1OpbCN4bBjI67pxU2oao9wpno5Vb+CqKzQ66fsGfQl
        cjS+71+ttfR1fzU+D3zN2rjL4Wtrq41yJXqHSw==
X-Google-Smtp-Source: ABdhPJx6DRw4IDsGYrLBmw6A9PqReHiO6wvi0esUQduYsRKc96s6AxX0ib2LtF+QvbSEOr3QJvhDocMOSY7cBJF89Ao=
X-Received: by 2002:a17:90a:5407:b0:1bf:43ce:f11b with SMTP id
 z7-20020a17090a540700b001bf43cef11bmr35665065pjh.31.1649667004582; Mon, 11
 Apr 2022 01:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjm2AdyEZ_-EgexdNDN7SvY4f89=4=FwAL+c0Mg0O+X50A@mail.gmail.com>
 <s5hk0bwcbjh.wl-tiwai@suse.de>
In-Reply-To: <s5hk0bwcbjh.wl-tiwai@suse.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 11 Apr 2022 16:49:53 +0800
Message-ID: <CAMhUBjmr_mHcz2G0tQ2qktGFw6XDLJiDTAHvM1yoRWzvtA6MYg@mail.gmail.com>
Subject: Re: [BUG] ALSA: echoaudio: warning when the driver fails to probe
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
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

On Mon, Apr 11, 2022 at 3:41 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 10 Apr 2022 11:13:55 +0200,
> Zheyu Ma wrote:
> >
> > Hello,
> >
> > I found a bug in echoaudio.c.
> > When the driver fails at the function snd_echo_create(), it should
> > release resources requested before, otherwise we will get the
> > following warning:
> >
> > [    3.262866] remove_proc_entry: removing non-empty directory
> > 'irq/21', leaking at least 'snd_indigodj'
> > [    3.263577] WARNING: CPU: 3 PID: 261 at fs/proc/generic.c:717
> > remove_proc_entry+0x389/0x3f0
> > [    3.267098] RIP: 0010:remove_proc_entry+0x389/0x3f0
> > [    3.269976] Call Trace:
> > [    3.269979]  <TASK>
> > [    3.269988]  unregister_irq_proc+0x14c/0x170
> > [    3.269997]  irq_free_descs+0x94/0xe0
> > [    3.270004]  mp_unmap_irq+0xb6/0x100
> > [    3.270011]  acpi_unregister_gsi_ioapic+0x27/0x40
> > [    3.270017]  acpi_pci_irq_disable+0x1d3/0x320
> > [    3.270025]  pci_disable_device+0x1ad/0x380
> > [    3.270034]  pcim_release+0x566/0x6d0
> > [    3.270046]  devres_release_all+0x1f1/0x2c0
> > [    3.270057]  really_probe+0xe0/0x920
>
> Could you try the patch below?

The following patch works for me, the previous warning disappears, thank you.
But I got another error, I have no idea about it.

[    3.326686] snd_indigodj 0000:00:05.0: Direct firmware load for
ea/indigo_dj_dsp.fw failed with error -2
[    3.327474] snd_indigodj 0000:00:05.0: get_firmware(): Firmware not
available (-2)
[    3.328077] snd_indigodj 0000:00:05.0: init_hw err=-2
[    3.328496] snd_indigodj: probe of 0000:00:05.0 failed with error -2
[    3.329965] ==================================================================
[    3.330525] BUG: KASAN: use-after-free in stop_transport+0xa5/0x4c0
[snd_indigodj]
[    3.331122] Read of size 4 at addr ffff88800943f010 by task systemd-udevd/255
[    3.333226] Call Trace:
[    3.333426]  <TASK>
[    3.333595]  dump_stack_lvl+0x5a/0x74
[    3.333888]  print_address_description+0x7b/0x440
[    3.334264]  print_report+0x101/0x200
[    3.334558]  ? _printk+0x54/0x6e
[    3.334818]  ? stop_transport+0xa5/0x4c0 [snd_indigodj]
[    3.335231]  kasan_report+0xc1/0xf0
[    3.335513]  ? stop_transport+0xa5/0x4c0 [snd_indigodj]
[    3.335938]  stop_transport+0xa5/0x4c0 [snd_indigodj]
[    3.336346]  snd_echo_free+0x8c/0x410 [snd_indigodj]
[    3.336741]  ? snd_echo_interrupt+0x4b0/0x4b0 [snd_indigodj]
[    3.337183]  release_card_device+0x7d/0x190
[    3.337519]  ? snd_power_wait+0x80/0x80
[    3.337829]  device_release+0x97/0x1c0
[    3.338127]  kobject_put+0x144/0x1c0
[    3.338417]  __snd_card_release+0xe4/0x140
[    3.338744]  devres_release_all+0x1f1/0x2c0
[    3.339079]  really_probe+0xe0/0x920

Regards,
Zheyu Ma
