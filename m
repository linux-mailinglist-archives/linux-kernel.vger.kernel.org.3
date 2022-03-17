Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6B4DC258
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiCQJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiCQJKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0547FE6161
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647508139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rEgtrLnyAIPwql7el4ksZ93xm8i72N7vX12uNHKsLPU=;
        b=WSe4tm2djixvGWDN1/QzXVKwLOiXyT5pImlLJQImt0VeYDvM9ANcJXP+lybrQFCMhr4Yco
        0UtnHIqTd5v/SPSK6HfdtjRO4sAqmWt5vdu4RTklPNsEa/J++xG4Oaft44cvkZizEveqhG
        TIk1ztgimq+nu5KW54ym/X/9IGsNs3U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-OLjCZeqtOw6OCPqiu4y6TA-1; Thu, 17 Mar 2022 05:08:57 -0400
X-MC-Unique: OLjCZeqtOw6OCPqiu4y6TA-1
Received: by mail-wr1-f70.google.com with SMTP id e6-20020a5d4e86000000b001f045d4a962so1326410wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEgtrLnyAIPwql7el4ksZ93xm8i72N7vX12uNHKsLPU=;
        b=TGJH4FCUx7fa31X9C2YUySQTaNbJo7laoDFRCqm8Sp7ZuXBhZ2CsrLYKzOvQbYh9vp
         xJilyoXwo1nQYgid8zl0vETj36+08MmFS9W04dFgrGoFl868lRL2dqHmmB7xHgt4tG4p
         /MfdSaTekIJrPJZP1oPDP7VCWdq/NC2sJBT1bfZmOQIy6XPahSN6hxvMYArvw2oEiAbm
         h93fBi3d8hsCatsqmUUvKRIrCOaFmBwjQ4ceqe6WWovrUArIeHqnske78N6Jbs/ZnnAT
         FDkHaoOHDhfflg3HOmDvuLoQSl6KVcJq8R5RkuZ6vdUGNkigqtmLspEbfp8m4Bvu/PaZ
         VirQ==
X-Gm-Message-State: AOAM5331a2CeGBBnsL7zi5VFyuKoOcQPbjq9wgFA4u+e3GkcYS20enR1
        XyuW6zWvi3IVGPaR10AGadaodfuR7ejj9pynCqhNSLE9ZT2pQO5tskeWLeBynPVNiapqWLjWsf0
        Ik2lw4MBs5cF5Bmx12uUKEDV28QoNhvN98o1BHgaB
X-Received: by 2002:a05:6000:178c:b0:203:86a7:e49 with SMTP id e12-20020a056000178c00b0020386a70e49mr3179117wrg.640.1647508136322;
        Thu, 17 Mar 2022 02:08:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrJ2enNRjNFJ5gVFBBS+CMYk0beLWJ72G+IrbS7cK85VdZH4bLMtvd5fSgE/nGNcDAySl0c8swJ7oR+9naZCo=
X-Received: by 2002:a05:6000:178c:b0:203:86a7:e49 with SMTP id
 e12-20020a056000178c00b0020386a70e49mr3179097wrg.640.1647508136104; Thu, 17
 Mar 2022 02:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <202203170954.vFlMcTje-lkp@intel.com>
In-Reply-To: <202203170954.vFlMcTje-lkp@intel.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 17 Mar 2022 10:08:44 +0100
Message-ID: <CAHc6FU6O-8sjt5vpLDUk29Ogm5Y3rDxqZJfQNDC-pOEOH9oHeA@mail.gmail.com>
Subject: Re: [kbuild] [gfs2:for-next 9/11] fs/gfs2/file.c:796:24: sparse:
 unsigned int *
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 9:25 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git  for-next
> head:   a20050c14edf19add5a9588cb196bb00aa410650
> commit: 165d142ffacdef3e620819a1031df3d896aa29ab [9/11] gfs2: Fix should_fault_in_pages() logic
> config: sh-randconfig-s032-20220313 (https://download.01.org/0day-ci/archive/20220317/202203170954.vFlMcTje-lkp@intel.com/config )
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=165d142ffacdef3e620819a1031df3d896aa29ab
>         git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
>         git fetch --no-tags gfs2 for-next
>         git checkout 165d142ffacdef3e620819a1031df3d896aa29ab
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash fs/gfs2/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> sparse warnings: (new ones prefixed by >>)
>    fs/gfs2/file.c:796:24: sparse: sparse: incompatible types in comparison expression (different signedness):
> >> fs/gfs2/file.c:796:24: sparse:    unsigned int *
>    fs/gfs2/file.c:796:24: sparse:    int *
> >> fs/gfs2/file.c:796:24: sparse: sparse: cannot size expression
>
> vim +796 fs/gfs2/file.c
>
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  773  static inline bool should_fault_in_pages(ssize_t ret, struct iov_iter *i,
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  774                                    size_t *prev_count,
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  775                                    size_t *window_size)
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  776  {
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  777   size_t count = iov_iter_count(i);
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  778   size_t size, offs;
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  779
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  780   if (likely(!count))
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  781           return false;
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  782   if (ret <= 0 && ret != -EFAULT)
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  783           return false;
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  784   if (!iter_is_iovec(i))
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  785           return false;
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  786
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  787   size = PAGE_SIZE;
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  788   offs = offset_in_page(i->iov[0].iov_base + i->iov_offset);
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  789   if (*prev_count != count || !*window_size) {
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  790           int nr_dirtied;
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  791
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  792           size = ALIGN(offs + count, PAGE_SIZE);
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  793           size = min_t(size_t, size, SZ_1M);
> 00bfe02f479688 fs/gfs2/file.c     Andreas Gruenbacher 2021-10-18  794           nr_dirtied = max(current->nr_dirtied_pause -
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07  795                            current->nr_dirtied, 8);
> 165d142ffacdef fs/gfs2/file.c     Andreas Gruenbacher 2022-03-07 @796           size = min(size, nr_dirtied << PAGE_SHIFT);
>
> size is size_t so nr_dirtied needs to be size_t as well.  I'm surprised
> this compiles.  The min()/max() macros are supposed to trigger a compile
> error for type mismatches.

Already fixed, thanks.

Andreas

