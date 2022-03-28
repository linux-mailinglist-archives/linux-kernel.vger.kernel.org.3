Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50C94E95BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbiC1LxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241897AbiC1Lrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D7B07
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FCC4611D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 11:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03361C004DD;
        Mon, 28 Mar 2022 11:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648467774;
        bh=jMaunHAXMlJ+DWdKZ1J2mPlg8iRfvDMvaDW/Gbm28E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=PBhbaW+fD1BPQ93FjKM7at0JOtBDEhoYmRbtWUb2T3cyhmQJsvDADFuvCGHqzfQoW
         y/tlW4i31COh9bIQ+E999BDp/LVsEp0s7r2TUa8cDTI9hGfWoYZWEoEKugAFgtJY3R
         3lR0v/4KDIgaxlsIVwdcimmR5o7MS13N3FYc8IyeyAzTDYE8FH8Fsj5HmsoPmf7sO/
         3koCjiH8vDU+nzQPg++KQfjrg7gWo9nwTk/T6FibfbGGawm7Pl27aQZCwsvEVS2uln
         +oxPDvHCFmh+2SQBDZEynsjkgYErnpDYW+fVhFpyq482heuGlQFXOo88AdiDCSvNhn
         I2A11bHfvRDug==
From:   sj@kernel.org
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] damon: vaddr-test: tweak code to make the logic clearer
Date:   Mon, 28 Mar 2022 11:42:51 +0000
Message-Id: <20220328114251.31851-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220328112930.31229-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 19:29:30 +0800 Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:

> Move these two lines into the damon_for_each_region loop, it is always
> for testing the last region. And also avoid to use a list iterator 'r'
> outside the loop which is considered harmful[1].
> 
> [1]:  https://lkml.org/lkml/2022/2/17/1032

Let's have one empty line here[1].

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#the-canonical-patch-format

> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

Other than the above trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/vaddr-test.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
> index 6a1b9272ea12..98b7a9f54b35 100644
> --- a/mm/damon/vaddr-test.h
> +++ b/mm/damon/vaddr-test.h
> @@ -281,14 +281,16 @@ static void damon_test_split_evenly_succ(struct kunit *test,
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
>  
>  	damon_for_each_region(r, t) {
> -		if (i == nr_pieces - 1)
> +		if (i == nr_pieces - 1) {
> +			KUNIT_EXPECT_EQ(test,
> +				r->ar.start, start + i * expected_width);
> +			KUNIT_EXPECT_EQ(test, r->ar.end, end);
>  			break;
> +		}
>  		KUNIT_EXPECT_EQ(test,
>  				r->ar.start, start + i++ * expected_width);
>  		KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
>  	}
> -	KUNIT_EXPECT_EQ(test, r->ar.start, start + i * expected_width);
> -	KUNIT_EXPECT_EQ(test, r->ar.end, end);
>  	damon_free_target(t);
>  }
>  
> -- 
> 2.17.1
