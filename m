Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA99D578C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiGRUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiGRUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:55:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76062CC98
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:55:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u19so12638597lfs.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngAg2yVO32eBtQbv+5HGxymaiT96wuzbFVwUnPbkYPs=;
        b=Lekm+r2aRj8xx29RD0wy/9Tl0pPKcs7oHW9Fd98cwNBSfHby25BNUaqXile6+m1W3J
         YlBpcOTBiSgo4GLV2EkMvz09EnwHmUNnw6N8DrwfOSvrx6y91FkuJ/CZPj2CsH7lDGv0
         o2tWRKHqhw4fCFTn9zXdMRxsg3zuz5eXOmvdR5+WDd61Z4EhpVK0l964j97jzc7hSIZG
         q2J1Idq/NpA3PMmskY2EYKBHPMWN+Jp7nFw61/1Ri+T33vzU7cYw9Fynr92ZeC156nXK
         zk4/C0BlRTyLcmaIVFcYuBR9D2IaW3gHdwiPhzFUrc3rEKXyHE8Kfkxz2QpTlaLG0D8m
         K/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngAg2yVO32eBtQbv+5HGxymaiT96wuzbFVwUnPbkYPs=;
        b=jtkfeG9Wvg+U5aZI20Sf1lgNd4fzTrD1+E+/Zy62/c3bR9ATj5i68a4Du3N/wG5RoS
         fsgISIYvUe2ruzSPuAwUfJXgjttvanF8BNtz2+0fD2XzsHHSvq7Zm3w1t1EEISSwy2co
         8ptg4p3vn4YIaH/4F/euD6E9EVgjZc0CAkkiibIGVLDbPztw40QLSlLy6b0P+O5bhuWe
         C/47Wq1yuZZuzPx7wBp+7PXXDiQgQV7lSFcEvQYzqeiLXw44fwAF8eKjc/YYqGk+dKU1
         vqSVZWUlCVJCWYwuuI9GrHyWFv8UZxRsSuTNxWu0cJv8RQXRS2D5i/WHHw7n1cwuZPZE
         /Gqg==
X-Gm-Message-State: AJIora/MtyquErzIB56z5fcMrlsruzINyDZgw8Dr2KId/b6gdvfgNfsm
        0CAexKgqdtIQ9Rusdj5fyoT1HNbOQagQnzD5Y39JWw==
X-Google-Smtp-Source: AGRyM1tcWZRhnGREO1HBCcsOSiZAmhbB+eNTAxfA1VHqRBIMV5ol//3U7P7L3hH5mPy40BaNkgIjSUUGC1iWFEDtcX4=
X-Received: by 2002:a05:6512:31d1:b0:489:cfee:3600 with SMTP id
 j17-20020a05651231d100b00489cfee3600mr15798595lfe.432.1658177732994; Mon, 18
 Jul 2022 13:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220708211447.135209-1-justinstitt@google.com> <20220718180421.49697-1-justinstitt@google.com>
In-Reply-To: <20220718180421.49697-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Jul 2022 13:55:21 -0700
Message-ID: <CAKwvOdn42__0Z4Qrh0rVzotCGFdecfyCY-=C_OE0U3z20A1NmA@mail.gmail.com>
Subject: Re: [PATCH v2] target: iscsi: fix clang -Wformat warnings
To:     martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        llvm@lists.linux.dev, mgurtovoy@nvidia.com,
        michael.christie@oracle.com, mingzhe.zou@easystack.cn,
        nathan@kernel.org, target-devel@vger.kernel.org, trix@redhat.com,
        Justin Stitt <justinstitt@google.com>
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

On Mon, Jul 18, 2022 at 11:04 AM Justin Stitt <justinstitt@google.com> wrote:
>
> When building with Clang we encounter these warnings:
> | drivers/target/iscsi/iscsi_target_login.c:719:24: error: format
> | specifies type 'unsigned short' but the argument has type 'int'
> | [-Werror,-Wformat] " from node: %s\n", atomic_read(&sess->nconn),
> -
> | drivers/target/iscsi/iscsi_target_login.c:767:12: error: format
> | specifies type 'unsigned short' but the argument has type 'int'
> | [-Werror,-Wformat] " %s\n", atomic_read(&sess->nconn),
> -
> | drivers/target/iscsi/iscsi_target.c:4365:12: error: format specifies
> | type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
> | " %s\n", atomic_read(&sess->nconn)
>
> For all warnings, the format specifier is `%hu` which describes an
> unsigned short. The resulting type of atomic_read is an int. The
> proposed fix is to listen to Clang and swap the format specifier.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> diff from v1->v2:
> Combined two similar patches into one:
> * https://lore.kernel.org/all/20220708221314.466294-1-justinstitt@google.com/
> * https://lore.kernel.org/llvm/20220708211447.135209-1-justinstitt@google.com/
>
>  drivers/target/iscsi/iscsi_target.c       | 2 +-
>  drivers/target/iscsi/iscsi_target_login.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index e368f038ff5c..bfb717065344 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -4361,7 +4361,7 @@ int iscsit_close_connection(
>
>         spin_lock_bh(&sess->conn_lock);
>         atomic_dec(&sess->nconn);
> -       pr_debug("Decremented iSCSI connection count to %hu from node:"
> +       pr_debug("Decremented iSCSI connection count to %d from node:"
>                 " %s\n", atomic_read(&sess->nconn),
>                 sess->sess_ops->InitiatorName);
>         /*
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
> 2.37.0.170.g444d1eabd0-goog
>


-- 
Thanks,
~Nick Desaulniers
