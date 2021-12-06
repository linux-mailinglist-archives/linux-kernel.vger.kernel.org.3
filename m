Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8247468F55
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhLFCsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhLFCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:48:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA9C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 18:45:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so36975937edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPkDgfSi39yTo3lA/qjUWlLR+uwbqkTX1ixff0nrnrA=;
        b=SFmn2wVsvV+hAxDhb7OcQgutgDiQ0TcwF/tXl2AWq0Ff5K2IUrX0rynCLNKdQozDNK
         Se63NXOlWvajuN06XNGP18fkfeARwldpEyDOO7+AC5M9VLfCa+Maykv/mzdBazqpnxzf
         yMziZm2AxVVcuEP+paOzfP2cVkf8+tG+9r7L3fd6B/a7WjR0Jfq1htp0PHS8zGXUl4OC
         XkcM072wzlerKetR69/pYPg+2xVaUZOZ5FvmQFrHAXbXYDFgmIwHKlxKj58WGvKm39y1
         5Hth9HZsjfIvXqVFg9ESfILQx1iIswyVG99BONxVpC7fi6YFyp8htDAqI2kAFRALvOQn
         WB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPkDgfSi39yTo3lA/qjUWlLR+uwbqkTX1ixff0nrnrA=;
        b=3cOn0misMPDrzGtWThAyI1zBLzAQjtm/mbjgni8SIDrRB4Ah5akfqA5E71wMBU4ojn
         40P1Imsri6utFB8iohfLmNL/4q8yKd+TuAEganwzoHetgurcTcjL56+pp0c/UVvKjRIs
         Ml1amKW3w6R/taTKjxdBevpYmnLKY/aDCUH5QZ3SBHidzhO/ky3qIm9pym336dXUGFGU
         hQfhunJsJxurJ0qhbn2EARsJT9EMrZoHNvqRbWuTwkARuDdFbNolGpTzvj2nPbLNj82t
         KsiOSxtSA4bU0BeJJOijZhP0QJIa35wi+BjudXdlLotLA1pVStiw4KTacZSXSBhsU87s
         je4w==
X-Gm-Message-State: AOAM5323xtFuB23s3DKtFBpfuijxh3ARnP3D1JUuVhuWDhFg0/0AnT7y
        4FJUcDw3/xcfZklHXf2TrrGr6gZTvTM9rlf0/G8M
X-Google-Smtp-Source: ABdhPJzW5eYEzA65lBlc1aKKHLqgHO6wHSlCcEI7uABDh3oOz2BbJsPx6uCf1VOYbxXAxj1GKlV68FSntswX2zKhjxc=
X-Received: by 2002:a17:907:7dac:: with SMTP id oz44mr11834244ejc.307.1638758698688;
 Sun, 05 Dec 2021 18:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20211124014332.36128-1-casey@schaufler-ca.com> <20211124014332.36128-24-casey@schaufler-ca.com>
In-Reply-To: <20211124014332.36128-24-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 21:44:47 -0500
Message-ID: <CAHC9VhRxkbb0L2gjMTt4eo7B0JUvPDT3hyA8FimieErp+vkweQ@mail.gmail.com>
Subject: Re: [PATCH v30 23/28] Audit: Create audit_stamp structure
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

On Tue, Nov 23, 2021 at 9:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 12 +++++++++---
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 24 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul moore
www.paul-moore.com
