Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C15658E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiGDOqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiGDOqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:46:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2AEE15
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:46:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so17094853eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M+qVlZDYaAoCOVBpeXTz8LxMK35K+S3D3doABPbbA6U=;
        b=O+YOPzG3QC5vCWWZEKLqaxGKZYtynjFnz6aQS6ibqsWEEVI11WzP+tP8h79MvxyvEI
         VQtFQjNwpI05jrdPqDiyxAQHNM3HU7V8eANnSthLH3fjHpazQEeiDqN2azM+oOMZ8r20
         bPXVCzPILpA7aqpUJZRdnrfD2lV/0VHDvK4CrObBHe79Zh2zhBt+2YqG94wstcDMwAqa
         FSWz/w+dyw54CtjOx1Ox1XnBKF3CIQAfYSmrBxfJPLLOs+k2F0rZd7gG44L+8T8UEJQC
         fUc38jfZwXld6BQy8XYnBSJWc44bEPnxhJlix/vdLigKWD5MmkdAPjKkZnGomLknYe+m
         6BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M+qVlZDYaAoCOVBpeXTz8LxMK35K+S3D3doABPbbA6U=;
        b=i0rkz6RSy+HJby6be/Xz9j3N7TkTsThox9KOKydqhk4yvlnXA5P73Aq+eAKwULXBZl
         UQaNrV9yMAN/RNZg1T4HRA5EzA+hD89w2GRAA2yJjL033ZCtfUvQ16ZsjufoKWUMcQuR
         U1LoS0sjxhYMr106HxcP+JHiv0XB8gP1hvn5SVdz68dGomwQ0f6jC+IDzKqceDU0J/fo
         Wzgi+acu69tlEfCHRUBuVD0kw9cvw0HZs6bGuaDJyGgw7lkFywskjDMJzuH1iUerysno
         WCubCyxV84uJx4oJFBSdyaMg/ZFzpMzesGk/N41NYq3vZi1RgtVBXgOZ4d07HxpXKy/B
         Y7Jg==
X-Gm-Message-State: AJIora+ReBodydQJQzkZym41IqqKKK1OVjgBBXsC1ynK4f17Kw7IZMgq
        Xm2BPsVLnoZXxHEP8i/fgZ7+
X-Google-Smtp-Source: AGRyM1t89RbesStqt7Tieom5AmKNJLEeLrY0+FlIzuKMV7VyOhtKEjj91xD5EazoVDBn2kcBfXPj4Q==
X-Received: by 2002:a17:906:6a11:b0:726:97b8:51e9 with SMTP id qw17-20020a1709066a1100b0072697b851e9mr29599521ejc.115.1656945980259;
        Mon, 04 Jul 2022 07:46:20 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id pv1-20020a170907208100b00726abf9cd8esm9904462ejb.125.2022.07.04.07.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:46:19 -0700 (PDT)
Date:   Mon, 4 Jul 2022 14:46:15 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsL9Ny3Vx9Q2uvpJ@google.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsLkJ1LMMnM9Mo0K@google.com>
 <19598d43-de61-c663-25e8-17b6f5d5ef80@I-love.SAKURA.ne.jp>
 <YsLx5JckMbx/4V4/@google.com>
 <951dd1a9-2b48-fb0c-9ee2-aac2b8170c2c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <951dd1a9-2b48-fb0c-9ee2-aac2b8170c2c@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 11:07:54PM +0900, Tetsuo Handa wrote:
> On 2022/07/04 22:57, Wedson Almeida Filho wrote:
> > On Mon, Jul 04, 2022 at 10:48:32PM +0900, Tetsuo Handa wrote:
> >> On 2022/07/04 21:59, Wedson Almeida Filho wrote:
> >>>> @@ -139,6 +139,10 @@ static int misc_open(struct inode *inode, struct file *file)
> >>>>  
> >>>>  	err = 0;
> >>>>  	replace_fops(file, new_fops);
> >>>> +	if (iter->unlocked_open && file->f_op->open) {
> >>>> +		mutex_unlock(&misc_mtx);
> >>>> +		return file->f_op->open(inode, file);
> >>>> +	}
> >>>
> >>> One of the invariants of miscdev is that once misc_deregister() returns,
> >>> no new calls to f_op->open() are made. (Although, of course, you can
> >>> still have open files but that's a whole different problem.)
> >>
> >> The point of this change is that file->f_op after mutex_unlock(&misc_mtx) is
> >>  from new_fops which is guaranteed to hold a ref on "struct file_operations"
> >> via new_fops = fops_get("struct miscdevice"->fops).
> >> That is, a module ref remains valid even after mutex_unlock(&misc_mtx).
> >>
> >> And as with major_names_lock case quoted below, this change assumes that
> >> misc_deregister() is called from module's __exit function, and fops_get()
> >> is preventing the module owning new_fops from calling __exit function.
> > 
> > Your assumption is not sound. misc_deregister() can be (and is)
> > legitimately called from other places, for example, a driver's remove()
> > callback. In fact, when I grep for misc_deregister(), the second
> > instance is such a case.
> 
> OK, the frequency of calling misc_deregister() can be much higher than
> unregister_blkdev(), which means that misc_mtx is more prone to trigger
> hung task warnings. I'm more inclined to avoid sleeping with misc_mtx held.

Tetsuo, I'm sorry if I'm not making myself clear. I'm arguing that your
patch is buggy and therefore should not be accepted.

Here's one example of an issue that your patch would introduce. In
binder init, we have the following error path:

err_init_binder_device_failed:
        hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
                misc_deregister(&device->miscdev);
                hlist_del(&device->hlist);
                kfree(device);
        }

Note that open() for binder touches the `device` pointer. If open() can
be called _after_ misc_deregister(), then there is a race condition
where open() is touching `device` while this error path is freeing it.

Right now it isn't a bug because misc_deregister() guarantees that after
it returns, open() won't be called anymore. Your patch breaks this
guarantee.
