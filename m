Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7232346DCA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhLHUIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhLHUIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:08:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD86C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:05:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so12358053edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ft5I8nfLjeZ/UkJIKaimQmlaiHw8YvU1BOwkkaA2CU=;
        b=EmPFxcepJ5xGXXdhooOhOomYnq6mzAFIzdX9Os0Lv4fmZAc8bNPfIgTvGSDma1wZDM
         /0nC58OBnmMk9SL24E2Q18DwFVlAxlKE6US9Jd3tjuaU+0qq+e1J4OQ1tFZ3w+7AySmE
         xBGgRzVzOV/QSX+ovzGF6NMFyoU6mE/XviyHXe3n/46WuNoCVF6JHQrvWIg1BVdgTKyn
         r40/mgd4OyjS+Et19BkNGA/K8t7hQcqH9U/OBmpai1kkFN8E32C3Jn5ZYOenYGwXlhhV
         IPjauSMGU4L/s0QFo1HG9zRMtANfWhcn9PdOvE+doxgYi1wxPyGU+bzxBESSGBDfreZp
         MeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ft5I8nfLjeZ/UkJIKaimQmlaiHw8YvU1BOwkkaA2CU=;
        b=X8lUvP1D7w7lo0RXX2YIsAXiWVv7opygSXAa7P5zA9kAS4sRW72wOHbroidtSTG6+I
         LOjDTuKRLBNt0ti5aqJhjvnPBr4WkOaTn4oiyKUdV+RCDQZ7Vq3L+bVyS+rQ/tEb380A
         FJEAZJOA2znbrVh4NblEITSyy2BYqNaWWfMclOgvKMD0loblb1cPgFMlVwj1uZMbMfxB
         F5WZnyEZguTv59l6SyCrHOFOW1Mxd2VYU2w9eDgo349B0v10E9Blh8IVTk/sZrCChM9v
         C1bZo/wB8vwIuNgUnCO86MLw+CagbBgTitRLk03f/ljf1LkQO0NcFbxZ0D5EeEJ0g3C5
         k3Aw==
X-Gm-Message-State: AOAM5336VAvb83V/tFt1hPZNTJDKmxriqalt6o6FLdl945kxpzUwSHg4
        HIbZ+mcSupeVAXpKEKOEu9eGWWL7uYKKShgy33Fo
X-Google-Smtp-Source: ABdhPJyAT5AcX24/vsaF4FuO3zmSI91sBLs+Bo7d3wsmD3mHwOXCNVYQbGhgfKwZE1LynLCP9HqwWfCtr/zzGD5cUOY=
X-Received: by 2002:aa7:cd5c:: with SMTP id v28mr22130323edw.6.1638993919043;
 Wed, 08 Dec 2021 12:05:19 -0800 (PST)
MIME-Version: 1.0
References: <163898788970.2840238.15026995173472005588.stgit@warthog.procyon.org.uk>
 <CAHC9VhTP-HbRU1z66MOkSyw9w7vhK7Vq8p0FrxVfEX-+tSD43A@mail.gmail.com> <2846548.1638993312@warthog.procyon.org.uk>
In-Reply-To: <2846548.1638993312@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:05:08 -0500
Message-ID: <CAHC9VhS4ZOWHD4+NnJ4uPbrQv1nookPovw23XoZ+=xOSeMZtEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] security: Remove security_add_mnt_opt() as it's unused
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, anna.schumaker@netapp.com,
        kolga@netapp.com, casey@schaufler-ca.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 2:55 PM David Howells <dhowells@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > There is already a patch in the selinux/next tree which does this.

It appears to be, yes.

> Looks pretty much identical to mine.  Feel free to add:
>
>         Reviewed-by: David Howells <dhowells@redhat.com>

Thanks.  I generally don't update patches for metadata (unless it is
really critical) so I don't have to do a force push, but if we have to
I'll be sure to add your tag (there is a tag from James Morris that
came in late too).

-- 
paul moore
www.paul-moore.com
