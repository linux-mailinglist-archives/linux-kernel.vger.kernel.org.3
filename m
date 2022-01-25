Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FAE49B6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiAYOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579776AbiAYOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:38:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D4C061401;
        Tue, 25 Jan 2022 06:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EB82B81812;
        Tue, 25 Jan 2022 14:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EE7C340E0;
        Tue, 25 Jan 2022 14:38:48 +0000 (UTC)
Date:   Tue, 25 Jan 2022 09:38:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
Message-ID: <20220125093846.59826cad@gandalf.local.home>
In-Reply-To: <20220125093702.3ffdb721@gandalf.local.home>
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
        <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
        <20220125093702.3ffdb721@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 09:37:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > +TRACE_EVENT(block_rq_error,
> > > +
> > > +       TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
> > > +
> > > +       TP_ARGS(rq, error, nr_bytes),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(  dev_t,        dev                     )
> > > +               __string( name,         rq->rq_disk ? rq->rq_disk->disk_name : "?")
> > > +               __field(  sector_t,     sector                  )
> > > +               __field(  unsigned int, nr_sector               )
> > > +               __field(  int,          error                   )
> > > +               __array(  char,         rwbs,   RWBS_LEN        )  
> 
> Why is the above not "__string" ?
> 
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->dev       = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
> > > +               __assign_str(name,   rq->rq_disk ? rq->rq_disk->disk_name : "?");  
> 
> __assign_str() will not work on an __array() type. It only works here
> because you added it at the end, but it's just shear luck that it didn't
> crash.

Never mind :-p  I see the above is for name which is __string, and the
array is for rwbs which is filled below. I need to finish my first cup of
coffee before reviewing patches.

-- Steve

> 
> 
> > > +               __entry->sector    = blk_rq_pos(rq);
> > > +               __entry->nr_sector = nr_bytes >> 9;
> > > +               __entry->error     = error;
> > > +
> > > +               blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
> > > +       ),
> > > +
> > > +       TP_printk("%d,%d %s %s %llu + %u [%d]",
> > > +                 MAJOR(__entry->dev), MINOR(__entry->dev),
> > > +                 __get_str(name), __entry->rwbs,
> > > +                 (unsigned long long)__entry->sector,
> > > +                 __entry->nr_sector, __entry->error)
> > > +);
> > > +
