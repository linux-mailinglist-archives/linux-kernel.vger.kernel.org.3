Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374AB4A3E74
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 09:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiAaIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 03:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiAaIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 03:07:32 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408BCC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 00:07:32 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-53-ed;
 t=1643616449; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=DUls+NSqCzLwdMvu9DMfYrIm8aID0KapGH5s3ZOvbmM=;
 b=HO/JA3FzstU7ddJ40KAF/Lb2XFouhcOhmEQwjCTTi0nYal7+D3kVQjpqaRVJ+9Frc1C9N
 C4GY0hPtgTCiIAQCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-53-rsa; t=1643616449; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=DUls+NSqCzLwdMvu9DMfYrIm8aID0KapGH5s3ZOvbmM=;
 b=aLVrOmahxQg+ZOd/LoQHUx/7vByrwGN7Xd0dgQQNhU1I5GVOkMKA7nwyXIK5UP7XG5MKH
 RDvCQZtIxBc7eLbNoXfJZzLQIOiTrWV+KMpLiNPvpV/Uu3zd3xLayV5lggbB7m8AjzCH2J8
 uLAn8QWVKes4qJdhfJfW3+v0RkWs4zhSLpxoXf/bLQwO08xqJKgYm8L30aAP/42vOrD7AEm
 vh3D9K+S5i6eVVk+jTE5EDJ57vc+QvmGKFV6bue6mI0pzBINsv57zAY6cUWPhLsGmVXzNfO
 fHyzKWELMEidcbPxbnLI9yA4e378PpkDyia5zYcDBWtUKkAEMb2jkch9sY8w==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id D1A82160968; Mon, 31 Jan 2022 00:07:29 -0800 (PST)
Date:   Mon, 31 Jan 2022 00:07:29 -0800
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20220131080729.GA785@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-34-michel@lespinasse.org>
 <YfZWtsC3QIzXR0LI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfZWtsC3QIzXR0LI@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 11:13:26AM +0200, Mike Rapoport wrote:
> The speculative page fault implementation here (and for PowerPC as well)
> looks very similar to x86. Can we factor it our rather than copy 3 (or
> more) times?

In each arch, the speculative code was written along the lines of the
existing non-speculative code, so that behavior would be unchanged
when speculation succeeds.

Now each arch's existing, non-speculative code paths are quite similar,
but they do have small differences as to how they implement various
permission checks, protection keys and the like. The same small
differences end up being reflected in the new speculative code paths.

I agree it would be nice if this code could be unified between archs,
but IMO this should start with the existing non-speculative code -
I don't think it would make sense to try unifying the new speculative
code while trying to follow the behavior of the non-unified old
non-speculative code paths...
