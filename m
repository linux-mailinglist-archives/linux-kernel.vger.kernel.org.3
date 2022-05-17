Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC9F52A9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbiEQSEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351829AbiEQSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:04:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128550B14
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60097B81B34
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F73C385B8;
        Tue, 17 May 2022 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652810634;
        bh=s1iMz7QuBiDw43pk+NOy8/Yc/NUPlEEPpk7eS7YwCrY=;
        h=Subject:From:To:Cc:Date:From;
        b=cB7B7oNxEsB0a+xkB85HI/YPZJBBTjPh7QtWgxbion21LTNaZwHeVGHs+vaeTq9kd
         uqUxpjezleMl29nEueeMfJnjrLJp9f51TBZLIMToQFpt3/CAfKU8aKkLVdTApNYwBO
         bX3KZO+Ug0g0aNZBSDHsMAVSi7kXGPOsmj2xKwMfrG9iOyS1Z/m+Abr22KSrt//liq
         hnad9s4MYga0e3q7s3TX3Rgq2ZTe1hYySNV4oXd2m8QcZfSHgaFQIlbrbHn6ftpS5V
         diWd3hyaOBXKMFqkUZln/mv8NLopSQoolLXXqUYsx0JTvguXJ/WdgmHIxL3zzDDm5c
         EPXzVQZyLK75w==
Message-ID: <d2ad3a3d7bdd794c6efb562d2f2b655fb67756b9.camel@kernel.org>
Subject: new __write_overflow_field compiler warning
From:   Jeff Layton <jlayton@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 17 May 2022 14:03:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I'm hoping you can help with this. I recently updated to Fedora 36,
which has gcc v12, and I've started seeing this warning pop up when
compiling the ceph.ko:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/ceph/ceph_debug.h:7,
                 from fs/ceph/inode.c:2:
In function =E2=80=98fortify_memset_chk=E2=80=99,
    inlined from =E2=80=98netfs_i_context_init=E2=80=99 at ./include/linux/=
netfs.h:326:2,
    inlined from =E2=80=98ceph_alloc_inode=E2=80=99 at fs/ceph/inode.c:463:=
2:
./include/linux/fortify-string.h:242:25: warning: call to =E2=80=98__write_=
overflow_field=E2=80=99 declared with attribute warning: detected write bey=
ond size of field (1st parameter); maybe use struct_group()? [-Wattribute-w=
arning]
  242 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This doesn't seem to happen with gcc v11. It looks like the code is
doing the right thing. Is there something we need to fix how the netfs
context gets initialized or is this a compiler problem?

FWIW: I'm using:

    gcc (GCC) 12.1.1 20220507 (Red Hat 12.1.1-1)

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
