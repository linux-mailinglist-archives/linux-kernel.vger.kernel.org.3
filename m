Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C44ED1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiCaCiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCaCiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:38:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818E4B91A9;
        Wed, 30 Mar 2022 19:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CAEADCE1F5F;
        Thu, 31 Mar 2022 02:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F1C340EE;
        Thu, 31 Mar 2022 02:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648694218;
        bh=WQsddbrCat3Q5bzZv57YLMCPNyaJSVBl8uYP7TxTInU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xNMzbJ1xwjJZk1Mxd47frKbLz4IPhdc9SUEeJID01zUHnI4aQ9cRhLtqNSUxVoXoH
         6OnIxPBwplerroTchdn9azB6EI7JNoTyXEiGvk//Ep3ykgqrCLaYpti9oGDjBoOUIB
         ajw3i6Uz5NRga7Lqy2PjpiteUGv6u/U8Q930LZKY=
Date:   Wed, 30 Mar 2022 19:36:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v6 4/4] mm: hugetlb_vmemmap: add hugetlb_free_vmemmap
 sysctl
Message-Id: <20220330193657.88f68bbf13fb198fb189bc15@linux-foundation.org>
In-Reply-To: <20220330153745.20465-5-songmuchun@bytedance.com>
References: <20220330153745.20465-1-songmuchun@bytedance.com>
        <20220330153745.20465-5-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 23:37:45 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> We must add "hugetlb_free_vmemmap=on" to boot cmdline and reboot the
> server to enable the feature of freeing vmemmap pages of HugeTLB
> pages.  Rebooting usually takes a long time.  Add a sysctl to enable
> or disable the feature at runtime without rebooting.

I forget, why did we add the hugetlb_free_vmemmap option in the first
place?  Why not just leave the feature enabled in all cases?

Furthermore, why would anyone want to tweak this at runtime?  What is
the use case?  Where is the end-user value in all of this?

> Disabling requires there is no any optimized HugeTLB page in the
> system.  If you fail to disable it, you can set "nr_hugepages" to 0
> and then retry.
> 
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -561,6 +561,20 @@ Change the minimum size of the hugepage pool.
>  See Documentation/admin-guide/mm/hugetlbpage.rst
>  
>  
> +hugetlb_free_vmemmap
> +====================
> +
> +Enable (set to 1) or disable (set to 0) the feature of optimizing vmemmap
> +pages associated with each HugeTLB page.  Once true, the vmemmap pages of
> +subsequent allocation of HugeTLB pages from buddy system will be optimized,
> +whereas already allocated HugeTLB pages will not be optimized.  If you fail
> +to disable this feature, you can set "nr_hugepages" to 0 and then retry
> +since it is only allowed to be disabled after there is no any optimized
> +HugeTLB page in the system.
> +

Pity the poor user who is looking at this and wondering whether it will
improve or worsen things.  If we don't tell them, who will?  Are they
supposed to just experiment?

What can we add here to help them understand whether this might be
beneficial?

> +See Documentation/admin-guide/mm/hugetlbpage.rst


