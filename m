Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC94D7D42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiCNIIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiCNII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:08:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF22FFE3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4A0611B8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C053EC340E9;
        Mon, 14 Mar 2022 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647245237;
        bh=Qhr3AT/HysLtUJqE2yY8Zz0XqrJA9evnIrPJ4H08OB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QA6vMD2HgDtCWP6cOe5kDFODkFdUwvX2BIlB+BbM/zCPBk52Xwbh2MDNmWxs5/KDA
         lMW+1nIOqp2QHDpQX8ZV3RX3t4wlwD4fq75UTTY8IJyWFQzEYnGIR0qfGapeqtEW8e
         aW22hLLyOsfwNVykqyzt7O/VHLD0D9A/oPb6K4gQ=
Date:   Mon, 14 Mar 2022 09:07:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     longman@redhat.com, dave@stgolabs.net, hdanton@sina.com,
        jaegeuk@google.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <Yi73sVutB2w3zxbT@kroah.com>
References: <cb03cbe5-0357-144d-0660-3ebc50c0245a@redhat.com>
 <20220217154154.6030-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217154154.6030-1-chenguanyou@xiaomi.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:41:54PM +0800, chenguanyou wrote:
> >>>>> Hi Waiman, Greg,
> >>>>> This patch has been merged in branch linux-5.16.y.
> >>>>> Can we take it to the linux-5.10.y LTS version?
> >>>> What is "this patch"?
> >>> commit d257cc8cb8d5355ffc43a96bab94db7b5a324803 ("locking/rwsem: Make handoff bit handling more consistent")
> >> Have you tested it on the 5.10.y branch to verify it actually works
> >> properly for you?
> >>
> >> If so, please provide a working backport to the stable list, as it does
> >> not apply cleanly as-is.
> >>
> >> thanks,
> >>
> >> greg k-h
> >>
> > I have attached the 5.10.y backport of commit 
> > d257cc8cb8d5355ffc43a96bab94db7b5a324803 ("locking/rwsem: Make handoff 
> > bit handling more consistent"). I also include a backport of commit 
> > 2f06f702925b512a95b95dca3855549c047eef58 ("locking/rwsem: Prevent 
> > potential lock starvation") which I think may help Jaegeuk. I had run 
> > some sanity tests and the backported patches work fine. However, I don't 
> > have access to their testing environments to verify if they can fix the 
> > problems seem by Chen or Jaegeuk. So please test these patches to see if 
> > they can address your problems.
> 
> Hi Longman,
> 
> I'll do some stability testing on our 5.10 phone.

What ever happened with this testing?

thanks,

greg k-h
