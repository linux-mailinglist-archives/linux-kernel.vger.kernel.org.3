Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB544A62A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiBARjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiBARi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:38:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560D2C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:38:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so56405571ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLyYRDKyhRNUUjbXm2Ujlcp19JICC/SXa1LXJLTz1vw=;
        b=ZHCEMwtbNECxtzlR4xf/pL7JGDS74huc3FBu6TDhhaLQlpYXfhy8Wl6S4qvRdofFBH
         c1ow5y0Ql7aYDXA8zVUXKEK5TMo+/uWsQFzD5B2Lp4mG3IjpN7rEyCknC0AR2yH1gi+I
         BntLiM4zr603lTqg3C7KccWKNXmT4MJcT8rCcWXqSXDZXsmKEwBTor/fvSGz7Ut4Lgtr
         qrUq8s5ofBqtQGCbBWlSeDEsqoLbE+2f2eny597bt8F/d6RndsWTHEWFLk1lE17hGeQq
         qdsHMCNAs7N14vJn78B3HuB81x+mEnpPBi5aotzsg/Y2Q4yso6ZAZCBglikMzUzkeB4X
         pp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLyYRDKyhRNUUjbXm2Ujlcp19JICC/SXa1LXJLTz1vw=;
        b=iA3p/n+ENi+lRAgOPWJHBrYnIf6LA7drLbsu1OCXqiISu4jLzRs4tI4UMtmq2UoCtr
         mHPY6G6z5xYF6hKzNMOD6tXOxR+tG4vY/CznkjZbUz5fwAXpzrDf3BacDcspzocVBPK5
         +nJRrcU55t7MoFyn9JGzVd/6z7tGCGndskxNCeiIDhqdis83qtPfdZnwp9oR64AhYbxn
         haFxw20JgGBMKhi9pzgCKUH2pNHoVYvk7pQLZnDbhwF382MGmV3qJ138Qj+cQq4OtqB+
         zWas/3K6yz7DB98L0Lkt46ZwMU3atFPKMP7CxzFaUWCWfu/8PNe0F8nWUchMOWiqte/7
         tRpA==
X-Gm-Message-State: AOAM530SVFiNfHXJ/nhNJ43ofYsI5DPRdjME2hbuY2WOpntO0/OiCl1u
        l/Mple7oo2pp0WGUvnQ7sif1480JYLRczmIoT0AA
X-Google-Smtp-Source: ABdhPJyebN+dpNWSAfMvrBdvpCqX/+HsqwiQrSUCywFNNjsye8fHn+IkPzfiba5z+EpFvSDMghxGQu2DEwyQCm9iToU=
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr21640491ejc.701.1643737137815;
 Tue, 01 Feb 2022 09:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-2-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-2-vbendel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 12:38:47 -0500
Message-ID: <CAHC9VhR78VGMPLv1xBRQEqzaPjJa_KvFE8OLmHa6J2pjaG6m1w@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: consistently clear cond_list on error paths
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> From: Vratislav Bendel <vbendel@redhat.com>
>
> Currently there are two users of policydb->cond_list: cond_read_list()
> and duplicate_policydb_cond_list(). On their error path one clears
> ->cond_list to NULL, but the other doesn't.
> Make the behavior consistent by resetting ->cond_list to NULL in
> cond_list_destroy(), which is called by both on the error path.

It's also important to see if there are any callers of
cond_list_destroy() which incorrectly might be making use of
policydb::cond_list after it has been freed; thankfully that does not
appear to be the case in any of the call paths I looked at just now.
As this is more a a style/Right-Thing-To-Do patch and not an immediate
bugfix I'm going to go and merge this into selinux/next.

Thanks Vratislav.

> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 2ec6e5cd25d9..1d0e5f326b62 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -152,6 +152,7 @@ static void cond_list_destroy(struct policydb *p)
>         for (i = 0; i < p->cond_list_len; i++)
>                 cond_node_destroy(&p->cond_list[i]);
>         kfree(p->cond_list);
> +       p->cond_list = NULL;
>  }
>
>  void cond_policydb_destroy(struct policydb *p)
> @@ -441,7 +442,6 @@ int cond_read_list(struct policydb *p, void *fp)
>         return 0;
>  err:
>         cond_list_destroy(p);
> -       p->cond_list = NULL;
>         return rc;
>  }
>
> --
> 2.26.3

-- 
paul-moore.com
