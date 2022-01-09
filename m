Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04001488C3F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiAIUWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiAIUWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:22:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996DC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 12:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hOqhSSA5rBeWUDJJ1IzkzR3tDWAM+JqrbagQBs4JGKM=; b=LNzLfkTKrMcMEFRgF8i/p2OjoF
        pdkhxO+j1UIjsP3vctMnZRuq8O4aYfLol8uGxHHs/Oe8bLUvSWzbAkASbAGm9TAXEKAk7WEGuvDec
        Z+I3x2/Czs5+Vm7Bv8NrqDbYLW0BRsC5E0UFtNgk0iRuUbqzBGjP8G3EJYLqS/G9Qc/gKUliMkRJm
        RIegUjaz5vedhNQuhexcO6MruFs2YFErl10xYBmasqWpCGPs5YoOcqKFvwxrlTFph4mm5QFAXslER
        F/bHumemjBp1pOySumdM0NjeYPxmUK85U0nxlfh7NBR0BJS5U/a0e4dBL+qOrirSP7b1A/e8fYsHN
        lKKVuGCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6ei8-001qZZ-OM; Sun, 09 Jan 2022 20:22:40 +0000
Date:   Sun, 9 Jan 2022 20:22:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] pcmcia: fix setting of kthread task states
Message-ID: <YdtEENWI7IF2Tpc0@casper.infradead.org>
References: <20220109201415.78895-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109201415.78895-1-linux@dominikbrodowski.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 09:14:15PM +0100, Dominik Brodowski wrote:
> We need to set TASK_INTERRUPTIBLE before calling kthread_should_stop().
> Otherwise, kthread_stop() might see that the pccardd thread is still
> in TASK_RUNNING state and fail to wake it up.
> 
> Additonally, we only need to set the state back to TASK_RUNNING if
> kthread_should_stop() breaks the loop.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Fixes: d3046ba809ce ("pcmcia: fix a boot time warning in pcmcia cs code")
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
