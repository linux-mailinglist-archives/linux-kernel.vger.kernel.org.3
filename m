Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA35A7444
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiHaDJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiHaDJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:09:21 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B893BAE847
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 20:09:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661915357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+3ORk9w0/P8hMy0Rd0PJ5O8aOfIB0XvybrmSgQilEU=;
        b=cPM+ReclE4FItUUB6STpSHjWCfinlVZbVvQKPf3AUXF422+uFW6nMaYvbE6JT9sFVYB5zd
        2X5Q2JZM0pWA2Z2gG+pIM/E5yf9JFgF1pvXeRvPQ8sjkhONl7LbjIXrihB7zuTFmzvxFc2
        kmKRyWLrmUziPibEyosNe2TTwi4WHqo=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220830141009.150075-1-chao@kernel.org>
Date:   Wed, 31 Aug 2022 11:09:09 +0800
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BAC9CE6A-5873-429F-ACE2-E0A9E507D807@linux.dev>
References: <20220830141009.150075-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2022, at 22:10, Chao Yu <chao@kernel.org> wrote:
>=20
> From: Chao Yu <chao.yu@oppo.com>
>=20
> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
> out-of-memory, if it fails, return errno correctly rather than
> triggering panic via BUG_ON();

I tend to agree with you. A mount operation shouldn=E2=80=99t panic the
kernel.

>=20
> kernel BUG at mm/slub.c:5893!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>=20
> Call trace:
> sysfs_slab_add+0x258/0x260 mm/slub.c:5973
> __kmem_cache_create+0x60/0x118 mm/slub.c:4899
> create_cache mm/slab_common.c:229 [inline]
> kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
> kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
> f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
> f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
> f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
> mount_bdev+0x1b8/0x210 fs/super.c:1400
> f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
> legacy_get_tree+0x30/0x74 fs/fs_context.c:610
> vfs_get_tree+0x40/0x140 fs/super.c:1530
> do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
> path_mount+0x358/0x914 fs/namespace.c:3370
> do_mount fs/namespace.c:3383 [inline]
> __do_sys_mount fs/namespace.c:3591 [inline]
> __se_sys_mount fs/namespace.c:3568 [inline]
> __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
>=20
> Cc: <stable@kernel.org>
> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
> Signed-off-by: Chao Yu <chao.yu@oppo.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

