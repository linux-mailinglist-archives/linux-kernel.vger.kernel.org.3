Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC84E59080F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiHKVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiHKVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BD9D8EE;
        Thu, 11 Aug 2022 14:30:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B0216148F;
        Thu, 11 Aug 2022 21:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BB0C433C1;
        Thu, 11 Aug 2022 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660253405;
        bh=x2wnfdHh9hLECh8av03/ocMCbc9lU0kiGT1idHoqt6E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fe9mDEKIwatWGnYpiBj/IjMwLcHO+1KJaHOHYuez8iz+DPGfiEoAyjdEqQZ8AJL1C
         n30qAApOiaEbFjheSXHNAUd2/I24sXqTRwAyry11jbQBFA677OMv7heiNspfnh9AM4
         dusjDyJhgqjfxepUUN0aRNdWBop3raPmai+RzhzdYfQf5+AAZANHoGBrO0dGKK8BpK
         WNTusRweNw8Zf/G8iKLdbfe8IhSABQG6sH2RXoRizjuFUWmpILZU8TIZzEZcxA9SaZ
         Di8+NKrMk6txZcv15wkmus2nhY32u5IelFgc+d17uaDSXocOP3OFqPVIN1BcM+xLmh
         IPTa2UCfdzYaA==
Message-ID: <72a93a2c8910c3615bba7c093c66c18b1a6a2696.camel@kernel.org>
Subject: Re: [GIT PULL] Ceph updates for 5.20-rc1
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Date:   Thu, 11 Aug 2022 17:30:03 -0400
In-Reply-To: <YvVzHQ5DVaPAvw26@ZenIV>
References: <20220811152446.281723-1-idryomov@gmail.com>
         <CAHk-=wifgq59uru6xDB=nY-1p6aQ-1YB8nVhW7T-N2ctK3m1gw@mail.gmail.com>
         <CAOi1vP9BSi-65of-8D0BA1_DC0eVD_TQcWkhrGJwaXw_skhHFQ@mail.gmail.com>
         <5d0b0367a5e28ec5b1f3b995c7792ff9a5cbcbd4.camel@kernel.org>
         <YvVzHQ5DVaPAvw26@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-11 at 22:22 +0100, Al Viro wrote:
> On Thu, Aug 11, 2022 at 05:08:11PM -0400, Jeff Layton wrote:
>=20
> > Actually, I never got a formal ack from Al. I did send it repeatedly,
> > but I assume he has been too busy to respond. We've had it sitting in
> > linux-next for a couple of months, and he did suggest that approach in
> > the first place, but I too would also prefer to see his official ack on
> > it.
>=20
> "Suggested approach" had been about inode_insert5() changes, right?

Right. I was talking about this patch (which I think is sane):

    fs: change test in inode_insert5 for adding to the sb list

> But that's fs/inode.c side of things...  I have to admit that I'd missed
> the unlining d_same_name() - exporting the sucker per se didn't look
> insane and I hadn't looked at that in details ;-/
>=20
> Looking at it now...  might be worth renaming it into __d_same_name(),
> leaving it inlined and exporting a wrapper; not sure if the impact on
> d_lookup()/__d_lookup()/d_alloc_parallel() is worth worrying about it,
> though.
>=20
> Profiling a case when we have a plenty of files in the same directory
> on tmpfs, with something earlier in the pathname to kick out of RCU
> mode (e.g. going through /proc/self/cwd) might be interesting...

The d_name_name changes seemed ok to me, but it would be good to have
your ack (or qualified NAK) if possible.

--=20
Jeff Layton <jlayton@kernel.org>
