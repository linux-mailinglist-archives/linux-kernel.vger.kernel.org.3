Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346951765C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386682AbiEBSP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbiEBSPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:15:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC56DDC;
        Mon,  2 May 2022 11:11:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e24so13331455pjt.2;
        Mon, 02 May 2022 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=km1RYLI1CobmrVkQO++1orn+WmYu8I6YnJXKOV3FSOQ=;
        b=dB62/6N/AupbAvnvnbYkc9o1gznuQKe5diiYys5TCW2fVoV0Z/PzlNNr0Vd3GZMsUu
         qv1m927BQ+WhuiRYLRPMXcUo+iGGzNcEUNBgvLpU196Uy2BKVJlhvhPSF5PqDMYX0fHG
         fbZi/rZV1blQmJcCKvTxPKd4hhJ0Wvt2vc2qVaWxN70gr2CMYt5JL84AmxcEEVA4WTdB
         PBZ9+NXWAl+ziAvI8YGOop1tGSAvqIi6anAsm6hsqCItEmUzNxCEXJk8IoON6l56iWhQ
         NqNxKUbwAM5/sBrcKAMSprHgc5LoWBtkWjaOZBAbfR163HJxBwZ4K5sHHtinVZ91VxlY
         SziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=km1RYLI1CobmrVkQO++1orn+WmYu8I6YnJXKOV3FSOQ=;
        b=2Bk5ijOIZ//P47QXau8fZTZ6G9oZ32lZfcKrWWBbOJue9Y4Zea8CWC2N4GjfDH/Ghi
         kHj+4pqaocUCMS7UID8MFUaydmye6SiNjKSsxJUOkSS9aB3IR7sJ4fSzi3TEpiG61bX8
         MinU+eWGuNJTqYCCO5GOYiCjgVwJlZiC/42ZNlqi2YaMkbtW3OYHmwBQbM1UonMa2ec4
         XVYEG/7vvNMRltS1w9JKR6RDDfZhGvgFi6O7kRr3Wc4SDtlruNa7WymlFCLBwqEKDhXn
         JDo9J7JOryi6+e8pWAsW+M2a4lz0rWXcvmqzsCB1OHUcXYSfeDe5VZ6WSodNvqv24LP6
         wQSQ==
X-Gm-Message-State: AOAM5327YXearednqChIwavcYovgkjkE931azChRAY7OXBWBbcNXy2JK
        e/UfcOgryUh7cl38wWtvSP3RDpbOLg0=
X-Google-Smtp-Source: ABdhPJzj3kGs5QP45BRIDGYHtsHAssbMOKq9HMUFTjzMJabeN+7kNncO7h3BuX770fKDhetwr1jI4Q==
X-Received: by 2002:a17:90a:170c:b0:1dc:20c4:6354 with SMTP id z12-20020a17090a170c00b001dc20c46354mr409558pjd.113.1651515114454;
        Mon, 02 May 2022 11:11:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4d84:d37e:584f:bdbc])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c7ca00b0015e8d4eb246sm4920428pla.144.2022.05.02.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:11:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 2 May 2022 11:11:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Aleksey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@chromium.org" <axboe@chromium.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mnitenko@gmail.com" <mnitenko@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: Re: [PATCH v2] zram: remove double compression logic
Message-ID: <YnAe52Eg60tjeBNK@google.com>
References: <20220427100345.29461-1-avromanov@sberdevices.ru>
 <YmkpSC/gJf7Cg2Ym@google.com>
 <20220428200107.hz65qvxf2aoz27q2@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428200107.hz65qvxf2aoz27q2@cab-wsm-0029881>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksey,

On Thu, Apr 28, 2022 at 08:01:12PM +0000, Aleksey Romanov wrote:
> Thanks for the reply!
> 
> On Wed, Apr 27, 2022 at 08:30:16PM +0900, Sergey Senozhatsky wrote:
> > On (22/04/27 13:03), Alexey Romanov wrote:
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index cb253d80d72b..4be6caf43b1d 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -1153,9 +1153,8 @@ static ssize_t debug_stat_show(struct device *dev,
> > >  
> > >  	down_read(&zram->init_lock);
> > >  	ret = scnprintf(buf, PAGE_SIZE,
> > > -			"version: %d\n%8llu %8llu\n",
> > > +			"version: %d\n%8llu\n",
> > >  			version,
> > > -			(u64)atomic64_read(&zram->stats.writestall),
> > >  			(u64)atomic64_read(&zram->stats.miss_free));
> > >  	up_read(&zram->init_lock);
> > 
> > I think this also has to bump `version` to 2, since format of the
> > file has changed.
> 
> Yes, I'll do that in the next patch.
> 
> Minchan, do you have any suggestions on this patch? 
> I want to fix Sergey suggestion and sumbit next patch.

You need to remove zs_free in the path "Compression failed"

Since we don't have double compression, we don't need QUEUE_FLAG_STABLE_WRITES
so you could remove QUEUE_FLAG_STABLE_WRITES, too.

Thanks.
