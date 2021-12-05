Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D080B468AAD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhLEMDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 07:03:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48340 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhLEMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 07:03:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBAA60AD4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2142C341C5;
        Sun,  5 Dec 2021 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638705593;
        bh=OiNkFk5G/CmqUjp/NHlUp+nNV+3LkMSULAq93llkGuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enWikgK+aJ7PYb+dDixnORrPlXenO6TCDd+CJi6f1QDOwd9mi/nXIVRpqAH9C/L05
         J1fhLsuKXvLu9iVjc+KIiqSeHZpRL4s9rfoqd55qpZhgtH9U0b/+uezIAp1PgyUw7M
         8eNyy4nqJgXJjbRvbKubvy4Gg+QE71vB+QeaXABJvKZUuHw4a5dbuWiYMhCnFb3Sh1
         Is9uzWVZHzf5kgn60dMY3zXntefNx4NsyHg9p9tl+2w7kpNV0808roEEM/y5oAY5zh
         xvzvdBWJY1f1x2I0vF9t2ugRjio4XU/wMt43v6Fj41sOjH6/QFM8EGQK/yON2BIkDX
         gwihIGL8383yQ==
Date:   Sun, 5 Dec 2021 13:59:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bixuan Cui <cuibixuan@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org, w@1wt.eu,
        keescook@chromium.org
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <YayptO82EvG3EwKA@unreal>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:06:24AM +0800, Bixuan Cui wrote:
> Delete the WARN_ON() and return NULL directly for oversized parameter
> in kvmalloc() calls.
> Also add unlikely().
> 
> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>

How can we progress with this patch?

From this discussion, at least for RDMA, KVM and BPF, this huge size is legit
and WARN_ON() can be seen as false alarm.

Thanks
