Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BFE546F05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350835AbiFJVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbiFJVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:11:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619E4926B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:11:09 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w21so532945pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAlhHjicxdibTZDY5HOZ3HLGftkcyfsPbsuBXvhev58=;
        b=rZoLQeeoRRIJfdLUJHE4dnrv8nvOAt9iOR0vH2qVCqvRI5W3AZ+mv8x+IW7fCeK6ba
         OVKZBg+dmXyW9W+XodkUKv8lx+avXiEFgpHK17IIYAWUXvzSmlWwi9ZgEJByV24JtQVO
         yqMzskfHsVeIjFMHcrNFCLiOvBVonmGQq2DEtnnHc9yOLy++SvJkgef5FG4G+cG43fEd
         /Fvg5ax3RpWb3XiCYQeuzl/1lH4B3XataJDDAwrYOiiTIg3FxWNSp0B+/gxNwomFI++O
         03qLVVKkULvOYqTllPPH4HMOJPK4F6Da8bvMMDw6+uMoPLYmWDrfFLEGDTdRsqCouOQ6
         n14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAlhHjicxdibTZDY5HOZ3HLGftkcyfsPbsuBXvhev58=;
        b=gRy9OBJYFxftSQxeJX2FTp+VkFEiGwaU2WorObEwjE5ivtMSe0fox3J9GXEX7WJoep
         cevtxCHbEY5v3r8IHu2F2BQRBPabuRPmWjLk8PtVqdhtLUCjJ0ufPj4gv2bEzc4aDgRQ
         npojwiCCEtmU3huSufVHGJkgNEwL7QggqAb6iApIktEDPKSKOzCqRmHBQQPOdssZgrJ5
         FqanoebUrqZ+1zxtPnUNFstG1onVaKwlnjdvS0jgAkApCjQAni9PGHTyTYvj5+AbOAwn
         FSEm6h9GEjdlkD1od4AQq9P3p4vdckU2kW6l0pQ30kFNlz5c7i75sq5UH1NSCtOcaDOx
         bX1A==
X-Gm-Message-State: AOAM533JDwoBplLEJ0E+PruFMyYH0nzp5qEDFWbgYFROFHFWwwUIXoZJ
        FVEFUtDUHDmJ6VkSdlyumPIIl/fMfn+B3wbHk7pt
X-Google-Smtp-Source: ABdhPJwx7n3musHGFyiyfqvl/EdH710RryS6Xm5TNC7u0DL6j33BjBGOdeGMogcoVPAETgbUEuZ93EmDm/ToHyuQPv0=
X-Received: by 2002:a63:31d0:0:b0:3fc:5770:e779 with SMTP id
 x199-20020a6331d0000000b003fc5770e779mr40782512pgx.376.1654895469427; Fri, 10
 Jun 2022 14:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220609230146.319210-1-casey@schaufler-ca.com> <20220609230146.319210-29-casey@schaufler-ca.com>
In-Reply-To: <20220609230146.319210-29-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jun 2022 17:10:58 -0400
Message-ID: <CAHC9VhSTdZVVAbSS_kT-Qtk6iy7w+GdAx7-F=aPQLtG5Ncb_ZA@mail.gmail.com>
Subject: Re: [PATCH v36 28/33] audit: multiple subject lsm values for netlabel
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 7:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Refactor audit_log_task_context(), creating a new
> audit_log_subject_context(). This is used in netlabel auditing
> to provide multiple subject security contexts as necessary.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  7 +++++++
>  kernel/audit.c               | 26 ++++++++++++++++----------
>  net/netlabel/netlabel_user.c |  7 +------
>  3 files changed, 24 insertions(+), 16 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
