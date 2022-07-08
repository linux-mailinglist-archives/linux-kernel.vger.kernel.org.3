Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596C256C556
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiGHXmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiGHXml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:42:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36976BC36
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:42:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a39so160781ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1z/XYffrQE1ulbZWqvB17ZvgZDPHSFhdrO4bt0sud0=;
        b=rwQIfx2Rbka3ZHXrSst/zHyIhKR2xW8QfdqVBrkvu70qG4LbOgX2/R7lqpN7urgSGj
         kW/vig2rxrw5x7BzghZ113H429+v5QNUXswiV5ZJ4sglOAcVoa1d/8+i15DcFgPlA4F/
         FRbh2JPOxgmXZOYbz9bx0muHxBonv8wFVGhPibkcY0RkzlW3wmuKuW4PYg9BS1NTBJYO
         bBlB9zQqFoE1tfmMg3xHd9pgI11PYjcfO3Ta5JHIuhEzYKZTr4o9w5zuOnGrakuZoksG
         ZHVXkuBvG253i4A3tfL6Pwgf+HtvL4RaNLKtDz5Um8913lZvvDuPY1bD1Zad3vxX5WPE
         jQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1z/XYffrQE1ulbZWqvB17ZvgZDPHSFhdrO4bt0sud0=;
        b=32g48+2kDJmCal1W4B9/Li3Y/fHue+/coFq6sLnk4SDBj/9DYXGueoIUzdPndoi9rG
         LpJ8u/EddrXUzzIaILpR68bR6t7BRq0gauaks1GusIBt7umpJcd/BjTpoa234KeTnG2Q
         DKHNWGDtqrKqKw3uMEga3m00b14XLuA6KyJXlIn4vt4lz0/QFpSgq3hgy0PK4RSI7baO
         dKxLQXGIvmcTm3M4uwm4NZyhb6Luv8jh0tBIbb8D1eEXs83//fJbz70RIp2qSD/4WyS7
         GVr142IyjIM3ySFZQAvyjh0Y66to4NlsSZrsgfzTFy9ywq6vUxJZLmq3aPlEYTrds4C6
         yzXA==
X-Gm-Message-State: AJIora8GqawalOWL5i0wUoLwJickuMPMw/9KPAst+VGNIBr2/20mX70D
        zLdTBfmNkhQCu0WL9Kb3oBZ2nzh2AHFOv3SI7qaTCWZVYA2XkQ==
X-Google-Smtp-Source: AGRyM1vOYSphaV8U+fKakVnibkqv4glTuEdXHVh6JjOdl+7EiEGP/eDNnQirMA5rO1tyZG9VLt5QlYutmIVp385/51c=
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id
 x9-20020a2e3109000000b0025a8a0c40e2mr3237589ljx.26.1657323757825; Fri, 08 Jul
 2022 16:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220708211447.135209-1-justinstitt@google.com>
In-Reply-To: <20220708211447.135209-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jul 2022 16:42:25 -0700
Message-ID: <CAKwvOdmXCB7VoQLXfBgfyxdMvqaNeacMVbkCFptAqzX21KuPtg@mail.gmail.com>
Subject: Re: [PATCH] target: iscsi: fix clang -Wformat warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Jul 8, 2022 at 2:15 PM Justin Stitt <justinstitt@google.com> wrote:
>
> When building with Clang we encounter these warnings:
> | drivers/target/iscsi/iscsi_target_login.c:719:24: error: format
> | specifies type 'unsigned short' but the argument has type 'int'
> | [-Werror,-Wformat] " from node: %s\n", atomic_read(&sess->nconn),
> -
> | drivers/target/iscsi/iscsi_target_login.c:767:12: error: format
> | specifies type 'unsigned short' but the argument has type 'int'
> | [-Werror,-Wformat] " %s\n", atomic_read(&sess->nconn),
>
> For both warnings, the format specifier is `%hu` which describes an
> unsigned short. The resulting type of atomic_read is an int. The
> proposed fix is to listen to Clang and swap the format specifier.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>

See also:
https://lore.kernel.org/lkml/CAKwvOd=uOrDe5DWnXn7fx8+kTCF6gQVYhgqpnDFbaKunfBBVVg@mail.gmail.com/

> ---
>  drivers/target/iscsi/iscsi_target_login.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
> index 6b94eecc4790..0778591abae7 100644
> --- a/drivers/target/iscsi/iscsi_target_login.c
> +++ b/drivers/target/iscsi/iscsi_target_login.c
> @@ -715,7 +715,7 @@ void iscsi_post_login_handler(
>
>                 list_add_tail(&conn->conn_list, &sess->sess_conn_list);
>                 atomic_inc(&sess->nconn);
> -               pr_debug("Incremented iSCSI Connection count to %hu"
> +               pr_debug("Incremented iSCSI Connection count to %d"
>                         " from node: %s\n", atomic_read(&sess->nconn),
>                         sess->sess_ops->InitiatorName);
>                 spin_unlock_bh(&sess->conn_lock);
> @@ -763,7 +763,7 @@ void iscsi_post_login_handler(
>         spin_lock_bh(&sess->conn_lock);
>         list_add_tail(&conn->conn_list, &sess->sess_conn_list);
>         atomic_inc(&sess->nconn);
> -       pr_debug("Incremented iSCSI Connection count to %hu from node:"
> +       pr_debug("Incremented iSCSI Connection count to %d from node:"
>                 " %s\n", atomic_read(&sess->nconn),
>                 sess->sess_ops->InitiatorName);
>         spin_unlock_bh(&sess->conn_lock);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>


-- 
Thanks,
~Nick Desaulniers
