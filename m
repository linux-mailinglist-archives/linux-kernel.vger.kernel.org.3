Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A9A470796
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbhLJRs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:48:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52386 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbhLJRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:48:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6BC45CE2C34;
        Fri, 10 Dec 2021 17:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF9DC00446;
        Fri, 10 Dec 2021 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639158318;
        bh=h2+tsYbJOupsl375+icjqBHrs1cW+BMfkxLDD2UUNjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PREYSS3TNe1zdeN12rSffhatLuWwieDm/d6zoldD+m6/eJKQUOmMQyMOlmpDi2eXr
         S4qKoLFiIro1Cqh/SUVwQMR/+Y7USkq6r4/20tv8hmMY1s4OqntEeTXQUgEu1V75P9
         kmGVRc2Jnt+J19PE3547Tt1XR5PMTMzqR1+kr3T0+f3aZSnQnMMNFQxbwTyI25BG54
         HurnMHdeP/AJWMIOtrINJJ6TssmfEI6hSsP+vceGE/rX87Kl4lsjIT/SDpG5LQBOAO
         xVdjd4I71vg8kO8qc/nsu2TLDpcjefIBLkkGt1ag3SIHHzt0ALntatttaKK27+NZYO
         I+LqcuN0mcZrw==
Date:   Fri, 10 Dec 2021 09:45:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YbOSLC9SNelqwD+g@sol.localdomain>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain>
 <YbL2uUqV0GWFOitE@kroah.com>
 <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb29756b-8b21-5b4d-f107-b5573945d7ab@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:29:41AM -0800, Bart Van Assche wrote:
> (c) This encoding enforces the restriction that data unit sizes are a power of
>     two. Is there anything fundamental in encryption that restricts data unit
>     sizes to a power of two? I don't know the answer myself.

Well, the data unit size has to evenly divide the size of the request (for
requests that have an encryption context which specifies that data unit size).
So if the data unit size was, say, 1536 bytes, then all requests would have to
be multiples of 1536 bytes.  That has a factor of 3 in it, so it would be
impossible to make any power-of-2 size request.  That sounds pretty impractical;
it's hard to see how and why we would ever support such a thing.

- Eric
