Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD3557274
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiFWFKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiFWFK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE04E4FC60
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6547B8216E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B64C3411B;
        Thu, 23 Jun 2022 04:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655959943;
        bh=f04UosaZrCBU0VGU+Q+K1maUIoOWgaPkn3n3p6hifTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aA3gntfBKhzWgoF/FE66TUz0Q7Zc6l8Etl/xxpPe230Ng19NDzmvnfs3hc8s6xn2h
         i6OU/IQc2XGwuuchuUR/KKeuQMPHaWd64NrhHijH/fgaE10DPKWq85aKO29zQGKH+m
         ElyJa1GVsmTVWj9fJlZhh0GowH7scNUwfVsqPeSmxCqAGU58DuxJLh6U8/mnop3Kt8
         hJjETRCLMt4mn1TU0k9I692VQP87//c8BrKbQoFFg8dt8r0VKeopSppkIKu6+CMbrP
         FaUsfnnbmhE+zWyLdbAy9oZO4pk06BuZm2TZ0AEZmfrXx+uWuyQJLSGZsS825AMsQv
         PEKpITHG7iMkA==
Date:   Wed, 22 Jun 2022 23:52:17 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 1/4] memblock tests: add user-provided arguments to
 Makefile
Message-ID: <YrPxgRzW0OYjyvti@kernel.org>
References: <cover.1655889641.git.remckee0@gmail.com>
 <b7e8e89dbbd7acdf41d62f1528f02d1dc2283e4b.1655889641.git.remckee0@gmail.com>
 <YrPia6frNDEyN41S@kernel.org>
 <YrPv8BnNWyqgwOMo@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPv8BnNWyqgwOMo@bertie>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:45:36PM -0500, Rebecca Mckeever wrote:
> Hi Mike,
> 
> On Wed, Jun 22, 2022 at 10:47:55PM -0500, Mike Rapoport wrote:
> > Hi Rebecca,
> > 
> > On Wed, Jun 22, 2022 at 04:29:06AM -0500, Rebecca Mckeever wrote:
> > >
> > > Subject: memblock tests: add user-provided arguments to Makefile
> > 
> > Please be more specific here, e.g. 
> > 
> > memblock tests: Makefile: add arguments to control verbosity
> >
>
> Should I also mention debug messages, or does verbosity refer to both
> arguments?

It does as enabling memblock_dbg() is also about overall verbosity.
But if you manage to squeeze both in 75 characters I won't mind :)
 
> > > Add VERBOSE and MEMBLOCK_DEBUG user-provided arguments. VERBOSE will
> > > enable verbose output from Memblock simulator. MEMBLOCK_DEBUG will enable
> > > memblock_dbg() messages.
> > > 
> > > Update the help message to include VERBOSE and MEMBLOCK_DEBUG. Update
> > > the README to include VERBOSE. The README does not include all available
> > > options and refers to the help message for the remaining options.
> > > Therefore, omit MEMBLOCK_DEBUG from README.
> > > 
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > > ---
> > >  tools/testing/memblock/Makefile                 |  4 ++++
> > >  tools/testing/memblock/README                   | 10 +++++++++-
> > >  tools/testing/memblock/scripts/Makefile.include | 10 ++++++++++
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
> > > index a698e24b35e7..9fde49ad73bd 100644
> > > --- a/tools/testing/memblock/Makefile
> > > +++ b/tools/testing/memblock/Makefile
> > > @@ -45,6 +45,10 @@ help:
> > >  	@echo  '  clean		  - Remove generated files and symlinks in the directory'
> > >  	@echo  ''
> > >  	@echo  'Configuration:'
> > > +	@echo  '  make VERBOSE=1            - enable verbose output, which includes the'
> > > +	@echo  '                              names of functions being tested and the'
> > > +	@echo  '                              number of test cases passing'
> > > +	@echo  '  make MEMBLOCK_DEBUG=1     - enable memblock_dbg() messages'
> > >  	@echo  '  make NUMA=1               - simulate enabled NUMA'
> > >  	@echo  '  make MOVABLE_NODE=1       - override `movable_node_is_enabled`'
> > >  	@echo  '                              definition to simulate movable NUMA nodes'
> > > diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> > > index ca6afcff013a..058146b528a5 100644
> > > --- a/tools/testing/memblock/README
> > > +++ b/tools/testing/memblock/README
> > > @@ -34,7 +34,15 @@ To run the tests, build the main target and run it:
> > >  $ make && ./main
> > >  
> > >  A successful run produces no output. It is also possible to override different
> > > -configuration parameters. For example, to simulate enabled NUMA, use:
> > > +configuration parameters. For example, to include verbose output, specify the
> > > +VERBOSE flag when building the main target:
> > > +
> > > +$ make VERBOSE=1
> > > +
> > > +This will print information about which functions are being tested and the
> > > +number of test cases that passed.
> > > +
> > > +To simulate enabled NUMA, use:
> > >  
> > >  $ make NUMA=1
> > >  
> > > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > > index 641569ccb7b0..4401f79bed4c 100644
> > > --- a/tools/testing/memblock/scripts/Makefile.include
> > > +++ b/tools/testing/memblock/scripts/Makefile.include
> > > @@ -17,3 +17,13 @@ ifeq ($(32BIT_PHYS_ADDR_T), 1)
> > >  	CFLAGS += -m32 -U CONFIG_PHYS_ADDR_T_64BIT
> > >  	LDFLAGS += -m32
> > >  endif
> > > +
> > > +# Enable verbose testing output
> > > +ifeq ($(VERBOSE), 1)
> > > +	CFLAGS += -D VERBOSE
> > > +endif
> > > +
> > > +# Enable memblock_dbg() messages
> > > +ifeq ($(MEMBLOCK_DEBUG), 1)
> > > +	CFLAGS += -D MEMBLOCK_DEBUG
> > > +endif
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> 
> Thanks,
> Rebecca

-- 
Sincerely yours,
Mike.
