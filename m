Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA04CD915
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbiCDQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbiCDQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:27:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053451C3D11;
        Fri,  4 Mar 2022 08:26:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B85A02113B;
        Fri,  4 Mar 2022 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646411185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnu2uD85M6pG4RSbO3bHxRsefMWNjAfi8wTJU9h1F9M=;
        b=HtMlRf6D2KRtlwf+bykNHRTiXleeyGfGJyCdK9awWwRMLz3zADKjsEAnnAHQxT/v9r3mN+
        43iIq5CmCOdtHnYJLB3OtrS99XbY/EvoKk4X2YjWk3Ur3Cw3FiZEqwsLsV+pwx47+lBa2e
        GY/w/V/l7Dz+16UOLnJfB7XuqKBvXag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646411185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnu2uD85M6pG4RSbO3bHxRsefMWNjAfi8wTJU9h1F9M=;
        b=XJrU0kq4+ZC/0f/zKPJZqlLviAbda/PZJzbl3BkEs7UCUF0cOCsuvInCII5FVX00mK09Kg
        GCbWPBOnWQrFgdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5114613CE6;
        Fri,  4 Mar 2022 16:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RIfUELE9ImJGSwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 04 Mar 2022 16:26:25 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id f3a5c227;
        Fri, 4 Mar 2022 16:26:40 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ceph: minor fixes and encrypted snapshot names
References: <20220304161403.19295-1-lhenriques@suse.de>
Date:   Fri, 04 Mar 2022 16:26:40 +0000
In-Reply-To: <20220304161403.19295-1-lhenriques@suse.de> (=?utf-8?Q?=22Lu?=
 =?utf-8?Q?=C3=ADs?= Henriques"'s
        message of "Fri, 4 Mar 2022 16:14:00 +0000")
Message-ID: <87fsnx4rb3.fsf@brahms.olymp>
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
> I'm sending another iteration of the encrypted snapshot names patch.  This
> patch assumes PR#45224 [1] to be merged as it adds support for the
> alternate names.
>
> Two notes:
>
> 1. Patch 0001 is just a small fix from another fscrypt patch.  It's
>    probably better to simply squash it.
>
> 2. I'm not sure how easy it is to hit the UAF fixed by patch 0002.  I can
>    reproduce it easily by commenting the code that adds the
>    DCACHE_NOKEY_NAME flag in patch 0003.

Obviously, immediately after sending this patchset I realized I failed to
mention a very (*VERY*) important note:

Snapshot names can not start with a '_'.  I think the reason is related
with the 'long snapshot names', but I can't really remember the details
anymore.  The point is that an encrypted snapshot name base64-encoded
*may* end-up starting with an '_' as we're using the base64-url variant.

I really don't know if it's possible to fix that.  I guess that in that
case the user will get an error and fail to create the snapshot but he'll
be clueless because the reason.  Probably a warning can be added to the
kernel logs, but maybe there are other ideas.

Cheers,
--=20
Lu=C3=ADs


> Any comments are welcome (including for the PR mentioned above, of course=
).
>
> [1] https://github.com/ceph/ceph/pull/45224
>
> Lu=C3=ADs Henriques (3):
>   ceph: fix error path in ceph_readdir()
>   ceph: fix use-after-free in ceph_readdir
>   ceph: add support for encrypted snapshot names
>
>  fs/ceph/dir.c   | 11 ++++++++++-
>  fs/ceph/inode.c | 13 +++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
