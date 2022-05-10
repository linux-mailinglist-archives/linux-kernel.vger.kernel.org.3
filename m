Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31E5223C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbiEJSVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348780AbiEJSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:21:05 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B3396B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:17:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o11so14142674qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j6VxUo8QQgucktTahfGjMnSHx49seR2VNE5VfPNoqpw=;
        b=AZ8FOeLYs0Ou66qeac0W+jy0+5ZasZRmYmeiVyej+xT3ycHzEWtgp+hRatbjGISWoZ
         W3uLF/kp7vL+Sfjeyug2wWia4wkxMJvWRv87HCIw7tK33gc73vCgsl/NtSOtWmjbZyob
         VBcwki3iHmsZPoaIRE5YJJJkKpfJ7VrCl7Xr+i+shLyDlFCMEAqJXnYlrvDCBsrkFhVi
         rJEa0btzLKYM4zLEWhRLDZbDvaVu5OUwKxt8iRZ0c7j/9qPSVqQUBnWRv6rKzE+5OcJN
         uZLdqJFn2knl07MWB9d3MNPa0aQA7Twpxp9KINsG5OxFhgdMsDBkxmU0KipHE89NfL9Z
         aRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6VxUo8QQgucktTahfGjMnSHx49seR2VNE5VfPNoqpw=;
        b=wcFE5ydFg3+7pYk9FiA+Dy0LDzbStoBtDxi/xBJJalJ3xk0NkazcrnJFXqUvZxn5Rf
         7w1tHRvuRhcBERqIm/YSfCexMWbKyT1/fXzBJkVQevzxz4rQsZqfQqgareBunMKEKQBf
         nk9T3W7j1m/p53L1052S9YQ6kne7EgDX4Y/Fp7O88vFzRydAD5InNFJNyh7AOn0zJLNR
         TmfD0LX49vAFozvozSUvrJkKK3qASOLOkyMQvWiLb4mkidsAC8WeHxdEM4Fh119mleGh
         NwpdYEbmPT9l0lFCMR4xxdzXyQ2Ewjyd3CH4n0iNhZE8b6op1BC/hKhDKXki2UawGwM0
         OZtg==
X-Gm-Message-State: AOAM531zKx3xDiUogQbXcf+rPiCd69P+pMWZyW0O4bNdjDYdEdJpR4Zn
        3R2g8qoxpx9PVkGsBvrqhrRnJg==
X-Google-Smtp-Source: ABdhPJz3dtPC+i3ZnJRRpdyaAU1Wjmt4AhGVlHQHl3jnllOUS6zAzRCqJaUZcXvpiJikOHbQzr09AQ==
X-Received: by 2002:ac8:5745:0:b0:2f3:e231:bc12 with SMTP id 5-20020ac85745000000b002f3e231bc12mr4843122qtx.291.1652206625133;
        Tue, 10 May 2022 11:17:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id k6-20020ac81406000000b002f39b99f69fsm9434981qtj.57.2022.05.10.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:17:04 -0700 (PDT)
Date:   Tue, 10 May 2022 14:16:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Martin Liu <liumartin@google.com>
Subject: Re: [PATCH v3] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <Ynqr57CVLPOqwhZa@cmpxchg.org>
References: <20220510171100.48500-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510171100.48500-1-minchan@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

The patch looks reasonable to me, but one thing stands out:

On Tue, May 10, 2022 at 10:11:00AM -0700, Minchan Kim wrote:
> @@ -1391,6 +1391,10 @@ static enum page_references folio_check_references(struct folio *folio,
>  	if (vm_flags & VM_LOCKED)
>  		return PAGEREF_ACTIVATE;
>  
> +	/* page_referenced didn't work due to lock contention */
> +	if (referenced_ptes == -1)
> +		return PAGEREF_KEEP;
> +
>  	if (referenced_ptes) {
>  		/*
>  		 * All mapped folios start out with page table

This means contended inactive pages get rotated.

> @@ -2492,7 +2496,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  		}
>  
>  		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> -				     &vm_flags)) {
> +				     &vm_flags) > 0) {
>  			/*
>  			 * Identify referenced, file-backed active pages and
>  			 * give them one more trip around the active list. So

This means contended active pages do NOT get rotated.

It's a bit of an arbitrary choice what to do with reclaim candidates
for which you can get no reference information, but staying consistent
is likely a good idea. My preference would be to just rotate contended
pages throughout rather than risk dropping the workingset on the floor.

		/* Referenced or rmap lock contention: rotate */
		if (folio_referenced() != 0) {
			...

What do you think?
