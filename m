Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA26571884
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGLL3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGLL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:29:36 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13B27193DF;
        Tue, 12 Jul 2022 04:29:35 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oBE58-00025x-00; Tue, 12 Jul 2022 13:29:34 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E75EEC036A; Tue, 12 Jul 2022 13:19:17 +0200 (CEST)
Date:   Tue, 12 Jul 2022 13:19:17 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: fix pmd_mkinvalid
Message-ID: <20220712111917.GA10936@alpha.franken.de>
References: <1657181495-33004-1-git-send-email-zhanghongchen@loongson.cn>
 <20220707092206.GA9894@alpha.franken.de>
 <bfb97f6b-7a39-8253-bc14-08f2f54ed312@loongson.cn>
 <0fd4e823-493f-07f0-08d5-f4a22491b602@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fd4e823-493f-07f0-08d5-f4a22491b602@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:01:08PM +0800, Hongchen Zhang wrote:
> On 2022/7/7 下午7:12, Hongchen Zhang wrote:
> > On 2022/7/7 下午5:22, Thomas Bogendoerfer wrote:
> > > On Thu, Jul 07, 2022 at 04:11:35PM +0800, Hongchen Zhang wrote:
> > > > When a pmd entry is invalidated by pmd_mkinvalid,pmd_present should
> > > > return true.
> > > > So introduce a _PMD_PRESENT_INVALID_SHIFT bit to check if a pmd is
> > > > present but invalidated by pmd_mkinvalid.
> > > 
> > > What problem are you trying to fix ? What are the symptoms ?
> > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > the test robot showed problems with your last version of the patch,
> > > which hasn't been integrated into at least the MIPS tree, so no
> > > need to that.
> > > 
> > > Thomas.
> > > 
> > 
> > Hi Thomas,
> >    The idea come from the commit:
> >    b65399f6111b(arm64/mm: Change THP helpers to comply with generic MM
> >  semantics).
> >    There is an problem now:
> >          CPU 0        CPU 1
> >      pmdp_invalidate        do_page_fault
> >      ...              __handle_mm_fault
> >                      is_swap_pmd == true
> >                      trigger VM_BUG_ON() ?
> >      set_pmd_at
> >    the reason is that pmd_present return true,after this commit
> >    pmd_present will return false,and the VM_BUG_ON will not be triggered.
> >    Like arm64 does,we can introduce a new bit to fix this.
> > 
> > Thanks.
> Hi Thomas,
>  Is there problem of this patch? What's your opinion of this patch?

I haven't dig deeper into it, but needing more page bits is a pain
for 32bit kernel and would make it nearly impossible to get huge
page support there. And the description you gave me, needs to be
in the commit description.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
