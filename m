Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23795510ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355155AbiDZUv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355103AbiDZUvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DFE4D251
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E3F461446
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EF2C385A0;
        Tue, 26 Apr 2022 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651006092;
        bh=rpvSC2xGOQbxtEJiuPwyZqO4h6SMbmUX1MZN0z6pcbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CgiytSfrTg2IwS09rq9QP0ZKU3f4BRurD7D9QqwTQzGtHGcWDO4sIcJ/TFZLuOlfh
         pzTdV+op3HjsvlCA4UMN+i3bC1xaQwWNAxGUwyVLWANZEXkhd3F7JqE5HGkC9juScp
         UGc3MJLIsDmXT1qPTdo0mUatALVHUbiO9ZDtL9/o=
Date:   Tue, 26 Apr 2022 13:48:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Message-Id: <20220426134811.63a398ea5d2212dfececfd83@linux-foundation.org>
In-Reply-To: <1790890.atdPhlSkOF@leap>
References: <20220426193020.8710-1-fmdefrancesco@gmail.com>
        <20220426123412.51fb58780a8fe2b32c7814ce@linux-foundation.org>
        <1790890.atdPhlSkOF@leap>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 22:19:57 +0200 "Fabio M. De Francesco" <fmdefrancesco@g=
mail.com> wrote:

> On marted=EC 26 aprile 2022 21:34:12 CEST Andrew Morton wrote:
> > On Tue, 26 Apr 2022 21:30:20 +0200 "Fabio M. De Francesco"=20
> <fmdefrancesco@gmail.com> wrote:
> >=20
> > > Add VM_BUG_ON() bounds checking to make sure that, if "offset + len>
> > > PAGE_SIZE", memset() does not corrupt data in adjacent pages.
> > >=20
> >=20
> > hm, why?  To match all the other functions in there?
> >=20
> > I suppose that's logical.  Or we could just delete all the other
> > VM_BUG_ON()s.  Have any of them proven to be at all useful?
> >=20
> I am not so sure about it being so useful. I just noted that memzero_page=
()=20
> is the only function of that family that is implemented with no=20
> VM_BUG_ON(). I have no actual proofs of usefulness :(=20
>=20
> This is why yesterday I sent an "RFC Patch" (please see =20
> https://lore.kernel.org/lkml/20220424104806.25396-1-fmdefrancesco@gmail.c=
om/
>=20
> Soon after sending it I thought that VM_WARN_ON_ONCE() could have been=20
> better suited, but Ira Weiny wrote to use VM_BUG_ON() for consistency.
>=20
> Now I could either delete all other VM_BUG_ON() or replace them with=20
> VM_WARN_ON_ONCE() (or some other macro).=20
>=20
> Ah, a third solution might be to leave highmem.h as it is now :)
>=20
> What do you prefer?

Merge this patch as-is, I guess.  Going through and removing unuseful
VM_BUG_ON()s is a separable activity.
