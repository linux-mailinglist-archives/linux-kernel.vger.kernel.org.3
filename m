Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44B482128
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbhLaBGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 20:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbhLaBGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 20:06:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 17:06:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z9so33955121edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 17:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yQ0lyfMsNWxiMLxC7em/5nNtO4aymAyCuSjy0PLjqE=;
        b=SLc0c5KYaStYakowoSGrDCyr+GCKo0gvXAK3yjZoe0eCjK0tvsYkX8SeaOeqLgv+VS
         rLeF/GiD7XZRyhmcw9sbXDVKeeFFi08zWDH4onV3aJ4ry+5CCLd0uBxfzu6r4ktM6RzF
         1NK6NtrifweJfmVuXC/QYhj0g7YvHAd5gPZN9RZbCAnbjuQ9CQSqNbN9D4NPnQc/G1WD
         7NNrV6CRid2kEA/D7bTxlDEiyDAHGe54qe6KO+/PDBtEyxMqzDrKkHk5OxYfELyg2sx3
         UZpUxupvmLWBQ7JSO3HqaOpa9AbeeURK75MlHGL+LMoRGAUT86pcp38ZCUqIW0jkMt7G
         X7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yQ0lyfMsNWxiMLxC7em/5nNtO4aymAyCuSjy0PLjqE=;
        b=7UbFx7gwughlqCEVVdkJy6oBDsgB64twGPcWp28oYyNf2VocQtjK8wmU6+Cx7rmqLD
         LpfkfY3q892T0dEstA/0e9ospgUgrZFnYT4tXJhNYxTvrSY8yu0+uotRYMBA44CQqjY3
         NIpfLJV8fDKPKPzK0NJ52aMR/w2a5/TWh4wYHwJpEMEsbuR2rWdi8j85mxh/cKso2Emc
         6G+w+JVuc80s4UZxCd7vDy9NlZRVZ3xVGJQKtSSjwoaYRT6UBn5nsyYOLkxWzmuUUxpN
         J2qtE9eX6683S7ToEUNxlc0x1OSfzsJuK8FeZg68IA+q2r/QhB27Lo0PfLzCaIAlGaQ5
         KW7A==
X-Gm-Message-State: AOAM5301/lsRJh1TTd2TmIko7qiTrDVAzDSFzM7mnhn/+zByd23KK9tG
        y9mx7RiIfDxsykl7lksdFEpVwNhMfSlOvHJ8FSo=
X-Google-Smtp-Source: ABdhPJyo68+ChNlP6cqot2N18ioE6wTAVKtpFUVqJGqbScez/zNRZ8+jd6QXBTq3VXQ5lPT2OuK0PcljVZ21ydATcds=
X-Received: by 2002:a17:906:3586:: with SMTP id o6mr27008922ejb.186.1640912794629;
 Thu, 30 Dec 2021 17:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20210903023811.3458-1-chao@kernel.org>
In-Reply-To: <20210903023811.3458-1-chao@kernel.org>
From:   Shachar Raindel <shacharr@gmail.com>
Date:   Thu, 30 Dec 2021 17:06:23 -0800
Message-ID: <CAGZn=28_q5tGd5kL_nU3Tz3_XA+gqODGpP6CKsZB6tKb3dAXtA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix potential deadlock
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        Yi Zhuang <zhuangyi1@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat late to the party (i.e. 3 months late), happy mailbox cleanup holidays!

On Thu, Sep 2, 2021 at 8:04 PM Chao Yu <chao@kernel.org> wrote:
>
> As Yi Zhuang reported in bugzilla:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=214299
>
Bug report is for kernel 5.3. When I reported very similar deadlock in
google-msm 4.9 tree (
https://lore.kernel.org/linux-f2fs-devel/20201128174124.22397-1-shacharr@gmail.com/t/
), you pointed out that the code was missing commits which removed the
cp_rwsem grabbing (which are also missing from kernel 5.3):


commit 435cbab95e3966cd8310addd9e9b758dce0e8b84
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Thu Apr 9 10:25:21 2020 -0700

     f2fs: fix quota_sync failure due to f2fs_lock_op

commit ca7f76e680745d3b8a386638045f85dac1c4b2f4
Author: Chao Yu <chao@kernel.org>
Date:   Fri May 29 17:29:47 2020 +0800

     f2fs: fix wrong discard space

commit 79963d967b492876fa17c8c2c2c17b7438683d9b
Author: Chao Yu <chao@kernel.org>
Date:   Thu Jun 18 14:36:23 2020 +0800

     f2fs: shrink node_write lock coverage

Is this patch needed with these commits applied?


>
> There is potential deadlock during quota data flush as below:
>
> Thread A:                       Thread B:
> f2fs_dquot_acquire
> down_read(&sbi->quota_sem)
>                                 f2fs_write_checkpoint
>                                 block_operations
>                                 f2fs_look_all
>                                 down_write(&sbi->cp_rwsem)
> f2fs_quota_write
> f2fs_write_begin
> __do_map_lock
> f2fs_lock_op
> down_read(&sbi->cp_rwsem)
>                                 __need_flush_qutoa
>                                 down_write(&sbi->quota_sem)
>
> This patch changes block_operations() to use trylock, if it fails,
> it means there is potential quota data updater, in this condition,
> let's flush quota data first and then trylock again to check dirty
> status of quota data.
>
> The side effect is: in heavy race condition (e.g. multi quota data
> upaters vs quota data flusher), it may decrease the probability of
> synchronizing quota data successfully in checkpoint() due to limited
> retry time of quota flush.
>
> Reported-by: Yi Zhuang <zhuangyi1@huawei.com>
> Signed-off-by: Chao Yu <chao@kernel.org>

As this patch is applied in the mainline kernel, can we CC -stable to
get this patch into the various Android kernels? Specifically,
https://android.googlesource.com/kernel/msm/+/refs/tags/android-12.0.0_r0.21/fs/f2fs/checkpoint.c#1147
needs this patch (alongside many other google-msm kernel branches).

Thanks,
--Shachar
