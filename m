Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE78859872C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbiHRPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245219AbiHRPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:17:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FF07C1B3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76105B8203A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9111FC433D6;
        Thu, 18 Aug 2022 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660835828;
        bh=Tm/++sxgfnVoUcC4gyi/rncDNqWMbIga+LlQ3XDx8SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYBGymDhV0ftY4+m0bqDhyt0iCQnqsojgJGDO/hXCWjMFHjtcZffxBV2VTeyMTYwx
         WeI2euwwjNggqk9okmcQHh4pli8WOA5ZnTRDSUsxoG/PYOZycsOj+hwASeJcC3djG+
         jzQEzOLg/HuXgcO7K2A2goqKiOpLGixWoivB81DvrSThl+KnfSgNN36+CHlswdy767
         ftdh/OVO6GO2bjEgbV3KQoVUmILeqXpiCbgak0xXUkxNTGNC29Q+xcv+q+pLIPig0o
         L3mgj79EERloFuRWWP0IPMpHiKXiUwrmsluI3Nd+pVU89MpAg/B7gCxrVrkxy9OQtM
         Kc0SfJZvtEyTg==
Date:   Thu, 18 Aug 2022 08:17:05 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, pbonzini@redhat.com,
        x86@kernel.org
Subject: Re: [PATCH] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Message-ID: <20220818151705.alu2y52rknp2mgsa@treble>
References: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
 <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
 <20220818011045.v4baekgxajylqxvh@treble>
 <Yv3qHNGBM2aU2NuA@worktop.programming.kicks-ass.net>
 <Yv3sha0zujQxW1X8@xpf.sh.intel.com>
 <Yv4dKABja9CxqcDS@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv4dKABja9CxqcDS@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 01:06:16PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 18, 2022 at 03:38:45PM +0800, Pengfei Xu wrote:
> >   And this "Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]" issue was
> >   reproduced again after ran syzkaller 5min on ADL-P.
> 
> Ha, indeed :/
> 
> > > > +/*
> > > > + * Create a dummy function pointer reference to prevent objtool from marking
> > > > + * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
> > > > + * apply_ibt_endbr()).
> > > > + */
> > > > +#define IBT_NOSEAL(fname)				\
> > > > +	".pushsection .discard.endbr.noseal\n\t"	\
> > > > +	_ASM_PTR fname "\n\t"				\
> > > > +	".popsection\n\t"
> > > > +
> 
> objtool/check.c:validate_ibt():
> 
>                 if (!strncmp(sec->name, ".discard", 8)                  ||
> 		    ...)
> 		    continue;
> 
> So yeah, that'll just get ignored. So at the very least we need to
> special case this section.

Indeed.  I swear that patch worked last night.

I also found that not all fastops use __FOP_FUNC().

Anyway I'll post a new (official) pair of patches shortly.

-- 
Josh
