Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E6A517B37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 02:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiECAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiECAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 20:20:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA6F37ABF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 17:16:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so21363015wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 17:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYv1vnQn01c0U+UUZJgP9Yz8sP26lRkEbJWLbcJb51Q=;
        b=ddRoWjOuUxYP6b00lDQWxMC8dG8BaQP8eAa1fxr/MmSiWbQUjDuHEJfp2okyiaEQkl
         Lg+phFet1W/aw+gC+toCkAmCxHa2I7pdP/F/qkoU3lcZRrvx/iVXfilL8BF88Dc/IU/z
         +VeMl9WNnkioNB0PHHQEBQR0tD7FOT40FkoWjzWMdD5aA/+B9FbqcqhHLdh0SVqq6oLt
         JmThc54G6v+6BSgFX6aldwkvPQZraIvnGNo/YRsQLxM4Ia+19s6QC9dnZTy8G1tvq+xv
         uJTuGkAYmlcuIHBBtL4ST5bNH0KfI8f6oBPHfWt/GWa13xuwQbPMvPlyiX7Gac3w1eeI
         07LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYv1vnQn01c0U+UUZJgP9Yz8sP26lRkEbJWLbcJb51Q=;
        b=nOLN0DkP2tCMc4CushOsWKMQ3ll3eW6j7ZQHDoorR/OD2sgWVMw4Y7d70h+5R+wEUT
         JM6VJu+0qMoZhdqjlZZMLTDzDprWrcPSJr1RyspU4h/bg34FQWB5RJ6zqSXHfqX8Wzrx
         LayfFECz27lOeP1FYZPJ9syKo+5epccpfLvDIQGfHYW+JXnqlKuuscm85jQaoenRR3Gj
         ZVtkP/q8IYg0SyzqnRVbuN5thS+iM06oGdJbySdc3jWrDH6XCeBn/9PatCyBGIXu+2Lj
         niqPIn8+0jryaJZUgVwSr1uJ+kOXFtAr7vu+0iI4qJseiZl2EDC/A+kBHOkaEhxR6olq
         VZUA==
X-Gm-Message-State: AOAM532fOMEV0pKnsVSqM4cuGICx8/h+djcoMjMN54eOFPmJaP7YQ+Q8
        n7C/7vlD2Hfej7rmgZEHxfiZDKAZeu0x0N5XZw+k
X-Google-Smtp-Source: ABdhPJx2W6FrPHp5nIaG1ku1K5IvYfvfUoQkOIVxhtgUFxRn+IcKb0D+3Qlo2FAdxwIOQkQmJWw48FxCOzk4sUtqyPM=
X-Received: by 2002:a05:6000:10cc:b0:20a:de6f:3c48 with SMTP id
 b12-20020a05600010cc00b0020ade6f3c48mr10598403wrx.650.1651536988351; Mon, 02
 May 2022 17:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com>
In-Reply-To: <23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 May 2022 20:16:17 -0400
Message-ID: <CAHC9VhSwVS=u+FhDrC6QucZbm7B1PgFudLeYcT_C111OEEY3rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fanotify: Allow audit to use the full permission
 event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch passes the full value so that the audit function can use all
> of it. The audit function was updated to log the additional information in
> the AUDIT_FANOTIFY record. The following is an example of the new record
> format:
>
> type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com
> ---
>  fs/notify/fanotify/fanotify.c |  4 +++-
>  include/linux/audit.h         |  8 ++++----
>  kernel/auditsc.c              | 18 +++++++++++++++---
>  3 files changed, 22 insertions(+), 8 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ea2ee1181921..afdbc416069a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -64,6 +64,7 @@
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
>  #include <uapi/linux/openat2.h> // struct open_how
> +#include <uapi/linux/fanotify.h>
>
>  #include "audit.h"
>
> @@ -2893,10 +2894,21 @@ void __audit_log_kern_module(char *name)
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> -void __audit_fanotify(unsigned int response)
> +void __audit_fanotify(__u16 response, __u16 type, char *buf)
>  {
> -       audit_log(audit_context(), GFP_KERNEL,
> -               AUDIT_FANOTIFY, "resp=%u", response);
> +       switch (type) {
> +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=%u fan_ctx=%u",
> +                         response, type, (__u32)*buf);

I think the above awkward cast helps the argument that
fanotify_response:extra_info_buf (and fanotify_perm_event) should
properly define a union to encapsulate the type specific data.  If you
defined a common union type you could share it among all of the
different users.


--
paul-moore.com
