Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7750646AEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354007AbhLGASt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbhLGASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:18:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0AC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:15:16 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np3so8975327pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1z1Amt/gcZvrn9YuV827NdLJuv0ueBqvE/K6X6pp/OM=;
        b=UByy/pOsB3XhG+dtY1dgRqOqscESyAIpuwSdt78c2k4XXGjsvdjzLRCnCWlM0f25tb
         yoQbaL22bQwAof2uskEIKQQZWuyS1NluK/mGGUCw9/T0mLN2HJ0z7pRxqY8kyxOj6/cT
         aj8/TzSv/cCxiQhnQ0vtiqMYRVl/7bnYchtUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1z1Amt/gcZvrn9YuV827NdLJuv0ueBqvE/K6X6pp/OM=;
        b=Juu5RcRRzlNNV88cViAXwYcpzsymEHUcL4ewtgtowXYqyGS1cg7gTGEaHwUZjU8BEC
         egbwvRiZkPwy4aqWpeG54u6VQCPvtWFRrdQW5i27A9Y+BWyReU9px9pim/Vflva7HnTh
         imy048b8lwwVTPc9SI+N1WiqVIp/6R/t+D39gzBZyXXwRs8J4jyPP0qiJvZRLRwIvPt2
         RMuSBhOg58fDNCOl3IDriFBnsS/ndPsdWVaJG+8XzzHjFZqUXPXnFGUu4He6Fd7o1xdl
         fAsWE6wKPcIcKERVxCOqipvHSqcnaATQ1E3fpaxtvJ9tZXfMTJIlFfZugsqpkvPIUvEt
         n4mA==
X-Gm-Message-State: AOAM5302Ym0PbTI/yZZ/zYHxr2lc7ZgoWr1cr4m6p1uAEpVDM+BPNzXm
        nM8ahWHpwHy+Nqi2D1CTWMJK3A==
X-Google-Smtp-Source: ABdhPJw34rhOXkkazRivd6dbc/G/DWRJyOIYHaoWZnpGkGOYNi2+d3ggUWw+DbcD2/I+T4CW4JCRBg==
X-Received: by 2002:a17:902:bc8b:b0:143:caf5:4a0e with SMTP id bb11-20020a170902bc8b00b00143caf54a0emr47292568plb.38.1638836116208;
        Mon, 06 Dec 2021 16:15:16 -0800 (PST)
Received: from localhost ([2620:15c:202:201:ab1b:c09c:ed69:5925])
        by smtp.gmail.com with UTF8SMTPSA id j8sm14298566pfc.8.2021.12.06.16.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:15:15 -0800 (PST)
Date:   Mon, 6 Dec 2021 16:15:14 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sujit Kautkar <sujitka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rpmsg: glink: Update cdev add/del API in
 rpmsg_ctrldev_release_device()
Message-ID: <Ya6nks3V4/G7aA9Q@google.com>
References: <20211102235147.872921-1-sujitka@chromium.org>
 <20211102165137.v3.2.Ie09561c5b453a91f10ecc7e1974c602c4ff78245@changeid>
 <YZWQQ6XPIdMLtZEy@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZWQQ6XPIdMLtZEy@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 05:29:07PM -0600, Bjorn Andersson wrote:
> On Tue 02 Nov 18:51 CDT 2021, Sujit Kautkar wrote:
> 
> I like Stephen's suggestion about modifying the $subject.
> Also note that the change isn't in the glink driver, so prefix should
> reflect that:
> 
> $ git log --oneline --no-decorate -- drivers/rpmsg/rpmsg_char.c
> f998d48f9b3c rpmsg: glink: Update cdev add/del API in rpmsg_ctrldev_release_device()
> bc774a3887cb rpmsg: char: Remove useless include
> 964e8bedd5a1 rpmsg: char: Return an error if device already open
> ...
> 
> > Replace cdev add/del APIs with cdev_device_add/cdev_device_del to avoid
> > below kernel warning. This correctly takes a reference to the parent
> > device so the parent will not get released until all references to the
> > cdev are released.
> > 
> > | ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x7c
> > | WARNING: CPU: 7 PID: 19892 at lib/debugobjects.c:488 debug_print_object+0x13c/0x1b0
> > | CPU: 7 PID: 19892 Comm: kworker/7:4 Tainted: G        W         5.4.147-lockdep #1
> > | ==================================================================
> > | Hardware name: Google CoachZ (rev1 - 2) with LTE (DT)
> > | Workqueue: events kobject_delayed_cleanup
> > | pstate: 60c00009 (nZCv daif +PAN +UAO)
> > | pc : debug_print_object+0x13c/0x1b0
> > | lr : debug_print_object+0x13c/0x1b0
> > | sp : ffffff83b2ec7970
> > | x29: ffffff83b2ec7970 x28: dfffffd000000000
> > | x27: ffffff83d674f000 x26: dfffffd000000000
> > | x25: ffffffd06b8fa660 x24: dfffffd000000000
> > | x23: 0000000000000000 x22: ffffffd06b7c5108
> > | x21: ffffffd06d597860 x20: ffffffd06e2c21c0
> > | x19: ffffffd06d5974c0 x18: 000000000001dad8
> > | x17: 0000000000000000 x16: dfffffd000000000
> > | BUG: KASAN: use-after-free in qcom_glink_rpdev_release+0x54/0x70
> > | x15: ffffffffffffffff x14: 79616c6564203a74
> > | x13: 0000000000000000 x12: 0000000000000080
> > | Write of size 8 at addr ffffff83d95768d0 by task kworker/3:1/150
> > | x11: 0000000000000001 x10: 0000000000000000
> > | x9 : fc9e8edec0ad0300 x8 : fc9e8edec0ad0300
> > |
> > | x7 : 0000000000000000 x6 : 0000000000000000
> > | x5 : 0000000000000080 x4 : 0000000000000000
> > | CPU: 3 PID: 150 Comm: kworker/3:1 Tainted: G        W         5.4.147-lockdep #1
> > | x3 : ffffffd06c149574 x2 : ffffff83f77f7498
> > | x1 : ffffffd06d596f60 x0 : 0000000000000061
> > | Hardware name: Google CoachZ (rev1 - 2) with LTE (DT)
> > | Call trace:
> > |  debug_print_object+0x13c/0x1b0
> > | Workqueue: events kobject_delayed_cleanup
> > |  __debug_check_no_obj_freed+0x25c/0x3c0
> > |  debug_check_no_obj_freed+0x18/0x20
> > | Call trace:
> > |  slab_free_freelist_hook+0xb4/0x1bc
> > |  kfree+0xe8/0x2d8
> > |  dump_backtrace+0x0/0x27c
> 
> Why is dump_backtrace in the callstack here inbetween
> rpmsg_ctrldev_release_device() and kfree()? Isn't the error that we're
> calling kfree() on an chunk of memory that contains a live object?

When I tried to repro there was no dump_backtrace():

  Call trace:
   debug_print_object+0x13c/0x1b0
   __debug_check_no_obj_freed+0x25c/0x3c0
   debug_check_no_obj_freed+0x18/0x20
   slab_free_freelist_hook+0xbc/0x1e4
   kfree+0xfc/0x2f4
   rpmsg_ctrldev_release_device+0x78/0xb8
   device_release+0x84/0x168
   kobject_cleanup+0x12c/0x298
   kobject_delayed_cleanup+0x10/0x18
   process_one_work+0x578/0x92c
   worker_thread+0x804/0xcf8
   kthread+0x2a8/0x314
   ret_from_fork+0x10/0x18

My guess is that Sujit added a dump_backtrace() for debugging and it was
still there when the backtrace of the commit message was generated. That
would also explain the two 'Call trace:' entries in the log.

> > |  rpmsg_ctrldev_release_device+0x78/0xb8
> > |  device_release+0x68/0x14c
> > |  show_stack+0x20/0x2c
> > |  kobject_cleanup+0x12c/0x298
> > |  kobject_delayed_cleanup+0x10/0x18
> > |  dump_stack+0xe0/0x19c
> > |  process_one_work+0x578/0x92c
> > |  worker_thread+0x804/0xcf8
> > |  print_address_description+0x3c/0x4a8
> > |  kthread+0x2a8/0x314
> > |  ret_from_fork+0x10/0x18
> > |  __kasan_report+0x100/0x124
> > 
> > Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> > ---
> > Changes in v3:
> > - Remove unecessary error check as per Matthias's comment
> > 
> > Changes in v2:
> > - Fix typo in commit message
> > 
> >  drivers/rpmsg/rpmsg_char.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > index 876ce43df732b..a6a33155ca859 100644
> > --- a/drivers/rpmsg/rpmsg_char.c
> > +++ b/drivers/rpmsg/rpmsg_char.c
> > @@ -458,7 +458,7 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
> >  
> >  	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> >  	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> > -	cdev_del(&ctrldev->cdev);
> > +	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
> 
> I am not able to find any other instance where cdev_device_del() is
> called from the device's release function itself, which tells me that
> this probably is not the right thing to do. Instead the appropriate way
> seem to put the cdev_device_del() in rpmsg_chrdev_remove().

Yes, it sounds reasonable to me to delete the char device when the control
device is removed.

> That said, we already do device_del() in rpmsg_chrdev_remove() so if the
> warning is trying to tell us that ctrldev->dev is not deleted I think we
> have an unbalanced put_device()?

My understanding is that the situation is analogous to this one:

commit 1413ef638abae4ab5621901cf4d8ef08a4a48ba6
Author: Kevin Hao <haokexin@gmail.com>
Date:   Fri Oct 11 23:00:14 2019 +0800

    i2c: dev: Fix the race between the release of i2c_dev and cdev

    The struct cdev is embedded in the struct i2c_dev. In the current code,
    we would free the i2c_dev struct directly in put_i2c_dev(), but the
    cdev is manged by a kobject, and the release of it is not predictable.
    So it is very possible that the i2c_dev is freed before the cdev is
    entirely released. We can easily get the following call trace with
    CONFIG_DEBUG_KOBJECT_RELEASE and CONFIG_DEBUG_OBJECTS_TIMERS enabled.
      ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x38
      WARNING: CPU: 19 PID: 1 at lib/debugobjects.c:325 debug_print_object+0xb0/0xf0

    ...

    This is a common issue when using cdev embedded in a struct.
    Fortunately, we already have a mechanism to solve this kind of issue.
    Please see commit 233ed09d7fda ("chardev: add helper function to
    egister char devs with a struct device") for more detail.

    In this patch, we choose to embed the struct device into the i2c_dev,
    and use the API provided by the commit 233ed09d7fda to make sure that
    the release of i2c_dev and cdev are in sequence.

