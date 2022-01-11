Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7C648AFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiAKO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:57:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiAKO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:57:39 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 254C7212C5;
        Tue, 11 Jan 2022 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641913058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlxQNmr/ZNHAhEYAOVN3PDy1I660OQmhK5nAkm2oCWQ=;
        b=HrqlaVXd1oBEoIOYpZ6TTolQmrdqFD4QDrAIF1CcUubAYpX+DbBldIif7Q8oR5bPIBAixc
        /eyShwKkmkENXGbwjpQbDZdHKLsALWYJA0eLAVIzkc/GHyN2gJBiP4kDM8sC8U3ZQ5xv48
        qlrQIvK+Jwy/Bb7PKvoQCP++1AVC4vQ=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C860EA3B81;
        Tue, 11 Jan 2022 14:57:37 +0000 (UTC)
Date:   Tue, 11 Jan 2022 15:57:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Message-ID: <Yd2a4MApVR8hexny@alley>
References: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-01-10 22:50:49, Andy Shevchenko wrote:
> The %p4cc specifier in some cases might get an unaligned pointer.
> Due to this we need to make copy to local variable once to avoid
> potential crashes on some architectures due to improper access.
> 
> Fixes: af612e43de6d ("lib/vsprintf: Add support for printing V4L2 and DRM fourccs")
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have already sent pull request for 5.17. Could this wait
for 5.18 or would you prefer to get it into 5.17, please?

My understanding of Sakari's reply is that the current callers
provide aligned pointers. In that case it would not be urgent.
But I might have gotten it wrong.

Best Regards,
Petr
