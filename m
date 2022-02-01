Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B64A619D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiBAQvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBAQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:51:42 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A616C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:51:42 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D904F101BFE; Tue,  1 Feb 2022 16:51:39 +0000 (UTC)
Date:   Tue, 1 Feb 2022 16:51:39 +0000
From:   Sean Young <sean@mess.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Subject: Re: [tools headers UAPI] e2bcbd7769: kernel-selftests.ir.make_fail
Message-ID: <YfllGx5PRMT9tDDc@gofer.mess.org>
References: <20220128075346.GG8421@xsang-OptiPlex-9020>
 <YfO39Q3mNHMQOkd4@gofer.mess.org>
 <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
 <e5b72f09-a208-a579-3e51-10935ccee1ff@linuxfoundation.org>
 <YfQqI2ryOYEDuvON@gofer.mess.org>
 <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <347bae9f-f775-4976-3d27-b0c725211d78@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:57:35AM -0700, Shuah Khan wrote:
> On 1/28/22 10:38 AM, Sean Young wrote:
> > On Fri, Jan 28, 2022 at 10:27:52AM -0700, Shuah Khan wrote:
> > > On 1/28/22 9:49 AM, Alexei Starovoitov wrote:
> > > > On Fri, Jan 28, 2022 at 1:32 AM Sean Young <sean@mess.org> wrote:
> > > > > 
> > > 
> > > > > > ir_loopback.c: In function ‘main’:
> > > > > > ir_loopback.c:147:20: error: ‘RC_PROTO_RCMM32’ undeclared (first use in this function); did you mean ‘RC_PROTO_RC6_MCE’?
> > > > > >       if (rc_proto == RC_PROTO_RCMM32 &&
> > > > > >                       ^~~~~~~~~~~~~~~
> > > > > >                       RC_PROTO_RC6_MCE
> > > > > 
> > > > > So this commit removes the copy of lirc.h from tools/include/uapi/linux/lirc.h,
> > > > > so now the test uses /usr/include/linux/lirc.h. It appears that this file
> > > > > does not have RC_PROTO_RCMM32 defined on this system, which means it is a
> > > > > kernel header from v5.1 or earlier (this was added in commit
> > > > > 721074b03411327e7bf41555d4cc7c18f49313f7).
> > > > > 
> > > > > It looks like this machine is redhat 8.3, which ships with kernel 4.18.
> > > > > 
> > > > > I guess my change was far too optimistic; I had no ideal enterprise kernels
> > > > > were so ancient.
> 
> > Hi Shuah,
> > 
> > I was thinking along the same lines, however RC_PROTO_RCMM32 is an enum
> > value so a pre-processor #ifdef is not going to work. At the moment I haven't
> > had any bright ideas other than doing a `#define RC_PROTO_RCMM32 26` at the
> > top of the file.
> > 
> 
> One more idea. Let's see if this works. Check for RC_PROTO_MAX if it existed
> before this commit that RC_PROTO_RCMM32, you could define RC_PROTO_RCMM32
> conditionally in the test scope. If not let's go woth your plan of defining
> it at the top with some info.

Good idea, this works! patch in another reply in this thread.

Sorry about the mess, thanks for the suggestions.

Sean
