Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA42E4B81D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiBPHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:41:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiBPHlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:41:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4D5A653C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:41:24 -0800 (PST)
Date:   Wed, 16 Feb 2022 08:40:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644997246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOiuPHiQmy5b8Qczc4D0Y+cV4Dyd9l37rqefvPeQyok=;
        b=y54hTjD3laosXu6abNeyuj9xM7XS/ixeG4dSr7/uctB5IbmWYV680ueR2/wrBFo76BQqeq
        e/3qxH7PKjdkreYb0GUpJF7c4kVVa4JRU7DxyDIOyrdCeihXFNNp8VVWdZq/REl5wOQbvw
        1OLBgQUnUZ2dNtlze9GrWbv3YNM3WrC/hTIxyL9LbtNTEIDxi17mpMlqxyXnttPjn2kLoC
        w240d/HUEcB0L9SLNC5dV3NsoWhXfm+fr3kiPkYuU6fGGfprgxdbi0lWFRYAw4hLzlyxyq
        EtFUiotS8TVFTFJHGVrGOkjAFXrRl7lzwHSiP8ZQiIShT+Ca9Fc3BdiVFvByiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644997246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOiuPHiQmy5b8Qczc4D0Y+cV4Dyd9l37rqefvPeQyok=;
        b=IKADsweeCveWUCuSN4KuISDViGfqpDJ95GXtfVROgz4KKgFd7wwQraQ0KHw3u9Tlkvrv9P
        9hAzJrvl7nXNufAg==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fb-helper: Avoid nesting spinlock_t into
 raw_spinlock_t
Message-ID: <YgyqfQkz+/Xs7VWR@linutronix.de>
References: <nycvar.YFH.7.76.2202151640200.11721@cbobk.fhfr.pm>
 <YgvLdvPihuQ9KZ6/@linutronix.de>
 <87o8382j5s.fsf@jogness.linutronix.de>
 <nycvar.YFH.7.76.2202152058300.11721@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2202152058300.11721@cbobk.fhfr.pm>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-15 20:59:24 [+0100], Jiri Kosina wrote:
> Thanks for confirmation, seems like this problem is indeed cured by your 
> series.

Oki.

> I still believe though that we shouldn't let 5.17 released with this 
> warning being emitted into dmesg, so I'd suggest going with my patch for 
> mainline, and revert it in your series on top of it.

No. That warning is only visible with CONFIG_PROVE_RAW_LOCK_NESTING with
the following paragraph in its help:
|   NOTE: There are known nesting problems. So if you enable this
|   option expect lockdep splats until these problems have been fully
|   addressed which is work in progress. This config switch allows to
|   identify and analyze these problems. It will be removed and the
|   check permanently enabled once the main issues have been fixed.

This warning in this call chain should affect every console driver which
acquires a lock.

> Thanks,

Sebastian
