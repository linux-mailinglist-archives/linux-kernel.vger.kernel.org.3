Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B044FCFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbiDLGkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350550AbiDLGiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:38:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783017E21;
        Mon, 11 Apr 2022 23:34:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id z128so16332237pgz.2;
        Mon, 11 Apr 2022 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0xn7fbBcfT9ZD65i3XI8WVPw6/lQKVr1FVvFfZdFfU=;
        b=ktKo1J5UX6I2KIr8lxRUOoE587v4xaDAo8VO52e3yvPJJoqc5W5+3QHrgIMlLumTqm
         qSoLi/ZoqlOQ62mMZua6v1ztNiMHuCo5rOVZ5R3GWCVAXmQ0TdJWu1tjEja76btfROew
         je1yMBOKUXqD17AA+u7+vqLDB1VwzUYN9Hoi/r6wLQYvMS9Vf4M1rUipBzfHjYivCBME
         f6RW3dQ8+fgjK9/aFuJ99E/Fh2zV+aLbGNMUJfLLV3dZ8pFPiOoarMksILlJnxbFB97l
         HDqnpGDHt+u5dnWIgxKaQfxRZd6O/u9etDxqR4BrKji7UPGdIv/aPHSdkpiSyZnqiLdC
         KdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0xn7fbBcfT9ZD65i3XI8WVPw6/lQKVr1FVvFfZdFfU=;
        b=J6/6VGtm0HCaaoj20Ld9M0D8TEIksqm5ZrzqD2R4SFnRUOkywTXj4OfQbOfpjPX0bc
         5TpDjIQbjRj+RjLV3K4hlFtnI+WuCssyIXlbUZoUEdAsFl3mP3wLHtjKxqfMJaVhmc5M
         pTwyUZPG8/GIJXQyIEgZywRXJ+ubXUJfyPspJ9swEi9zQckFdo9d26A7JPKKge+eMOeq
         gJaRA6sSfakkJLZRncgAWkGdVi9PUZIisnV+zIlT0mL0KRmMjTGCg7Bfva1bRLIkzfof
         8Fy+i3pofAWz05jSIQmSe48hhiPv2OfFyeh+TUpUcGwj19KBgi3cD5N6031mMWocU9Sp
         PkoA==
X-Gm-Message-State: AOAM53043pgmrrHH+wrfs++5Kcz2MT7fHS6EmDvQ3srAXQ8EAwp7ch3H
        1MsHCbFzw7VRZaLZIIAxDgcX11GSyFn3YhciEbK4xMW6lTgwu/M=
X-Google-Smtp-Source: ABdhPJwOC/K9SGVkUC2meA5MdUIXSRC7mUdRZxdon0F+Xn1g35vHqqoyQnulcMAGBDbgykn2BNjeSg8eKKFXiDcpIhs=
X-Received: by 2002:a05:6a00:18a5:b0:505:c080:a4e0 with SMTP id
 x37-20020a056a0018a500b00505c080a4e0mr9065116pfh.2.1649745291160; Mon, 11 Apr
 2022 23:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
 <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com>
In-Reply-To: <05433153-0424-ab66-1573-993d0490c5bc@opensource.wdc.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 12 Apr 2022 14:34:40 +0800
Message-ID: <CAMhUBj=JsiHnnQzrqPKzA=Z2+589Ju_HE0cFKyon58Fk0waeAQ@mail.gmail.com>
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

On Mon, Apr 11, 2022 at 7:53 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 4/10/22 15:30, Zheyu Ma wrote:
> > Hello,
> >
> > I found a bug in the pata_marvell module.
> > When probing the driver, it seems to trigger the error path and
> > executes the function marvell_cable_detect(), but the
> > 'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.
>
> I do not have this hardware so I cannot debug this. Please debug it and
> send a patch. bmdma_addr is normally set in ata_pci_bmdma_init(), but some
> drivers set it manually in their probe functions. No idea about the
> marvell driver, I have not checked it.

To be honest I don't have a good solution to this problem, because
other drivers don't have similar behavior. The marvell driver doesn't
even initialize 'bmdma_addr' before calling 'cable_detect'.

So a simple idea I have is to check if 'bmdma_addr' is 0 before
reading it and if so return the error code ATA_CBL_NONE.

Zheyu Ma
