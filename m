Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9759CA62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiHVUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiHVUxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336EF76
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:53:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA29D61291
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF223C433D6;
        Mon, 22 Aug 2022 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661201597;
        bh=0XYtpJeYJIHTuAMCFA1D+7TBHuPnWebnHkoxH17FW/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=raKsoKUJ3D+YKLX5I0Fp20KUC1w4f8jQqCeSn1QA75zKUowJi/lu3eE0+/SxDaoGw
         IkfWtk48VuSEG1mMMlPer9zM8rLLF+Y790dYCzMbAV8R2vq7hS5px34QAy9JALT+Z7
         9uCYMBdmhghHTXgGrvVEg0HIof+j5onbbYkKZVpA=
Date:   Mon, 22 Aug 2022 13:53:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: pagewalk: make error checks more obvious
Message-Id: <20220822135316.ee37696392ff756b1c810059@linux-foundation.org>
In-Reply-To: <2203731.iZASKD2KPV@devpool047>
References: <3200642.44csPzL39Z@devpool047>
        <2203731.iZASKD2KPV@devpool047>
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

On Mon, 22 Aug 2022 15:00:05 +0200 Rolf Eike Beer <eb@emlix.com> wrote:

> The err variable only needs to be checked when it was assigned directly
> before, it is not carried on to any later checks. Move the checks into the
> same "if" conditions where they are assigned. Also just return the error at
> the relevant places. While at it move these err variables to a more local
> scope at some places.
> 
> ...
>
> @@ -593,16 +608,15 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
>  		walk.mm = vma->vm_mm;
>  
>  		err = walk_page_test(vma->vm_start, vma->vm_end, &walk);
> -		if (err > 0) {
> -			err = 0;
> -			break;
> -		} else if (err < 0)
> -			break;
> +		if (err > 0)
> +			return 0;
> +		else if (err < 0)
> +			return err;
>  
>  		err = __walk_page_range(start_addr, end_addr, &walk);
>  		if (err)
> -			break;
> +			return err;
>  	}
>  
> -	return err;
> +	return 0;
>  }

I'm not really a fan of multiple return points - it tends to lead to
locking/resource leaks as the code evolves.  I don't really think it's
worth redoing the patch for this reason though; the rest looks good.
