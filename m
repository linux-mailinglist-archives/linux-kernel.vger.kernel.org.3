Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB94C4FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiBYUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiBYUrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:47:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8BB22310C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:46:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so13038318eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utTqWRs+GkKXV11qsxEXPqGJGJ6F+nTPt5fnCdMDPXQ=;
        b=tI2+rQMEja4fDKELjX1NDYKaqajvfvYXnbQcVdVdRMNyTpm00H//XDHoDKOQR2OdF2
         t1IlODbLjAyssNiiDSDVJD/Z8Qw8f26+rEMozOg8sAEII+YOy7AbnZ1pw6KJ5NRVNP6F
         xKMUIxfLROx2D+GgPWpwQzaFR18NM2oj2YyGew07ecI1uvNfgVu5WdqnEu4tHcKJ2bqg
         6tt+cKJEVfXyk5vO3rA8Ydj3Quh4Rd70osoYUzuQvJ5v0VzF4uGWj2ikB7JhqfnItciq
         aO6+SZX8QUFJXYVkThIbV9PAxFSIry+FNFeJZJ2OsF+DEbvSIooA1UvstRvIQN5YpuTs
         XNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utTqWRs+GkKXV11qsxEXPqGJGJ6F+nTPt5fnCdMDPXQ=;
        b=xSE98a+eLcfCdyhZHNHztuiVr1jqQP3LTgOwn0Ywkkidp+7QLQE2EBqPnHF2G5vki8
         g3BRUeqmo3XqVOwKiJVo5xizSI2L85Q8GrZpdQJ1CxUAvZDrhXTDcOgnCHFQcAJ5xle2
         1X+nsl8pi721Up6av+ahrks9FmlEWWv5W802LwUlguRv0VWAGBqPq0sue1FrF6TKKidY
         OhW0RmE3WiWBevhXIdcUHjc8CzvxB2bQtGKUhZpIDAvMC8YCqtl3l+3gM/FNUDAimEgt
         /HsNAzXocD31wbpTitk3ncnbCdLGTTydfIdP4FejE3ez+sGv0KGV6s0oEXljahwoVDE7
         VAjw==
X-Gm-Message-State: AOAM532Xd+7uxsCshDyNYL3EsJdWKzdAQkB7OHMHaPvdbVvP+r2Xdk4T
        qbuUlZDQvcdHWfKIPX5fzLWot40rKe80xd1xX67E86HIKQ==
X-Google-Smtp-Source: ABdhPJyu1JgVYgogCMyHJX1QHgwhhhOjQgju44rr2XZHMgeY1ki8EZuvUbJbBf0ft7DGNpKJQMxcr33/sUW3Q4Mj7wM=
X-Received: by 2002:a17:907:6e10:b0:6d1:4447:95bc with SMTP id
 sd16-20020a1709076e1000b006d1444795bcmr7152310ejc.610.1645822006270; Fri, 25
 Feb 2022 12:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20220225175438.302365-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220225175438.302365-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Feb 2022 15:46:35 -0500
Message-ID: <CAHC9VhRY8+R3Tnz9TTKiP12u7Cv1QiYnKoMjrS=VkAG-DF=eWg@mail.gmail.com>
Subject: Re: [PATCH V4] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        demiobenour@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux-refpolicy@vger.kernel.org,
        jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:54 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> descriptor being leaked to a process that should not have access to it.
>
> As this patch removes access controls, a policy capability needs to be
> enabled in policy to always allow these ioctls.
>
> Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change: Control via a policy capability.
> V3 Change: Update switch check.
> V4 Change: Use POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC
>
>  security/selinux/hooks.c                   | 6 ++++++
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 3 ++-
>  security/selinux/include/security.h        | 7 +++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks everyone!

-- 
paul-moore.com
