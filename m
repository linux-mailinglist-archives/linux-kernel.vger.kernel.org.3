Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521974F912F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiDHIxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiDHIx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:53:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610C215921;
        Fri,  8 Apr 2022 01:51:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67E5A1F862;
        Fri,  8 Apr 2022 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649407882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uTGU4pxoIdecWm4trOJxGHJ9iItKUNYJ1jmjMl6SEx4=;
        b=VhVZqo81opV2Tbo6thBWgam3/nXYsf0Hhvr72+/6xVkPHVFlyEHjkpREVrE1QtAumjQbwq
        9+xR0oASwZ79uam/ix++zW/7rzcCT6DFEvU63PzZlDSJf9u/SS/E/W5I4dWkGjlQpHlaU4
        ygdzXpwmqr+MdCNxWxMkcXqRnK8TUyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649407882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uTGU4pxoIdecWm4trOJxGHJ9iItKUNYJ1jmjMl6SEx4=;
        b=t0ijmoGdavYzXFzGXhf38G2KTYQ7SjR1398XagWLNdHqgp6418CKRIc9Rl5ZYfDDJLr6a4
        Zd0+zw+Iw5L3tpAw==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02632A3B93;
        Fri,  8 Apr 2022 08:51:21 +0000 (UTC)
Date:   Fri, 8 Apr 2022 10:51:20 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Coiby Xu <coxu@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 0/4] Unifrom keyring support across architectures and
 functions
Message-ID: <20220408085120.GV163591@kunlun.suse.cz>
References: <cover.1644953683.git.msuchanek@suse.de>
 <20220408074704.wkyyv2qnx66iinzo@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408074704.wkyyv2qnx66iinzo@Rk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 03:47:04PM +0800, Coiby Xu wrote:
> Hi Michal,
> 
> As mentioned by Baoquan, I have a patch set "[PATCH v5 0/3] use more
> system keyrings to verify arm64 kdump kernel image signature" [1]. The
> differences between your patch set and mine are as follows,  - my patch set
> only adds support for arm64 while yours also extends to
>    s390
>  - I made the code for verifying signed kernel image as PE file in x86
>    public so arm64 can reuse the code as well which seems to be better
>    approach
>  - I also cleaned up clean up arch_kexec_kernel_verify_sig
> 
> Would you mind if I integrate your first 3 patches with mine as follows
>  - for arm64, I'll use my version
>  - for s390, I'll use your version

Great

less code duplication is always good.

Thanks

Michal

> 
> For your last patch which allows to use of platform keyring for
> signature verification of kernel module, I'll leave it to yourself. How
> do you think about it?
> 
> 
> [1] https://lore.kernel.org/all/20220401013118.348084-1-coxu@redhat.com/
> 
> On Tue, Feb 15, 2022 at 08:39:37PM +0100, Michal Suchanek wrote:
> > While testing KEXEC_SIG on powerpc I noticed discrepancy in support for
> > different keyrings across architectures and between KEXEC_SIG and
> > MODULE_SIG. Fix this by enabling suport for the missing keyrings.
> > 
> > The latter two patches obviously conflict with the ongoing module code
> > cleanup. If they turn out desirable I will add them to the other series
> > dealing with KEXEC_SIG.
> > 
> > The arm patches can be merged independently.
> > 
> > Thanks
> > 
> > Michal
> > 
> > Michal Suchanek (4):
> >  Fix arm64 kexec forbidding kernels signed with keys in the secondary
> >    keyring to boot
> >  kexec, KEYS, arm64: Make use of platform keyring for signature
> >    verification
> >  kexec, KEYS, s390: Make use of built-in and secondary keyring for
> >    signature verification
> >  module, KEYS: Make use of platform keyring for signature verification
> > 
> > arch/arm64/kernel/kexec_image.c       | 13 +++++++++++--
> > arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> > kernel/module_signing.c               | 14 ++++++++++----
> > 3 files changed, 34 insertions(+), 11 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Best regards,
> Coiby
> 
