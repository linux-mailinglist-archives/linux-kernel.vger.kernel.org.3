Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0443566731
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiGEKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGEKAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:00:00 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CD2C5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=hfguVTYtwGIPAZW3F2nHNrYsfzOFO5Gzn/MKF5X3APE=; b=js1UbpPK+4YZd7XWcFc4g+4A4i
        +/FfUED/+wuXBMtH1MTWO/3xUIJpstl8yshe8/1r8rdE47FtwU3uaNphHFpnYcmk6J4u+BET8CUV9
        /CRb1ws0P/74H4EnXBksOwg39w0IOV8gcX75UEmM5uUorujnUWagaxqQvoqYqdJAEWpoiZioW+3D3
        spyrxU1lTdd3xu0f05zg2bElFlB5Mfv+Frl/UqeJMp3mmOX3807lniWAtwRI3tBrcqezYvO4yxqdz
        NlooT/cBTHXGMiI1uljwKD9smB6bU/qBcGwo0VHCCms25tfS73+UtlOGHrYFMJTh3pf8PbN/po4Sn
        /frhxhS+C86kw5ZHhTx6x89WBx06UpqCmwZ3O44BH+j7lcVsMrFRfbX2cF1Quaes09B4+xAgGd2lc
        +CisZDNnw1nIMRYJP17P3g3qZSvTxb/AhM7163JAvSxbtvJCqD3bl8fw18doUPdelUnBIuw/5fGR+
        2R+xfcSc4qQTbJYObFAqsLR8kFFeXctWhlY0lk5GdlMjn1LVfDy6wLP+CQWbVO1iemBC7XkZGuKa3
        kHMgQodPJf2Xp6uFV1p3pv07HtWCpLKXOSvqF4fILOdUr64FdB6T5ylPMywZx1KP/SiROdhUeZWbK
        7xocmaNkySHHzWGeV1mEmpEQZOyESPG3x3VEr8Jec=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Tue, 05 Jul 2022 11:59:55 +0200
Message-ID: <2478340.1TyedNfDZE@silver>
In-Reply-To: <20220704141946.4yqo2o6ih5zrqjmy@moria.home.lan>
References: <20220704010945.C230AC341C7@smtp.kernel.org> <1877940.0u7pHPiiHj@silver>
 <20220704141946.4yqo2o6ih5zrqjmy@moria.home.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 4. Juli 2022 16:19:46 CEST Kent Overstreet wrote:
> On Mon, Jul 04, 2022 at 03:39:32PM +0200, Christian Schoenebeck wrote:
> > So simple that it already had one obvious bug (at least). But as it seems
> > that Dominique already supports your patch, I refrain from enumerating
> > more reasons.
> 
> So snippy.

Yeah, the tone makes the music. If you adjust yours, then I'll do, too.

> > > > However that's exactly what I was going to address with my already
> > > > posted
> > > > patches (relevant patches regarding this issue here being 9..12):
> > > > https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.c
> > > > om/
> > > > And in the cover letter (section "STILL TODO" ... "3.") I was
> > > > suggesting
> > > > to
> > > > subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size
> > > > categories? Because that's what my already posted patches do anyway.
> > > 
> > > Yeah that sounds like you're just reimplementing kmalloc.
> > 
> > Quite exaggerated statement.
> 
> I'm just pointing out that kmalloc() is just a frontend around
> kmem_cache_alloc() that picks the cache based on the size parameter... so...
> still sounds like you are?
> 
> Not that there's never a legitimate reason to do so, but it does raise an
> eyebrow.

So you are saying this change was useless as well then?
https://github.com/torvalds/linux/commit/91a76be37ff89795526c452a6799576b03bec501

Like already discussed in the other email, I omitted those cache size
granularity changes for good reasons, until proofen by benchmark that they
would actually help.

Best regards,
Christian Schoenebeck


