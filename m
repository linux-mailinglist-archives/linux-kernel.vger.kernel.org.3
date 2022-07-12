Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D789257180D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGLLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiGLLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:09:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED0B0270
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:09:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d12so13326325lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVQOPlTnuA1yYhPt8Wh3gI7FjQUx1QY7F8FI0tZWYAY=;
        b=A7XXKjFrCEue0kURaD9nT4FN22E5h3lG+vmU0ZFaKnYQoZhHQeza8pmqyUxUtN84/f
         VCySaEG5ncb10Gie42hSd1OPPJhNiRor+oTvAhKmeRVql9oPocLIhV1Vq7JqgRzjwAtZ
         37TGhrhpwUIawgBGjjOwFzn793fln8sLLCvy6ihwGzI7+WX69trd3LhEEwwSlwyfTs54
         r7Q4RcLrf/pZq4dYH+iSh+fYKmAHSFxL5Jlhm3A+SLbrXndrqGKPojIDFIakbwM2R6QW
         FJjyw2FyQdBzN5SVOsBHiHW9WunvOLHBhLzSujlp1HGMbjMxrpW/987MYwu2JIDV/6Cv
         8aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVQOPlTnuA1yYhPt8Wh3gI7FjQUx1QY7F8FI0tZWYAY=;
        b=QfkPI3mrxjRycA6rEv0XCjPdm5wdzQeNkiN5Vz3iRAl5M7GLoeWhBn6ZLR6E/oSlXP
         /UK2EEn539ADMSJfs5rlohKeqv1XXFthJBVcl2cxzXFPT4nH7aAk/wbo/q5ouHASukE8
         +0KaiT7GQh0hRkklQonUUmzAtQts6pcGXa7CRJWWbOObCA75BgxaNJMskZ09xz7Fed80
         Qz3ivw3u70rmQkYn7hszBgX75ckcDw8bHSDJzWufB/FurTvPKKLuM9I0atLGruE7jAQB
         UaqXzPbRmMe7YskQ98YVtXQOvWCPqSlyw102pA+oORr2zqMwt04Ofjz9yz8K1Jr1V2nu
         nyZA==
X-Gm-Message-State: AJIora+D2v6u+Nar6/CbXnUzvZAyR64rPJe8VA9bK4AYYkcuPAU6iC7p
        59+k17YUylWdQUgYYsIOdWGbOaKUktgQHaoT8tKQZw==
X-Google-Smtp-Source: AGRyM1tdIQpFjs4FQN5KurKmOeod20NGBrauxzzr9JmeaXPOXMwNM060XOMcv3FEpzY2zQWVFbLcYiMaf9pn0ReFt88=
X-Received: by 2002:a05:6512:ad6:b0:481:1a75:44c with SMTP id
 n22-20020a0565120ad600b004811a75044cmr15165411lfu.167.1657624172374; Tue, 12
 Jul 2022 04:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656155715.git.christophe.jaillet@wanadoo.fr> <b3b78926569445962ea5c3b6e9102418a9effb88.1656155715.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b3b78926569445962ea5c3b6e9102418a9effb88.1656155715.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:08:53 +0200
Message-ID: <CAPDyKFr2VpKVtFhNYPjy+uXKRNVTXS6LaMoAkv8u9YDeXTnnBQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] memstick/ms_block: Fix a memory leak
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 at 14:55, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'erased_blocks_bitmap' is never freed. As it is allocated at the same time
> as 'used_blocks_bitmap', it is likely that it should be freed also at the
> same time.
>
> Add the corresponding bitmap_free() in msb_data_clear().
>
> Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This patch is speculative.
> ---
>  drivers/memstick/core/ms_block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index f8f151163667..f8fdf88fb240 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -1947,6 +1947,7 @@ static void msb_data_clear(struct msb_data *msb)
>  {
>         kfree(msb->boot_page);
>         bitmap_free(msb->used_blocks_bitmap);
> +       bitmap_free(msb->erased_blocks_bitmap);
>         kfree(msb->lba_to_pba_table);
>         kfree(msb->cache);
>         msb->card = NULL;
> --
> 2.34.1
>
