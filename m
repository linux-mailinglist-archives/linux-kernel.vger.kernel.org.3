Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD3D49BE73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiAYW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiAYW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:27:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC36C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:27:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w14so12937347edd.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1BiB0LlRhrBnkIdJld33ntWmu5J0JJj0Fcrw4TDuSI=;
        b=codcubGyPRRa9Co1DwYI2ifTPo2sxWpxhfC162hwvfv0Dvj34aQMGqFZRV+Fb2oImP
         YpQ02SJTC8gYN4g1JmYjUiqx+ZGdRf3JxCvvepEPZ3YpTdzCmnsRqP74xG00slnsfB+u
         4xuSx8u/lS9VDpfe9MwjJKJneITNky/Le68TZyQyLDyUH4T+w+PWeJ8Igu2HT5b6VpEl
         cfIkvq3BZdEDsTfy/SW7uKUQAsA5A7Q0VdZ8kkr4a+Yp8jpTMnbe+KebgjevbzkM5X3l
         qpJbeaR8+ZXrHfrkX8i4u7kjQOIV0mBbZjfbgS5QSZSt7U+d7952i/y2bjS3bwCWniS9
         NqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1BiB0LlRhrBnkIdJld33ntWmu5J0JJj0Fcrw4TDuSI=;
        b=pewWE0LseDt5S4ugsVEUnpHx1bt6xkXR6NK9UzNa/p768RTv6MM52PwJGWU+Mh/le0
         VcnhhRjYmSBcLNKyEfqI6B5V92GKNBvw+x3naprqWItZrb9R0muYwPSNZTFYQILH17ZC
         PeurVthNZjWcOivmYvf7Y6yBPDDXwWbezA5Q4JRQfh8fXljUYCLeuFCpQZSE/fSlfp1x
         6UbRzdeUC/+rnzbBbqWoKZI5r6CEVkv3DCjCx+gepkvt2z+gTXibOMvBHJyPHvt3A8iz
         JTO3OlAiFJHfXYXiocz26l7pqGyyBurJiEFHi9ZOqVBtdcmIs0QEE/ltUJu5dvPovaMh
         NyoA==
X-Gm-Message-State: AOAM530GgmtVNETC6lcdopdFBgckBS7W/tHCH63mMoq24A4dXMuImDyR
        r2WXB9wp23yMeGjwehGUM9yGliHhmwK1DVz0CA2u
X-Google-Smtp-Source: ABdhPJyMnhB7AjQM90R3rAyHkw09pciULNZQsSRVFJsPjgGXkMK5fv7dlJ9igPXCWWBfuR6Qb8adl5BW2dDLMR1lkNk=
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr21939603edf.343.1643149633597;
 Tue, 25 Jan 2022 14:27:13 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
In-Reply-To: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 17:27:02 -0500
Message-ID: <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Demi Marie Obenour <demiobenour@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
>
> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> descriptor being leaked to a process that should not have access to it.
>
> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> ---
>  security/selinux/hooks.c | 5 +++++
>  1 file changed, 5 insertions(+)

I'm not convinced that these two ioctls should be exempt from SELinux
policy control, can you explain why allowing these ioctls with the
file:ioctl permission is not sufficient for your use case?  Is it a
matter of granularity?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4fc29..8f3b2f15c1f3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3728,6 +3728,11 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>                 error = file_has_perm(cred, file, FILE__GETATTR);
>                 break;
>
> +       /* must always succeed */
> +       case FIOCLEX:
> +       case FIONCLEX:
> +               break;
> +
>         case FS_IOC_SETFLAGS:
>         case FS_IOC_SETVERSION:
>                 error = file_has_perm(cred, file, FILE__SETATTR);

--
paul-moore.com
