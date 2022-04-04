Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F714F1FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiDDXE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349767AbiDDXCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1181CFED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCA461683
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DEBC2BBE4;
        Mon,  4 Apr 2022 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649110973;
        bh=/OEcMz0jdUh8BECJfpc1/XPI/AqNgsW05n8DDoGH5yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dI9HQbt8uVpF984go+rwahRF0pZzHRQgjlBESFHQpNtEmWt0c2vcDKI0vERleFyXn
         DSuizM0AeZ065Nw5dOmGssDA9thbr1iW6H3A4/UMgjQ2bP/pqrUDUnN8tcONHvR/Pz
         jAFGeAzvFqOvfuf9qAvTRzJcqKCrHDHxXzi3TOo4=
Date:   Mon, 4 Apr 2022 15:22:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de
Subject: Re: [PATCH v3] kcov: don't generate a warning on vm_insert_page()'s
 failure
Message-Id: <20220404152252.af0c9c9127455e9cf5e632fb@linux-foundation.org>
In-Reply-To: <20220401182512.249282-1-nogikh@google.com>
References: <20220401182512.249282-1-nogikh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Apr 2022 18:25:12 +0000 Aleksandr Nogikh <nogikh@google.com> wrote:

> vm_insert_page()'s failure is not an unexpected condition, so don't do
> WARN_ONCE() in such a case.
> 
> Instead, print a kernel message and just return an error code.
> 
> ...
>
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -475,8 +475,11 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>  	vma->vm_flags |= VM_DONTEXPAND;
>  	for (off = 0; off < size; off += PAGE_SIZE) {
>  		page = vmalloc_to_page(kcov->area + off);
> -		if (vm_insert_page(vma, vma->vm_start + off, page))
> -			WARN_ONCE(1, "vm_insert_page() failed");
> +		res = vm_insert_page(vma, vma->vm_start + off, page);
> +		if (res) {
> +			pr_warn_once("kcov: vm_insert_page() failed\n");
> +			return res;
> +		}
>  	}
>  	return 0;
>  exit:

Can you explain the rationale here?  If vm_insert_page() failure is an
expected condition, why warn at all?

I'm struggling to understand why a condition is worth a printk, but not
a WARN.

Some explanation of what leads to the vm_insert_page() failure would
have been helpful.

