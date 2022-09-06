Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80F5AF5B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiIFUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiIFUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:20:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5781A383
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:19:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j12so65047pfi.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bqnp9p0V4JZZT62KX8DMFQ4HAlt6ExXQvsl9ninrHkE=;
        b=HxH3B/ypEeEHPycGK1ub43NY1/iAcvqWjPl3p2ZggH2WoIeJ31Z4EXbsHjxdgCIXWl
         BGzdKcKnKRqonP0oeiz+9g49J50VQPVrjGdb41JhIGqOuNa+gNalYMZEewZ7vSQVAyHP
         nk7s297IAu749Q95EJ6GuBR9KQ1eWCEzadzo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bqnp9p0V4JZZT62KX8DMFQ4HAlt6ExXQvsl9ninrHkE=;
        b=SsVm6a02un13Pi/inMjLPJ9vcEtsom217OQuK+yZATdlHIefs3qK6lf+vBCs6NnNCU
         LrszpddZB4NIoSwh7PKhOmkIyUDu05jNGe5XE5EOVo2IIXfp0eawT4zuFyppcunh8dX7
         wESE+rCFbmWYKznOLzWXYUFnXNjnZL1dU9JXxz8eaX5OGO+ALwXZqGwH5wTGkZ+mYNI9
         r1b/g5wdngsp2j9ZvP/fLxavSWWachxqDIvdfPWReNXXY9NNpfR8DH6flvBPUyU8L9d9
         jBS6qaqHUwDHnaZtGTBAWJx8p6Om5CoTmtJxEd2lgzGZetbRU5XIpgkiXVnskm10YAx8
         Vt3g==
X-Gm-Message-State: ACgBeo1S8kT93MQdmM3YSRPvfcqNiReBtIvBnl+lsJyqN9VE6XVg2gIz
        G5nVcOyspwlkDZANiSNPeTaX5g==
X-Google-Smtp-Source: AA6agR4mkbHYE4uEDFCfru06OH+HhFds5FNHm3/a9vONq8j/WvPR1MrirUM2/BnsQmRtFKIJRxBfvA==
X-Received: by 2002:a63:6683:0:b0:42b:1d69:a0ff with SMTP id a125-20020a636683000000b0042b1d69a0ffmr291631pgc.475.1662495539906;
        Tue, 06 Sep 2022 13:18:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i71-20020a639d4a000000b0041b667a1b69sm8991694pgd.36.2022.09.06.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:18:59 -0700 (PDT)
Date:   Tue, 6 Sep 2022 13:18:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     WeiXiong Liao <gmpy.liaowx@gmail.com>, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pstore/zone: Use GFP_ATOMIC to allocate zone buffer
Message-ID: <202209061315.08B5962@keescook>
References: <CAJRQjofRCF7wjrYmw3D7zd5QZnwHQq+F8U-mJDJ6NZ4bddYdLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJRQjofRCF7wjrYmw3D7zd5QZnwHQq+F8U-mJDJ6NZ4bddYdLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 11:17:13PM +0800, Qiujun Huang wrote:
> There is a case found when triggering a panic_on_oom, pstore fails to dump
> kmsg. Because psz_kmsg_write_record can't get the new buffer.
> 
> Handle this by using GFP_ATOMIC to allocate a buffer at lower watermark.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  fs/pstore/zone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
> index 017d0d4ad329..2770746bb7aa 100644
> --- a/fs/pstore/zone.c
> +++ b/fs/pstore/zone.c
> @@ -761,7 +761,7 @@ static inline int notrace
> psz_kmsg_write_record(struct psz_context *cxt,
>   /* avoid destroying old data, allocate a new one */
>   len = zone->buffer_size + sizeof(*zone->buffer);
>   zone->oldbuf = zone->buffer;
> - zone->buffer = kzalloc(len, GFP_KERNEL);
> + zone->buffer = kzalloc(len, GFP_ATOMIC);
>   if (!zone->buffer) {
>   zone->buffer = zone->oldbuf;
>   return -ENOMEM;

This patch appears to be whitespace damaged, but I've manually applied
it. Thank you!

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/pstore&id=27001e611bb642287eddf93227bd72d295a35453

-- 
Kees Cook
