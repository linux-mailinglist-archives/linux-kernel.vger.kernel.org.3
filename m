Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAD595413
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiHPHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiHPHnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:43:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453E9C53B;
        Mon, 15 Aug 2022 21:36:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i14so16783444ejg.6;
        Mon, 15 Aug 2022 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mJgV2TbRMYBhyG0pUzyspC3dQe6/h27C+GdQ4x8eYhI=;
        b=KbZX+lRZQ/8NbexleO3N+VJjhv9Vmq0CJ+0Do/vOBkPR36i/9DgWwfWOAVOFcSH3/y
         FE7sXalvbrTPyhvnu5GNCF7wC9rdOe9oOVwvdBlT+9dfZBk9vEvX6LKJoXN8VIv2cTra
         LeVgYU5eljCGgVyarFGUipBvVoWwe5pDJvKZ/3HqkU9iZ57QiGGNPW9snsbREqLFrGvl
         EkkP3gPxe/Ck4lcmerZIm6AaJkcDO4Bt8aUw0nxT3mNiSYff3XQmbuuSvnwxSOSKQQ2S
         49Bd4Imsae/ftIc70j3tegWAtiqCTOPi5ialHK72EbL3lYatcQUS5UjSUdl0+0/tE9Tx
         Skhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mJgV2TbRMYBhyG0pUzyspC3dQe6/h27C+GdQ4x8eYhI=;
        b=eq8vN2VnT6otKDzy7Vk3FvwnKM/IPgGxTXzaXKHzt3y7BPmInPqDE7FzHeDdQACvYr
         TcU8Relk4traL3qHKfXJ6pyn3u1w22zKXWXPaa/1EpBw8oK57HAHAcN/NU2VZR+4QmFg
         aoF4w5IRC18qLNx0Z9hHhXkUwcwxhYeWgUDLjeuDXLq3xecT9ZZ3+Qsant3WCnAqCwDX
         u/p12PIan0YC/+CMN1jCFzZ6Zaw3+b33l7gmxEa4jgci39c97cjoxL8vCDAG/mQcRMif
         eG9I/15gRlp0TOxNDYp6g6Tzyz/uvyTVXE0e3/R4JWE3Ts0jgXJx1c3kZxPb0vS/I2iG
         kzFQ==
X-Gm-Message-State: ACgBeo0oIO7uE9MUcRNrrZX1b2ciAIGEQXCl1I7h8kUhBMnUmvtmpczr
        eG+XYNB7KfycmHRrRS7xM8TR2EaAL5Ejx/bJ0EZpvfiBH+ngPwJ6KLU=
X-Google-Smtp-Source: AA6agR5ADSm2dU6KocBDxJD+F53KZs3OdtemlEgbiSzNT5GBwCk/Q28gr7WNLxxA5ujpTJ5J/8UzPJ8gEDofT0FSWQA=
X-Received: by 2002:a17:907:2809:b0:730:a723:9ddf with SMTP id
 eb9-20020a170907280900b00730a7239ddfmr12060393ejc.42.1660624610328; Mon, 15
 Aug 2022 21:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220815164324.645550-1-haowenchao@huawei.com> <3ed022dd-3026-542a-c3b0-e4f4005208aa@linux.ibm.com>
In-Reply-To: <3ed022dd-3026-542a-c3b0-e4f4005208aa@linux.ibm.com>
From:   wenchao hao <haowenchao22@gmail.com>
Date:   Tue, 16 Aug 2022 12:36:38 +0800
Message-ID: <CAOptpSMqfiApXn2jgmaLu-CdqyGUr7yQ1v3AwQUDev4mFjaqJQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: increase scsi device's iodone_cnt in scsi_timeout()
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenchao Hao <haowenchao@huawei.com>
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

On Tue, Aug 16, 2022 at 12:53 AM Steffen Maier <maier@linux.ibm.com> wrote:
>
> On 8/15/22 18:43, Wenchao Hao wrote:
> > The iodone_cnt might be less than iorequest_cnt because
> > we did not increase the iodone_cnt when a command is done
> > from timeout.
> >
> > Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> > ---
> >   drivers/scsi/scsi_error.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > index 448748e3fba5..d21ae0090166 100644
> > --- a/drivers/scsi/scsi_error.c
> > +++ b/drivers/scsi/scsi_error.c
> > @@ -355,6 +355,7 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
> >                */
> >               if (test_and_set_bit(SCMD_STATE_COMPLETE, &scmd->state))
> >                       return BLK_EH_RESET_TIMER;
> > +             atomic_inc(&scmd->device->iodone_cnt);
> >               if (scsi_abort_command(scmd) != SUCCESS) {
> >                       set_host_byte(scmd, DID_TIME_OUT);
> >                       scsi_eh_scmd_add(scmd);
>
> Not sure, but can't we still get a (late) regular completion even after the
> timeout happened (double accounting) and before we successfully aborted the
> command?
>
>
The flag SCMD_STATE_COMPLETE would take care of it, this would make
sure a scsi command
is done from timeout or regular completion exclusively.

When scsi_abort_command() begins to handle a command, the command
would be finished by
scsi_finish_command() or retried by requeue function.

If a command finished by scsi_finish_command(), it would not add the iodone_cnt.
If a command is requeued, it would call scsi_dispatch_cmd() again and
another iorequest_cnt would be
added.

According to above analysis, I think it's suitable to increase iodone_cnt here.
