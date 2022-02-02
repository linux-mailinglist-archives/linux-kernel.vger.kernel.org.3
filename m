Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B9B4A7562
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbiBBQE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343546AbiBBQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:04:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288CC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 08:04:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id p7so42989758edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8XDJWaf+HoqlQNAE1r2JlUclS76hjxcv6QG3k0ojVY=;
        b=aewIzRW3bYO9Qtvi7ydqWjuFPI08RZUw1/OybUT1wYKGO2mJlxKzTiBSYhgcPlpEpT
         xDF8igGtowMtCHME+9TAmdAfBfOmPykesYpCGZ1qLXrvJeumxlSiokQVowqKEZKEZU3v
         oB/4cMClDgQxpya/m9MRTkK1GFvVLEVB0p6GqQaPyIePmHPm9WKyHjGW53qG1S7XhDSW
         ejZblN14eIi0NTJK9eU/LnPnZDGIfoGcH4Uz65H7hWeaheeHcmIHPV2rGEmfFU/3BxUC
         +0L6GUNohQi9mvCDHqn9pDCsUfXQcPOXU2/m/egCWB9u1qD8WYbHFmmxh4Jt01BC1gaY
         Az0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8XDJWaf+HoqlQNAE1r2JlUclS76hjxcv6QG3k0ojVY=;
        b=BbyTYJ3NEmFaPVb8VmToxNxSo7THFmx9v4okjZDzV0egPBL9oonIlAebiaLQvVaTsY
         VM8iJaoSGRuhyKaVFODSfTCUMi1eBSuw9h7ZUpywLaqiYcDagN3OxBounQbfCYw4dUrJ
         L0ItxfxJFF/6+JNvDdM3/us4ZcazMrNTAtSVBsGTVhm2mGUQqAthaB47BIEZO3oOOJBT
         gDD3fIa4yCrE7kIKPVQNFEUC0v59s6zeF2Lcv7okPxJDpxLU3zjJppGvkJQ1Z3mRSlqY
         2WxivEWFxGfs98rJsA2/mQDyy+QeHCab21c9mJlUohvyi2MJNj/MLCHvb7fVWIrV/B9f
         dQuA==
X-Gm-Message-State: AOAM533k2942970uHKvNbP1KxpOnLkNty/AF6pFmt3Zc/HUiP0XhUquA
        IArJ37wIW5ec+IYnOlcXmx5ZdmRXCDRB3zpddYlg
X-Google-Smtp-Source: ABdhPJzIYm4R3hFxsLqXy5P6CnVCHdTDObqlpa9JdFdXHJwMMuF58QjL3ONLdVHQwGsYwm2ftdw32L2jtgeJM+Mbxzs=
X-Received: by 2002:a05:6402:345:: with SMTP id r5mr31399867edw.269.1643817893533;
 Wed, 02 Feb 2022 08:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20220202112511.18010-1-vbendel@redhat.com>
In-Reply-To: <20220202112511.18010-1-vbendel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Feb 2022 11:04:42 -0500
Message-ID: <CAHC9VhR4eTEOO2m=HXYdG89mDBOPnd5BcWLwMCO-qZ8BWNMd9Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix double free of cond_list on error paths
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 6:25 AM <vbendel@redhat.com> wrote:
>
> From: Vratislav Bendel <vbendel@redhat.com>
>
> On error path from cond_read_list() and duplicate_policydb_cond_list()
> the cond_list_destroy() gets called a second time in caller functions,
> resulting in NULL pointer deref.
> Fix this by resetting the cond_list_len to 0 in cond_list_destroy(),
> making subsequent calls a noop.
>
> Also consistently reset the cond_list pointer to NULL after freeing.
>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I just merged this into selinux/stable-5.17 and I'll plan on sending
this up to Linus tomorrow, thanks Vratislav.

-- 
paul-moore.com
