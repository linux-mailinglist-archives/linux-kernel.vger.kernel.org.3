Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150874A58DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiBAI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:59:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33422 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBAI7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:59:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09169614ED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAC2C340F3;
        Tue,  1 Feb 2022 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643705895;
        bh=r7eAvwcNoIC4Kqf/puxztITN9gelFA2bWYzMxyTBcqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUTn9VwBJk+gowjJncdfhI8YXGOVVoIvmYE9IzQqC9cdhW/cMO+e5VqWM30haDrIc
         U3FgJjjUJTNCNrZRZahJLZgeI0tlOZip0xbbil5ZXBz/XnAPlEHP+aSpYFeioDK5aS
         3UY6EvPW3KtfatgAcmH3fEr1POVlk/KY/BZ7CD10WiX4vSdFlOR52JYAgs4YrGkw7a
         SRNG6rdPTssNKdXJmV14poc8ykiZcLknTdUDl8RRqOQWONsZTc7o4jATs5pHejPjJg
         0aHc1ERZGT5SwWzdSSfYoIB3pwTAYz5/zFk6+Em53I4ru4ulTd0eT9MvNu1Gj+7FpI
         Re/uASIcXallw==
Date:   Tue, 1 Feb 2022 10:58:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 33/35] arm64/mm: attempt speculative mm faults first
Message-ID: <Yfj2G3oOC6cZx0IL@kernel.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-34-michel@lespinasse.org>
 <YfZWtsC3QIzXR0LI@kernel.org>
 <20220131080729.GA785@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131080729.GA785@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:07:29AM -0800, Michel Lespinasse wrote:
> On Sun, Jan 30, 2022 at 11:13:26AM +0200, Mike Rapoport wrote:
> > The speculative page fault implementation here (and for PowerPC as well)
> > looks very similar to x86. Can we factor it our rather than copy 3 (or
> > more) times?
> 
> In each arch, the speculative code was written along the lines of the
> existing non-speculative code, so that behavior would be unchanged
> when speculation succeeds.
> 
> Now each arch's existing, non-speculative code paths are quite similar,
> but they do have small differences as to how they implement various
> permission checks, protection keys and the like. The same small
> differences end up being reflected in the new speculative code paths.
> 
> I agree it would be nice if this code could be unified between archs,
> but IMO this should start with the existing non-speculative code -
> I don't think it would make sense to try unifying the new speculative
> code while trying to follow the behavior of the non-unified old
> non-speculative code paths...

Then maybe this unification can be done as the ground work for the
speculative page fault handling?

-- 
Sincerely yours,
Mike.
