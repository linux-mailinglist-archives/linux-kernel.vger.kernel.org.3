Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC748F24A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiANWNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiANWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:13:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693ADC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:13:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w16so38898078edc.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akNBIPEkQByIFfu1P2peeZN+JzE2WGUVrx0nJKmv+Ig=;
        b=GSAsqvuvZ11joKI+dRdRJOuuVW/GJ5oZzAyrppAVppJB8/otiBguI1w2lk9hHNXqnI
         Ah2KYY6LjOawBgQgGE7+KdjMHlAl54JHjYq3LkyXXdtAFjOKz1mvf6BzmmkH3bJ3ITRx
         BoAPd/vlyz23S4tdpthx6JmSXvk85dXhFPneTR68UnNNct00yEIDFQ7BKo5JeCGAFsTf
         kSfwAWc+cdnWmPAUKROQqfPdMslbpdSaLjacJqBTP+eYHZGM1v0OM3x0Yxp48pMigh0+
         RFP+MRBcL7tHV7qoZI8yQcfPZtmOb4cFGQM7UPaDISXkdWalKSpU0eAVdplz/50FrSXS
         esDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akNBIPEkQByIFfu1P2peeZN+JzE2WGUVrx0nJKmv+Ig=;
        b=mDdOgb+hBULAV+sQgORavr5wWKgPDwzgcMF/z34NvGN3nta9Sw6sCb0pfXAy5Xhdss
         fnK/f0lIkRca77amdAW8dJcFrAy3tjGXaDPxgO/8FERL0/nP2Yq3O8IZpYZwxmqnyigO
         rbo2M/tK1q/BfV5ARO/2FMTpec4RWLMsXUsCShtBBWTdYwP5eKy+FIvj0OIT8H2vdSp4
         sxXrSmKGNY/1BOLxEJ62iAX0R4JZ96PjXTItTCHLYhUPlKYMUNV2sWkl3HLc4t8aZhNA
         Dv6CGhaA5dNUoOGIz8JDlOo4Q37bVqcRApbvpieyQZJmsRNSUL510ZoscuBE+MowEJUA
         qIVQ==
X-Gm-Message-State: AOAM531Pd6mIw23M46CT1At5i9RsU9u4A9c8d6cznH9joccGNPT5AW2F
        zofsXaENx2SaWmuruMhDtvO9sSgGDmAej5peOzJF
X-Google-Smtp-Source: ABdhPJycdiADIHXzwCC4XbXDGCbSn1ShsYMkBqzWdZbiKVObYX6mlneZ3AzzwH9MsKG0FKNcfDxCMHxteeDPm3BK6vw=
X-Received: by 2002:a05:6402:3551:: with SMTP id f17mr10816345edd.331.1642198393740;
 Fri, 14 Jan 2022 14:13:13 -0800 (PST)
MIME-Version: 1.0
References: <tencent_A49992D0BF00081EB37A6E21070E45563806@qq.com>
In-Reply-To: <tencent_A49992D0BF00081EB37A6E21070E45563806@qq.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Jan 2022 17:13:02 -0500
Message-ID: <CAHC9VhQDEG7hOwAzTCkaiO7r7sgaV2B08BVV6V3XMVLZztcS+g@mail.gmail.com>
Subject: Re: [PATCHv2] integrity: check the return value of audit_log_start()
To:     xkernel.wang@foxmail.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:24 PM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> audit_log_start() returns audit_buffer pointer on success or NULL on
> error, so it is better to check the return value of it.
>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Reviewed-by: Paul Moore <paul@paul-moore.com>

> ---
> Changelogs: simplify the patch.
> Note: Take the suggestion from Paul Moore.
>  security/integrity/integrity_audit.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 2922005..0ec5e4c 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
>                 return;
>
>         ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
> +       if (!ab)
> +               return;
>         audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
>                          task_pid_nr(current),
>                          from_kuid(&init_user_ns, current_uid()),
> --

-- 
paul moore
www.paul-moore.com
