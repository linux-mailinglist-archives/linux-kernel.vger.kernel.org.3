Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAC4B0DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiBJMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:40:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiBJMkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:40:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597151036
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:40:48 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A5E1E21115;
        Thu, 10 Feb 2022 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644496846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9ZbzBgnxPunXqjYGK83et/vqjK6YE0/d/TYWMUW5n8=;
        b=sOOedZfG3mAXqF2Xghmmi6/8PqkLVcjEIfwWB5Llzc+Mw2cDNcri6STJXa5GG8nHO148nV
        DrTHbR/DHi9cJOwwlK+W/ON0zOfxvNNvXR7OzAHbYj/nkR92F25aMpzTa2wxK+hw8c1WHQ
        pTyqYfJp7+bXUgbEHfdA6OYr6WwEfQA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25F55A3B83;
        Thu, 10 Feb 2022 12:40:45 +0000 (UTC)
Date:   Thu, 10 Feb 2022 13:40:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YgUHzSqltDp2dr70@dhcp22.suse.cz>
References: <20220210043215.42794-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210043215.42794-1-surenb@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-02-22 20:32:15, Suren Baghdasaryan wrote:
> When adjacent vmas are being merged it can result in the vma that was
> originally passed to madvise_update_vma being destroyed. In the current
> implementation, the name parameter passed to madvise_update_vma points
> directly to vma->anon_name->name and it is used after the call to
> vma_merge. In the cases when vma_merge merges the original vma and
> destroys it, this will result in use-after-free bug as shown below:
> 
> madvise_vma_behavior << passes vma->anon_name->name as name param
>   madvise_update_vma(name)
>     vma_merge
>       __vma_adjust
>         vm_area_free <-- frees the vma
>     replace_vma_anon_name(name) <-- UAF
> 
> Fix this by raising the name refcount and stabilizing it. Introduce
> vma_anon_name_{get/put} API for this purpose.

What is the reason that madvise_update_vma uses the naked name rather
than the encapsulated anon_vma_name? This really just begs for problems.
-- 
Michal Hocko
SUSE Labs
