Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B9C52A2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbiEQNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347575AbiEQNM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:12:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BA43499
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:12:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r30so6996403wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwMrKlO2MqbTE9nwU9Tb94pfbBXuygfDTBIAQ9AIcak=;
        b=evSRBxjPOwiQhrL4v2tc5BXHcq28KJSKKUUZ8tw4lNVq9aRp8nPvo0pJBUfdetFaXm
         V1KEXcs4XRianJg/wscukWim/Rvlkp7C612GqnAaSUACxnitN6m/g3d5Ust/ACWw4bWn
         ssAVJhvdun7xb3pGk1hdC2KNF+7wfne3suLPkda0HabEDbl5vJloWdQeIzfNU9doEx7t
         J30nZaYKFbeGK1xbb80WR1OVGVf9SvYg5Zow34xbjf69AzuGkqnVP303OajJm3PjJOaD
         dCIQfCisE9iA7ytzHIjynNnkneq5ope+XqIOD9WHVk0i5oszK/B8QFcB3T2JEFcYTegk
         Ewyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwMrKlO2MqbTE9nwU9Tb94pfbBXuygfDTBIAQ9AIcak=;
        b=lYezxQHNHXcDZh+AqCzYXkkRiULJNeoHsUpJfeOBkJhNsuxvt+ZtRfgnL0h/8TQzEO
         PYM7BLzw++Kl59XFOgvtVPLdbPlUpMmLMV2btslYkFNR6hgTTrJtX9f5n1iQngxx789U
         Be47aoJmJ9qtIpoHSkoIR6JMXLyy5ttmJygrRkR81fW0S5J9isKUmblGDIat/FuJgv6/
         H7TZGrqs0TVpJ2UVHA1Y2sRCUA7X9bhscciASuWxboUoozRRMyqJTbpma8IgulOFasD3
         WncpLUWWulnR1dROxrfohYh7QsMhxRytbwrKtiXv1Y1bst+ELYq0pFFufj13cgLlJk8Y
         0Yag==
X-Gm-Message-State: AOAM531Mc0xR+rfsKk9F1LGElmmqSi9yO4uZ1nhTKmyg7b1n6eQACup+
        P3qEg4b1efADUl+U5h4u6jTpITz4R8ldUhDKWDiV
X-Google-Smtp-Source: ABdhPJy5x7WRBePtOFFE9hLaUmgKrxsydjvYn2c1pQL2u+K02T5jzKArZGcf5IzxWufEnIOu/fDwZB7Ef592P6i5XQE=
X-Received: by 2002:a5d:5888:0:b0:20c:9868:9d94 with SMTP id
 n8-20020a5d5888000000b0020c98689d94mr17973192wrf.433.1652793165091; Tue, 17
 May 2022 06:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220517103253.22601-1-ju.orth@gmail.com> <20220517103253.22601-2-ju.orth@gmail.com>
In-Reply-To: <20220517103253.22601-2-ju.orth@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 May 2022 09:12:34 -0400
Message-ID: <CAHC9VhR_N+N1=3vbbmym36aDA+sUY2c4yRJq74K+=Fr27TBLQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] audit,io_uring,io-wq: call __audit_uring_exit for
 dummy contexts
To:     Julian Orth <ju.orth@gmail.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 6:33 AM Julian Orth <ju.orth@gmail.com> wrote:
>
> Not calling the function for dummy contexts will cause the context to
> not be reset. During the next syscall, this will cause an error in
> __audit_syscall_entry:
>
>         WARN_ON(context->context != AUDIT_CTX_UNUSED);
>         WARN_ON(context->name_count);
>         if (context->context != AUDIT_CTX_UNUSED || context->name_count) {
>                 audit_panic("unrecoverable error in audit_syscall_entry()");
>                 return;
>         }
>
> These problematic dummy contexts are created via the following call
> chain:
>
>        exit_to_user_mode_prepare
>     -> arch_do_signal_or_restart
>     -> get_signal
>     -> task_work_run
>     -> tctx_task_work
>     -> io_req_task_submit
>     -> io_issue_sqe
>     -> audit_uring_entry
>
> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> Signed-off-by: Julian Orth <ju.orth@gmail.com>
> ---
>  include/linux/audit.h | 2 +-
>  kernel/auditsc.c      | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Hi Julian,

Thanks for the report and the patch too!  I agree that it does seem a
little odd that we haven't seen this before, let me dig into this a
bit more today and respond back.

-- 
paul-moore.com
