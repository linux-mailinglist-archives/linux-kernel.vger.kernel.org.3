Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229A5552247
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiFTQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiFTQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:29:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C152DFD1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:29:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B4A61F74D;
        Mon, 20 Jun 2022 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655742578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2md7ifxeCy3ar4+fRCCm0Z7DlFfpGvnA2qgiu2UJkUE=;
        b=YQvRNX6dvhgZKRjAxTBToMujsPekyvCYfwq1UZq/SLX6YzAYT/NTOm/gllMyWzg+iAqPfV
        d0ECKD0X2JriVbcSOU3H6KyKecdXAd4OY3bIGwerYWtp+GNS3mfZGLczL989T3RmW8nZon
        dmRwExPsEAqr8iy6icWmtpHu525NOW4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 868D42C141;
        Mon, 20 Jun 2022 16:29:37 +0000 (UTC)
Date:   Mon, 20 Jun 2022 18:29:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     kernel test robot <lkp@intel.com>,
        Minchan Kim <minchan@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to
 itself. [selfAssignment]
Message-ID: <YrCgcEGKxjN7mNu9@dhcp22.suse.cz>
References: <202206180617.UzO7ymnD-lkp@intel.com>
 <5ec7b561-551b-f02a-9b7b-65d05ccdabbc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec7b561-551b-f02a-9b7b-65d05ccdabbc@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18-06-22 11:25:43, Charan Teja Kalla wrote:
> Hello Andrew,
> 
> On 6/18/2022 4:34 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
> > commit: 5bd009c7c9a9e888077c07535dc0c70aeab242c3 mm: madvise: return correct bytes advised with process_madvise
> > date:   3 months ago
> > compiler: mips-linux-gcc (GCC) 11.3.0
> > reproduce (cppcheck warning):
> >         # apt-get install cppcheck
> >         git checkout 5bd009c7c9a9e888077c07535dc0c70aeab242c3
> >         cppcheck --quiet --enable=style,performance,portability --template=gcc FILE
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > cppcheck warnings: (new ones prefixed by >>)
> >>> mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to itself. [selfAssignment]
> >     ret = (total_len - iov_iter_count(&iter)) ? : ret;
> 
> Other way to avoid this warning is by creating another local variable
> that holds the total bytes processed. Having another local variable to
> get rid off some compilation warning doesn't seem proper to me. So,
> leaving this warning unless you ask me to fix this.

Is this a new warning? I do not see it supported by my gcc 10.x. Do we
plan to have it enabled by default? I do not see anything wrong with the
above code and I think this is not an unusual pattern in the kernel.
While you could go with
	if (rotal_len - iov_iter_count(&iter))
		ret = rotal_len - iov_iter_count(&iter);

or do the same with a temporary variable but I am not really sure this would
add to the readability much.
-- 
Michal Hocko
SUSE Labs
