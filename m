Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589B049FFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbiA1Rir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbiA1Riq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:38:46 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D657C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:38:45 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id C7E2F10008F; Fri, 28 Jan 2022 17:38:43 +0000 (UTC)
Date:   Fri, 28 Jan 2022 17:38:43 +0000
From:   Sean Young <sean@mess.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Subject: Re: [tools headers UAPI] e2bcbd7769: kernel-selftests.ir.make_fail
Message-ID: <YfQqI2ryOYEDuvON@gofer.mess.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:27:52AM -0700, Shuah Khan wrote:
> On 1/28/22 9:49 AM, Alexei Starovoitov wrote:
> > On Fri, Jan 28, 2022 at 1:32 AM Sean Young <sean@mess.org> wrote:
> > > 
> 
> > > > ir_loopback.c: In function ‘main’:
> > > > ir_loopback.c:147:20: error: ‘RC_PROTO_RCMM32’ undeclared (first use in this function); did you mean ‘RC_PROTO_RC6_MCE’?
> > > >      if (rc_proto == RC_PROTO_RCMM32 &&
> > > >                      ^~~~~~~~~~~~~~~
> > > >                      RC_PROTO_RC6_MCE
> > > 
> > > So this commit removes the copy of lirc.h from tools/include/uapi/linux/lirc.h,
> > > so now the test uses /usr/include/linux/lirc.h. It appears that this file
> > > does not have RC_PROTO_RCMM32 defined on this system, which means it is a
> > > kernel header from v5.1 or earlier (this was added in commit
> > > 721074b03411327e7bf41555d4cc7c18f49313f7).
> > > 
> > > It looks like this machine is redhat 8.3, which ships with kernel 4.18.
> > > 
> > > I guess my change was far too optimistic; I had no ideal enterprise kernels
> > > were so ancient.
> > > 
> > > We should probably drop e2bcbd7769ee8f05e1b3d10848aace98973844e4. Sorry about
> > > the turbulence.
> > 
> > I'd rather avoid reverting.
> > Just add ifdef or something to shut up the error on old distros.
> > 
> 
> Sean,
> 
> Let's not add release checks.
> 
> Since RC_PROTO_RCMM32 is the only one missing, perhaps you could define
> just that one in ir_loopback.c with a comment that it can be removed.
> 
> ifndef RC_PROTO_RCMM32 ---

Hi Shuah,

I was thinking along the same lines, however RC_PROTO_RCMM32 is an enum
value so a pre-processor #ifdef is not going to work. At the moment I haven't
had any bright ideas other than doing a `#define RC_PROTO_RCMM32 26` at the
top of the file.

Open to suggestions.

Thanks,

Sean
