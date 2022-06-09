Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A057D545029
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbiFIPHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243905AbiFIPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:07:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5FA3AA9E8;
        Thu,  9 Jun 2022 08:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 983FFB82DE6;
        Thu,  9 Jun 2022 15:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD14C34115;
        Thu,  9 Jun 2022 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654787230;
        bh=sr7x9nyyc6Swg+unCedL/fcC7RNlzrz9OBX0Z8PtW2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmTCsIUcRHP8cYOWzsESc7rdP8dbhJLzPFBVFPWqAQh8AyUbeVvXZOJZeMSIiGwLO
         2nO1Fi+QMcB/5BmACfKI5lZlbhg+Y3lXtetC57VlZ8AzyaMRWUiYnLUAzYr5tNgmNj
         R8pmr7uV49KorN6IUaOMU/vZ2UfUiIQibv0FMbEoB6J8H6ECa7qBSLvSV25GKcnG9r
         ZMnxI/PSBktUAULW/sto0d0mgg9hd24kVRi66PbX0ypU8tM1QaKvvZb+H6NfGcf53T
         604jOe1tP/s6daahxVEi+kSF2qLg+solsR8sWApJVC+Gmnxz8IpHItxxyCjwKqcItp
         xUs8ox/NpvFVg==
Date:   Thu, 9 Jun 2022 16:07:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH -lkmm] docs/memory-barriers: Fix inconsistent name of
 'data dependency barrier'
Message-ID: <20220609150703.GB3289@willie-the-truck>
References: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
 <20220607133432.GA32701@willie-the-truck>
 <Yp9h4Cmo0UNZp6xD@rowland.harvard.edu>
 <d6fab7d9-cf22-cb64-d4dd-50cf8bdd4bba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6fab7d9-cf22-cb64-d4dd-50cf8bdd4bba@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 11:00:46AM +0900, Akira Yokosawa wrote:
> On Tue, 7 Jun 2022 10:34:08 -0400, Alan Stern wrote:
> > On Tue, Jun 07, 2022 at 02:34:33PM +0100, Will Deacon wrote:
> >> Alternatively, maybe we should be removing the historical stuff from the
> >> document altogether if it's no longer needed. We don't have any occurrences
> >> of read_barrier_depends() anymore, so why confuse people with it?
> > 
> > How about relegating discussion of these barriers to a special 
> > "historical" or "niche architecture" section of the document?  In a 
> > separate patch, of course.
> 
> Another option would be to add a section on "Ordering guarantees by
> dependencies", and explain three variants: address, data, and
> control.  We have only "control dependencies" section at the moment
> and uses "data dependency" without properly defining it. 
> 
> Address dependencies are special in that they can provide load-to-load
> ordering guarantees as well as those of load-to-store.
> Alpha doesn't provide these guarantees at the architecture level, hence
> the implicit address-dependency barrier in READ_ONCE().
> 
> Also, IIUC, arm64's READ_ONCE() is promoted to acquire-load when
> LTO is enabled.  It is to cope with the possible (but not observed
> yet) transformation of address dependencies into control dependencies,
> which can't provide load-to-load ordering guarantees.
> 
> These points can be added later in memory-barriers.txt, but I'm
> afraid I might not be up to such involved changes.

I think we should try hard to avoid documenting how specific architectures
implement the memory model (in this document, at least); it's likely to
stagnate and it encourages people to rely on the behaviours of a specific
architecture rather than the portable guarantees offered by the higher-level
memory model.

Will
