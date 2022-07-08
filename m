Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8E56C559
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGHXlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGHXlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:41:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728999660
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:41:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bf9so120064lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eU4Pn+QfTubmNmsGNshAIHOz3MlAVSj+62C5s2QQP0=;
        b=YPfCC534/rpUeeQu1ADA77pUJyQmCCHALh/h1R+1Q51Gz57+L7IhzKcg47WrIA8wym
         L7+bevHAwkW9YksRTXPl4tK1B52C/Rlb0eEqa4CJdNxgBhhFkYY8DI0zXksxckpvRRWD
         D0hUiOpqBXjb6tuh1sMs9ABJt0SIHMJt5UeYua9Dxx6FFF6MSxywqe2O+dk70ueYyHyI
         PZgPQTvR8xuUJUQ4DOXQ3AY20QCOfX56fRUCHNX9C/Iys3P6ib+i3lKN3yvJTbcUXNEi
         5KQJ209dZm0hD4QrfetKIHEX/uSrXdiq+316wXVyXimUShvHpmsyDjvx2eI7XtigNicJ
         RDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eU4Pn+QfTubmNmsGNshAIHOz3MlAVSj+62C5s2QQP0=;
        b=oYnarI4tz/A8i/gQ6j9XyCkBO1B+//CvxaXC6GFaSykmk3nep9JzF/KLbzdi2I4A29
         j9hlVJqdmnnQB+HTGKUbq0XU6c4rC+QmmxmobJ6xRKnjGvgxQNo3XP67A0aqBkMU2eFR
         ThrlCh0qzHZJ0Scus0SYRsPBAydms/KVL+k2Ol5w3ltKd3sRRexvPAQ2xN2ol4x8Kj56
         gz13F04BOn/cgyKdeLZbkL5aX9svmjN2y98Z76HK5hqEtASsdvKwznmW8iRM6Lm/GC/y
         p8BBlvZoOFNryjBES9JN+kXPa/teIa/SG449IcnVbotF0crWqlzJrJlCgUWUsqosscAp
         VBXw==
X-Gm-Message-State: AJIora83BnC/pLrXMhjXISLefzntJesxrnfHJQ9MKfWoGiyk08AtSMIX
        kgEX04yKY5QL6ODIGV/ZZm/B0DxOwMvvRPcpXwzPhg==
X-Google-Smtp-Source: AGRyM1uP9YifLrRKvafA7w1uy6h0ZJ7JTDYw1RTJw5mjCkRfNXTOUn69pM/MdgvhyJoN6Q41bZb5XuusaOL3IL9Nv7Y=
X-Received: by 2002:a05:6512:e9a:b0:489:c681:da2b with SMTP id
 bi26-20020a0565120e9a00b00489c681da2bmr2113455lfb.626.1657323672384; Fri, 08
 Jul 2022 16:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220708221314.466294-1-justinstitt@google.com>
In-Reply-To: <20220708221314.466294-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jul 2022 16:41:01 -0700
Message-ID: <CAKwvOd=uOrDe5DWnXn7fx8+kTCF6gQVYhgqpnDFbaKunfBBVVg@mail.gmail.com>
Subject: Re: [PATCH] iscsi: iscsi_target: fix clang -Wformat warning
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

On Fri, Jul 8, 2022 at 3:14 PM Justin Stitt <justinstitt@google.com> wrote:
>
> When building with Clang we encounter this warning:
> | drivers/target/iscsi/iscsi_target.c:4365:12: error: format specifies
> | type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
> | " %s\n", atomic_read(&sess->nconn)
>
> The format specifier used is `%hu` which describes an unsigned short.
> However, atomic_read returns an int which means the format specifier
> should be `%d`.

Thanks for the patches!

Please fold this into:
https://lore.kernel.org/llvm/20220708221314.466294-1-justinstitt@google.com/
and send a v2 of that.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/target/iscsi/iscsi_target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>


-- 
Thanks,
~Nick Desaulniers
