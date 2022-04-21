Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7550AC11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442617AbiDUXna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442612AbiDUXnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142565CF;
        Thu, 21 Apr 2022 16:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C93B61ED6;
        Thu, 21 Apr 2022 23:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A32C385A7;
        Thu, 21 Apr 2022 23:40:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QvHrmzwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650584427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKGSSXBewV8iwcVtrAOqicwFSmOZw+K6H7Pd52VpMcY=;
        b=QvHrmzwUGemOIsU3YRqPcoKjV5EFRVm/GbypSc0nolztWPEAS0uQUoSkafHp01gyNmOKKV
        TTa3D1rCL0c1RAAJJljgS5tK7DC1mAnppgi4zO2A+MJ6XFIu/lo+Uu3PkEcOI8IeUN+EoM
        QPtowJpnEXOpxsvHh9f9/cXQUEQRvA8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a195fe7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 21 Apr 2022 23:40:27 +0000 (UTC)
Date:   Fri, 22 Apr 2022 01:40:25 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmHraZcGnY3stnp9@zx2c4.com>
References: <20220421233152.58522-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421233152.58522-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thanks. This looks better.

On Thu, Apr 21, 2022 at 04:31:52PM -0700, Eric Biggers wrote:
> Therefore, increase the number of counter comparisons from 1 to 3, to
> greatly reduce the rate of false positive cycle counter detections.
> +	for (i = 0; i < 3; i++) {
> +		unsigned long entropy = random_get_entropy();
 
Wondering: why do you do 3 comparisons rather than 2? What does 3 get
you that 2 doesn't already? I thought the only real requirement was that
in the event where (a)!=(b), (b) is read as meaningfully close as
possible to when the counter changes.

Jason
