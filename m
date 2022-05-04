Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7551A44C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbiEDPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352624AbiEDPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:44:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B668403CB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4A45B8271D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA66C385AA;
        Wed,  4 May 2022 15:40:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lSku+Mz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651678841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5oHSSkfKxB1jCirj58pbPfVt0b7FmgoFjBwpLsCmXc=;
        b=lSku+Mz4lwdLiQKuu71u/Yf6hYY2d3pGYc9b8e78euko+6ws7Ng8SoIcdCLn/ecIaB8xms
        YlgZz1C0MBRaFvRcL9a6Z7PLZVSy5IlwjDNgElw29Wxx2LjjX9dAQigddHXP9KzRIkSnK6
        WIPSKWHZka/cIYRUZ6QNhwxMd6UWBJc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34011ef4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 4 May 2022 15:40:40 +0000 (UTC)
Date:   Wed, 4 May 2022 17:40:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
Message-ID: <YnKeag3Ulg0NR58Q@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220501192740.203963477@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, May 01, 2022 at 09:31:42PM +0200, Thomas Gleixner wrote:
> The recent changes in the random code unearthed a long standing FPU state
> corruption due do a buggy condition for granting in-kernel FPU usage.
 
Thanks for working that out. I've been banging my head over [1] for a
few days now trying to see if it's a mis-bisect or a real thing. I'll
ask Larry to retry with this patchset.

Jason

[1] https://lore.kernel.org/lkml/7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net/
