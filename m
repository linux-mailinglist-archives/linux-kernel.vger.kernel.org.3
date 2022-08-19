Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E38599562
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346231AbiHSGdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHSGdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:33:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0FDD0745
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7D11CE134F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A041C433D6;
        Fri, 19 Aug 2022 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660890781;
        bh=7KnI6WEOjESTVzU0a8ICQJZFhVe3GPGSdd9HRl9UTKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s90eIGPpVmk3+i9VQYk4sGJbRue9fzVHkoMwI4uodC9qlNrXaPMJAuUfW0CJBOVzq
         kjO2WXsq6gvtXKFpmJkHpAiFm4HegLWQ7IGs54VyzTpGRQVRz52SwOxyphcCmkz3Jl
         8psKhyiPt5S3qJXCDWWbOHlgdSAxrMCcHpRf21GE=
Date:   Fri, 19 Aug 2022 08:32:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: Re: [PATCH] mm: hugetlb: simplify per-node sysfs creation and removal
Message-ID: <Yv8umgIXfbpMFukB@kroah.com>
References: <20220819052137.7985-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819052137.7985-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 01:21:37PM +0800, Muchun Song wrote:
> The following commit offload per-node sysfs creation and removal to a kworker and
> did not say why it is needed.  And it also said "I don't know that this is
> absolutely required".  It seems like the author was not sure as well.  Since it
> only complicates the code, this patch will revert the changes to simplify the code.
> 
>   39da08cb074c ("hugetlb: offload per node attribute registrations")

Any specific reason why you did not cc: the original author of this
commit, or anyone else on the patch?

> We could use memory hotplug notifier to do per-node sysfs creation and removal
> instead of inserting those operations to node registration and unregistration.
> Then, it can reduce the code coupling between node.c and hugetlb.c.  Also, it can
> simplify the code.

I do not think we had memory hotplug notifier back in 2009 when this
commit was first written.

How did you test this?  Did you use a HUGETLBFS system and verify that
everything still works properly?  You are deleting a lot of code (always
nice), but making sure everything is still operating the same is a good
thing.

thanks,

greg k-h
