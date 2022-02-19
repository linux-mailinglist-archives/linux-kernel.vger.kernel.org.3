Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC74BCB15
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 00:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbiBSXB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 18:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiBSXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 18:01:24 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882EA506F1;
        Sat, 19 Feb 2022 15:01:01 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id z7so7312529ilb.6;
        Sat, 19 Feb 2022 15:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JsTvQXRsbNOiGcu58U9fFMq2V+cC9hbrFYaW/h3E+1g=;
        b=Z6v34CPkmCq2AZb1WTbW3mh6Tm48Pu3YR0j6WN/wwMs+xuHp22zD8kUHhoz3TVmfOY
         z+qdVyKgtKySnD20XiY4UuUPARq7lbCMHyKPxma3uECUDKeh0763ogQlE3zULF2a183i
         WIrv5A6NnC6nhREzAEKWftm+BtXYFboYrsYDmyB7lqBClTxPONUHt8aFTDZZmQSu9cUK
         fQVjei7MWURhmlT1R0aoYg31Rhwdxn7sDgTPJ4cNdN5QfC7Lo4OSPUNiMnhvwcgkPU+Z
         juIkgyW5aH96hluWwW9l2ci2gK0uyLRnxxprEBnxCVOiqjuP6w3pNxlhLamLNHvVhPzV
         ObSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JsTvQXRsbNOiGcu58U9fFMq2V+cC9hbrFYaW/h3E+1g=;
        b=KIjb9TgsPoAr/16501mzzAYAkFkJp4DA33vZzuqbQuWTnaWzRBfKTigK69YDWpsiFC
         pEBMhsPnf2aEgHAb14vJNQ87AHvfQCHm4znQUTSWWL8bdWD1wL8jsfDipsArWu7H3LO1
         qERceGSoGJk3P0Z2AsszSg6BuQ7D6T9BkkevXqiE2LlctrlHGysGpRpPGgOMwQlJHaws
         /TqehExv/g9COIY/jYkjzoWpTwsfjjdu5tqhIflUi8GCOBstjifE00GGa7SckMelL6SN
         1qgfD1aUzoza5Jxxpu3yGN8ULw5jS6NspNHErOe9YUxRSv4zpBjOoBoK8ay68RqlQB76
         8o3Q==
X-Gm-Message-State: AOAM5308AdjgW32K+iiPjsh47f5ZBU/qoU5f23ntCB8Kk5jJsqRr1jEv
        vHWM1MfiH6eihe5JI3dsjisvkxO2dGeRNuvTtE4=
X-Google-Smtp-Source: ABdhPJxAq6Xhci6X8EyjKISKWHQB8A7GAnQkTQsSYKWI9pTBuyyqr9uAdwughLQMbr6RkpSBKXR6D5MB/Sif6OYt2oU=
X-Received: by 2002:a92:cd8c:0:b0:2be:abb:ec04 with SMTP id
 r12-20020a92cd8c000000b002be0abbec04mr10635076ilb.246.1645311660937; Sat, 19
 Feb 2022 15:01:00 -0800 (PST)
MIME-Version: 1.0
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area>
In-Reply-To: <20220219210354.GF59715@dread.disaster.area>
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Sat, 19 Feb 2022 15:00:51 -0800
Message-ID: <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
To:     Dave Chinner <david@fromorbit.com>
Cc:     qat-linux@intel.com, giovanni.cabiddu@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        salvatore.benedetto@intel.com, herbert@gondor.apana.org.au,
        pablo.marcos.oltra@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Dave,

> This really sounds like broken hardware, not a kernel problem.

It is indeed a hardware issue, specifically the intel qat crypto
driver that's in-tree - the hardware is fine (see below). The IQAT
eratta documentation states that if a request is not submitted
properly it can stall the entire device. The remediation guidance from
2020 was "don't do that" and "don't allow unprivileged users access to
the device". The in-tree driver is not implemented properly either for
this SoC or board - I'm thinking it's related to QATE-7495.

https://01.org/sites/default/files/downloads//336211qatsoftwareforlinux-rn-hwversion1.7021.pdf

> This implies a dmcrypt level problem - XFS can't make progress is dmcrypt is not completing IOs.

That's the weird part about it. Some bio's are completing, others are
completely dropped, with some stalling forever. I had to use
xfs_repair to get the volumes operational again. I lost a good deal of
files and had to recover from backup after toggling the device back on
on a production system (silly, I know).

> Where are the XFS corruption reports that the subject implies is occurring?

I think you're right, it's dm-crypt that's broken here, with
ultimately the crypto driver causing this corruption. XFS being the
edge to the end-user is taking the brunt of it. There's reports going
back to late 2017 of significant issues with this mainlined stable
driver.

https://bugzilla.redhat.com/show_bug.cgi?id=1522962
https://serverfault.com/questions/1010108/luks-hangs-on-centos-running-on-atom-c3758-cpu
https://www.phoronix.com/forums/forum/software/distributions/1172231-fedora-33-s-enterprise-linux-next-effort-approved-testbed-for-raising-cpu-requirements-etc?p=1174560#post1174560

Any guidance would be appreciated.
Kyle.
On Sat, Feb 19, 2022 at 1:03 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 18, 2022 at 09:02:28PM -0800, Kyle Sanderson wrote:
> > A2SDi-8C-HLN4F has IQAT enabled by default, when this device is
> > attempted to be used by xfs (through dm-crypt) the entire kernel
> > thread stalls forever. Multiple users have hit this over the years
> > (through sporadic reporting) - I ended up trying ZFS and encryption
> > wasn't an issue there at all because I guess they don't use this
> > device. Returning to sanity (xfs), I was able to provision a dm-crypt
> > volume no problem on the disk, however when running mkfs.xfs on the
> > volume is what triggers the cascading failure (each request kills a
> > kthread).
>
> Can you provide the full stack traces for these errors so we can see
> exactly what this cascading failure looks like, please? In reality,
> the stall messages some time after this are not interesting - it's
> the first errors that cause the stall that need to be investigated.
>
> A good idea would be to provide the full storage stack decription
> and hardware in use, as per:
>
> https://xfs.org/index.php/XFS_FAQ#Q:_What_information_should_I_include_when_reporting_a_problem.3F
>
> > Disabling IQAT on the south bridge results in a working
> > system, however this is not the default configuration for the
> > distribution of choice (Ubuntu 20.04.3 LTS), nor the motherboard. I'm
> > convinced this never worked properly based on the lack of popularity
> > for kernel encryption (crypto), and the embedded nature that
> > SuperMicro has integrated this device in collaboration with intel as
> > it looks like the primary usage is through external accelerator cards.
>
> This really sounds like broken hardware, not a kernel problem.
>
> > Kernels tried were from RHEL8 over a year ago, and this impacts the
> > entirety of the 5.4 series on Ubuntu.
> > Please CC me on replies as I'm not subscribed to all lists. CPU is C3758.
>
> [snip stalled kcryptd worker threads]
>
> This implies a dmcrypt level problem - XFS can't make progress is
> dmcrypt is not completing IOs.
>
> Where are the XFS corruption reports that the subject implies is
> occurring?
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
