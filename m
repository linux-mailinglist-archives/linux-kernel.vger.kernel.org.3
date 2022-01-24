Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38CC49A37E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2368236AbiAXX6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847630AbiAXXUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:20:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8343C08E90D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:27:55 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jx6so25175898ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RYjOggTIatflhN2tcFQRaqqDoiv4Tn5RiFVJCwGLqbw=;
        b=3gh94fdxPP1DWGi6gOuYZrgk2uf3k5hBepC1rTfdXAfdOBNwWYVRFT+7VJ//ZBKj48
         9cUBdcc1L83luJV4tNyo6xJ2NhDMZh+fGByJMZOR/E6OGpvhKXMfLugkrlVdTOH56MDo
         53GnLKtMZ1UmD6cNG2HLa7dp6n40gG/YORbut8GypvyjOFtcXXVbFmRUkHhk5gGPcxEp
         Dgpu/Tpnuc1tgVySpXrEXV2khVCSkxu0v94hJwxyVmROc7D4gXyjwSOqfPqFfbNilXgd
         1HKCc/J/SbsB8BIH3KWfAuFdAb4ahrykJGfJjcwv72KNRdT+NPieaA//XGgx9ofoPnqK
         CFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RYjOggTIatflhN2tcFQRaqqDoiv4Tn5RiFVJCwGLqbw=;
        b=Ond3R3yGJOvfD6L7hHgYe9amG0jeG/t4+ecfWUzco0rSMvzOSxKMCvk4WTnWyMAGaG
         SbUF+KbQXh9tdSLheu1wpOQ8R+R3/oN3JwQfhbIbJ9s56sxq3yvJidTIGJhz5Wh6jXP7
         suHyg3OlzzQnF/IKrQHDZ3vJk5X5ttIztc1CB0kMxSNTNIJ3RUmlwpZZrEwZTCGtXfji
         JiyxZkRKa/Bz7NHS0mB26e1A2tJfRSjVYWQo9fYMXzPbmN5qmv2IeJkGA5OIiU2vwqYZ
         +v/tAFBqeDZxFAmxs2MP7ef4LZ8k7ovnjhM+M3EriA+6AFDlQj+YLyoEGNql/lvKcwRN
         TmoQ==
X-Gm-Message-State: AOAM530hMOLTcMGDmm91j1sv8I2IzM1+2+3/fXiJaLKLOT4Uwfv7r01X
        bizXtInrbSJqK2SotwNvtcoKgQSYpcwkWJipiphn
X-Google-Smtp-Source: ABdhPJzYbZvpioE6dEHN6JXBqwOIehEPUtOGXhvu9h/22uwOkXqdsmf4vjBbxGP53yiW7luwQlXcqdOThz5giAMUPiM=
X-Received: by 2002:a17:907:968d:: with SMTP id hd13mr4919050ejc.12.1643059674146;
 Mon, 24 Jan 2022 13:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
In-Reply-To: <20220120214948.3637895-2-smayhew@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Jan 2022 16:27:43 -0500
Message-ID: <CAHC9VhT2RhnXtK3aQuDCFUr5qayH25G8HHjRTJzhWM3H41YNog@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 4:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> shouldn't be performing any memory allocations.  Fix this by parsing the
> sids at the same time we're chopping up the security mount options
> string and then using the pre-parsed sids when doing the comparison.
>
> Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
>  1 file changed, 76 insertions(+), 36 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4fc29..f27ca9e870c0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -342,6 +342,11 @@ static void inode_free_security(struct inode *inode)
>
>  struct selinux_mnt_opts {
>         const char *fscontext, *context, *rootcontext, *defcontext;
> +       u32 fscontext_sid;
> +       u32 context_sid;
> +       u32 rootcontext_sid;
> +       u32 defcontext_sid;
> +       unsigned short preparsed;
>  };

Is the preparsed field strictly necessary?  Can't we just write the
code to assume that if a given SID field is not SECSID_NULL then it is
valid/preparsed?

> @@ -598,12 +603,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
>         return 0;
>  }
>
> -static int parse_sid(struct super_block *sb, const char *s, u32 *sid,
> -                    gfp_t gfp)
> +static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
>  {
>         int rc = security_context_str_to_sid(&selinux_state, s,
> -                                            sid, gfp);
> -       if (rc)
> +                                            sid, GFP_KERNEL);
> +       if (rc && sb != NULL)
>                 pr_warn("SELinux: security_context_str_to_sid"
>                        "(%s) failed for (dev %s, type %s) errno=%d\n",
>                        s, sb->s_id, sb->s_type->name, rc);

It seems like it would still be useful to see the warning even when sb
is NULL, wouldn't you say?  How about something like this:

  if (rc)
    pr_warn("SELinux: blah blah blah (dev %s, type %s) blah blah\n",
            (sb ? sb->s_id : "?"),
            (sb ? sb->s_type->name : "?"));

> @@ -976,6 +976,9 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>  {
>         struct selinux_mnt_opts *opts = *mnt_opts;
>         bool is_alloc_opts = false;
> +       bool preparse_sid = false;
> +       u32 sid;
> +       int rc;
>
>         if (token == Opt_seclabel)
>                 /* eaten and completely ignored */
> @@ -991,26 +994,57 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>                 is_alloc_opts = true;
>         }
>
> +       if (selinux_initialized(&selinux_state))
> +               preparse_sid = true;

Since there is no looping in selinux_add_opt, and you can only specify
one token/option for a given call to this function, it seems like we
can do away with preparse_sid and just do the selinux_initialized(...)
check directly in the code below, yes?

>         switch (token) {
>         case Opt_context:
>                 if (opts->context || opts->defcontext)
>                         goto err;
>                 opts->context = s;
> +               if (preparse_sid) {
> +                       rc = parse_sid(NULL, s, &sid);
> +                       if (rc == 0) {
> +                               opts->context_sid = sid;
> +                               opts->preparsed |= CONTEXT_MNT;
> +                       }
> +               }

Is there a reason why we need a dedicated sid variable as opposed to
passing opt->context_sid as the parameter?  For example:

  rc = parse_sid(NULL, s, &opts->context_sid);

-- 
paul moore
paul-moore.com
