Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DAF51EA94
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 01:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiEGXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiEGXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 19:04:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1D19000
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 16:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16F6EB80B3C
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB06C385A6;
        Sat,  7 May 2022 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651964411;
        bh=PI9YBhyJ05Qj2TBmHJYBGR+TzRijgTsKpsKyP8FRIm4=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=CICA6/dE7xyVPrJbWnCv0QxiptoChazOuu4BdQswqsjmKRcNEZ+Y+JHjBEX6q9TPy
         VUuDDu8BMKXRYwi5kx2MTW9Ol8k8XkdHXY+/z7JYNBi0yw2CU7qcvNIKkjAklnXZu2
         jRnW7uS4dnO+5IvcTZmNXf8l9GSwIYyAT441XZzs=
Date:   Sat, 7 May 2022 16:00:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vvs@openvz.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm] tracing: incorrect gfp_t conversion
Message-Id: <20220507160010.aa2077e28c4710400e144bfb@linux-foundation.org>
In-Reply-To: <20220507154835.4d4d737d8eed579969f15938@linux-foundation.org>
References: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
        <331d88fe-f4f7-657c-02a2-d977f15fbff6@openvz.org>
        <20220507123728.f20d977eba9fbb66bddee722@linux-foundation.org>
        <8b1cfefa-da7d-3376-cf04-1ff77dab8170@openvz.org>
        <20220507154835.4d4d737d8eed579969f15938@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2022 15:48:35 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> I did the below.
> 

Silly me, doesn't work.

> 
> --- a/include/trace/events/mmflags.h~tracing-incorrect-gfp_t-conversion-fix
> +++ a/include/trace/events/mmflags.h
> @@ -13,53 +13,57 @@
>   * Thus most bits set go first.
>   */
>  
> +#define FUL __force unsigned long
> +
>  #define __def_gfpflag_names						\
> -	{(__force unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\

Can't expand FUL here within the macro definition.
