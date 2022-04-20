Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC4507EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358928AbiDTCYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356849AbiDTCYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:24:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEDE2C64E;
        Tue, 19 Apr 2022 19:21:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so593263pfh.3;
        Tue, 19 Apr 2022 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g71afBe03kBYuxiT9CusOK+qbu46m0CphYm7CF5fRTQ=;
        b=oA7X0J5wj1JyA7Pva/Rylb7Gvkt1hdiEl92H4JvGgufP2ViDVvxtwuh8qRawYrpAcy
         XzFHjcS8ChQdptHrFyA//Ma1wo4UoOXQFCY7PA83PIbVE2h360oSOwhZbeC48vgJNmAa
         Y9tylgfh/mY4MwcfljQ5q+Id9w2z0z7O0fisqY/Kulu6BMEBLwAEdNC7I+sSr9MCYmEp
         Q1BigWesesQP9OkmRLHFGeqEFrolFOb1O4MFEDvTTktrgXIc7BTfFfU2WMY4EQ/bV+Gh
         gHKLWF5R9nus9QwdY5/MMd/iPjVWk2/oMEMT348v1Y4qqCfaMcu7zmV466MJOGh93asZ
         1USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g71afBe03kBYuxiT9CusOK+qbu46m0CphYm7CF5fRTQ=;
        b=wtzqZgrZN0PjorSqePX8oRmuYTZyvy/BoYBW8maaMCpJOOtISJo3v5wmqq6D+Whzge
         xPoxiZ+QTgBpFwcGM4MAqOikM4z5jRtuRZ4QlH8euI/SZsVpFv6q2nISQp3gyRfsWdEF
         vt1tM0xOdiWCsS4PHQAB66+pQb45gEWsOsHSq9OGXjR+GCcVPPN//EYmgYA7ujCu1G25
         9k1FYXCwEiWKRhciw2S/BVtPehVNuZhfvEGXzczMwl/M180pA5zzrM/rJSyuy8zx+k57
         zOzT7IHs1NFnzDBQNa3aLnayppI9kDq7ivNXz9Tffndumb3y24IFDYA7SAPMpyiWXJNk
         briA==
X-Gm-Message-State: AOAM531iP8LBE49UuZc3KXsbHhiDeau+z1ZIbcEjaNDAIsrwaoqJGdjI
        wHFaPhGhksCIPRuDX0G29tLGWXApgJ8ZUBrSqQ==
X-Google-Smtp-Source: ABdhPJxdhiqCMbSuciWgIU0XOlbdgGSS7iKlAAMJ7MpBmeJRWin2AJ41Z/DwmoMHHj4EayThMxJYFg0TorvHa4sa8Hc=
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr17587195pgi.542.1650421286100; Tue, 19
 Apr 2022 19:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com> <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
 <3045fde1-2d5b-e731-ef18-6cf3f0987259@opensource.wdc.com>
In-Reply-To: <3045fde1-2d5b-e731-ef18-6cf3f0987259@opensource.wdc.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 20 Apr 2022 10:21:14 +0800
Message-ID: <CAMhUBjnG75XANF1E5KUyigKSmhxzvJytfapieC6_jpKdiFwzSg@mail.gmail.com>
Subject: Re: [BUG] ata: pata_marvell: Warning when probing the module
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
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

On Wed, Apr 13, 2022 at 11:42 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 4/12/22 15:34, Zheyu Ma wrote:
> > On Mon, Apr 11, 2022 at 7:53 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 4/10/22 15:30, Zheyu Ma wrote:
> >>> Hello,
> >>>
> >>> I found a bug in the pata_marvell module.
> >>> When probing the driver, it seems to trigger the error path and
> >>> executes the function marvell_cable_detect(), but the
> >>> 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
> >>
> >> I do not have this hardware so I cannot debug this. Please debug it and
> >> send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
> >> drivers set it manually in their probe functions. No idea about the
> >> marvell driver, I have not checked it.
> >
> > To be honest I don't have a good solution to this problem, because
> > other drivers don't have similar behavior. The marvell driver doesn't
> > even initialize 'bmdma_addr' before calling 'cable_detect'.
>
> Then this is the bug that needs to be fixed, no ?
>
> > So a simple idea I have is to check if 'bmdma_addr' is 0 before
> > reading it and if so return the error code ATA_CBL_NONE.
>
> And if indeed, even after it is initialized it is still 0, then yes, this
> change seems sensible.

Sorry for the late reply, I found the root cause of this issue.
The marvell driver execute the ata_pci_bmdma_init() function, but the
driver just returned at the following code snippet.

if (pci_resource_start(pdev, 4) == 0) {
      ata_bmdma_nodma(host, "BAR4 is zero");
      return;
}

So the driver didn't initialize the 'bmdma_addr' but used it in the
cable_detect() function.
It seems that the problem is caused by the hardware, is this a bug
that we should fix?

Zheyu Ma


Zheyu Ma
