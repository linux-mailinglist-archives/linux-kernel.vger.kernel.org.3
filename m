Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154924E60D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349112AbiCXJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCXJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:06:32 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9FE19D0E2;
        Thu, 24 Mar 2022 02:05:00 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nXJOs-0002LV-01; Thu, 24 Mar 2022 10:04:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 40811C2ECE; Thu, 24 Mar 2022 10:04:43 +0100 (CET)
Date:   Thu, 24 Mar 2022 10:04:43 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org
Subject: Re: undefined reference to `node_data'
Message-ID: <20220324090443.GA5375@alpha.franken.de>
References: <202203232042.AS9SV1zv-lkp@intel.com>
 <Yjs0ausRy6/mLUFD@dhcp22.suse.cz>
 <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 05:46:59PM +0100, Michal Hocko wrote:
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
> > > >> (.init.text+0x1680): undefined reference to `node_data'
> > >    mips64-linux-ld: (.init.text+0x1690): undefined reference to `node_data'
> > 
> > OK, I can see what is going here. The page allocator normally
> > uses NODE_DATA but arch_refresh_nodedata refers to node_data directly.
> > This is a problem with
> > arch/mips/include/asm/mach-loongson64/mmzone.h:
> > extern struct pglist_data *__node_data[];
> > 
> > #define NODE_DATA(n)            (__node_data[n])
> > 
> > Unfortunately we cannot use NODE_DATA there because of header inclusion
> > ordering. I will think about a solution.
> 
> Is there any reason why (some?) MIPS arches use __node_data rather than
> node_data as most other architectures? Would it be acceptable to do the
> renaming? It would help to cover the above compilation problem because
> arch_refresh_nodedata could keep using node_data directly.

I've just checked history and I don't see a reason for __node_data.
So I'm fine with changing it to node_data.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
