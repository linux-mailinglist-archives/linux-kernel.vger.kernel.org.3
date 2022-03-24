Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB334E6984
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353623AbiCXTxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352951AbiCXTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:52:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B2A7771
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:51:20 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t21so1103177oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSDOl4RxPS3vwyxqajmQzws6vv0+qNWYgNjBfF6MJdA=;
        b=M/fjEFAgiHj+BzsOVIXD82r8Ii2g8/s3VpSIXQR4zlmIZcAD0IkMUr+xPROHHPknNI
         dr7E95zOmFbRwstcOpTFjgkUKi7TvXSb8zjVJ+87LPI+Ovj+pNG9umxoKi0JJYR+2ZqH
         H+hQe+5easlTGLQo61UyGbxLJo1g426f4C9eBnBF/zjc7LEmnQJWiRsmwlbqWfJ1s5nm
         HeZJbX3G80U0Pi76oSMosL4FkMOeEdROwBIarfq2JMlUpH2bh34vFXr8o++pDEZFMJuN
         VKSOMW8UxGtJaLGe5gHS9uH5DxaO7AHfn8cXU7Iz0m1U0GcK4jJv0up0vPsYb/HTlfRA
         lF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSDOl4RxPS3vwyxqajmQzws6vv0+qNWYgNjBfF6MJdA=;
        b=CnKq4MWwbRbhYKFh58fll2drInjCwd5lbFucSiznYiJyenGMy1sG0RwbRdEmgMxGSM
         gUiiKi+pIXriIUdNPNyfI5qnK93ybKLeLHPJgKGfXPkPIFoAaWkaNWCx6z+YbzTBg+/N
         MCHa9L/yUO/qSoRlsnj7JcvoGM7o97t4QmBCfysnIkfGv3auFlLABsn7U36sXawdc2sT
         oMd8NxTUuncydHuK6AILAoxJxItUNISD/iu5VDCcunHKYCQz6UrSCD+tXH+BMG/0dAb7
         Re7jQCs7UpNuj5YICDErt6mqwutDOb/zXYHmD6vEDH9t3dnnFKeQjb739lkhcEq4zunF
         yL4g==
X-Gm-Message-State: AOAM533HGTymQQivva0xcaU4yDlLl6/OdyACvJwdLm24mHn8eTibLxJr
        B2zGn8bqabzfWr0PLfwFCkwHuzh4DR/FTw9mOqw=
X-Google-Smtp-Source: ABdhPJzOeCxYZASuuN8H5BbjKWV4ZEeFQNdF1FDoP/DFeIQU4e0iF9/sVJW6kzKUUgcBKqVhmnGeOFxdPVfTMW7C8vo=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr7765124oic.200.1648151480357; Thu, 24
 Mar 2022 12:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <1648110383-3533-1-git-send-email-unSimple1993@163.com>
In-Reply-To: <1648110383-3533-1-git-send-email-unSimple1993@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 24 Mar 2022 15:51:09 -0400
Message-ID: <CADnq5_PkpohP3zYxMMoS7i_nRxTZfg0d3tiwPQA2hK3RFHVjMw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdkfd: Check for potential null return of kmalloc_array()
To:     QintaoShen <unSimple1993@163.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Mar 24, 2022 at 9:46 AM QintaoShen <unSimple1993@163.com> wrote:
>
> As the kmalloc_array() may return null, the 'event_waiters[i].wait' would lead to null-pointer dereference.
> Therefore, it is better to check the return value of kmalloc_array() to avoid this confusion.
>
> Signed-off-by: QintaoShen <unSimple1993@163.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index deeccce..64f4a51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -749,6 +749,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
>         event_waiters = kmalloc_array(num_events,
>                                         sizeof(struct kfd_event_waiter),
>                                         GFP_KERNEL);
> +       if (!event_waiters)
> +               return NULL;
>
>         for (i = 0; (event_waiters) && (i < num_events) ; i++) {
>                 init_wait(&event_waiters[i].wait);
> --
> 2.7.4
>
