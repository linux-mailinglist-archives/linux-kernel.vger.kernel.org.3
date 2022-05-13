Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BC5259D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbiEMC4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376611AbiEMC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:56:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3FE2497D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:56:33 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2DFB33F940
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652410591;
        bh=rF63nrgHe2cIWk7sqY1Jv0XZG3knafOJHCDaTqNMlvM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=U7KowGIG4s7z5FG0WOqTY/eK9wmuEnpsB2PFxDxPPyr4e1M1zHDP8JSrCwLUBaCYP
         j5on83bV4UEsnsf1EbLFjQU6SdJeWrLPidvoyCYeLbJ7hGJl7kYUDhuFwvgC2GKqIT
         eUs5UEle2gslIGlADDUVXA3zidIc4eXk0qF+oehgS2WdSPLwroyY7nMYoP1pu/FWOF
         xsEtWAYZUZ5mAMnzDVwyLU5kKi5UiqNrQTzj188ZiGLJn0TeAJ5mxjjyIh9JxdTSX9
         d7CzkUGB6irM976tohb6FQl2YuU+DDx5areRZ56ElOrVMjb/PCJv6f/WzWHiQ9KYXI
         R/tK/GNLgXWhA==
Received: by mail-pg1-f197.google.com with SMTP id d125-20020a636883000000b003db5e24db27so2064281pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF63nrgHe2cIWk7sqY1Jv0XZG3knafOJHCDaTqNMlvM=;
        b=Ext0jT8rp5FnPEetD2ZsYag7/2zLhPDWVV2QDEWm7WGUMCow2+qA6/tZ2Ot05UExKq
         ZRLkzL9u90nUHkG71WEYCUUQRb13tL8JX+l68gGh2wWXLUK30cbRDFRACHYx/MuD6inK
         43LRDzuZeR+qFSmV5Zo66sNgV5Xk4oo2bprHGJ3l7nAibYVk9NryXG9D60knHcfTjDRp
         gx5V+M3LV5/xD49y2SLusitftA0TpQ1NBFsu8uWzwiBvf8TomSmS4+f+ujklrXKWyTpP
         mBl28lBuGb4Vjns5Hzd4ij1fCUxZO9R/CmfYfgCBmpKlHhY7yziFlvLtz2iAJIWR1mGe
         dyKg==
X-Gm-Message-State: AOAM5319Hkv1r/hwi6JYLUb7JJtciEHJTyAUxOogjZ8KUr+LZQmgD1oX
        16U+Zks23u52s+bOXh2dUjGP3oE/EVSsuXqDusU7b7Y7Saa9clvSAsK5tLPL6jR7znGuARLVTVS
        sJ+/zYuk3p2fmfmvbfcMbMv/4u5dIoFIvaxytoFXBudQl856pXflH18HVnw==
X-Received: by 2002:a05:6a00:14ce:b0:50f:ac00:2a8b with SMTP id w14-20020a056a0014ce00b0050fac002a8bmr2515921pfu.36.1652410589569;
        Thu, 12 May 2022 19:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF07aqxQuyHQBnn1dyRbK0T+OdhcKZA2/h0j3IrKXjFeE5mXIWYnicu3Vjp1wRI+BJrCi2u/Pe5db7SXi1Biw=
X-Received: by 2002:a05:6a00:14ce:b0:50f:ac00:2a8b with SMTP id
 w14-20020a056a0014ce00b0050fac002a8bmr2515909pfu.36.1652410589312; Thu, 12
 May 2022 19:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com> <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
In-Reply-To: <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Date:   Fri, 13 May 2022 14:56:18 +1200
Message-ID: <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

Just a friendly ping, I am more than happy to test a patch, if you send it
inline in the email, since the pastebin you used expired after 1 day, and I
couldn't access it.

I came across and tested Yu Kuai's patches [1][2] which are for the same issue,
and they indeed fix the hang. Thank you Yu.

[1] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
https://lists.debian.org/nbd/2022/04/msg00212.html

[2] nbd: fix io hung while disconnecting device
https://lists.debian.org/nbd/2022/04/msg00207.html

I am also happy to test any patches to fix the I/O errors.

Thanks,
Matthew

On Tue, Apr 26, 2022 at 9:47 AM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> Hi Josef,
>
> The pastebin has expired the link, and I can't access your patch.
> Seems to default to 1 day deletion.
>
> Could you please create a new paste or send the patch inline in this
> email thread?
>
> I am more than happy to try the patch out.
>
> Thank you for your analysis.
> Matthew
>
> On Sat, Apr 23, 2022 at 3:24 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Fri, Apr 22, 2022 at 1:42 AM Matthew Ruffell
> > <matthew.ruffell@canonical.com> wrote:
> > >
> > > Dear maintainers of the nbd subsystem,
> > >
> > > A user has come across an issue which causes the nbd module to hang after a
> > > disconnect where a write has been made to a qemu qcow image file, with qemu-nbd
> > > being the server.
> > >
> >
> > Ok there's two problems here, but I want to make sure I have the right
> > fix for the hang first.  Can you apply this patch
> >
> > https://paste.centos.org/view/b1a2d01a
> >
> > and make sure the hang goes away?  Once that part is fixed I'll fix
> > the IO errors, this is just us racing with systemd while we teardown
> > the device and then we're triggering a partition read while the device
> > is going down and it's complaining loudly.  Before we would
> > set_capacity to 0 whenever we disconnected, but that causes problems
> > with file systems that may still have the device open.  However now we
> > only do this if the server does the CLEAR_SOCK ioctl, which clearly
> > can race with systemd poking the device, so I need to make it
> > set_capacity(0) when the last opener closes the device to prevent this
> > style of race.
> >
> > Let me know if that patch fixes the hang, and then I'll work up
> > something for the capacity problem.  Thanks,
> >
> > Josef
