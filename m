Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E74EDFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiCaRfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiCaRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EC61522C1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648748016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50Lm2+gUhcbOfOCwPpXSj381+JxolC9BpO77iX6eyvs=;
        b=ECvli7HJtdviDHUAbnaDPuL4nE9UK3GmKuMgRbmwTgUIqgBbjP6kQZ8Ng2GTiCu91bDoOI
        D0f1j23NIVa7tVOp7Dz9LtWsNIQ1DprbaFCVmG/RnZj1blLGHJDyPqiBX6aHfjcmBWqhgU
        CO831pctAZKiqHGsGXitOmWCIQuNDrw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-pn-eu29cPKewd4NApaAcjA-1; Thu, 31 Mar 2022 13:33:35 -0400
X-MC-Unique: pn-eu29cPKewd4NApaAcjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17DF11C0EDC6;
        Thu, 31 Mar 2022 17:33:32 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44A4E400E420;
        Thu, 31 Mar 2022 17:33:25 +0000 (UTC)
Message-ID: <3ffaa931-bc25-efff-173b-397824422842@redhat.com>
Date:   Thu, 31 Mar 2022 13:33:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mm/sparsemem: Fix 'mem_section' will never be NULL gcc
 12 warning
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220330205919.2713275-1-longman@redhat.com>
 <202203312327.XGeCiD5T-lkp@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <202203312327.XGeCiD5T-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 11:54, kernel test robot wrote:
> Hi Waiman,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on hnaz-mm/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/mm-sparsemem-Fix-mem_section-will-never-be-NULL-gcc-12-warning/20220331-050049
> base:   https://github.com/hnaz/linux-mm master
> config: arm-randconfig-c024-20220330 (https://download.01.org/0day-ci/archive/20220331/202203312327.XGeCiD5T-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/2098f1d78cde338e81b3ba596ea39f37824e496e
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Waiman-Long/mm-sparsemem-Fix-mem_section-will-never-be-NULL-gcc-12-warning/20220331-050049
>          git checkout 2098f1d78cde338e81b3ba596ea39f37824e496e
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash security/keys/encrypted-keys/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     In file included from include/linux/gfp.h:6,
>                      from include/linux/umh.h:4,
>                      from include/linux/kmod.h:9,
>                      from include/linux/module.h:17,
>                      from security/keys/encrypted-keys/encrypted.c:15:
>     security/keys/encrypted-keys/encrypted.c: In function 'derived_key_encrypt.constprop':
>>> include/linux/mmzone.h:1432:23: warning: array subscript 32 is outside array bounds of 'struct mem_section[32][1]' [-Warray-bounds]
>      1432 |         unsigned long map = section->section_mem_map;
>           |                       ^~~
>     include/linux/mmzone.h:1390:27: note: while referencing 'mem_section'
>      1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>           |                           ^~~~~~~~~~~
>
>
> vim +1432 include/linux/mmzone.h
>
> 29751f6991e845 Andy Whitcroft 2005-06-23  1429
> 29751f6991e845 Andy Whitcroft 2005-06-23  1430  static inline struct page *__section_mem_map_addr(struct mem_section *section)
> 29751f6991e845 Andy Whitcroft 2005-06-23  1431  {
> 29751f6991e845 Andy Whitcroft 2005-06-23 @1432  	unsigned long map = section->section_mem_map;
> 29751f6991e845 Andy Whitcroft 2005-06-23  1433  	map &= SECTION_MAP_MASK;
> 29751f6991e845 Andy Whitcroft 2005-06-23  1434  	return (struct page *)map;
> 29751f6991e845 Andy Whitcroft 2005-06-23  1435  }
> 29751f6991e845 Andy Whitcroft 2005-06-23  1436
>
This warning happens with !CONFIG_SPARSEMEM_VMEMMAP && CONFIG_SPARSEMEM. 
In this case, __section_mem_map_addr() is used only by __pfn_to_page() 
and __page_to_pfn().  My patch only modifies __nr_to_section. In this 
particular case, it is removing The !mem_section[32] check. Perhaps it 
is somewhat equivalent to a (sec >= 32) check for gcc 11.2. However, 
this check will cause a warning in gcc 12. I will update the patch to 
add an explicit (sec >= NR_SECTION_ROOTS) then.

Thanks,
Longman


