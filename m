Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D858247BF41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhLUMCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:02:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49752 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLUMCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:02:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93CC7B81677;
        Tue, 21 Dec 2021 12:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523AFC36AE2;
        Tue, 21 Dec 2021 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640088135;
        bh=/cDqb+k+/DozT6Zaq2smBv7oklT7ITD/1he8tAejXHU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kxEUMBDJN9PiErljpRu9UHqIy26sU0qz2KLdpcPaEVu5p8Z7pYltaY8OaHkZqbpI4
         bEROfPQ9+RqceVywgW2Vl+JMSl6pMZAsXOaWenBLtQ4uLm+ASM/7GHZTdaeoOBS8uV
         1Uy+iqoLfdHRWSD5jYBYSmXPRzuzBj43NNRSR0vp8fF71zHJpp8DzCnXb4XdrQQWQZ
         ivtMiH7uSmQNqq7O4TpOhYBKD6BpyfgPqGKXPr5jz3pK2c8MnHN1w271MPd8pBvLCB
         2ahS/GOcI/5WpQzYvhjtH9XDE9y+Js3tV+VGfprFadRA70Y4bQo4d9vpSZ7tn++TSt
         qU1IZ3nuTy7MQ==
Received: by mail-ot1-f43.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so16359577otj.7;
        Tue, 21 Dec 2021 04:02:15 -0800 (PST)
X-Gm-Message-State: AOAM532EAOGewnYlXmhcA7KRxPNqP65+/xDZPQWN8/zVrkPUB/QElIPl
        FXmOhWLlVobd5rPhG66YZ9rgXFOMgRgmr/XRfrM=
X-Google-Smtp-Source: ABdhPJxmzJL5QI+4YZoyyFnJ8hnTCiG2Z8L/x7tzCSEyArXz+Ae7jrpcXn57GKSCloAVMTfjuVHEO5W5eVk3D7NSouc=
X-Received: by 2002:a9d:6653:: with SMTP id q19mr1963162otm.116.1640088134567;
 Tue, 21 Dec 2021 04:02:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:428a:0:0:0:0:0 with HTTP; Tue, 21 Dec 2021 04:02:14
 -0800 (PST)
In-Reply-To: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
References: <e2aef4e7-a9b9-e44e-94a2-29ed6bc20091@virtuozzo.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 21 Dec 2021 21:02:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
Message-ID: <CAKYAXd8pCfUBPRXT-44N_g2GD_BKtjboiepgTGz5DQ93YEiz-A@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: use F_SETLK to force vfs_file_lock() to return asynchronously
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, kernel@openvz.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021-12-19 18:34 GMT+09:00, Vasily Averin <vvs@virtuozzo.com>:
> To avoid possible deadlock ksmbd should process locks asynchronously.
> Callers expecting vfs_file_locks() to return asynchronously should only
> use F_SETLK, not F_SETLKW.
Should I check this patch instead of
[PATCH] ksmbd: force "fail immediately" flag on fs with its own ->lock ?

>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/ksmbd/smb2pdu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 0c020deb76bb..34f333549767 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -6646,13 +6646,13 @@ static int smb2_set_flock_flags(struct file_lock
> *flock, int flags)
>  	switch (flags) {
>  	case SMB2_LOCKFLAG_SHARED:
>  		ksmbd_debug(SMB, "received shared request\n");
> -		cmd = F_SETLKW;
> +		cmd = F_SETLK;
>  		flock->fl_type = F_RDLCK;
>  		flock->fl_flags |= FL_SLEEP;
>  		break;
>  	case SMB2_LOCKFLAG_EXCLUSIVE:
>  		ksmbd_debug(SMB, "received exclusive request\n");
> -		cmd = F_SETLKW;
> +		cmd = F_SETLK;
>  		flock->fl_type = F_WRLCK;
>  		flock->fl_flags |= FL_SLEEP;
>  		break;
> --
> 2.25.1
>
>
