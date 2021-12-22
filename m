Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACBC47CE93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbhLVJBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:01:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33880 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbhLVJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:01:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9DAB61948;
        Wed, 22 Dec 2021 09:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC24C36AED;
        Wed, 22 Dec 2021 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640163680;
        bh=2moYNoWlwOl9vGeaInC5IbNS/P0yE72jrtG09/FTmSg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UU42TL/5+qV7slg6LKwN19dhqaNHopUeV8WF4k84O1fU3BEuv3l3BJXogYJi2nEs/
         tqUbfZs7oFmOHZ85vQzWMRe9SMG57DdaPzFtfvU73565t4ntWD7VQPcm8qDxoVTfkB
         bXVm2Ymy7d9Zhs5QYToX9tHxnpPwpTM7dhxZbHvqP2TpkuVPaHYVfifjeCzlvQO4GU
         1/1lsGIAGeJ2ifRNSoaW/zsFHiMzqpX8OK3bdFNQx/+DAGithxBjzf/8kRuw85ccMg
         UQtaLzsvkJBfKBbl0uerONaI0tqJOtjltELCqtmXo3GO1v2XkC9ie05i9OT8i3MHFM
         f/P0YeYZq0XmA==
Received: by mail-yb1-f173.google.com with SMTP id j2so4576860ybg.9;
        Wed, 22 Dec 2021 01:01:20 -0800 (PST)
X-Gm-Message-State: AOAM531fBvcNP7tN0MdRD5O1qvnshFgM9vH+X9euRdwr7LluCAVK6FS3
        HZOvwYH67LTT0jnxehGnfDvwIVRJ30Krq8aj5qw=
X-Google-Smtp-Source: ABdhPJwJHFOdM+I8yd4DzexYFkdoFEOKhPY4OP+s/Ps+Ppp8eP1m/Mmy45xUCOHlPjym6cQ8xSi7mlkhmNEKBQDyxdE=
X-Received: by 2002:a5b:c50:: with SMTP id d16mr2838979ybr.106.1640163679293;
 Wed, 22 Dec 2021 01:01:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:1313:b0:11b:f4cd:b869 with HTTP; Wed, 22 Dec 2021
 01:01:18 -0800 (PST)
In-Reply-To: <bdd6f570-f387-0371-09fb-d7b8c9993e8b@virtuozzo.com>
References: <bdd6f570-f387-0371-09fb-d7b8c9993e8b@virtuozzo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 22 Dec 2021 18:01:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_WJa76Jy5StEQ0G3Xa2gufh2CtRF47YiXsMPb3r4hCUA@mail.gmail.com>
Message-ID: <CAKYAXd_WJa76Jy5StEQ0G3Xa2gufh2CtRF47YiXsMPb3r4hCUA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-12-17 20:23 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
> Like nfsd and lockd, ksmbd can cause deadlock if the exported
> file system does not support asynchronous processing of blocking locks:
> if all ksmbd worker threads handles such requests,
> they can never finish and the server will not be able to handle
> any other incoming requests.
>
> Any filesystem that leaves ->lock NULL will use posix_lock_file(), which
> does the right thing. Simplest is just to assume that any filesystem
> that defines its own ->lock is not safe to request a blocking lock from.
>
> To work around the problem we need to drop fl->fl_flag FL_SLEEP before
> vfs_lock_file() execution, it forces affected functions to avoid blocking.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
> ---
>  fs/ksmbd/smb2pdu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 121f8e8c70ac..f2225491af02 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -6634,6 +6634,12 @@ static int smb2_set_flock_flags(struct file_lock
> *flock, int flags)
>  {
>  	int cmd = -EINVAL;
>
> +	if ((flock->fl_file->f_op->lock) &&
> +	    ((flags == SMB2_LOCKFLAG_SHARED) ||
> +	     (flags == SMB2_LOCKFLAG_EXCLUSIVE))) {
> +		ksmbd_debug(SMB, "force fail immediately request\n");
> +		flags |= SMB2_LOCKFLAG_FAIL_IMMEDIATELY;
> +	}
>  	/* Checking for wrong flag combination during lock request*/
>  	switch (flags) {
>  	case SMB2_LOCKFLAG_SHARED:
> --
> 2.25.1
>
>
