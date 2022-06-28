Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5155E98C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbiF1PN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344472AbiF1PNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:13:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1D24BC5;
        Tue, 28 Jun 2022 08:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8966A60F12;
        Tue, 28 Jun 2022 15:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE345C3411D;
        Tue, 28 Jun 2022 15:13:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Mvf/U4H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656429219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSloj0brG5bY7mdOHUoBdYMTWYdqdgpOBJQxXJWQhIs=;
        b=Mvf/U4H250uHD//VCHHEFWF4dRnaFg8uUreDF0NEjyU7kploiNMNxYd1qnBixnjkj4vdtJ
        +fftl9mN1dhrW3k3z8d8Fe1canDszKfF/p3MA812sAVw1NTQ+YSeEOH87Ll8MBgIBzTp4E
        mJ/kFO2wa0G2AHHHxGQle358Cf5+Z7M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fdb5660b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Jun 2022 15:13:38 +0000 (UTC)
Date:   Tue, 28 Jun 2022 17:13:24 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org, urezki@gmail.com,
        uladzislau.rezki@sony.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
        Theodore Ts'o <tytso@mit.edu>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <YrsalGetwIfl8Wkw@zx2c4.com>
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
 <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1656421946.ic03168yc3.none@localhost>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, Jun 28, 2022 at 11:02:40AM -0400, Alex Xu (Hello71) wrote:
> WireGuard and random also use CONFIG_ANDROID in a similar "proxy" way as 
> rcu, there to see if suspends are "frequent". This seems dubious for the 
> same reasons.

I'd be happy to take a patch in WireGuard and random.c to get rid of the
CONFIG_ANDROID usage, if you can conduct an analysis and conclude this
won't break anything inadvertently.

Jason
