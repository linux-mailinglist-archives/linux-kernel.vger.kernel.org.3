Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97F4E885E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiC0PRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiC0PRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 11:17:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C150B1E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 08:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0220561036
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05176C340EC;
        Sun, 27 Mar 2022 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648394123;
        bh=Hl0LXWoiLzrKX6l1Eq/43l5hDVxWTAXk31ja3k+z+ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u16gBWssceWp1pZoEzsr2VAt8LlB6WKPEzcsCxfqNMA22jp4UYuDOwdmE4lDRwI3J
         YkJX5q5CorWKR0QBLmdvSlc9Tnb1sVFHYc/RaOIDabn+kYr2H4dRxy15iJhjjwPY1+
         9tg4b/Q8/rcnTAI6aV52vWernTiarCalzcdsKWbRDC6xf0Pfxcwu65Jn0/tjZvVJTU
         /L2I5StgosR+jakn9tbHYgHdj6AQB/kDNYbE/tYiACoFj/6jbmoYJvCA1k379+m1NN
         Jo4jVyBoOhwrYJFczNtZlB0d19NPVci5h7I1ep2BDh5X658N7ZT9kYLaAwEcENBNc+
         EA8e2MNk4c9kw==
Date:   Sun, 27 Mar 2022 18:15:15 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Message-ID: <YkB/gzP6tOpDktoZ@kernel.org>
References: <YkAU2JlcX7nlvbwp@kernel.org>
 <Yj1zVkryTVoAnxsX@kernel.org>
 <20220324070158.22969-1-jaewon31.kim@samsung.com>
 <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
 <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p1>
 <20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48@epcms1p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48@epcms1p1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 10:53:47PM +0900, Jaewon Kim wrote:
> > 
> >--------- Original Message ---------
> >Sender : Mike Rapoport <rppt@kernel.org>
> >Date : 2022-03-27 16:40 (GMT+9)
> >Title : Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
> > 
> > 
> >I'm still not following. The reserved region sizes are available in the
> >existing memblock debugfs.
> >Why the names are important? What is the value of having names for *some*
> >of the reserved regions?
> 
> Hi
> 
> There are many memory regions in memblock debugfs memory/reserved, and some might
> be splited or merged with other region. Among regions in debugfs, we can't find 
> the one we defined in device tree. Especially it is difficult to find the region we
> described size only without start address.
> 
> On mobile environment, memory is used by not only CPU but also GPU, Camera, Secure
> world, Audio, ETC. To support them, there are many reserved regions described in
> device tree. So the name is quite important to recognize a region. And with thename
> we can compare reserved memory map with other map.

You still didn't describe your use case. What is the problem your patches
are trying to solve? Why is it important to know what is the use of particular
reserved region? 

You propose complex mechanism that seems to fit very particular scenario
and sprinkle some calls to this mechanism at random places because you need
to "compare reserved memory map with other map".

Does not sound convincing to me, sorry.

> Thank you
> Jaewon Kim

-- 
Sincerely yours,
Mike.
