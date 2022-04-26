Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C185106F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351367AbiDZScf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiDZScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:32:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0140139983
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:29:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k29so16723842pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HmuM5TIrwy84aRDSAaK7McD8VamJbDNCdZW2GH9f+To=;
        b=MfYuxcKeCTEuBVEfzxDFoba59NLkUYg5jUNX9a5LKHOOzuQoWOi4Wvt4Px2wzrFk8h
         s2n6TdsnpqJgg8TmZLmpGt2cHk+1/ErZwtEuB0s0Su3XLsP0Tv5QF1WSHGuCKdmybOW2
         FCafZXx0Iyj5T3h+jHhYcNJNQ74MIcIjudt5RR5Kqf1VNJaZ2GVh9kobaYFQg+FS/JJ0
         CWvX5u526j6oJPQzAlTekog+P/hG66wLvA3HQJC2NgyHJXBvyyJrkP8NHJA2HNoPVD9q
         HufP7saM2lzUqGHavV/NFraZ1HWGow37M9X6uSCIVyq0dg+hiTzXropa5n1f5tHXd1r7
         qb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HmuM5TIrwy84aRDSAaK7McD8VamJbDNCdZW2GH9f+To=;
        b=XenU5VLQRdET8jlGLk7O5/scmwr3ToWpw7OTbpTx922JqwP82lIDlN1aYRm6b7q5fq
         nfhAY6ZawxAVMIwyfD1Gc9IK4FUK2oJIilV8jluyaI7ipLRevBsZV3ugirn4j8RNj3WW
         ZJ86s5C2lmS8yM9DqOS2UoShUoTRPAGMSdnX6UTqKOn5buy9+E1ak6NjX7uN9j0S3ptg
         WWq6reJe3O124cQypB4t1XF6b70OPUwKuuExmJHwL3vR7aEIeNEfN7AbOyjv0/sRxPKU
         LkfZxJOh+b2rcVvwOD0tVwdpX5nairIG7yaALDmhVsRQw750nVwBReYC3senRAvfVzBx
         8VbQ==
X-Gm-Message-State: AOAM5332c3ACDIxkR3b2V2cTi+KookzkILd378fvygim2oA6mGiFGO1v
        b9Xjxt+pDEKOX9Cxb60Klsd9F1zdBXM=
X-Google-Smtp-Source: ABdhPJwvMxJVNR6kW3QNSNsRhBl66zyylvfdGKWu1zqHQv7Jwme01ZPi9Y+4Zm7d08UEEz6X4PCRAQ==
X-Received: by 2002:a63:bd49:0:b0:39d:a2d3:94a2 with SMTP id d9-20020a63bd49000000b0039da2d394a2mr20429929pgp.242.1650997763982;
        Tue, 26 Apr 2022 11:29:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a3e])
        by smtp.gmail.com with ESMTPSA id lw4-20020a17090b180400b001d7faf357b7sm4403417pjb.4.2022.04.26.11.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:29:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Apr 2022 08:29:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/10] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <Ymg6AazfnwdZXkXx@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-2-imran.f.khan@oracle.com>
 <YmLRxWUnF/zflEO2@slm.duckdns.org>
 <e30f95c3-ab55-bb1b-75c1-8bd2f91787b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30f95c3-ab55-bb1b-75c1-8bd2f91787b5@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:43:38AM +1000, Imran Khan wrote:
> Hello Tejun,
> 
> On 23/4/22 2:03 am, Tejun Heo wrote:
> > On Sun, Apr 10, 2022 at 12:37:10PM +1000, Imran Khan wrote:
> >> @@ -768,15 +765,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
> >>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
> >>  		return;
> >>  
> >> -	spin_lock_irq(&kernfs_open_node_lock);
> >>  	on = kn->attr.open;
> >> -	if (on)
> >> -		atomic_inc(&on->refcnt);
> >> -	spin_unlock_irq(&kernfs_open_node_lock);
> >>  	if (!on)
> >>  		return;
> >>
> >>  	mutex_lock(&kernfs_open_file_mutex);
> >> +	if (!kn->attr.open) {
> >> +		mutex_unlock(&kernfs_open_file_mutex);
> >> +		return;
> >> +	}
> > 
> > What if @on got freed and new one got allocated between the lockless check
> > and the locked check? Is there a reason to keep the lockless check at all?
> 
> The only reason for lockless check is to opportunistically check and
> return if ->attr.open is already NULL, without waiting to acquire the
> mutex. This is because no one will be adding to ->attr.open at this
> point of time.
> But we can live with just the locked check as well.
> Please let me know if you think of lockless check as an overkill in this
> case.

The code is just wrong. You can end up:

        on = kn->attr.open;
        if (!on)
                return;

        // we get preempted here and someone else puts @on and then
        // recreates it

        mutex_lock();
        if (!kn->attr.open) {
                mutex_unlock();
                return;
        }

        // we're here but @on is a pointer to an already freed memory

Thanks.

-- 
tejun
