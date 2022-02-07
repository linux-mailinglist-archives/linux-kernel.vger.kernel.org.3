Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A683B4ACC56
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiBGWxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiBGWxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:53:33 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C256C061355;
        Mon,  7 Feb 2022 14:53:33 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 192so18395168ybd.10;
        Mon, 07 Feb 2022 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khCuXFvktKenvt0NMs7br3GwZ3/YeGP6WmAl4hcRAtk=;
        b=kpXQP4l5WqQVZcPI2J7GhEMqRblCCx/VRl+7iJydLg96usujA3KkyvhEDN8DAxkZrC
         VqNQE2h1mUw9YHBsuHDWeCSqBv7hN2FtGHYPBnPFuVYbUO4b6eFwMorU0hNXO0hFHfqJ
         LH9ZfKHrUD9BIxCdMloGbBLY83ikW/eYozz6FCJN5KLYDKjZvCwBdm24RNLvaha87PF/
         9d21FkIthNP97QSw5w5kozooVmpSzF9o5ARO2dod2p6VRtFAb54CBjPdMCQ9mYa3UuhT
         wiRoyL2/Vgfj+NQH7GbZ4UCDrjQ6iOX4wO9+6zkestoQ0q2WCsWTwDsTqHxwi6Y1r1OI
         jnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khCuXFvktKenvt0NMs7br3GwZ3/YeGP6WmAl4hcRAtk=;
        b=n4zlGNicuxMNVlCzx2oKAi85GYQNVJdOTgxbZGLAADuRj1U+i1OLMtLmW/76U7bet4
         +5/MSDZR00e55o60OpLriCkLHZFlmLGTh7aUOJNw4aQsMn2sXFrxPfJLZjfs/6pMvG4l
         oefED+qwAn9Fyanf5wWnZUunV/ij4magGPEUW9amCM07JOqjQ4sYTpuLP3KxulAmqSaN
         w+1312bv/VLVKDRkfne6Hji/yq5/PO7IlyRZD6K2WKO7Jzfn0LWqK441dBANu4gT0vr+
         /fBT8ZrwXYs8YjOwKWhe73kLQKitX3J3h+QPQX7Xorzh0taZ5LF52vZGwo73RfiZSZgP
         nzaA==
X-Gm-Message-State: AOAM533jwHIGaL3EVzi0vZTrEurGpQ1Ds0n3kQbT94ZWLgfZA81L2sIx
        dXwv6jv0F9eUcbMTnAerLlh+d0Npe8nxC/FApvQ=
X-Google-Smtp-Source: ABdhPJwtR96yA0741OSUHlWaYDYM35eW1MyuwW/VLWiMWd373q68Xe4YJlgprQaxpU/4SKFiD85WcCUCA08nNOmIrX4=
X-Received: by 2002:a25:148b:: with SMTP id 133mr2112718ybu.270.1644274412302;
 Mon, 07 Feb 2022 14:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20220121221021.60533b009c357d660791476e@linux-foundation.org>
 <20220122061228.nmuo75sDn%akpm@linux-foundation.org> <YgEeQNdgBuHRyEWl@dumbo> <YgGTSR628xhRvCjB@bombadil.infradead.org>
In-Reply-To: <YgGTSR628xhRvCjB@bombadil.infradead.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 7 Feb 2022 14:53:21 -0800
Message-ID: <CAA5qM4BGmrkwatyO_h3F=ErDZ9t5swuttbt6NkQU-1KDGDiD4g@mail.gmail.com>
Subject: Re: [PATCH] Fix regression due to "fs: move binfmt_misc sysctl to its
 own file"
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, bcrl@kvack.org,
        benh@kernel.crashing.org, clemens@ladisch.de, crope@iki.fi,
        dgilbert@interlog.com, Greg KH <gregkh@linuxfoundation.org>,
        jack@suse.cz, jani.nikula@intel.com, jani.nikula@linux.intel.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jlbec@evilplan.org,
        john.ogness@linutronix.de, joonas.lahtinen@linux.intel.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>, julia.lawall@inria.fr,
        Kees Cook <keescook@chromium.org>, kernel@tuxforce.de,
        Linux Memory Management List <linux-mm@kvack.org>,
        mark@fasheh.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        mm-commits@vger.kernel.org, nixiaoming@huawei.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        phil@philpotter.co.uk, pjt@google.com, pmladek@suse.com,
        rafael@kernel.org, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, sre@kernel.org, steve@sk2.org,
        surenb@google.com, torvalds@linux-foundation.org, tytso@mit.edu,
        Al Viro <viro@zeniv.linux.org.uk>, wangqing@vivo.com,
        Iurii Zaikin <yzaikin@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> OK I think the issue here should have been that declaring this on
> fs/binfmt_misc.c creates the chicken and the egg issue, and so we
> need to do this on built-in code. Instead of your patch can you try
> this instead, it just always creates the sysctl mount always now
> so long as proc sysctl is enabled. It does not do the unregistration
> as we always want the path present as it used to be before as well.
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 57edef16dce4..4f4739c9405c 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -119,6 +119,7 @@ static struct ctl_table fs_stat_sysctls[] = {
>  static int __init init_fs_stat_sysctls(void)
>  {
>         register_sysctl_init("fs", fs_stat_sysctls);
> +       register_sysctl_mount_point("fs/binfmt_misc");
>         return 0;
>  }
>  fs_initcall(init_fs_stat_sysctls);

I'm looking at the original code, and it seems that if we don't select
CONFIG_BINFMT_MISC at all,
this file won't be created. This would suggest an IF MACRO around
> +       register_sysctl_mount_point("fs/binfmt_misc");
and it should looks like
+#if IS_ENABLED(CONFIG_BINFMT_MISC)
+       register_sysctl_mount_point("fs/binfmt_misc");
+#endif
or if you prefer original style:
#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)

- Tong
