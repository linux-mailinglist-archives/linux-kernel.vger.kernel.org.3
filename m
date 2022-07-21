Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD057C9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiGULh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiGULhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:37:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6C731DF4;
        Thu, 21 Jul 2022 04:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0B64B823C8;
        Thu, 21 Jul 2022 11:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C31DC341CE;
        Thu, 21 Jul 2022 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658403440;
        bh=IJfrVQPMT4yKttp8HhU31vIdYsxoLfOU3EqREIXq8TY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mpLbs1fgXFwTqj00tbzZDZNxz2E4STwel3+kvfzwsPwr4M8E0iDna/YTsYKjY+6OG
         AIFZrGgvBL/fn3g6N6JVUGUK1OqxkKoOt9AAg86LfDa61gEwCTGALeIzMo6Q3szskm
         57xcN0rWPIbOtRtVre6EE42ZeDRqGwyWbuZJ9eVq6AynpVtnWPK9eBKl/IvOz+B4fz
         e7WyuJNm+lFP98HgwuBylwAPlmlQ7HZv9CB6/x4W/+prsyJTqx7E7Xl55toftbEbtC
         FapDcAfWltbTsP2tr7P+IFqK5zhHPfJcd1FkA8uqoSNjvzO0fyXhZrRnTg5PBh6iwy
         at+ZoK1EDnYvg==
Date:   Thu, 21 Jul 2022 13:37:15 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: core: remove unneeded assignment in
 hid_process_report()
In-Reply-To: <20220701112720.13452-1-lukas.bulwahn@gmail.com>
Message-ID: <nycvar.YFH.7.76.2207211337090.19850@cbobk.fhfr.pm>
References: <20220701112720.13452-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022, Lukas Bulwahn wrote:

> Commit bebcc522fbee ("HID: core: for input reports, process the usages by
> priority list") split the iteration into two distinct loops in
> hid_process_report().
> 
> After this change, the variable field is only used while iterating in the
> second loop and the assignment of values to this variable in the first loop
> is simply not needed.
> 
> Remove the unneeded assignment during retrieval. No functional change and
> no change in the resulting object code.
> 
> This was discovered as a dead store with clang-analyzer.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Benjamin, Jiri, please pick this minor non-urgent clean-up patch.
> 
>  drivers/hid/hid-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 00154a1cd2d8..b7f5566e338d 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1662,7 +1662,7 @@ static void hid_process_report(struct hid_device *hid,
>  
>  	/* first retrieve all incoming values in data */
>  	for (a = 0; a < report->maxfield; a++)
> -		hid_input_fetch_field(hid, field = report->field[a], data);
> +		hid_input_fetch_field(hid, report->field[a], data);
>  
>  	if (!list_empty(&report->field_entry_list)) {

Applied, thanks Lukas.

-- 
Jiri Kosina
SUSE Labs

