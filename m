Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948256B1CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiGHEqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiGHEp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:45:56 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF46261E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:45:54 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r2so5157124qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TH1DEH3ugKVlgLwwZhwhLtP7cgOEydE2KiN+E9aH/A=;
        b=MUYvvC0zBGI32l5G5tdnDbzHons4WfJEL3AqGOV8mpLskmYbv5/nGC1s1BJxGYmPMP
         IlrbpNnXmYA13jWrlfMiGXOj0AQhUtaERuEXKr3+yTgOmWZih1r7kX5v2wNW/h5aRdji
         98wa7fkAZnnwwB8wJUULC8vGNgkkz6/JWAC78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TH1DEH3ugKVlgLwwZhwhLtP7cgOEydE2KiN+E9aH/A=;
        b=Oj1cxlF+KGaEO5VqPTQ4wcccKKAm0G8TnmIMoGdcSbZJRArbZqeQ8Dypfla61U+hcT
         Dqsr67CtLBfg41uDH3fvzqwbpEy3VklMIcZ8bpSxeOZskm0EMgHfFSRKRK/FGLjUa+9t
         JzvCkF4dJ68r6/JpS1qhWf8bf+Gv+6Of4CtmlFxnte+y8lcozAFjRixkI9D/m1uwjVOw
         mZaDTP+fyZ9HvwgI6LJF5fyr6h71YJJ42PctczuCW8wn5uC4DjCmaJoT9GGndYkcJQ29
         fLlDcX5VYPygY+NuYU5fzAgUskzrvaTURIUjde4HzvBceNWNOSQIzy2rAvZCR7w+psG+
         EKXw==
X-Gm-Message-State: AJIora9fLo1Cxb3pXIipZ/+8aIxvBaKSf9kNW0a1sNsyH93w3230shlR
        VLcmdr8sTAEz9GZeBhM6x6EgJ09nMqJ2nwLX
X-Google-Smtp-Source: AGRyM1tTI3/CNJBb0b3yZ2opSxEfLiXOBHfNzEBWDq7+C+SEToIuRqTiFkk9BXHNe06ZOGyyIlCj0Q==
X-Received: by 2002:a05:6214:19cc:b0:472:f402:5ba4 with SMTP id j12-20020a05621419cc00b00472f4025ba4mr1194910qvc.46.1657255553419;
        Thu, 07 Jul 2022 21:45:53 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id u5-20020a37ab05000000b006b4748535a1sm10005855qke.16.2022.07.07.21.45.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 21:45:49 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id g4so36029710ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:45:49 -0700 (PDT)
X-Received: by 2002:a25:1583:0:b0:668:e74a:995f with SMTP id
 125-20020a251583000000b00668e74a995fmr1662451ybv.1.1657255548819; Thu, 07 Jul
 2022 21:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar> <20220706182657.210650-9-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <20220706182657.210650-9-ezequiel@vanguardiasur.com.ar>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Jul 2022 13:45:35 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cxn+HVun+H66-RvUh6SUqnSbug0vpmFFanmrGywfqHeg@mail.gmail.com>
Message-ID: <CAAFQd5Cxn+HVun+H66-RvUh6SUqnSbug0vpmFFanmrGywfqHeg@mail.gmail.com>
Subject: Re: [PATCH 8/8] videobuf2: Remove vb2_find_timestamp()
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Thu, Jul 7, 2022 at 3:27 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Now that we've transitioned all users to vb2_find_buffer API,
> remove the unused vb2_find_timestamp().
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 12 ++++-----
>  include/media/videobuf2-v4l2.h                | 26 +------------------
>  2 files changed, 7 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 075d24ebf44c..a9696442dfba 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -625,18 +625,18 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
>         .copy_timestamp         = __copy_timestamp,
>  };
>
> -int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
> -                      unsigned int start_idx)
> +struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
>  {
>         unsigned int i;
>
> -       for (i = start_idx; i < q->num_buffers; i++)
> +       for (i = 0; i < q->num_buffers; i++)
>                 if (q->bufs[i]->copied_timestamp &&
>                     q->bufs[i]->timestamp == timestamp)
> -                       return i;
> -       return -1;
> +                       return vb2_get_buffer(q, i);
> +
> +       return NULL;
>  }
> -EXPORT_SYMBOL_GPL(vb2_find_timestamp);
> +EXPORT_SYMBOL_GPL(vb2_find_buffer);
>
>  /*
>   * vb2_querybuf() - query video buffer information
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 7f9ae5b39b78..5a845887850b 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -62,22 +62,6 @@ struct vb2_v4l2_buffer {
>  #define to_vb2_v4l2_buffer(vb) \
>         container_of(vb, struct vb2_v4l2_buffer, vb2_buf)
>
> -/**
> - * vb2_find_timestamp() - Find buffer with given timestamp in the queue
> - *
> - * @q:         pointer to &struct vb2_queue with videobuf2 queue.
> - * @timestamp: the timestamp to find.
> - * @start_idx: the start index (usually 0) in the buffer array to start
> - *             searching from. Note that there may be multiple buffers
> - *             with the same timestamp value, so you can restart the search
> - *             by setting @start_idx to the previously found index + 1.
> - *
> - * Returns the buffer index of the buffer with the given @timestamp, or
> - * -1 if no buffer with @timestamp was found.
> - */
> -int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
> -                      unsigned int start_idx);
> -
>  /**
>   * vb2_find_buffer() - Find a buffer with given timestamp
>   *
> @@ -86,15 +70,7 @@ int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
>   *
>   * Returns the buffer with the given @timestamp, or NULL if not found.
>   */
> -static inline struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q,
> -                                                u64 timestamp)
> -{
> -       int index = vb2_find_timestamp(q, timestamp, 0);
> -
> -       if (index < 0)
> -               return NULL;
> -       return vb2_get_buffer(q, index);
> -}
> +struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp);

Was there any specific reason to add it as an inline initially rather
than just having it close to the final shape from the very beginning?
Sorry for being picky, but I find it more difficult to review this
way.

Best regards,
Tomasz

>
>  int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b);
>
> --
> 2.34.3
>
