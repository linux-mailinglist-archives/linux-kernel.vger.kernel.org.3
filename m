Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5194D99EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347794AbiCOLGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347454AbiCOLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:06:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A784AE3F;
        Tue, 15 Mar 2022 04:05:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B94C1F391;
        Tue, 15 Mar 2022 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647342326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLw41+5ZpezMuacv/AvoLLnfRmTs4f7SFKLbMOQ9EHE=;
        b=TIwLVts1yxnG+OZnu+DV9cGy7HYnyfg9FtQnGTB85kg0yzl3wD7ZnPlqCAz4JE5phC5J/8
        kWHqX5IklI8S529vFe4vW6HNZgwOFk35aBhINrUrl6Fro/9Gw9P3NenimTAYNs3Re/Zz7c
        cOVlikcEdRsr6liomhrnF4q3onP3L/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647342326;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLw41+5ZpezMuacv/AvoLLnfRmTs4f7SFKLbMOQ9EHE=;
        b=/7HkYtB7PZa6MhXq9CWPbStm9v5g93QOCKXL5gzJfUnwhonXPIWFX0Gx9PSQ3sFTwWILoc
        5285/E0NU8PlDGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0A4713EDD;
        Tue, 15 Mar 2022 11:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RM3hK/VyMGKHLQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 15 Mar 2022 11:05:25 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id fa79eb4c;
        Tue, 15 Mar 2022 11:05:43 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] ceph: add support for encrypted snapshot names
References: <20220310172616.16212-1-lhenriques@suse.de>
        <20220310172616.16212-2-lhenriques@suse.de>
        <fdf774cd-3cca-14e5-d5aa-44de70bb89f0@redhat.com>
        <2d69e6dd-b047-13fe-7dc5-2c64190e0e8a@redhat.com>
        <cff2b7ac-d4bb-4096-06a9-79b41b31a57a@redhat.com>
        <87o8288jwd.fsf@brahms.olymp>
        <7aedb4b9-11e4-cfa1-986f-75cf8706c6c0@redhat.com>
Date:   Tue, 15 Mar 2022 11:05:43 +0000
In-Reply-To: <7aedb4b9-11e4-cfa1-986f-75cf8706c6c0@redhat.com> (Xiubo Li's
        message of "Tue, 15 Mar 2022 15:28:48 +0800")
Message-ID: <87ee33jx14.fsf@brahms.olymp>
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
<...>
> I think there has one simple way. Just think about without setting the
> fscrypt_auth for the '.snap' dir's inode, that is without your this=20
> patch it works well.
>
> That's because when we create a snapshot under '.snap' dir, since the '.s=
nap'
> dir related inode doesn't have the fscrypt_auth been filled, so when crea=
ting a
> new inode for the snapshot it won't fill the fscrypt_auth for the new ino=
de. And
> then in the handle_reply() it can fill the fscrypt auth as expected.
>
> You can make sure that in the ceph_new_inode() just skip setting the
> fscrypt_auth for the new inode if the parent dir is a snapdir, that is=20
> '.snap/'. And this will just leave it to be filled in the handle_reply().

Ah! That's it!  Great suggestion, I'll go test this and send out a new
version later.  (And I think I'll need to rebase my patches on top of the
latest changes too.)

Cheers,
--=20
Lu=C3=ADs
