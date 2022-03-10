Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9084D52BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbiCJUBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiCJUBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:01:21 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F3157223
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:00:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z4so5591185pgh.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cnhyfcl5nAyHE1LJvcV9lqwhiOSk2bQhU5e71mqbyLo=;
        b=a8GUbSNbmWRosOZSsqafwb5a+tlzcMgo1ibtbv1wYiCvxtfZwQX5HipbHLDhCw+tsJ
         +RnYfSkseYIoaofmjk6qjpwMo5b92LAX0hu08RyLmYzlKcazYHlOXxelUzvQPz+M9AXA
         UhZI8AZSbuRvcjJJgbsHty1GaQLURMkyETncQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cnhyfcl5nAyHE1LJvcV9lqwhiOSk2bQhU5e71mqbyLo=;
        b=Gwk5daGZFUIUNNnR4eR1z4VmKoRQaUkG947HO2GnoraGcFZtOSnS6T9IWQUJY2TWd+
         mXCgw9hHfmlsOKbtNqzX8uCBktzv1AS9FVR9c9jHw22gIdlO32iQU1ieDUJX2v+EWoBp
         yJlFZkILAH9vnK2MDN+t4wz07BpqpU39wP7wE4In7B8M3va6m+QSEby/JrIU6Z4MDnil
         y4sghEMkYlKbF2ZsWHSpWCqnasG7CYRfUMIBJs8wkOaU82rfpGVa293kTpzyVSI6L3lX
         j4WC1v7ptbinsljFCY5IPzItGxa/pttPVKz02vYBz8GxeBJY6JpTE1HzwN3bSAzKWfNV
         lvdA==
X-Gm-Message-State: AOAM531A92zRqmViVy2wRHRFkF4PHksb3D9P1nOY3ZDEfriKFYu4Ei/5
        mCUCt/LreBZjY7TfikXsINMZB5qvNYavXA==
X-Google-Smtp-Source: ABdhPJyBobP8Ylh4YF57Epnj868JhcY33KXtkG3YbUuTL1J/nGUz2M+iXUj4fYXVivLbKu3/S7MKqQ==
X-Received: by 2002:a65:5888:0:b0:374:5575:ba08 with SMTP id d8-20020a655888000000b003745575ba08mr5245684pgu.375.1646942420127;
        Thu, 10 Mar 2022 12:00:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b004f78813b2d6sm236371pfi.178.2022.03.10.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:00:19 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:00:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 08/13] task_work: Call tracehook_notify_signal from
 get_signal on all architectures
Message-ID: <202203101159.67711A1@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-8-ebiederm@xmission.com>
 <202203091455.D4ED8650@keescook>
 <874k45633f.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k45633f.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 01:04:52PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Wed, Mar 09, 2022 at 10:24:49AM -0600, Eric W. Biederman wrote:
> >> Always handle TIF_NOTIFY_SIGNAL in get_signal.  With commit 35d0b389f3b2
> >> ("task_work: unconditionally run task_work from get_signal()") always
> >> calling task_wofffffffrk_run all of the work of tracehook_notify_signal is
> >
> > typo: cat on keyboard
> >
> >> already happening except clearing TIF_NOTIFY_SIGNAL.
> >> 
> >> Factor clear_notify_signal out of tracehook_notify_signal and use it in
> >> get_signal so that get_signal only needs one call of trask_work_run.
> >
> > typo: trask -> task
> >
> >> 
> >> To keep the semantics in sync update xfer_to_guest_mode_work (which
> >> does not call get_signal) to call tracehook_notify_signal if either
> >> _TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL.
> 
> First let me say thanks for the close look at this work.
> 
> > I see three logical changes in this patch, I think?
> >
> > - creation and use of clear_notify_signal()
> > - removal of handle_signal_work() and removal of
> >   arch_do_signal_or_restart() has_signal arg
> > - something with get_signal() I don't understand yet:
> >   - why is clear_notify_signal() added?
> >   - why is tracehook_notify_signal() removed?
> 
> 
> The spoiler is the change to get_signal is the logical change.
> The rest of the changes follow from that change.  Please see below.
> 
> The inline expansion of tracehook_notify_signal in get_signal and
> in it's other two callers in the next change is the only real kernel
> internal api change in this series of changes.
> 
> The optimization that was tried with TIF_NOTIFY_SIGNAL and being able to
> only call task_work_run() when TIF_NOTIFY_SIGNAL was set instead of when
> get_signal was called failed, and caused a regression.  The removal of
> calling task_work_run from get_signal has been reverted but the rest
> of the change had not been.  So this change just removes the rest of
> the failed optimization.
> 
> Please see below for my detailed description of the get_signal change.
> 
> I hope this helps.

It does! Thanks very much for the additional details.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
