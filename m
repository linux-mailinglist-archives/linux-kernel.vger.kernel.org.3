Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD2F4EBB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiC3HK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbiC3HKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7014925D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 627AEB81B7B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E8AC340EC;
        Wed, 30 Mar 2022 07:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648624111;
        bh=DKoq9YvSczGdQCdMOF+NabMNKq/zWi6ZojZmF4Zj6bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw7ByWb4Xkwu28+hAngRXO/bi3ONlQPQQSQuEAAKhnzXh8yqY4cjj71nGa1yMpBPi
         XwSwIEUfQWCnD3+xERtK8mKgw59ZSaD4cBV4i39F/aFKx9TFDp0xSXPTcviilSwUmx
         3Xa8Wv/GhTUgvTx7PtQBsmwavkqa4onOYQ5ynKrt9Guq1TF7lPZ7nG/pyPpVPfSpoB
         yXax5RUPkQOVN+0QfbyJFjRwCOE0u7nTRBxdmFj6Lo3z5yHoeisnZph4nL3CNvKhsw
         Mexhqqt37niEoHaqeA+vuLOrK3oA/bPeqPPpDrgEvy2AbH9TQaiKJ/pXmDN2jilQeo
         zvJOaUE6E8IVw==
Date:   Wed, 30 Mar 2022 10:08:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Message-ID: <YkQB6Ah603yPR3qf@kernel.org>
References: <YkB/gzP6tOpDktoZ@kernel.org>
 <YkAU2JlcX7nlvbwp@kernel.org>
 <Yj1zVkryTVoAnxsX@kernel.org>
 <20220324070158.22969-1-jaewon31.kim@samsung.com>
 <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
 <20220327135347epcms1p13faf0f2b7d98d3b59b25e903678d9c48@epcms1p1>
 <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p7>
 <20220329024620epcms1p7633018e83f54e532761008a60da5254f@epcms1p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329024620epcms1p7633018e83f54e532761008a60da5254f@epcms1p7>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 29, 2022 at 11:46:20AM +0900, Jaewon Kim wrote:
> >> > 
> >> >I'm still not following. The reserved region sizes are available in the
> >> >existing memblock debugfs.
> >> >Why the names are important? What is the value of having names for *some*
> >> >of the reserved regions?
> >> 
> >> Hi
> >> 
> >> There are many memory regions in memblock debugfs memory/reserved, and some might
> >> be splited or merged with other region. Among regions in debugfs, we can't find 
> >> the one we defined in device tree. Especially it is difficult to find the region we
> >> described size only without start address.
> >> 
> >> On mobile environment, memory is used by not only CPU but also GPU, Camera, Secure
> >> world, Audio, ETC. To support them, there are many reserved regions described in
> >> device tree. So the name is quite important to recognize a region. And with thename
> >> we can compare reserved memory map with other map.
> >
> >You still didn't describe your use case. What is the problem your patches
> >are trying to solve? Why is it important to know what is the use of particular
> >reserved region? 
> >
> >You propose complex mechanism that seems to fit very particular scenario
> >and sprinkle some calls to this mechanism at random places because you need
> >to "compare reserved memory map with other map".
> >
> >Does not sound convincing to me, sorry.
> 
> As I said serveral times, I want a simple knob showing all reserved
> memory status.  The current debugfs, device tree do not show all those
> information I want. I think you also know that.  i.e. late freed pages,
> splited or merged memblock, address defined at boot time, kernel size,
> ETC. 

I know that there is not much information about reserved memory exposed and
I understand *what* are you trying to achieve. But you never provided
details about *why* you want this information exposed.

I don't mind providing more visibility into reserved memory attributes in
general, but I'd like to see something way more simple and localized.

-- 
Sincerely yours,
Mike.
