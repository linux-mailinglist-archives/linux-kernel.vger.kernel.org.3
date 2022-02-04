Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A024A9EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377400AbiBDSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbiBDSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:11:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B0C061714;
        Fri,  4 Feb 2022 10:11:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w25so14711864edt.7;
        Fri, 04 Feb 2022 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6s9CxsBC8cchiiPxKjwG6ONmmaSZUcKlcytb21KkuK4=;
        b=mMwobpRUXA9Il4+uCKlHw6uyqMvTiH9Co4xQriHvk+7cQWLGfV4ISuvLZjoEIYz2YL
         spSlxMCfXEqOlVgcBgRfvr7pMEccBcsjdEJHVaT+9IGq1T4x45Wh/IY0kFLObZgjyEi6
         qBKsaymIjp4oJsFJiFD1K8E1Cg0Cd2guzmTHMmlzvSuMbBVmk+i8SZSOiiaPlv4yvlz6
         rOsdvp0VNA5dRowLx6zMu5Av5Jz3WZLFQJTgvJknSwvoVcGuB9D3oLpqChe5IFVYxnzz
         oztZ8x+bOOEFXJH4M77HfNGxKRMNJh4UWDTgYw42Z8YdBcIHdA86Z8Nrowue70SLFobL
         4/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6s9CxsBC8cchiiPxKjwG6ONmmaSZUcKlcytb21KkuK4=;
        b=mm+ZNuoY1AyZvJCUfW7Y3XjWcpUkLtxrOcWAgfGUBo9wf06oA4TdM4cIqIZx24qakk
         rkojaC/1fpvfukWsDJImV7UjWHyaM7OqA+l3sCoC/oJg3u35PG9kWC3xoZ68tR3cP0hQ
         hpOVRSZzqLo58/C3Gme25J+9ICVg74cC5x0WJ63PnUn2g/TP6Ks+eTdpvJYqR8XaT805
         Eg6wSqUMeWpEBslQ7R7pRdQXf3G7RDwt865//h0sACTmCL9G5Jx0fIa+AWF1zyd4/n6i
         dTNXPfUq+O+fLv07YlDAvsDxGOCmNltXyuGnM7H/oZ/0RkMwK3DKo2DApg+xElNuhpHa
         fZYg==
X-Gm-Message-State: AOAM5308MbIol/L4N82FbluMumUaUD8spwQGEyxxy1ADEEz7AlFKD1Nr
        Ir4P8SQq9bGQEwdSCbEKo0h5+f+lmotfY/k4smc=
X-Google-Smtp-Source: ABdhPJxIigxgUUaumtaROQOhEriR+Qg/btM9GhyxFDVYRkUss89SOw+32KatpfY67ve6G/Onyk2M09eet+4uxIblNBQ=
X-Received: by 2002:a50:ee01:: with SMTP id g1mr316060eds.415.1643998267355;
 Fri, 04 Feb 2022 10:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20220203201207.1075933-1-shy828301@gmail.com> <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
 <ff0d4285-471b-7a33-15a5-3ce89443b41a@nvidia.com>
In-Reply-To: <ff0d4285-471b-7a33-15a5-3ce89443b41a@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Feb 2022 10:10:55 -0800
Message-ID: <CAHbLzkpSD8C2qTytUejrjuNG_o7r=UuHyqpJasiN_r9MD7AeMg@mail.gmail.com>
Subject: Re: [v6 PATCH] block: introduce block_rq_error tracepoint
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 12:35 AM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> Yang,
>
> > Question 1 :- What prevents us from using the same format for
> > both blk_rq_complete() and blk_rq_error() ?
> >
> > Question 2 :- assuming that blk_rq_complete() and blk_rq_error()
> > are using same format why can't we :-
> >
> > declare DECLARE_EVENT_CLASS(blk_rq_completion....)
> > and use that class for blk_rq_complete() and blk_rq_error() ?
> >
> > since if I remember correctly we need to define a event class
> > instead of duplicating a tracepoint with similar reporting.
>
> What I meant is following compile tested patch (although it will
> need to split into a prep patch in order to post it) :-

Thank you so much. I will prepare the new patches. I assume you prefer
a prep patch which converts trace event to event class, then add
block_rq_err event.

>
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 27170e40e8c9..7f4dfbdf12a6 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -100,19 +100,7 @@ TRACE_EVENT(block_rq_requeue,
>                    __entry->nr_sector, 0)
>   );
>
> -/**
> - * block_rq_complete - block IO operation completed by device driver
> - * @rq: block operations request
> - * @error: status code
> - * @nr_bytes: number of completed bytes
> - *
> - * The block_rq_complete tracepoint event indicates that some portion
> - * of operation request has been completed by the device driver.  If
> - * the @rq->bio is %NULL, then there is absolutely no additional work to
> - * do for the request. If @rq->bio is non-NULL then there is
> - * additional work required to complete the request.
> - */
> -TRACE_EVENT(block_rq_complete,
> +DECLARE_EVENT_CLASS(block_rq_completion,
>
>          TP_PROTO(struct request *rq, blk_status_t error, unsigned int
> nr_bytes),
>
> @@ -144,6 +132,41 @@ TRACE_EVENT(block_rq_complete,
>                    __entry->nr_sector, __entry->error)
>   );
>
> +/**
> + * block_rq_complete - block IO operation completed by device driver
> + * @rq: block operations request
> + * @error: status code
> + * @nr_bytes: number of completed bytes
> + *
> + * The block_rq_complete tracepoint event indicates that some portion
> + * of operation request has been completed by the device driver.  If
> + * the @rq->bio is %NULL, then there is absolutely no additional work to
> + * do for the request. If @rq->bio is non-NULL then there is
> + * additional work required to complete the request.
> + */
> +DEFINE_EVENT(block_rq_completion, block_rq_complete,
> +
> +       TP_PROTO(struct request *rq, blk_status_t error, unsigned int
> nr_bytes),
> +
> +       TP_ARGS(rq, error, nr_bytes)
> +);
> +
> +/**
> + * block_rq_error - block IO operation error reported by device driver
> + * @rq: block operations request
> + * @error: status code
> + * @nr_bytes: number of completed bytes
> + *
> + * The block_rq_error tracepoint event indicates that some portion
> + * of operation request has failed as reported by the device driver.
> + */
> +DEFINE_EVENT(block_rq_completion, block_rq_error,
> +
> +       TP_PROTO(struct request *rq, blk_status_t error, unsigned int
> nr_bytes),
> +
> +       TP_ARGS(rq, error, nr_bytes)
> +);
> +
>   DECLARE_EVENT_CLASS(block_rq,
>
>          TP_PROTO(struct request *rq),
> >
> > -ck
> >
> >
>
