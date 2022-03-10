Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0A4D50AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbiCJRfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbiCJRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:35:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1018A783;
        Thu, 10 Mar 2022 09:34:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B943821118;
        Thu, 10 Mar 2022 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646933684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KDfpWUXGgNfwg4pSY2tFwPFDpbdq51qGNZu1umBHBc=;
        b=Y/2lVPlInBMkrgJSrPMjHHlOLqn6BrGzAizjvO9safctGhfDiHuVQndxq+p6nWyVW0A9qe
        SxgyKSGqd0hTqSHpv79Uf/XSFUQjJDOTD+qD+FC5K1LDwpw3JX1PhvaBPBi2AfMRYgJi8r
        eTvDtHVhu9JUDUa9fbulBk3q3S8XjIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646933684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KDfpWUXGgNfwg4pSY2tFwPFDpbdq51qGNZu1umBHBc=;
        b=jafbHF8U0MxchYh5bs34Hpq3mUAYqVpgCPedjIMwahSMukKrASxczdXGOA+GN3C4SQm6BV
        979YKxLretGua9Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55F7813A66;
        Thu, 10 Mar 2022 17:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jDUkEbQ2KmJbNAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 10 Mar 2022 17:34:44 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 7fb2f45e;
        Thu, 10 Mar 2022 17:34:58 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add support for snapshot names encryption
References: <20220310172616.16212-1-lhenriques@suse.de>
Date:   Thu, 10 Mar 2022 17:34:58 +0000
In-Reply-To: <20220310172616.16212-1-lhenriques@suse.de> (=?utf-8?Q?=22Lu?=
 =?utf-8?Q?=C3=ADs?= Henriques"'s
        message of "Thu, 10 Mar 2022 17:26:14 +0000")
Message-ID: <87ilsl7ltp.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lu=C3=ADs Henriques <lhenriques@suse.de> writes:

> Hi!
>
> So, I've changed this code back into and RFC as I'm not sure yet if this
> is it's final form.  I think the 2 patches in this series should probably
> be squashed into a single patch.  I decided to keep them separate as the
> 1st one is simple (it's the same patch I had already sent), and the 2nd
> patch adds a lot more complexity to the whole thing.
>
> So, I've looked at Xiubo initial patch for handling snapshots long names.
> It was complex, of course, and it required extra MDS changes.  I *think*
> my approach is slightly simpler, but I'm not entirely sure yet that I'm
> handling every case.
>
> In order to test this code the following PRs are required:
>
>   mds: add protection from clients without fscrypt support #45073
>   mds: use the whole string as the snapshot long name #45192
>   mds: support alternate names for snapshots #45224
>   mds: limit the snapshot names to 240 characters #45312
>
> Comments are welcome, I'm still testing these patches and I do expect to
> find that something is still missing.  And I do expect to find bugs.
> These strings parsing scares me a lot, but I couldn't see a simpler
> approach.

Again, I forgot to mention in the cover-letter that handling
base64-encoded snapshots that start with '_' is still missing.  That's
next on my list.

Cheers,
--=20
Lu=C3=ADs

>
> Lu=C3=ADs Henriques (2):
>   ceph: add support for encrypted snapshot names
>   ceph: add support for handling encrypted snapshot names in subtree
>
>  fs/ceph/crypto.c | 146 +++++++++++++++++++++++++++++++++++++++++------
>  fs/ceph/crypto.h |   9 ++-
>  fs/ceph/dir.c    |   9 +++
>  fs/ceph/inode.c  |  13 +++++
>  4 files changed, 156 insertions(+), 21 deletions(-)
>

