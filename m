Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455404ED72F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiCaJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiCaJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:44:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442311D8315
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:42:27 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22V8sGQL020599;
        Thu, 31 Mar 2022 09:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=WPCIEKOGOxbgD3kRwImprKgQzLng/m2SyAvJQuPp6V4=;
 b=iq/8IpTboNsw2qrshfSjmWvbiW/ChVW5VK8GTfUr4yBVXwKcHBzwly0lvM1NcHlKfc8b
 crlU0UayNPnKy6iLwR26VGzhvtqTP+HFzmvxR4KksAPPkLCMG/VI4NJBVmV6LSKNoT4I
 xKb0n7dd0zuDw7Gp4HMhZaHnUoFP9fQmYNMqV+6ji9OeEYtvezvShnrUyX8oKt0pbarI
 +rqI4VfqrZzNvQcpMguscR1iOnR5pGbNJGb5t7exPVxWTwQa7DSiHb0xlwT0eGJtzanp
 f70ukiKl2+Bv0AE+Of960gyZWaSPG/ITouJ7gfKWo0vnFKNNxLMRKAlQVKsD1Th+ZT3b tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f562rmw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 09:42:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22V9b8Nx014636;
        Thu, 31 Mar 2022 09:42:13 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f562rmw6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 09:42:13 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22V9fSpf025701;
        Thu, 31 Mar 2022 09:42:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3f1tf90uyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 09:42:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22V9gE3C42336748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 09:42:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65952A405B;
        Thu, 31 Mar 2022 09:42:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F4FCA4054;
        Thu, 31 Mar 2022 09:42:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.144.204])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 31 Mar 2022 09:42:06 +0000 (GMT)
Date:   Thu, 31 Mar 2022 12:42:04 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     kernel test robot <lkp@intel.com>, Roman Gushchin <guro@fb.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Minchan Kim <minchan@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re:
 [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 4036/5872] WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in
 reference from the function memblock_bottom_up() to the variable
 .meminit.data:memblock
Message-ID: <YkV3bCqtLaVH+mC7@linux.ibm.com>
References: <202203301412.MZ7wQvQz-lkp@intel.com>
 <YkTP/+jhhAX6xlAQ@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkTP/+jhhAX6xlAQ@carbon.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ihh56QH7Def_i5PNnurIYBjwTTybEFOK
X-Proofpoint-ORIG-GUID: KFDrNZ5oYnuEr9lVqDjlhUbjbVbEtXWT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_03,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added llvm folks)

Hi,

On Wed, Mar 30, 2022 at 02:47:43PM -0700, Roman Gushchin wrote:
> On Wed, Mar 30, 2022 at 02:53:14PM +0800, kbuild test robot wrote:
> > Hi Roman,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
> > head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
> > commit: 0e0bfc41fdf4d79d39ebe929844cdee44f97366d [4036/5872] UPSTREAM: mm: cma: allocate cma areas bottom-up
> > config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220330/202203301412.MZ7wQvQz-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/ammarfaizi2/linux-block/commit/0e0bfc41fdf4d79d39ebe929844cdee44f97366d
> >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> >         git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
> >         git checkout 0e0bfc41fdf4d79d39ebe929844cdee44f97366d
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the variable .meminit.data:memblock
> > The function memblock_bottom_up() references
> > the variable __meminitdata memblock.
> > This is often because memblock_bottom_up lacks a __meminitdata
> > annotation or the annotation of memblock is wrong.
> 
> I guess this patch should fix it, however I fail to reproduce the original issue.
> Maybe it's up to the specific compiler version.
> 
> --
> 
> From b55a8dd19f4156d7e24ec39b18ede06965ce1c4f Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Wed, 30 Mar 2022 14:42:12 -0700
> Subject: [PATCH] memblock: fix memblock_bottom_up() and
>  memblock_set_bottom_up() annotations
> 
> memblock_bottom_up() and memblock_set_bottom_up() lack __meminitdata
> annotations causing compiler warnings like:
>   WARNING: modpost: vmlinux.o(.text+0x4111c4): Section mismatch in reference from the function memblock_bottom_up() to the
>   variable .meminit.data:memblock
> 
> Fix it by adding the missing annotation and removing the wrong
> __meminit annotation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memblock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 50ad19662a32..536bc2fc31e6 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -460,7 +460,7 @@ static inline void *memblock_alloc_node(phys_addr_t size,
>  /*
>   * Set the allocation direction to bottom-up or top-down.
>   */
> -static inline __init_memblock void memblock_set_bottom_up(bool enable)
> +static inline __initdata_memblock void memblock_set_bottom_up(bool enable)

I think putting __initdata_memlock won't help here, because there should be
nothing wrong with __meminit function accessing __meminitdata data.

My guesstimate would be that the compiler decided not to inline this and
still dropped section attribute because of 'inline'.

If this is the case we I think we should 

	s/inline __init_memblock/__always_inline/

>  {
>  	memblock.bottom_up = enable;
>  }
> @@ -470,7 +470,7 @@ static inline __init_memblock void memblock_set_bottom_up(bool enable)
>   * if this is true, that said, memblock will allocate memory
>   * in bottom-up direction.
>   */
> -static inline __init_memblock bool memblock_bottom_up(void)
> +static inline __initdata_memblock bool memblock_bottom_up(void)
>  {
>  	return memblock.bottom_up;
>  }
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
