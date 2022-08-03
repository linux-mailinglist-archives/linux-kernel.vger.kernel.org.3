Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D425589421
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiHCVrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D081167C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659563268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g5uD7GSiugR//AbWEYTlGaC1DztD7rLesYw/5UTNxzU=;
        b=A/bSjWP8GK9d9Edsb7UaFg6mOeuTN2bBiEZYx80PLIQekj1fFeYX561mgc4m1W6pCFIcEZ
        1TdqRKssL6nPEonWEgwZjkNSV1ZPv9gBVPLd5mH3cbUilHLxsfVP13gHKwfchFSQtECk6c
        Dqm3Z9+xrGv9v3xV/VALj95SyLxWFcM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-Flu34mOwNsSTK1Wtwd0rhA-1; Wed, 03 Aug 2022 17:47:47 -0400
X-MC-Unique: Flu34mOwNsSTK1Wtwd0rhA-1
Received: by mail-qv1-f70.google.com with SMTP id ea7-20020ad458a7000000b00476b8d9bfdcso5168658qvb.18
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 14:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g5uD7GSiugR//AbWEYTlGaC1DztD7rLesYw/5UTNxzU=;
        b=4NsSBdCuTLJ9Xwb+MTG6zhhiyfJnvS/PLnZsMXNM1De653m3CALojUzsPamz9Z3ep2
         F9Kz1x4pODJKEgCPj3JfhBiQWefhHjx6ri8t/BVLNcM1V5ZM46SLroVhJg6XUG+XrZHY
         +semD35vZn62WYBVUto+x+T88N5gP4V9FID9AcU2Qj0Vx7lmYEYg/5c1wDQQUUncLBo4
         2rKU43GhhxcLuXOhNorqDXyacuZ4KShalvUM4wTohMwUIpomZv5I5opML9kqPVaQBY+Y
         SyfWUrhWAfedHUCfoy7vmTQ5JJaJ/u9ibJmYJYg2zlATvP9AGI5c5y2IE+Sh9Ps04VBz
         kbRw==
X-Gm-Message-State: ACgBeo1SyTB6UM2HyEoWrHHF3uDy1YDIdMyLafifdcup27/7CmtChOE6
        xxoxkisg642QUf21kTS/u6/KdL5QhaoUiWCogfDemDPR/u4pR1p+9THePVYM71ijlWaOewig73P
        HDXF9QEiLm2L+YpKzTnHuZxRp
X-Received: by 2002:a0c:9124:0:b0:473:be1e:b11d with SMTP id q33-20020a0c9124000000b00473be1eb11dmr24163954qvq.20.1659563266912;
        Wed, 03 Aug 2022 14:47:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/gRpPz8gLgLfIEYyRXhCQb2VYGd3wNqztIznBSwaTIiI4cLk8hTAC1nnQQJ0h//cPezJe6w==
X-Received: by 2002:a0c:9124:0:b0:473:be1e:b11d with SMTP id q33-20020a0c9124000000b00473be1eb11dmr24163938qvq.20.1659563266681;
        Wed, 03 Aug 2022 14:47:46 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a284a00b006b5cb0c512asm13963191qkp.101.2022.08.03.14.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:47:46 -0700 (PDT)
Date:   Wed, 3 Aug 2022 17:47:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
Message-ID: <YurtAFQ9xfZ7KfOF@xz-m1.local>
References: <20220803012159.36551-3-peterx@redhat.com>
 <202208032031.PVcMB0Hr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202208032031.PVcMB0Hr-lkp@intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 08:21:43PM +0800, kernel test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-Remember-young-bit-for-migration-entries/20220803-092311
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: openrisc-randconfig-r016-20220803 (https://download.01.org/0day-ci/archive/20220803/202208032031.PVcMB0Hr-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/2fca6cb25745d1404fc34e0ec2ea89b6195a8c27
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Peter-Xu/mm-Remember-young-bit-for-migration-entries/20220803-092311
>         git checkout 2fca6cb25745d1404fc34e0ec2ea89b6195a8c27
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    or1k-linux-ld: mm/rmap.o: in function `migration_entry_supports_young':
> >> include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
>    include/linux/swapops.h:288:(.text+0x31a0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `max_swapfile_size'
>    or1k-linux-ld: mm/migrate.o: in function `migration_entry_supports_young':
> >> include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
>    include/linux/swapops.h:288:(.text+0x158): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `max_swapfile_size'

Hmm, a bit surprised to know swapops.h will be used without CONFIG_SWAP..
I'll squash this in the next version (if not going via a page flag based
approach):

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 9ddede3790a4..d689f59479c3 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -285,7 +285,11 @@ static inline bool migration_entry_supports_young(void)
         * entry has the offset larger than storing the PFN value, then it
         * means there's extra bit(s) where we can store the young bit.
         */
+#ifdef CONFIG_SWAP
        return max_swapfile_size() > SWP_MIG_YOUNG_BIT;
+#else
+       return false;
+#endif
 }
 
 static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)

-- 
Peter Xu

