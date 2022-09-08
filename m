Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CEC5B21E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIHPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIHPVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A1878BC9;
        Thu,  8 Sep 2022 08:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E810761BFE;
        Thu,  8 Sep 2022 15:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3488AC4347C;
        Thu,  8 Sep 2022 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662650492;
        bh=eJoxN3IDoBjA5zFjhlv+ya3W+4HG4JCLG/oKmLzVM80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZH8OmXfBjfzXD8V/qT1VOWuf8IGkzf0re8V9xEWrzbuzatrDuWgynikGQC8YlWjdX
         5RjfekzWAx0edzbx8UobXb1Yg8wrZ5kkfUB2guVNhastvLMSj0h1I23d1WvDqB2J/1
         OrKlg3lo7sBDREaWnUk2/1yg0dsPjWnHzE6IPzmY7kF6eCi0W0B10si3TK0AfviAWt
         3YWiDGLneNJ8d9HZoK2O/8j+vZZATgq/m2/OR/Mcu8OoCE3Tu8Af2Btocut9nKuyIi
         t6fnQ/dPDB/YuVlzZP9LRJrPt328fnxD8RJYGaEa3XHo2g3lx9GUxmUnUSVhfbBzuQ
         2HbmhQpCtJtqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4AE69404A1; Thu,  8 Sep 2022 12:21:29 -0300 (-03)
Date:   Thu, 8 Sep 2022 12:21:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <YxoIeRLNtSnRyMm4@kernel.org>
References: <20220831083452.2fc938cf@canb.auug.org.au>
 <20220907050535.243e5030@canb.auug.org.au>
 <29e096e8-4ede-df66-4606-4bd0e5bda755@arm.com>
 <20220907130011.32818436@canb.auug.org.au>
 <e091ed53-d5d0-101d-92a6-a215350e482e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e091ed53-d5d0-101d-92a6-a215350e482e@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 07, 2022 at 09:52:48AM +0530, Anshuman Khandual escreveu:
> 
> 
> On 9/7/22 08:30, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Wed, 7 Sep 2022 08:01:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >>
> >> On 9/7/22 00:35, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> On Wed, 31 Aug 2022 08:34:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:  
> >>>>
> >>>> After merging the perf tree, today's linux-next build (native perf)
> >>>> failed like this:
> >>>>
> >>>> In file included from /usr/include/stdio.h:866,
> >>>>                  from /home/sfr/next/next/tools/perf/util/branch.h:9,
> >>>>                  from util/branch.c:2:
> >>>> In function 'fprintf',
> >>>>     inlined from 'branch_type_stat_display' at util/branch.c:152:4:
> >>>> /usr/include/powerpc64le-linux-gnu/bits/stdio2.h:105:10: error: '%8s' directive argument is null [-Werror=format-overflow=]
> >>>>   105 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
> >>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>   106 |                         __va_arg_pack ());
> >>>>       |                         ~~~~~~~~~~~~~~~~~
> >>>> cc1: all warnings being treated as errors
> >>>>
> >>>> Presumably caused by commit
> >>>>
> >>>>   9781e500dcb8 ("perf branch: Extend branch type classification")
> >>>>
> >>>> "native" here is PowerPC64 LE.
> >>>> $ gcc --version
> >>>> gcc (Debian 11.2.0-10) 11.2.0
> >>>>
> >>>> I have used the perf tree from next-20220830 for today.  
> >>>
> >>> I am still seeing this build failure.  
> >>
> >> But did you apply the fix patch from Arnaldo that removes -Wno-format-overflow
> >> compiler option for the file util/branch.c ?
> >>
> >> https://lore.kernel.org/all/YxJBh3wvAGol+Ekq@kernel.org/
> > 
> > No, I expected a fix to be in the perf tree ...
> > 
> > Also note that the following fixes the problem for me:
> > 
> > diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> > index d40776c44b06..b7b898f2872e 100644
> > --- a/tools/perf/util/branch.c
> > +++ b/tools/perf/util/branch.c
> > @@ -88,7 +88,8 @@ const char *branch_type_name(int type)
> >  		"ERET",
> >  		"IRQ",
> >  		"SERROR",
> > -		"NO_TX"
> > +		"NO_TX",
> > +		""
> >  	};
> >  
> >  	if (type >= 0 && type < PERF_BR_MAX)
> 
> This looks right, makes sense.
> 
> > 
> > 
> > PERF_BR_MAX has been increased by one (when PERF_BR_EXTEND_ABI was
> > added), but a new string has not been added to the array ...
> 
> Right, even though new branch_new_names[] array gets queried on when type
> value is PERF_BR_EXTEND_ABI, branch_names[] should still contain an empty
> string "" just to match the now incremented PERF_BR_MAX which extends the
> array size as well. I guess the compiler detects this mismatch here and
> just complains about it.
> 
> Hello Arnaldo,
> 
> As adding empty string to the array solves the build problem, I guess we
> should fold this fix instead, rather than trying to drop the compiler
> option itself, as discussed earlier.

I'll do it, and even force push perf/core so that this problem doesn't
get into the bisection history upstream.

- Arnaldo
 
> The above fix should be folded into the following commit
> 
> 9781e500dcb8 ("perf branch: Extend branch type classification")
> 
> in the following perf tree - branch.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git (perf/core)
> 
> - Anshuman

-- 

- Arnaldo
