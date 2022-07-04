Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD745657F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiGDN6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiGDN6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:58:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB43CBC34
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:58:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eq6so11813276edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UdZbdODkdHiKHKsoqfWT9gUyl7dOicXz4AledhbVmOg=;
        b=BQD9qE6Jc/aN+K+kYEC06Dxf5ud8lhi5xUAhZi/1gwo8SGpNgrMQL4384J6s/MqoZK
         PPVhzfjn5uS8ki/H3RIaKHGwmCm2Da2meA1rtS5VVzroAtcR8MW8IQbTyagiliagx1PT
         ErEbiJaGNEhDLlyNBRLkhO0mlkP9YXqeWeU7UtREqEFp9D2/FxBRXUj1zmqm/urYaGog
         n+2OgR9EGGmEvUiBLnzArqOhI7iYf8tTZA5ccZUIqAq3pnOv2EKGkLXXeZwj3BwQThqJ
         HZc/E7Pz9+p2Wy9SUaJJ/v88fKPYfbrNSBZdb/AadjfnYXu6yMFi6+63/Ip9bZ8KqA+f
         oyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdZbdODkdHiKHKsoqfWT9gUyl7dOicXz4AledhbVmOg=;
        b=ATo0nhGTotrZRxtV/ocqH++lFlAcPXQ2K9D38fyemRmTN7UwpKFDlsFENHrX8fnNRz
         j7FqsO0n9QBXchaYnFiNHiMefpUJXpo8wwu11lascSnoau2MaRdb9AotwyQ2STHDXjkU
         ufF3KD8LTTSza75HDfwDEiwHziy2Evb0th6pXj6ZdU5KOojlLgbkKH7SmqE538LQty0s
         nks1z40sS7eYbxiqMxdbfEGfmVmkRsn0KRTCI5ks9eDuAxYG2XZ0IV+ng4pzR6CVNyQb
         +YSFl4BDEzLTunlDmICLJoaf/dsQD6maGMzQLoevOiAhUqFsdCw9zEEmcgnvES0ksLgb
         rnSg==
X-Gm-Message-State: AJIora9hiwiinEIKOutuM7SAn0VQ9ABTDYyXllGeBUNfirIfj/Dt4KPi
        VoLtBI6j+TuNX2gIZGarRk9R
X-Google-Smtp-Source: AGRyM1sv7B0XLkawGn0pM5mH2AtE/6QtQdKmYiP9ANzbpjK6RLAP7fvJ9OhxDdq5zCGmOD94BjDLkg==
X-Received: by 2002:a05:6402:4144:b0:431:6ef0:bef7 with SMTP id x4-20020a056402414400b004316ef0bef7mr38225771eda.151.1656943081371;
        Mon, 04 Jul 2022 06:58:01 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id b4-20020a1709065e4400b00706287ba061sm14271841eju.180.2022.07.04.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:58:00 -0700 (PDT)
Date:   Mon, 4 Jul 2022 13:57:56 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsLx5JckMbx/4V4/@google.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsLkJ1LMMnM9Mo0K@google.com>
 <19598d43-de61-c663-25e8-17b6f5d5ef80@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19598d43-de61-c663-25e8-17b6f5d5ef80@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:48:32PM +0900, Tetsuo Handa wrote:
> On 2022/07/04 21:59, Wedson Almeida Filho wrote:
> >> @@ -139,6 +139,10 @@ static int misc_open(struct inode *inode, struct file *file)
> >>  
> >>  	err = 0;
> >>  	replace_fops(file, new_fops);
> >> +	if (iter->unlocked_open && file->f_op->open) {
> >> +		mutex_unlock(&misc_mtx);
> >> +		return file->f_op->open(inode, file);
> >> +	}
> > 
> > One of the invariants of miscdev is that once misc_deregister() returns,
> > no new calls to f_op->open() are made. (Although, of course, you can
> > still have open files but that's a whole different problem.)
> 
> The point of this change is that file->f_op after mutex_unlock(&misc_mtx) is
>  from new_fops which is guaranteed to hold a ref on "struct file_operations"
> via new_fops = fops_get("struct miscdevice"->fops).
> That is, a module ref remains valid even after mutex_unlock(&misc_mtx).
> 
> And as with major_names_lock case quoted below, this change assumes that
> misc_deregister() is called from module's __exit function, and fops_get()
> is preventing the module owning new_fops from calling __exit function.

Your assumption is not sound. misc_deregister() can be (and is)
legitimately called from other places, for example, a driver's remove()
callback. In fact, when I grep for misc_deregister(), the second
instance is such a case.

Anyway, I agree that something should be done about the issue you
report, I'm just arguing that this proposal isn't a good one because it
breaks an invariant that makes it really hard for drivers to properly
cleanup.

> 
> +		if ((*n)->major != major || !(*n)->probe)
> +			continue;
> +		if (!try_module_get((*n)->owner))
> +			break;
> +		/*
> +		 * Calling probe function with major_names_lock held causes
> +		 * circular locking dependency problem. Thus, call it after
> +		 * releasing major_names_lock.
> +		 */
> +		probe_fn = (*n)->probe;
> +		mutex_unlock(&major_names_lock);
> +		/*
> +		 * Assuming that unregister_blkdev() is called from module's
> +		 * __exit function, a module refcount taken above allows us
> +		 * to safely call probe function without major_names_lock held.
> +		 */
> +		probe_fn(devt);
> +		module_put((*n)->owner);
> +		return;
> 
