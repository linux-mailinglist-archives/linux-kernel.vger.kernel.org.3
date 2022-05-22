Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD6530137
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiEVGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiEVGPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:15:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998513C705
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:15:43 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t28so3471316pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jllyWuWeoq7lgbBX7gZVoDEy2R2rk3cOIHKyYS++UUY=;
        b=sWeUD/D1clhUErYbKOXtKqynTBLrkJB1uVVgoQA4sEi3itZZbUsHO22ls87JrxSjNm
         UeX464kzGuklpWcvHi5OyzkoEktjnBi79wR+4Tf3ERYxkA3NQ/LweHsV/OV0JX9QV+NG
         kxHSOC8uV+YWZ70C4qImSedkQqesGhIphdX33G3DbcdoVvBeb3VcHwZAqluVvRxX19kf
         zVSJMjirqSlFf3T75xoLrhs8wIMnbIyV2tiLdZ0659mTtGKICLopPrqoPHNKz4CkmJNW
         2m7V+DtsvSY+eU0SiIHHI0HzuKUIaqdN+bxieEFaqSglLDcCA7G1zPngCL4NmVjFeSCA
         IqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jllyWuWeoq7lgbBX7gZVoDEy2R2rk3cOIHKyYS++UUY=;
        b=fbE2ze8WQa6k1cvkOiTkq4h0L/lSYBX88/xHXM/7p0/HnbLTE4WnKCSpAb9kiLjCkC
         GIbJ7SoVd2ktghn/eqDFYpUswgW4Ng/a8L8O6sO7msmm0oq13ntTQRdXmoKeG2WKDN2Q
         0k1BZGQiC93LG/3CEOUXAZWjGW2fhyGJvLACjI1OqoeBVJ1549FQls1VJ7sOFmhzQDv2
         YZo1OZjnR+UEdNjfGHY7dDiYZxxEDbMyWFv1Ns8Sc87wJtrIaKDCoxBvFJY/hOSVMAeR
         2nPPuwZNX6L2RbhPzehx3xaf5uF6n2jf76ngCB2mc/sKE7x4ZUcSsds5AZ4eq5mvnP+E
         LVlQ==
X-Gm-Message-State: AOAM532z/jkef6/JqLSW8VTqLZWYZqyH5KA2RKc0YMdbRDAdd/K5VeWo
        12OBq/cNjNFNgBi6+cIn1O8UzQ==
X-Google-Smtp-Source: ABdhPJxAF+axv6wD4J6IBdMK5B2toBuQwMmUI2TzTVYd/f0rmMlL5qEwOSktLI58jMU6mHP+st8E+w==
X-Received: by 2002:a63:181:0:b0:3f6:656a:e616 with SMTP id 123-20020a630181000000b003f6656ae616mr11321356pgb.448.1653200142709;
        Sat, 21 May 2022 23:15:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a660400b001df666ebddesm4644331pjj.6.2022.05.21.23.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:15:42 -0700 (PDT)
Date:   Sun, 22 May 2022 14:15:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Joe Mario <jmario@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com,
        Jiri Olsa <jolsa@kernel.org>, kjain@linux.ibm.com,
        lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 0/4] perf: arm-spe: Decode SPE source and use for perf
 c2c
Message-ID: <20220522061533.GA715382@leoy-ThinkPad-X240s>
References: <20220517020326.18580-1-alisaidi@amazon.com>
 <YoQRg1r7HuwiO3bZ@kernel.org>
 <20220518041630.GD402837@leoy-ThinkPad-X240s>
 <32e5a3b7-9294-bbd5-0ae4-b5c04eb4e0e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32e5a3b7-9294-bbd5-0ae4-b5c04eb4e0e6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Thu, May 19, 2022 at 11:16:53AM -0400, Joe Mario wrote:

[...]

> Hi Leo:
> Thanks for getting this working on ARM.  I do have a few comments.
> 
> I built and ran this on a ARM Neoverse-N1 system with 2 numa nodes.  
> 
> Comment 1:
> When I run "perf c2c report", the "Node" field is marked "N/A".  It's supposed to show the numa node where the data address for the cacheline resides.  That's important both to see what node hot data resides on and if that data is getting lots of cross-numa accesses. 

Good catching.  Will fix it.

> Comment 2:
> I'm assuming you're identifying the contended cachelines using the "peer" load response, which indicates the load was resolved from a "peer" cpu's cacheline.  Please confirm.

Yeah, "peer" is ambiguous.  AFAIK, "peer" load can come from:
- Local node which in peer CPU's cache (can be same cluster or peer cluster);
- Remove ndoe which in CPU's cache line, or even from *remote DRAM*.

> If that's true, is it possible to identify if that "peer" response was on the local or remote numa node?  

Good point.  Yes, we can do this.  So far, the remote accesses are
accounted in the metric "rmt_hit", it should be same with the
remote peer load; but so far we have no a metric to account local
peer loads, it would be not hard to add metric "lcl_peer".

> I ask because being able to identify both local and remote HitM's on Intel X86_64 has been quite valuable.  That's because remote HitM's are costly and because it helps the viewer see if they need to optimize their cpu affinity or what node their hot data resides on.

Thanks a lot for the info.  This means at least I should refine the shared
cache line distribution pareto for remote peer access, will do some
experiment for the enhancement.

> Last Comment:
> There's a row in the Pareto table that has incorrect column alignment.
> Look at row 80 below in the truncated snipit of output.  It has an extra field inserted in it at the beginning.
> I also show what the corrected output should look like.
> 
> Incorrect row 80:
>     71	=================================================
>     72	      Shared Cache Line Distribution Pareto      
>     73	=================================================
>     74	#
>     75	# ----- HITM -----    Snoop  ------- Store Refs ------  ------- CL --------                      
>     76	# RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A    Off  Node  PA cnt        Code address
>     77	# .......  .......  .......  .......  .......  .......  .....  ....  ......  ..................
>     78	#
>     79	  -------------------------------------------------------------------------------
>     80	      0        0        0     4648        0        0    11572            0x422140
>     81	  -------------------------------------------------------------------------------
>     82	    0.00%    0.00%    0.00%    0.00%    0.00%   44.47%    0x0   N/A       0            0x400ce8
>     83	    0.00%    0.00%   10.26%    0.00%    0.00%    0.00%    0x0   N/A       0            0x400e48
>     84	    0.00%    0.00%    0.00%    0.00%    0.00%   55.53%    0x0   N/A       0            0x400e54
>     85	    0.00%    0.00%   89.74%    0.00%    0.00%    0.00%    0x8   N/A       0            0x401038
> 
> 
> Corrected row 80:
>     71	=================================================
>     72	      Shared Cache Line Distribution Pareto      
>     73	=================================================
>     74	#
>     75	# ----- HITM -----    Snoop  ------- Store Refs -----   ------- CL --------                       
>     76	# RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss     N/A     Off  Node  PA cnt        Code address
>     77	# .......  .......  .......  .......  .......  ......   .....  ....  ......  ..................
>     78	#
>     79	  -------------------------------------------------------------------------------
>     80	       0        0     4648        0        0    11572            0x422140
>     81	  -------------------------------------------------------------------------------
>     82	    0.00%    0.00%    0.00%    0.00%    0.00%   44.47%    0x0   N/A       0            0x400ce8
>     83	    0.00%    0.00%   10.26%    0.00%    0.00%    0.00%    0x0   N/A       0            0x400e48
>     84	    0.00%    0.00%    0.00%    0.00%    0.00%   55.53%    0x0   N/A       0            0x400e54
>     85	    0.00%    0.00%   89.74%    0.00%    0.00%    0.00%    0x8   N/A       0            0x401038

Hmm‥.  At my side, I used below command to output pareto view, but I
cannot see the conlumn "CL", the conlumn "CL" is only shown for TUI
mode but not for the mode "--stdio".  Could you share the method for
how to reproduce this issue?

$ ./perf c2c report -i perf.data.v3 -N

=================================================
      Shared Cache Line Distribution Pareto      
=================================================
#
#        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                      --------------- cycles ---------------    Total       cpu                                     Shared                              
#   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol             Object             Source:Line  Node{cpus %peers %stores}
# .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  ..................  ........  ........  ........  ........  .......  ........  ......................  .................  ......................  ....
#
  -------------------------------------------------------------------------------
      0        0        0    56183        0        0    26534            0x420180
  -------------------------------------------------------------------------------
           0.00%    0.00%   99.85%    0.00%    0.00%    0.00%                 0x0   N/A       0            0x400bd0         0         0      1587      4034   188785         2  [.] 0x0000000000000bd0  false_sharing.exe  false_sharing.exe[bd0]   0{ 1  87.4%    n/a}  1{ 1  12.6%    n/a}
           0.00%    0.00%    0.00%    0.00%    0.00%   54.56%                 0x0   N/A       0            0x400bd4         0         0         0         0    14476         2  [.] 0x0000000000000bd4  false_sharing.exe  false_sharing.exe[bd4]   0{ 1    n/a   0.2%}  1{ 1    n/a  99.8%}
           0.00%    0.00%    0.00%    0.00%    0.00%   45.44%                 0x0   N/A       0            0x400bf8         0         0         0         0    12058         2  [.] 0x0000000000000bf8  false_sharing.exe  false_sharing.exe[bf8]   0{ 1    n/a  70.3%}  1{ 1    n/a  29.7%}
           0.00%    0.00%    0.15%    0.00%    0.00%    0.00%                0x20   N/A       0            0x400c64         0         0      2462      2451     4835         2  [.] 0x0000000000000c64  false_sharing.exe  false_sharing.exe[c64]   0{ 1  11.9%    n/a}  1{ 1  88.1%    n/a}

  -------------------------------------------------------------------------------
      1        0        0     2571        0        0    69861            0x420100
  -------------------------------------------------------------------------------
           0.00%    0.00%    0.00%    0.00%    0.00%  100.00%                 0x8   N/A       0            0x400c08         0         0         0         0    69861         2  [.] 0x0000000000000c08  false_sharing.exe  false_sharing.exe[c08]   0{ 1    n/a  62.1%}  1{ 1    n/a  37.9%}
           0.00%    0.00%  100.00%    0.00%    0.00%    0.00%                0x20   N/A       0            0x400c74         0         0       834       641     6576         2  [.] 0x0000000000000c74  false_sharing.exe  false_sharing.exe[c74]   0{ 1  93.2%    n/a}  1{ 1   6.8%    n/a}

Very appreciate your testing and suggestions!

Leo
