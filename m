Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC154FB9F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbiDKKtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiDKKtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:49:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D7A43ECC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:47:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so13495747plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D61e5PhtFJPcIJdrPl1gSUgNp3pemKHhA66zJEsV9FM=;
        b=A4Jk68wM4X0r58C8JBY86tyj7B6qU/KA0BUvsUrgdYgeFSQPF/0L6mUWUGtpL9BWoh
         QT53llRS+5kFsvzwsiKgwEeik+Gr7+6FILNA889tzzx782qbFHbldXEfpy+2w4FUV9b7
         wF7XLqNylZxxCrW2P+3TGcYkQr+ybttO/B3tlzpFA/sDnth1BB1TjRMDVOe1rF91M/4t
         e4PgtHKnbCbzLxY8uTPe0XKjEmI2yj2g6l+qPmaw0n45MFHQqgVDXqQKzw+Nj6H0onZV
         q8vynE1L6tPyHigNfK6p3VrWNI/aF0ppwdv0m01vwSAbe4IROB/M3B3y2VZ2oGDy2Y39
         fdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D61e5PhtFJPcIJdrPl1gSUgNp3pemKHhA66zJEsV9FM=;
        b=167DMPAGXrRWuP898w43yJ2gWL2wrjQpnlMtSySFPYuQ2o/UsGxSqPr3reUcor5/W4
         9YCk6TAfVCaeZA4hTMZkLklhk82sypllTRHZylsJyJPQI+vAX7vDV+9Dzn/+v6UmBOMy
         Wuu8xRPA4BgVZbDZ1wv3LcG+/lA/M07BYurXuWDh1pweOT9nr2y6UuBQ7Cf2aXvVKuIH
         FxU4SXABjkr/8s5DrsjFVrY7NLq9kmYXMjnNfsTVHa0M/NzAzlf6CNtuNUGxaB+FmnXo
         se7EBItzM89g6uAzp3x/zc4wIuHaCmRedpwVrzEAeCUb6o3A3hYHLu8edrl+Cg1Wh11Z
         RDig==
X-Gm-Message-State: AOAM5329uVXxOYBME3qwZIa4HFJHnLGpOQ9OTEDUR4s1z7LkFku99YHL
        GuYvUHcpgzLskjMH1hHgZSc9CBmg58wfP/jWKg==
X-Google-Smtp-Source: ABdhPJw9zQgg8aq+ex04YlfU4TBmmq7cCCdpQ4wKdPETEclZPcjGAnNhQ7WCeWPz51/6DWRoa7PmQB1YWm9dJpyJg0I=
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id
 lw3-20020a17090b180300b001c724c4ab52mr35530871pjb.240.1649674024416; Mon, 11
 Apr 2022 03:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220410114814.3920474-1-zheyuma97@gmail.com> <f9e0d516-d3a7-c0bf-f673-2a4c3dd9184d@kernel.org>
In-Reply-To: <f9e0d516-d3a7-c0bf-f673-2a4c3dd9184d@kernel.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 11 Apr 2022 18:46:53 +0800
Message-ID: <CAMhUBjkhJ2GvuNVH_9b9mm0d8NwS9Jmf51i8RHdfLLpsR=V5HQ@mail.gmail.com>
Subject: Re: [PATCH] tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, Apr 11, 2022 at 6:13 PM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 10. 04. 22, 13:48, Zheyu Ma wrote:
> > When the driver fails at alloc_hdlcdev(), and then we remove the driver
> > module, we will get the following splat:
> >
> > [   25.065966] general protection fault, probably for non-canonical address 0xdffffc0000000182: 0000 [#1] PREEMPT SMP KASAN PTI
> > [   25.066914] KASAN: null-ptr-deref in range [0x0000000000000c10-0x0000000000000c17]
> > [   25.069262] RIP: 0010:detach_hdlc_protocol+0x2a/0x3e0
> > [   25.077709] Call Trace:
> > [   25.077924]  <TASK>
> > [   25.078108]  unregister_hdlc_device+0x16/0x30
> > [   25.078481]  slgt_cleanup+0x157/0x9f0 [synclink_gt]
> >
> > Fix this by checking whether the 'info->netdev' is a null pointer first.
>
> Hi,
>
> LGTM
>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>
> Out of curiosity, do you use the driver, or you only do some static
> analysis?

In fact, neither. I test the driver via fuzzing in a simulated environment.

Zheyu Ma
