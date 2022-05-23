Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C514530B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiEWIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiEWIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:38:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9D1839C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:38:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq30so24346222lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRSf7h1C+xevOx79dYwYdjwGLlCvPnsIvKCuQNVg6b0=;
        b=HnJDIO1DD8uWsK5M80OQ/Xr6r0UGYvi0eFEoAZtbgiZkvBA4J9Uz6T8juUT1zdiaha
         08ZPti5x8CYw/4TNGLynbwtKiaPYHuN1B4K2ZFqri7QmxKRgGQKs/9kDPAeNJBRskYsN
         sJR7EgZwGUwDv85JHujCng2x8R0nmiOQc/zT99iNbFDIz9zts7LuYHgr33APVT43Reld
         WnFO6/ITg+411JGs4Icf8eKbNM8mGMIlpycCff4pkr49dCunmEabaFkP32nrXMd/OB1z
         4KGy16V8+jjnG08Ydmsz+sc7AqVB/Qb6QhCmv30neoOWoN2U8vfJdwsGfa/8W29CXXQG
         QNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRSf7h1C+xevOx79dYwYdjwGLlCvPnsIvKCuQNVg6b0=;
        b=nxT4wG26tXSn81uEQ5lawaOTDQ0E0CYHXaAVjpXkITgJ5W34nTZzDHSkCmksSVk6iz
         axtb8sJSVZthwqOLw9QwVa8hyvKgZ//peYILRAzP8S7TAB7bBwaiBowx+4m7d4fQgrCl
         sn9/VD+mfhxiQqCZ2guQMR33PA/h1ErkbD/Th+FnNE7YECg6XYwtbQlgkTyk95FQx7yJ
         TrfaKsiD0K/QJatMLEdsLlBqfkgI0lvkq7MHFroqvcdMV7SUw34i4+m9G2DT6jKaDNYS
         tTVpBnxxyLHgUkAvCQAq1bC+cF4eE0nTGOKegrEqUXkTkJERrFo5yE8U2WVYIzuCj8at
         pqjA==
X-Gm-Message-State: AOAM530a3OUktpzX4Hr8ECmQAI7ueSgUIadw4xcFRuiCXFj6Gk8EXH+C
        1OSlV0ZIk/jT3T5G6Wrvp/VEI92qElKDhM7CBuKpkQ==
X-Google-Smtp-Source: ABdhPJz6Lb5JNL+yOggQNGHfley1Yg72XGZ1kFLRFSAA1t53iLIJaFR4omn7p+jlwWEEOazGWn2SpGK7BH5wRLZofK4=
X-Received: by 2002:a05:6512:ace:b0:473:cca7:a7fa with SMTP id
 n14-20020a0565120ace00b00473cca7a7famr15178834lfu.410.1653295130619; Mon, 23
 May 2022 01:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220523053531.1572793-1-liu3101@purdue.edu>
In-Reply-To: <20220523053531.1572793-1-liu3101@purdue.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 May 2022 10:38:39 +0200
Message-ID: <CACT4Y+Y9bx0Yrn=kntwcRwdrZh+O7xMKvPWgg=aMjyXb9P4dLw@mail.gmail.com>
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace function
To:     Congyu Liu <liu3101@purdue.edu>
Cc:     andreyknvl@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 07:35, Congyu Liu <liu3101@purdue.edu> wrote:
>
> In __sanitizer_cov_trace_pc(), previously we write pc before updating pos.
> However, some early interrupt code could bypass check_kcov_mode()
> check and invoke __sanitizer_cov_trace_pc(). If such interrupt is raised
> between writing pc and updating pos, the pc could be overitten by the
> recursive __sanitizer_cov_trace_pc().
>
> As suggested by Dmitry, we cold update pos before writing pc to avoid
> such interleaving.
>
> Apply the same change to write_comp_data().
>
> Signed-off-by: Congyu Liu <liu3101@purdue.edu>

This version looks good to me.
I wonder how you encountered this? Do you mind sharing a bit about
what you are doing with kcov?

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks

> ---
> PATCH v2:
> * Update pos before writing pc as suggested by Dmitry.
>
> PATCH v1:
> https://lore.kernel.org/lkml/20220517210532.1506591-1-liu3101@purdue.edu/
> ---
>  kernel/kcov.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index b3732b210593..e19c84b02452 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -204,8 +204,16 @@ void notrace __sanitizer_cov_trace_pc(void)
>         /* The first 64-bit word is the number of subsequent PCs. */
>         pos = READ_ONCE(area[0]) + 1;
>         if (likely(pos < t->kcov_size)) {
> -               area[pos] = ip;
> +               /* Previously we write pc before updating pos. However, some
> +                * early interrupt code could bypass check_kcov_mode() check
> +                * and invoke __sanitizer_cov_trace_pc(). If such interrupt is
> +                * raised between writing pc and updating pos, the pc could be
> +                * overitten by the recursive __sanitizer_cov_trace_pc().
> +                * Update pos before writing pc to avoid such interleaving.
> +                */
>                 WRITE_ONCE(area[0], pos);
> +               barrier();
> +               area[pos] = ip;
>         }
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> @@ -236,11 +244,13 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         start_index = 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <= max_pos)) {
> +               /* See comment in __sanitizer_cov_trace_pc(). */
> +               WRITE_ONCE(area[0], count + 1);
> +               barrier();
>                 area[start_index] = type;
>                 area[start_index + 1] = arg1;
>                 area[start_index + 2] = arg2;
>                 area[start_index + 3] = ip;
> -               WRITE_ONCE(area[0], count + 1);
>         }
>  }
>
> --
> 2.34.1
>
