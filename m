Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DBF58923A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiHCSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiHCSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:25:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F6363B5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28B05B82330
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 18:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C08C433D6;
        Wed,  3 Aug 2022 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659551120;
        bh=9Ljb7abzn52HuoZKUa9GwMJTqJ4LWPVSB5gBZhJMZGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdqcJr2+3QQt64+cVCZ8ymKktWzBkWiuPotYbODBSS6qll2uLYIPDJ9+ZbakvsRTG
         5V+oVAxVJPcLoX/1c80nbjtWbjoAve/+F5R989K7Jw4hiLye4TBkEhOXiD2RYs+Pc6
         NXXDVrDPRi1xDQGMi2ID8bRTpLHKVuflugheqbVrVk8C/f3edabqAXtsx8+7PjVJA9
         JjI+TvUsoVGPA9HuswCKbHBG5xwotd9eq5OApwIFKsMZ7K4VJGqHkL3SR3lorq9h0G
         9LFjBTVeLQ1xBfCGQ79WV0mMiumunCpIXTwFPC10ruUqxeA/r4ApKboWxuzOWQnC4x
         OuYNgv6bfXzIQ==
Date:   Wed, 3 Aug 2022 18:25:18 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Zdenek Kabelac <zdenek.kabelac@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow
 device open
Message-ID: <Yuq9jhxb+WgO55KJ@gmail.com>
References: <20220704000225.345536-1-dlunev@chromium.org>
 <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com>
 <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
 <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
 <Yun4LH+StcuBXRtO@sol.localdomain>
 <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 02:29:40PM +1000, Daniil Lunev wrote:
> > This seems like an access control policy, which the Linux kernel already has a
> > lot of mechanisms for.  Chrome OS already uses SELinux.  Couldn't this be solved
> > by giving the device node an SELinux label that no one has permission to open?
> That would be the ideal solution, but there is a number of challenges
> that prevent
> us enabling enforcement on all SELinux domains unfortunately. While in the long
> run that would be a preferred option, in the short run this doesn't
> seem feasible. I
> would assume the problem of enabling full SELInux enforcement would plague
> any big project that didn't have them enabled from the get going.
> --Daniil

Have you also considered unlinking the device node (/dev/dm-$idx) from the
filesystem after it has been set up for swap?

- Eric
