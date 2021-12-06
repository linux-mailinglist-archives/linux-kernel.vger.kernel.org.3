Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B2468F4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhLFCsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhLFCsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:48:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B7C061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:44:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so36803044eda.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEpXl2rjEsQ/iZu4ZR5a4fZjtkeItsGvSxcWdc7M5Zk=;
        b=fEC0JL3Q3DjRFMGWonua7hcYvacbTymemEAL9m0L1IKQTYU7jXdvqbKOdfIpkZL9PP
         LOK81AbIdOhxqqfzvEagihtDvbP1lSk6FfLLVqgzCsbu5dYFHc4zoGRR1IZWg6MR2JQG
         akNV1TgQ9qiDpcTn8e1M942LzVjUjeeuaeihjCg3eoPQzL/111zPayRC0gOZcZYOyB2a
         1kUox4ZvMvtFNj5mlra3Cu3c6819pwgWHkTbqGqFxvuFkMjsQNcG6PMSgVL/3KCm1MEQ
         99sze4mx73lV+Lc2HQOjxFTsVw8RZXRn24p2v1pC0xXiRVRSo3Tsp9/DID/WopxTP8d7
         CBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEpXl2rjEsQ/iZu4ZR5a4fZjtkeItsGvSxcWdc7M5Zk=;
        b=F7pDNuRFUR6TVnBkC2+YWEUXxpGv79eFVFtsQuikjIc8TLmZjndyAnDEP0JuEd/Dok
         F73lLcpS+jb/BDIIz//HifTL8TvP1wamgCwZw8YdO7LjI3PmZK4GElKYvEaueNckF+Mn
         dGOUU+j+lndpv4hUO36/AmdujKXXRy3Qar1ogBgYjD+vaWuK8dQL3xNOEjdORSnNgcP9
         WgnoPvSF7Shvv/PUzDGQOlyGC7RYtauSfXOhMdfrP58Rmsas0G+dzOC74rIY7eS1jt8y
         jdMskGBYIT1eZjZgGqh/KQjajufJSzcbMmjNKSv0d2PFf9sMLULJ8FlEDtSRDBfTFOmB
         h0dg==
X-Gm-Message-State: AOAM532N4Uga4KUdDIzqQkNED0+73OFSrUCvzFZY74fRvdxiiuVhIvpN
        fm6ynCycIaQRmnIo5Ht7KG/A9VNRGsB3w5DW5LK+
X-Google-Smtp-Source: ABdhPJz88VaoH/gPDTPj32gZHevyPs1vCaW00GNL3rgM+vqLPf2Urzonomb/cc2eL8/nvqRm7/jHabq1R3VDBOzvnNo=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr40290591ejb.69.1638758678834;
 Sun, 05 Dec 2021 18:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-7-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-7-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:44:28 -0500
Message-ID: <CAHC9VhRnFehuM4ODOMeUo9MZ-6K5bDL6KdakgzrivJKeUGDQFA@mail.gmail.com>
Subject: Re: [PATCH v30 06/28] LSM: Use lsmblob in security_audit_rule_match
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 8:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
>
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. The scaffolding function lsmblob_init()
> fills the blob with the value of the old secid, ensuring that
> it is available to the appropriate module hook. The sources of
> the secid, security_task_getsecid() and security_inode_getsecid(),
> will be converted to use the blob structure later in the series.
> At the point the use of lsmblob_init() is dropped.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-audit@redhat.com
> ---
>  include/linux/security.h |  5 +++--
>  kernel/auditfilter.c     |  6 ++++--
>  kernel/auditsc.c         | 16 +++++++++++-----
>  security/security.c      |  5 +++--
>  4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ddd4cf48413c..d846d90f5624 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1954,7 +1954,7 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr,
>                              struct audit_rules *lsmrules);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
>                               struct audit_rules *lsmrules);
>  void security_audit_rule_free(struct audit_rules *lsmrules);
>
> @@ -1971,7 +1971,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>         return 0;
>  }
>
> -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> +static inline int security_audit_rule_match(struct lsmblob *blob secid,
> +                                           u32 field, u32 op,
>                                             struct audit_rules *lsmrules)
>  {
>         return 0;

Assuming you fixup the typo above that the test robot found it looks
reasonable to me.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul moore
www.paul-moore.com
