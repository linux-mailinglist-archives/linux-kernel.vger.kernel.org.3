Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD192552282
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiFTQzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiFTQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:55:08 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCC1193E0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=80UMITqfcEXbQBuxCEFv3WvM8vMQi18p2VPQJD28/NU=;
  b=WplHZSV4v5Cb0PupcCAvLTVl7rdhbOpIS6h6wmjsTuLVWqUKIpFjJXTH
   goJOfa+jBX6rEgM177rcNmCn5TF5U3v1oNcu4YWwQX8qHrzWJSPI5GM7U
   IsmNhZLRciRMwuchLMDYSwO8hR+m5i0zewHsqERY+sC7raeCWNdnlHK/t
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,207,1650924000"; 
   d="scan'208";a="17310869"
Received: from 71-51-190-12.chvl.centurylink.net (HELO hadrien) ([71.51.190.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:55:02 +0200
Date:   Mon, 20 Jun 2022 12:54:56 -0400 (EDT)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Michal Hocko <mhocko@suse.com>
cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        kernel test robot <lkp@intel.com>,
        Minchan Kim <minchan@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: mm/madvise.c:1438:6: warning: Redundant assignment
 of 'ret' to itself. [selfAssignment]
In-Reply-To: <YrCgcEGKxjN7mNu9@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.22.394.2206201253480.2243@hadrien>
References: <202206180617.UzO7ymnD-lkp@intel.com> <5ec7b561-551b-f02a-9b7b-65d05ccdabbc@quicinc.com> <YrCgcEGKxjN7mNu9@dhcp22.suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Jun 2022, Michal Hocko wrote:

> On Sat 18-06-22 11:25:43, Charan Teja Kalla wrote:
> > Hello Andrew,
> >
> > On 6/18/2022 4:34 AM, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
> > > commit: 5bd009c7c9a9e888077c07535dc0c70aeab242c3 mm: madvise: return correct bytes advised with process_madvise
> > > date:   3 months ago
> > > compiler: mips-linux-gcc (GCC) 11.3.0
> > > reproduce (cppcheck warning):
> > >         # apt-get install cppcheck
> > >         git checkout 5bd009c7c9a9e888077c07535dc0c70aeab242c3
> > >         cppcheck --quiet --enable=style,performance,portability --template=gcc FILE
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > cppcheck warnings: (new ones prefixed by >>)
> > >>> mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to itself. [selfAssignment]
> > >     ret = (total_len - iov_iter_count(&iter)) ? : ret;
> >
> > Other way to avoid this warning is by creating another local variable
> > that holds the total bytes processed. Having another local variable to
> > get rid off some compilation warning doesn't seem proper to me. So,
> > leaving this warning unless you ask me to fix this.
>
> Is this a new warning? I do not see it supported by my gcc 10.x. Do we

cppcheck is a static analysis tool.  It looks like it doesn't have a
proper understanding of ?:

julia

> plan to have it enabled by default? I do not see anything wrong with the
> above code and I think this is not an unusual pattern in the kernel.
> While you could go with
> 	if (rotal_len - iov_iter_count(&iter))
> 		ret = rotal_len - iov_iter_count(&iter);
>
> or do the same with a temporary variable but I am not really sure this would
> add to the readability much.
> --
> Michal Hocko
> SUSE Labs
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
>
