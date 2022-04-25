Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F450E7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiDYSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiDYSOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:14:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7911115E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:11:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g19so27680917lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgZPcLi8Qc/FYo24I5Ui5ng4v5S2bS11j/TNA42dNdI=;
        b=AyTemggbe9yNeY3RXNoqcAc/M7mfZVWIDn0MNHEfheqaKT2mcwlb1VrhXvL8uuTyWP
         CNpuA7a0bg5jbWSiYl+aSOaGguqQA+9lY1Fqi7X4ipyhhZBkLDx7aYGS9i92fZTJ7olj
         bAGHOsvS2m1+Iwe/cjKA6S/ZrJVP0VywU2AmgY0M5byGjlTdfWSXKWgPtQIel65podM8
         JRrSuaXT2mgZyZ+OaamNgbFGvPaL0qZpMz5kIc6MnOC6tqpZuikPOsgHwpYlHsnrAfUE
         JtHEtd/MgNB6te4d8uiGz6w4z8KqV2ijeLHQB9eHKFt4iwRMhm5xLJNutC1Z1Et2HDAO
         GHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgZPcLi8Qc/FYo24I5Ui5ng4v5S2bS11j/TNA42dNdI=;
        b=rlTZFtsEtS5ptC4knKna+oIkL1azZbfF6lwQJ/HlzP4d2mV96Dt2J4pS5C87M8Lx/h
         dQMHhgoObMEXgBv2C45I9rRo4Ok9lfpb6IZmF6erXrsisrTGzHMncLsvlYrQRM6OiQ/z
         qPcJrBJb6i9xzdbERwjQf+pv9W90CR6xuowjVnoYb6T56lxrXUew0koAFH8jeJRGSJNJ
         ylZ3tnKhy/iF9BsfPRnQeRKt4Z1uZydC6LeQ2FvlHBo84/ZE3OjVgAsETZnWb7RVlL3u
         7QW5phDUIFZ7IS4HhSN1EKYBkzjCHNSFeXtcwBOI5lhsHjF7wmF5z9KtjXKqFFPoD6H+
         9b9A==
X-Gm-Message-State: AOAM5330JVrJdjIHtU7y33yHHmB/fWlJm0mY+/2D4oaYwFMK2r/hA4I6
        Gcl96NdIbDNrwOdZsyjLok6GLoGqmSWk6v1wxGxKcUR2ffA=
X-Google-Smtp-Source: ABdhPJxiQBayWivPSmwOm7iRe8+oFmRUHaUcR4YG3TbfL0hdALVJpOAd5m2+OrL9AulLRlq44PjBgHKNC39atXKgnfg=
X-Received: by 2002:a05:6512:1d1:b0:471:f63a:b182 with SMTP id
 f17-20020a05651201d100b00471f63ab182mr9720569lfp.392.1650910289712; Mon, 25
 Apr 2022 11:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-2-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:11:17 -0700
Message-ID: <CAKwvOdmaezR92E1p7UNGTdJf5D+DbKZEaNwTimxSbHVOjPgnuQ@mail.gmail.com>
Subject: Re: [PATCH 01/27] modpost: use snprintf() instead of sprintf() for safety
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use snprintf() to avoid the potential buffer overflow, and also
> check the return value to detect the too long path.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 522d5249d196..141370ebbfd3 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2560,6 +2560,7 @@ int main(int argc, char **argv)
>
>         for (mod = modules; mod; mod = mod->next) {
>                 char fname[PATH_MAX];
> +               int ret;
>
>                 if (mod->is_vmlinux || mod->from_dump)
>                         continue;
> @@ -2578,7 +2579,12 @@ int main(int argc, char **argv)
>                 add_moddevtable(&buf, mod);
>                 add_srcversion(&buf, mod);
>
> -               sprintf(fname, "%s.mod.c", mod->name);
> +               ret = snprintf(fname, sizeof(fname), "%s.mod.c", mod->name);
> +               if (ret >= sizeof(fname)) {
> +                       error("%s: too long path was truncated\n", fname);
> +                       continue;
> +               }
> +
>                 write_if_changed(&buf, fname);
>         }
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
