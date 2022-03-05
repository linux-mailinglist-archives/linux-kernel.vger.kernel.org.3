Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914F4CE548
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiCEOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:32:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CAC6243;
        Sat,  5 Mar 2022 06:32:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE542210FD;
        Sat,  5 Mar 2022 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646490726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pkewT5jbNnN2HTsBh7xuswvEese/PWWGAMR/fts6ok=;
        b=IwcC+H9NPeQDyRL96F6rjHmMP31gweE4oUUKFRxPkTu7CqkYfu0TkJXVhVESXE/4lYNCXr
        367uA1ClLwLDdnsg+YaFNE0P12Y/OkPRqi5mvEkdPZAQ3teV5j1JtFRLqlbknblqmcJRt9
        nUu2YfAuJmmKx0u+IFQyvCSuzZW+Zzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646490726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pkewT5jbNnN2HTsBh7xuswvEese/PWWGAMR/fts6ok=;
        b=jFcYZm4CnouZthNJTPfpiMqALiZuaAEFX/J3sKtcXHjONnlL7hPbnd9wG9EVqtXdgQDuiu
        DMUGSEVXXp3LIYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EDAE13519;
        Sat,  5 Mar 2022 14:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u5+tF2Z0I2IcWgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Sat, 05 Mar 2022 14:32:06 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 3f547f38;
        Sat, 5 Mar 2022 14:32:22 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ceph: fix use-after-free in ceph_readdir
References: <20220304161403.19295-1-lhenriques@suse.de>
        <20220304161403.19295-3-lhenriques@suse.de>
        <55c6363a0ef0dcca3e6a7c882783f5d47dbbbdc7.camel@kernel.org>
        <79cd6979-cb02-c0a3-a4e9-d66f65d78976@redhat.com>
Date:   Sat, 05 Mar 2022 14:32:22 +0000
In-Reply-To: <79cd6979-cb02-c0a3-a4e9-d66f65d78976@redhat.com> (Xiubo Li's
        message of "Sat, 5 Mar 2022 20:43:04 +0800")
Message-ID: <87h78co4g9.fsf@brahms.olymp>
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

Xiubo Li <xiubli@redhat.com> writes:

> On 3/5/22 2:20 AM, Jeff Layton wrote:
>> On Fri, 2022-03-04 at 16:14 +0000, Lu=C3=ADs Henriques wrote:
>>> After calling ceph_mdsc_put_request() on dfi->last_readdir, this field
>>> should be set to NULL, otherwise we may end-up freeing it twince and get
>>> the following splat:
>>>
>>>    refcount_t: underflow; use-after-free.
>>>    WARNING: CPU: 0 PID: 229 at lib/refcount.c:28 refcount_warn_saturate=
+0xa6/0xf0
>>>    ...
>>>    Call Trace:
>>>      <TASK>
>>>      ceph_readdir+0xd35/0x1460 [ceph]
>>>      ? _raw_spin_unlock+0x12/0x30
>>>      ? preempt_count_add+0x73/0xa0
>>>      ? _raw_spin_unlock+0x12/0x30
>>>      ? __mark_inode_dirty+0x27c/0x3a0
>>>      iterate_dir+0x7d/0x190
>>>      __x64_sys_getdents64+0x80/0x120
>>>      ? compat_fillonedir+0x160/0x160
>>>      do_syscall_64+0x43/0x90
>>>      entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>> ---
>>>   fs/ceph/dir.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>>> index 0bcb677d2199..934402f5e9e6 100644
>>> --- a/fs/ceph/dir.c
>>> +++ b/fs/ceph/dir.c
>>> @@ -555,6 +555,7 @@ static int ceph_readdir(struct file *file, struct d=
ir_context *ctx)
>>>   			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
>>>   			dout("filldir stopping us...\n");
>>>   			ceph_mdsc_put_request(dfi->last_readdir);
>>> +			dfi->last_readdir =3D NULL;
>>>   			err =3D 0;
>>>   			goto out;
>>>   		}
>> I think Xiubo fixed this in the testing branch late yesterday. It should
>> no longer be needed.
>
> Right and I have sent a new version of my previous patch to remove the bu=
ggy
> code.

Ok, cool.  This definitely proofs that my local branch wasn't updated :-)

(I really need to get rid of this mails/patches backlog.)

Cheers,
--=20
Lu=C3=ADs
