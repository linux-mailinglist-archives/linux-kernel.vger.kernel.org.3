Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448E751F467
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiEIGUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiEIGIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:08:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF816F928
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:05:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so24695416ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sw7Zi7DGMrbELjm7YLKrP67Ls5mBx8gONxvhPDCVqiI=;
        b=Ng8JEmBqJoXz5M2EIEc+wmxB3NQaIwlSqGBmKZJIV2UmBRJM4tYn7cRX0rQVc8uvH5
         neMfG7X75w6VCp3u2CyxuUsz/C1hwUor/LUM5u6Z2/ktXOe0/3w7IOAoqleLWG02KUC1
         e9VNaCXLcjZiYe048X7cVOVmd/kFzzH8BFI4WUPNGhWcXQzzEOWoFIlFBaeDLjgqXsnX
         L0TlvIPbDhMXLxgKf+x2Qp3SgcD35F0hV6GNh0Di/LJn757M97a1KmPDBtZT42IgtmJE
         dWVwDBVfqiWRBsfH2pByWzIr4DZVBLdhbcKGDrB2pgD4fLZxHwDF61ouRiFaed96Cgwk
         vjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw7Zi7DGMrbELjm7YLKrP67Ls5mBx8gONxvhPDCVqiI=;
        b=JdC+rssStoZahCEzdBTu3bl3Ph1KAgdcCMafICg3el4gEN0sdsEZdWE+bREIvt1iMW
         gkqqozIrjYcObh7ckIODhHFAD49+4PcS9P5/mZume5i5PBzsby2BFqspMAjX29x3TwVO
         iR9buepgeQF5QXFdB2tVYMvf17POy+Gs78RH5b+ASmRxlIFOhzsjZ143bJ78AEv5IEu5
         u++PHjPVFOuHHqodivzY6RGZZ41NL53uEfvLnmf/aW9y7KS1L+vaNpIEmZhFUiClUXtK
         vk0WRM7KLjSINmiG5hD6hE4xnc79/BzCQ5N/CnBCelLLq74uoEilxnkva4MZvc7glifv
         PAXw==
X-Gm-Message-State: AOAM531OpJktmXhBidfgaCHgdZAPZl5dSkKQ+TeCNQYF0dgTgRa0daBg
        oCaH+yzDUwTzBIIaA9DfI06tWXsz6U0=
X-Google-Smtp-Source: ABdhPJw7j0lHvKP9Jf8Naz3+QQ8P1iZeqT2k1y84YAJOfw2+2NexcJencU/x29LUbu0n54pHV4mJHQ==
X-Received: by 2002:a17:907:c02:b0:6df:fb64:2770 with SMTP id ga2-20020a1709070c0200b006dffb642770mr13303735ejc.221.1652076300205;
        Sun, 08 May 2022 23:05:00 -0700 (PDT)
Received: from leap.localnet (host-79-53-109-4.retail.telecomitalia.it. [79.53.109.4])
        by smtp.gmail.com with ESMTPSA id qr48-20020a1709068cb000b006f3ef214e5csm4753556ejc.194.2022.05.08.23.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 23:04:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] fs/ufs: Replace kmap() with kmap_local_page()
Date:   Mon, 09 May 2022 08:04:54 +0200
Message-ID: <11975023.O9o76ZdvQC@leap>
In-Reply-To: <202205090729.mU23mv8h-lkp@intel.com>
References: <20220508200755.24586-1-fmdefrancesco@gmail.com> <202205090729.mU23mv8h-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 9 maggio 2022 01:44:13 CEST kernel test robot wrote:
> Hi "Fabio,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.18-rc6 next-20220506]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Frances=
co/fs-ufs-Replace-kmap-with-kmap_local_page/20220509-040920
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
linux.git e3de3a1cda5fdc3ac42cb0d45321fb254500595f
> config: arm-randconfig-s032-20220508 (https://download.01.org/0day-ci/
archive/20220509/202205090729.mU23mv8h-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/
sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/intel-lab-lkp/linux/commit/
e73d9919e2725b216318d5d02b8a184876ab3b11
>         git remote add linux-review https://github.com/intel-lab-lkp/
linux
>         git fetch --no-tags linux-review Fabio-M-De-Francesco/fs-ufs-
Replace-kmap-with-kmap_local_page/20220509-040920
>         git checkout e73d9919e2725b216318d5d02b8a184876ab3b11
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cro=
ss=20
C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3Dbuild_dir ARCH=3Dar=
m=20
SHELL=3D/bin/bash fs/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>    fs/ufs/namei.c: note: in included file:
> >> fs/ufs/ufs.h:114:32: sparse: sparse: marked inline, but without a=20
definition
> >> fs/ufs/ufs.h:114:32: sparse: sparse: marked inline, but without a=20
definition
> >> fs/ufs/ufs.h:114:32: sparse: sparse: marked inline, but without a=20
definition
>=20
> vim +114 fs/ufs/ufs.h
>=20
>     99=09
>    100	/* dir.c */
>    101	extern const struct inode_operations ufs_dir_inode_operations;
>    102	extern int ufs_add_link (struct dentry *, struct inode *);
>    103	extern ino_t ufs_inode_by_name(struct inode *, const struct qstr=20
*);
>    104	extern int ufs_make_empty(struct inode *, struct inode *);
>    105	extern struct ufs_dir_entry *ufs_find_entry(struct inode *, const=
=20
struct qstr *,
>    106						    struct page=20
**, void **);
>    107	extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry=20
*, struct page *,
>    108				    char *);
>    109	extern int ufs_empty_dir (struct inode *);
>    110	extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct=20
page **, void **);
>    111	extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry=20
*de,
>    112				 struct page *page, void=20
*page_addr,
>    113				 struct inode *inode, bool=20
update_times);
>  > 114	extern inline void ufs_put_page(struct page *page, void=20
*page_addr);
>    115=09
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

This will be fixed in v2.

Thanks,

=46abio



