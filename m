Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652C518398
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiECL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiECL7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F0EB7F1;
        Tue,  3 May 2022 04:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 433176164E;
        Tue,  3 May 2022 11:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902D0C385A9;
        Tue,  3 May 2022 11:55:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iwmrY2Q1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651578938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmnpymFgrKna+sorYsF9uO7087ZOoY3Nagqmgfgtvyw=;
        b=iwmrY2Q1Z5D2rGVAA265kMFcIFN0uJku1PhjnGHwvIhDRbrtY5xC0tE8RmF9AHg2cdbv7X
        w59MpGC2fCz7GMwqv2ef6Sdw1MNYtmmiBTK0+d7veygZHmULjs9O1XX1mOc32pN4ewyMF8
        YoCyXu/14vRA+o3aNNd5wpIVEN/3Yn8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8fcc1fbf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 3 May 2022 11:55:38 +0000 (UTC)
Date:   Tue, 3 May 2022 13:55:35 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnEYN+Q3q76NVX3Q@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
 <YnDn/d6iB0aUZkWJ@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnDn/d6iB0aUZkWJ@gardel-login>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 10:29:49AM +0200, Lennart Poettering wrote:
> As mentioned earlier, I am not convinced sysctl is the right place for
> this. sysctls are understood by most people as being the place for
> tweaking kernel settings. This is not a kernel setting, but a
> notification concept, and the way Jason defined it there's nothing to
> read nor write, which strongly suggests to move it elsewhere, but not
> /proc/sys/.

I think I'm coming around to this view that having a sysctl return
-ENODATA is weird. It makes `sysctl -a` always complain to stderr, for
example, which seems bad.

> > I can see attractiveness in providing the /run/fork-id directly from the
> > kernel though, to remove the dependency on systemd for poll-less
> > notification of libraries.
> 
> I agree.

I'm still not convinced there's value in having a counter or a UUID, but
if you had to choose, would you prefer a counter or a UUID? It sounds
like the former, because you see a use for distinguishing between zero
and non-zero? Or did you finally agree with me that vmgenid isn't
granular enough for that?

Jason
