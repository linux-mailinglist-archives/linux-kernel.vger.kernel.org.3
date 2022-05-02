Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6335176CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352775AbiEBSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiEBSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B6BE04;
        Mon,  2 May 2022 11:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C175614A5;
        Mon,  2 May 2022 18:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB9BC385AC;
        Mon,  2 May 2022 18:46:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pc08Ys26"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651517201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCPz9yDQbtceEsLuC3rMNC0OSyPzfVOMTuOAVe0IAaI=;
        b=pc08Ys26CvQoChqk5TWzKuQrrCDplm9XM18Nz3iWgufCENImlQUhBGLML2o/lPWGKcqYPq
        FJaivNTJI9lFFR3MbAQtaedId3uE4WGZg6GClWGiJ/kezmvk29n1zwnUXHv3rFFia4wCQ2
        wO6oFUr7D6SKvUb91cXB4A6GqTSopfo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fcb55f61 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 18:46:41 +0000 (UTC)
Date:   Mon, 2 May 2022 20:46:34 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnAnCgxmPBrMdKt5@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 08:34:38PM +0200, Alexander Graf wrote:
> Michael, since we already changed the CID in the spec, can we add a 
> property to the device that indicates the first 4 bytes of the UUID will 
> always be different between parent and child?
> 
> That should give us the ability to mmap the vmgenid directly to user 
> space and act based on a simple u32 compare for clone notification, no?

That is not a good idea. We want an _additional_ 4 bytes, so that we can
keep the first 16 bytes (128 bits) as a kernel space secret.

Jason
