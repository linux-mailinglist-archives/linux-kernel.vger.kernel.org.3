Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E365786F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiGRQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiGRQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:06:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72115DE85;
        Mon, 18 Jul 2022 09:06:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x21so9430900plb.3;
        Mon, 18 Jul 2022 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a0s8px3/RXnurTCxUDxMO4W/3qNbuh+YY9hkSyPHlqw=;
        b=LrBaIMF6COvViX5DtFglUTH0q1CuPSPG5iuEstXaYcgwfaru6AtDA1iIDWf2Ed6jjs
         sykws9SDgJWVINwOukrPsnWIcp2jGlUYjCF2MmNXqqe+kXCpfv+JRLx+B87b7X0x7UQy
         jUrTDEtmeiFDTqxzsYcoDBnupB2MZrQDe5ZlC6FfhupNfG++ulDdzeZ/fU2MFzOeCCeu
         RR6EXfCkgWk7EWwMFuGm5W29eDKSC0auX0Mn1FnkwCKIyGCkJdanv7Fvdf1UNBipm0Q6
         KgsvH3w5SilDwawg6wWZr0a/tVrUklhsmF5OslXn/yEJP52zKUHoy3JQM0zqwsrj2TSZ
         z7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0s8px3/RXnurTCxUDxMO4W/3qNbuh+YY9hkSyPHlqw=;
        b=7w6WwhrcNDwhxyaBAKlYImrjJzW2enyCG0dVWHQvFxNDidQxXeXvEBWAA3n2k9T+T4
         ikRDOYw97H/pIN/lg6uz3vJJM6YhM5SRWnQQqw8OSsjrNcU801CXAzh4Xi1uBnj6E74O
         FGCRfuCVYt8iRSX2zSOSsKZPSe1ooUq6dVu3OZSz+bvJ528xFPbCTGHbPh/6DaAF2hDI
         PUgRsNkxygx07s9KaUnBb7xE1coVe8ZwhUhrfi2BF3k8HM3o5GmAYJMf2lapLm1++TQy
         nH4TSMsBtNGhD4PCS+8AilZZ4Zo972ZZxOGf28wLJyDHWCv5j7CZ97YpUJ4BBHbWh8we
         EtIg==
X-Gm-Message-State: AJIora/2psqWFHcfIbSZvUuXd9kF6wBLY2jSZHyFxrLEip0ts+/vjfiZ
        5YtnqdBGjQzdpDHYM8YK3rg=
X-Google-Smtp-Source: AGRyM1vjM1mQ5+vKx3O9hxJDeWTy0SvQrZcnBLb4icB9XZ48AAYMf1oaAxQJmCeoYUvW/wP692w/qA==
X-Received: by 2002:a17:90b:4b49:b0:1ef:a03e:b671 with SMTP id mi9-20020a17090b4b4900b001efa03eb671mr38988994pjb.108.1658160415872;
        Mon, 18 Jul 2022 09:06:55 -0700 (PDT)
Received: from biggie ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id g23-20020a631117000000b00412a708f38asm8219773pgl.35.2022.07.18.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 09:06:55 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:36:50 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [RFC] block: Add a NULL check in blk_mq_free_rqs()
Message-ID: <YtWFGsZIXx+KDl2G@biggie>
References: <20220717102242.219424-1-gautammenghani201@gmail.com>
 <d4efe597-94b0-5878-fb54-1c6deb915659@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4efe597-94b0-5878-fb54-1c6deb915659@acm.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 07:49:12AM -0700, Bart Van Assche wrote:
> On 7/17/22 03:22, Gautam Menghani wrote:
> > Syzbot reported a general protection fault in the function
> > blk_mq_clear_rq_mapping() in the file block/blk-mq.c.
> > The issue is that the variable drv_tags is NULL, and this
> > originates from the struct blk_mq_tag_set. The dashboard link for this
> > issue is :
> > syzkaller.appspot.com/bug?id=c3ce4caa4fc58c156d4903984131cdfa38eee354
> > 
> > This patch fixes the above bug, but there is another syzbot bug which is
> > related to this and getting triggered after the call to
> > blk_mq_clear_rq_mapping(). As a result, I cannot determine if the issue
> > is really solved. The link to other issue:
> > syzkaller.appspot.com/bug?id=7643cea70f1d0ce15f5f4bc39488918837ad4233
> > 
> > Please provide feedback/suggestions on the same.
> > 
> > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> > ---
> >   block/blk-mq.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 93d9d60980fb..c1dd1b78b95c 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -3092,7 +3092,8 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >   		}
> >   	}
> > -	blk_mq_clear_rq_mapping(drv_tags, tags);
> > +	if (drv_tags)
> > +		blk_mq_clear_rq_mapping(drv_tags, tags);
> >   	while (!list_empty(&tags->page_list)) {
> >   		page = list_first_entry(&tags->page_list, struct page, lru);
> 
> I don't see how drv_tags could be NULL without triggering a race condition.
> Please take a look at the nbd driver to see whether the root cause is
> perhaps in that driver instead of in the block layer core.

Yes, this might very well be the case. Thank you for the feedback.
> 
> Thanks,
> 
> Bart.

Thanks,
Gautam
