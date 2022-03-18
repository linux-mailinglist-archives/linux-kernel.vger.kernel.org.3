Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466A24DD764
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiCRJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiCRJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE1DD129248
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647597195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2Vf7q2asHFKoMM8PRSbFSspV/nKtVI304vE7VqFgcw=;
        b=D3zADZ4B7MkMwldKQoodO7KfcGswhdtT9/6XDMTP03hYEJ9lngkrm98sGNMVtJWd3pC3hk
        EEQA4iGfWEkGS7zZJ1dUM7NYYausvMxL6yX/B0pyrdPYyyZMTH278uYdDqPZ2FvX0mz1LE
        4hhPvrbUXHvFY5Z7vvn01HkVI3hOHxE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-Fu8Z7CXuMy-3m8KpX5nntg-1; Fri, 18 Mar 2022 05:53:14 -0400
X-MC-Unique: Fu8Z7CXuMy-3m8KpX5nntg-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso4621361edh.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w2Vf7q2asHFKoMM8PRSbFSspV/nKtVI304vE7VqFgcw=;
        b=ujjq56lEO1xFVf8MxIGtNCrrU5Rf5o7yXn4qT937Uo0b/j5Ry8CdF+k/h9g/o/RXft
         UryZlpSJy/69HtChWxDqlqPfIcWIWLd3+o73Hymjhai+8/50PpaUanrrfQ2U4dMk0yW3
         EcHquzzjG/1drMyeEuvwaarbJ45a8kjv4KIyUnjcMuUP+3smdOWo92/rj2jZ6eaSV/Sn
         nSnOvJACoQECleoTKjBHZsMdIsruuGe5qPLaBO2KJ+xkR6/BDkNdOqrJqqIICsdvnI+v
         v8WsOxh4a+qP+8i3fJNgu/LAlSYF88diH8OOcBtKw11eIWfBkiKyaxGMR9PqNuNXRc/j
         7nFg==
X-Gm-Message-State: AOAM531gK2AYa8c4gpp2JOLRGzMfa+uBQy0coU4xhED8NX3M4KKFbSuY
        XU3FZlyEc3l6yn5WdHaF5vLEgjqanp8ojy8dN25U+48Xt1Pbf/0sX2izMiGunY8xJWA+AdsK60/
        1TXlnlmhZ0rgBhcrpbXlUFjC2CjUWj4klumBzNpKx
X-Received: by 2002:a50:a6c8:0:b0:418:60c9:6a6a with SMTP id f8-20020a50a6c8000000b0041860c96a6amr8524493edc.327.1647597193230;
        Fri, 18 Mar 2022 02:53:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaoDA2ww64B9mRA8nCBiVUzqr4LEOTKGBudSHf52rVNphj9Hlq8H1Z4Mus0ZQBj8Z1m6iGtkjL+DYfIljMQ+8=
X-Received: by 2002:a50:a6c8:0:b0:418:60c9:6a6a with SMTP id
 f8-20020a50a6c8000000b0041860c96a6amr8524469edc.327.1647597192926; Fri, 18
 Mar 2022 02:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <202203181425.lKRZyrao-lkp@intel.com>
In-Reply-To: <202203181425.lKRZyrao-lkp@intel.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 18 Mar 2022 05:52:36 -0400
Message-ID: <CALF+zOmjdFV4GVc2-v2yTh+gTSePR9=jsBdJ09_XhySPnW=OCA@mail.gmail.com>
Subject: Re: [trondmy-nfs-2.6:testing 52/72] fs/nfs/fscache.c:231:71: error:
 'nfsi' undeclared
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 2:51 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
> head:   2fd93b6b58106aa3bc5a70739ba0f86cfee8fda9
> commit: 45f3a70ba68e1fc7fe0edde731b08d85435da30d [52/72] NFS: Cleanup usa=
ge of nfs_inode in fscache interface
> config: arm-allmodconfig (https://download.01.org/0day-ci/archive/2022031=
8/202203181425.lKRZyrao-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/t=
rondmy/nfs-2.6.git
>         git fetch --no-tags trondmy-nfs-2.6 testing
>         git checkout 45f3a70ba68e1fc7fe0edde731b08d85435da30d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cro=
ss O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash fs/nfs/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> Note: the trondmy-nfs-2.6/testing HEAD 2fd93b6b58106aa3bc5a70739ba0f86cfe=
e8fda9 builds fine.
>       It only hurts bisectability.
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/kernel.h:29,
>                     from fs/nfs/fscache.c:9:
>    fs/nfs/fscache.c: In function 'nfs_fscache_open_file':
> >> fs/nfs/fscache.c:231:71: error: 'nfsi' undeclared (first use in this f=
unction)
>      231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling ca=
che\n", nfsi);
>          |                                                               =
        ^~~~
>    include/linux/printk.h:418:33: note: in definition of macro 'printk_in=
dex_wrap'
>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                 =
          \
>          |                                 ^~~~~~~~~~~
>    include/linux/sunrpc/debug.h:40:17: note: in expansion of macro 'print=
k'
>       40 |                 printk(KERN_DEFAULT fmt, ##__VA_ARGS__);      =
          \
>          |                 ^~~~~~
>    fs/nfs/fscache.c:231:17: note: in expansion of macro 'dfprintk'
>      231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling ca=
che\n", nfsi);
>          |                 ^~~~~~~~
>    fs/nfs/fscache.c:231:71: note: each undeclared identifier is reported =
only once for each function it appears in
>      231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling ca=
che\n", nfsi);
>          |                                                               =
        ^~~~
>    include/linux/printk.h:418:33: note: in definition of macro 'printk_in=
dex_wrap'
>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                 =
          \
>          |                                 ^~~~~~~~~~~
>    include/linux/sunrpc/debug.h:40:17: note: in expansion of macro 'print=
k'
>       40 |                 printk(KERN_DEFAULT fmt, ##__VA_ARGS__);      =
          \
>          |                 ^~~~~~
>    fs/nfs/fscache.c:231:17: note: in expansion of macro 'dfprintk'
>      231 |                 dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling ca=
che\n", nfsi);
>          |                 ^~~~~~~~
>
>
> vim +/nfsi +231 fs/nfs/fscache.c
>
> ef79c097bbe9724 David Howells    2009-04-03  200
> ef79c097bbe9724 David Howells    2009-04-03  201  /*
> f1fe29b4a02d080 David Howells    2013-09-27  202   * Enable or disable ca=
ching for a file that is being opened as appropriate.
> f1fe29b4a02d080 David Howells    2013-09-27  203   * The cookie is alloca=
ted when the inode is initialised, but is not enabled at
> f1fe29b4a02d080 David Howells    2013-09-27  204   * that time.  Enableme=
nt is deferred to file-open time to avoid stat() and
> f1fe29b4a02d080 David Howells    2013-09-27  205   * access() thrashing t=
he cache.
> f1fe29b4a02d080 David Howells    2013-09-27  206   *
> f1fe29b4a02d080 David Howells    2013-09-27  207   * For now, with NFS, o=
nly regular files that are open read-only will be able
> ef79c097bbe9724 David Howells    2009-04-03  208   * to use the cache.
> f1fe29b4a02d080 David Howells    2013-09-27  209   *
> f1fe29b4a02d080 David Howells    2013-09-27  210   * We enable the cache =
for an inode if we open it read-only and it isn't
> f1fe29b4a02d080 David Howells    2013-09-27  211   * currently open for w=
riting.  We disable the cache if the inode is open
> f1fe29b4a02d080 David Howells    2013-09-27  212   * write-only.
> f1fe29b4a02d080 David Howells    2013-09-27  213   *
> f1fe29b4a02d080 David Howells    2013-09-27  214   * The caller uses the =
file struct to pin i_writecount on the inode before
> f1fe29b4a02d080 David Howells    2013-09-27  215   * calling us when a fi=
le is opened for writing, so we can make use of that.
> f1fe29b4a02d080 David Howells    2013-09-27  216   *
> f1fe29b4a02d080 David Howells    2013-09-27  217   * Note that this may b=
e invoked multiple times in parallel by parallel
> f1fe29b4a02d080 David Howells    2013-09-27  218   * nfs_open() functions=
.
> ef79c097bbe9724 David Howells    2009-04-03  219   */
> f1fe29b4a02d080 David Howells    2013-09-27  220  void nfs_fscache_open_f=
ile(struct inode *inode, struct file *filp)
> ef79c097bbe9724 David Howells    2009-04-03  221  {
> 402cb8dda949d9b David Howells    2018-04-04  222        struct nfs_fscach=
e_inode_auxdata auxdata;
> f1fe29b4a02d080 David Howells    2013-09-27  223        struct fscache_co=
okie *cookie =3D nfs_i_fscache(inode);
> a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  224        bool open_for_wri=
te =3D inode_is_open_for_write(inode);
> ef79c097bbe9724 David Howells    2009-04-03  225
> f1fe29b4a02d080 David Howells    2013-09-27  226        if (!fscache_cook=
ie_valid(cookie))
> f1fe29b4a02d080 David Howells    2013-09-27  227                return;
> ef79c097bbe9724 David Howells    2009-04-03  228
> a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  229        fscache_use_cooki=
e(cookie, open_for_write);
> a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  230        if (open_for_writ=
e) {
> f1fe29b4a02d080 David Howells    2013-09-27 @231                dfprintk(=
FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
> 45f3a70ba68e1fc Dave Wysochanski 2022-03-01  232                nfs_fscac=
he_update_auxdata(&auxdata, inode);
> a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  233                fscache_i=
nvalidate(cookie, &auxdata, i_size_read(inode),
> a6b5a28eb56c3f4 Dave Wysochanski 2020-11-14  234                         =
          FSCACHE_INVAL_DIO_WRITE);
> ef79c097bbe9724 David Howells    2009-04-03  235        }
> ef79c097bbe9724 David Howells    2009-04-03  236  }
> f1fe29b4a02d080 David Howells    2013-09-27  237  EXPORT_SYMBOL_GPL(nfs_f=
scache_open_file);
> 545db45f0fc0d42 David Howells    2009-04-03  238
>
> :::::: The code at line 231 was first introduced by commit
> :::::: f1fe29b4a02d0805aa7d0ff6b73410a9f9316d69 NFS: Use i_writecount to =
control whether to get an fscache cookie in nfs_open()
>
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>
>
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

Apologies for the oversight.
Fixing this requires adding a 1 liner to the patch in question, then
removing it after a few patches.

Add the below 1-liner on top commit:
45f3a70ba68e1fc7fe0edde731b08d85435da30d [52/72] NFS: Cleanup usage of
nfs_inode in fscache interface

commit bfec475e971304a737acd1fd9e4cbbb37f0f7eff (HEAD -> trond-testing)
Author: Dave Wysochanski <dwysocha@redhat.com>
Date:   Fri Mar 18 05:36:11 2022 -0400

    NFS: Fix bisectability of 'Cleanup usage of nfs_inode in fscache interf=
ace'

    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 81bd2770e640..2e77f0d9ebf4 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -220,6 +220,7 @@ void nfs_fscache_clear_inode(struct inode *inode)
 void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 {
        struct nfs_fscache_inode_auxdata auxdata;
+       struct nfs_inode *nfsi =3D NFS_I(inode);
        struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
        bool open_for_write =3D inode_is_open_for_write(inode);


Then remove the line in the 4th patch in my series to avoid a warning
on an unused variable:

commit bb1dd0ecedba4a75889894ecce560558720c39f5 (HEAD -> trond-testing)
Author: Dave Wysochanski <dwysocha@redhat.com>
Date:   Fri Mar 18 05:48:29 2022 -0400

    NFS: Fix build error on 'Remove remaining dfprintks related to fscache'

    Fixes the following build error:
    fs/nfs/fscache.c: In function =E2=80=98nfs_fscache_open_file=E2=80=99:
    fs/nfs/fscache.c:215:27: warning: unused variable =E2=80=98nfsi=E2=80=
=99 [-Wunused-variable]
      215 |         struct nfs_inode *nfsi =3D NFS_I(inode);
          |                           ^~~~

    Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e427f3343f0f..4dee53ceb941 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -212,7 +212,6 @@ void nfs_fscache_clear_inode(struct inode *inode)
 void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 {
        struct nfs_fscache_inode_auxdata auxdata;
-       struct nfs_inode *nfsi =3D NFS_I(inode);
        struct fscache_cookie *cookie =3D nfs_i_fscache(inode);
        bool open_for_write =3D inode_is_open_for_write(inode);

