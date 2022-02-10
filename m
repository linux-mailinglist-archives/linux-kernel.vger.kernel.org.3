Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E79B4B0E69
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiBJN2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:28:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbiBJN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:28:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DB4BA0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qgJ7BeTdHSxnO0s1F6v+Di4M//rT9yP6AOORlVtJCSI=; b=pDt7Kz1BNTg3Gif0QrECApPRwq
        t/zFCnya18pfeKuahfGbTny5QJloaHTjPTgQ/bHWSSq0ejUd7IEzW776dUIekV3nWgM3RDzCnyygU
        jCAh6agscdA2uUPKvEsEBjr+sykJ6LK8bXafhhGpkLdyMtXI1qHfewnm0j5mkzW/lC0+Q7Ut5v+Tg
        hycFoeofKLY2e5Q/TLn7Hw1vnXXQ+i2D0Jyqk4DP24VZ3QHEac+pqmbHPI241HgYCm7EfecpC2a1v
        XJ54dWQ5Ee/uit71wuIYXWqi9xfjCa9gkHaOZu4ttBqGzV31RU+HIcJlerIvdQI1L4bMYTFAqUoeU
        H5l3tTBA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI9Tz-009Stf-7J; Thu, 10 Feb 2022 13:27:35 +0000
Date:   Thu, 10 Feb 2022 13:27:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, hannes@cmpxchg.org, ebiederm@xmission.com,
        brauner@kernel.org, legion@kernel.org, ran.xiaokai@zte.com.cn,
        sashal@kernel.org, chris.hyser@oracle.com, dave@stgolabs.net,
        pcc@google.com, caoxiaofeng@yulong.com, david@redhat.com,
        gorcunov@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
Message-ID: <YgUSxzp/qDwLkiKb@casper.infradead.org>
References: <20220210043215.42794-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210043215.42794-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 08:32:15PM -0800, Suren Baghdasaryan wrote:
> +void vma_anon_name_put(struct anon_vma_name *anon_name)
> +{
> +	kref_put(&anon_name->kref, vma_anon_name_free);
> +}

To agree with Michal, make this:

	if (anon_name)
		kref_put(&anon_name->kref, vma_anon_name_free);

>  
> -	error = madvise_update_vma(vma, prev, start, end, new_flags,
> -				   vma_anon_name(vma));
> +	anon_name = vma_anon_name_get(vma);
> +	if (anon_name) {
> +		error = madvise_update_vma(vma, prev, start, end, new_flags,
> +					   anon_name->name);
> +		vma_anon_name_put(anon_name);
> +	} else {
> +		error = madvise_update_vma(vma, prev, start, end, new_flags,
> +					   NULL);
> +	}

And then this becomes:

	anon_name = vma_anon_name_get(vma);
	error = madvise_update_vma(vma, prev, start, end, new_flags, anon_name);
	vma_anon_name_put(anon_name);
