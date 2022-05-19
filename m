Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1F152CE41
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiESIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiESIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:24:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AD66A012;
        Thu, 19 May 2022 01:24:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D12571F86B;
        Thu, 19 May 2022 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652948648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwOhrJSnnXYoizy86SeAUsXvstx5Qk5Sxc5L+MZBqyo=;
        b=j1hPdPE4GhTJhJXK5vft++K8S2O3MW6b5IsLzl2daI0uZUWn59BeqXofVnLyF0BFhi1KwH
        wGpS8EufX9bKXt9AKCvcbYvBFE5Lh0Pi6arigelrUHexT0SCvFN5d+iEubG+GdikL7MSjR
        LRGj4XLhExkDFG/e7AH53Mjsj/1JxTA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3FBFA2C180;
        Thu, 19 May 2022 08:24:08 +0000 (UTC)
Date:   Thu, 19 May 2022 10:24:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Hugh Dickins <hughd@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
Message-ID: <YoX+ps7fYFMqjQDq@dhcp22.suse.cz>
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoOrdh85+AqJH8w1@dhcp22.suse.cz>
 <62845e2b.1c69fb81.cbf4a.1200@mx.google.com>
 <YoTiqm4sQCtq8C1C@dhcp22.suse.cz>
 <6285e264.1c69fb81.3f416.71a8@mx.google.com>
 <YoXzQqZ5Yluv8JMa@dhcp22.suse.cz>
 <6285f983.1c69fb81.b0a8b.837f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6285f983.1c69fb81.b0a8b.837f@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-05-22 08:02:10, CGEL wrote:
> On Thu, May 19, 2022 at 09:35:30AM +0200, Michal Hocko wrote:
> > On Thu 19-05-22 06:23:30, CGEL wrote:
> > > On Wed, May 18, 2022 at 02:12:26PM +0200, Michal Hocko wrote:
> > > > On Wed 18-05-22 02:47:06, CGEL wrote:
> > > > > On Tue, May 17, 2022 at 04:04:38PM +0200, Michal Hocko wrote:
> > > > > > [CCing Hugh and linux-api]
> > > > > > 
> > > > > > On Tue 17-05-22 09:27:01, cgel.zte@gmail.com wrote:
> > > > > > per mm but the actual implementation currently relies on the per-vma
> > > > > > flags. That means that one can explicitly disallow merging by madvise
> > > > > > for a range. Is it wise to override that by a per-process knob? I mean
> > > > > > there might be a very good reason why a particular memory ranges should
> > > > > > never be merged but a per-process knob could easily ignore that hint
> > > > > > from the application. Or am I just confuse?
> > > > > For now, there is no any hints for letting KSM never merge some memory
> > > > > ranges.
> > > > 
> > > > I am not sure I understand. Could you be more specific?
> > > 
> > > Not like THP, KSM doesn't have anything like VM_NOHUGEPAGE, so apps
> > > cann't explicitly disallow merging by madvise. If it is really necessary for
> > > a particular meory ranges of a process to be never merged, we have to submit
> > > one more patch to achieve that.
> > 
> > What about MADV_UNMERGEABLE?
> 
> MADV_UNMERGEABLE and MADV_MERGEABLE usually appear in pairs, MADV_UNMERGEABLE cannot
> appear alone.

That might be the case currently because KSM is an opt-in feature that
has to be explicitly enabled. The existing interface only allows to
enable it by MADV_MERGEABLE but now you are proposing an extension when
there would be other way to achieve the same (with a wider scope but
that is not really all that important). MADV_UNMERGEABLE has a well
defined behavior even on VMAs which are not marked for merging.

Let's say that somebody would like to use a process wide setup except
for few special mappings because merging is not really desirable for
whatever reason. How do you achieve that?

> I mean MADV_UNMERGEABLE is used to unmerges whatever it merged in the
> specifed range, not to disallow merging.

I disagree. It clearly drops the mergeable flag so it effectivelly disallow
merging.
-- 
Michal Hocko
SUSE Labs
