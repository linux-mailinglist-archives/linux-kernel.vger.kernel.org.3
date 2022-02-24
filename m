Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A34C340F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiBXRyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiBXRya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:54:30 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496EB2221AE;
        Thu, 24 Feb 2022 09:54:00 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d66f95f1d1so7001187b3.0;
        Thu, 24 Feb 2022 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eq0rhSJW/1Sw11xhooN6LOA8GL16OGqICWs9SpqOzME=;
        b=ovlMUCBoPHm0Ng7jBHgOGMvsivibBY0eFjYSXrf3lveZO9y7J2WPN15pjxopiEooRf
         jPMf3/Zbrl33kMLio4YHaGFu/g0gHEoxnq6wMuDCigvid5G32wBFY4FwqI6X3TqCQKq5
         s7OhTDCOZJ4i0qXn57rbq8Ygjw6NGONXkOhHCYlCpilq99mqAILegufcLLdORRqVk9TO
         ul4bgzurtbgclnajz6YRvaRZDtc6tgxRenOvk76+cIAjaOihY0FZq8LTCujURAMByF06
         xwZrGcr5kT+BK+kj0pQyLbeubQwxi7aY00qKJ9mawM7Pnf1MmavxrN5t9ESMA4xU+lOL
         Bp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eq0rhSJW/1Sw11xhooN6LOA8GL16OGqICWs9SpqOzME=;
        b=juZ5mGOZGXbyCxBl+X9EYqoekE9Mjz3oM9fxoV8y9uncWYLnNep3QG4BMUXWlWXe4Q
         EFCTPgV/Tp9xGP3qysbfxFZ5+OQ3PfPUHG3Rwx9KUn41HjiuCBzvUhCBRONubmuTNvyP
         eJs/hot7tD+7Aj5yL0NVE2zGA8vw0oIJZwT/aAXmoOwo6B7DnyuDOu26SaG1gOawtI8K
         +/k2B0qXwOA3xJSDojnPtXC6+zvDHhR7fUgtg/erpRTXrgCErYEffzk7GH+Gni89WdQL
         HR0rHv6scfSINzB8n5Y7aQ66OSej6LhiSpCyam5wTdSGvTFZR7djgYGvme3VOUT2dfrH
         MIrw==
X-Gm-Message-State: AOAM530AVSZMnVslyklvr/SWq4pyKTjXlwiJDGiLlO17xsZbp3qT79FY
        J7/dTTHOtX2Skkk9W5hzrexbaVuWtECIgzRa47fJA4UO
X-Google-Smtp-Source: ABdhPJxZp7Dh9XnMn1jok5IIVuFXG8ISgSBdeWyaZRCCEUUTGIHlI1sJNlJ0ObUBALgQDfzFy67N/QQEgUJvocgwQo4=
X-Received: by 2002:a0d:d748:0:b0:2d7:549a:552d with SMTP id
 z69-20020a0dd748000000b002d7549a552dmr3559431ywd.261.1645725239362; Thu, 24
 Feb 2022 09:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20220207103738.103661-1-jiapeng.chong@linux.alibaba.com> <CAKFNMokx2Qk4jJx6s0vzseYRbfjejZwoDY3MnPODWhT7-_1K=g@mail.gmail.com>
In-Reply-To: <CAKFNMokx2Qk4jJx6s0vzseYRbfjejZwoDY3MnPODWhT7-_1K=g@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 25 Feb 2022 02:53:47 +0900
Message-ID: <CAKFNMo=jrEwV_U4wkfKvWeMoTJ9Ojbb0xx2cMrhr1KXD2gnxeg@mail.gmail.com>
Subject: Re: [PATCH] mm/fs: Remove redundant code
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
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

Hi,

On Fri, Feb 25, 2022 at 2:30 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> Hi Jiapeng,
>
> On Mon, Feb 7, 2022 at 7:37 PM Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> >
> > Clean up the following smatch warning:
> >
> > fs/nilfs2/segbuf.c:358 nilfs_segbuf_submit_bio() warn: ignoring
> > unreachable code.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> >  fs/nilfs2/segbuf.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
> > index 9e5dd6324ea1..50d7e2e4daed 100644
> > --- a/fs/nilfs2/segbuf.c
> > +++ b/fs/nilfs2/segbuf.c
> > @@ -341,7 +341,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
> >                                    int mode_flags)
> >  {
> >         struct bio *bio = wi->bio;
> > -       int err;
> >
> >         bio->bi_end_io = nilfs_end_bio_write;
> >         bio->bi_private = segbuf;
> > @@ -354,9 +353,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
> >         wi->nr_vecs = min(wi->max_pages, wi->rest_blocks);
> >         wi->start = wi->end;
> >         return 0;
> > -
> > -       wi->bio = NULL;
> > -       return err;
> >  }
>
> Sorry for my late reply.
>
> I will send this to Andrew to report and fix the regression on the -mm
> patch series.
>
> I'd like to change the patch title to something like "nilfs2: Remove
> redundant code"
> since the "mm/fs" prefix does not properly represent what it applies to.
> (this patch may be folded into the patch that is causing the warning)
>
> Regards,
> Ryusuke Konishi

Sorry again.

The reported issue was already corrected in NeilBrown's revised patch set, so I
will suspend this.

Thanks,
Ryusuke Konishi
