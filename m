Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDF507948
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357377AbiDSSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357683AbiDSSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1C1C107
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D4A61522
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87877C385A5;
        Tue, 19 Apr 2022 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650393206;
        bh=H1oFXf3wjHIKjyaD0GET6MgKHiZJtaQEQDv0ySaB/Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWArRDd8xXHD/+D6eA5paKurMw53dJH/3JxkKZGZG+KZ46ea5EbwOFw7jVLhqNXX+
         g7l1S17XK4upMUQLpZO0MqOTbUnL9od6JxT/+e2jABkPr0Zzb/sy6rGxNmNOlbHXcX
         xqO57L4pfrcghUzyZXLdOeT/RoMcFXCOEvnNgLFo=
Date:   Tue, 19 Apr 2022 20:33:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl8AchMeoHkG1e9l@kroah.com>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220418212709.42f2ba15e00999bb57086b27@linux-foundation.org>
 <Yl727M1Dxm+vC/R1@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl727M1Dxm+vC/R1@carbon>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:52:44AM -0700, Roman Gushchin wrote:
> On Mon, Apr 18, 2022 at 09:27:09PM -0700, Andrew Morton wrote:
> > > The folder
> > > contains "count" and "scan" files, which allow to trigger count_objects()
> > > and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> > > count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> > > and scan_memcg_node are additionally provided. They allow to get per-memcg
> > > and/or per-node object count and shrink only a specific memcg/node.
> > > 
> > > To make debugging more pleasant, the patchset also names all shrinkers,
> > > so that sysfs entries can have more meaningful names.
> > 
> > I also was wondering "why not debugfs".
> 
> Fair enough, moving to debugfs in v1.

Thank you, that keeps me from complaining about how badly you were
abusing sysfs in this patchset :)

