Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322844C38E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbiBXWmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiBXWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81AA162115
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645742509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ri6ltO02GOnb7gOb5jp++nfcVbKCACVLgFw1sGOCVdY=;
        b=G1JahLUswntYRAaiO5JnCZdRI7Jc6Dp2mgvR8GMXy68D/36NDZ9jJGPuatHuR/1KYdHFai
        1Qbal5XOefilTjeOWWn+4MB/tS2xOVyrFJlMm/B8ik/p8j0LMAazSIsibLnABzENI+4gz9
        7/kMHeKOJZNsKNOjzKG6moItpLUWzPs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-IZPmdd4XPjKSBj92wHLXWQ-1; Thu, 24 Feb 2022 17:41:48 -0500
X-MC-Unique: IZPmdd4XPjKSBj92wHLXWQ-1
Received: by mail-qv1-f70.google.com with SMTP id z8-20020a0cda88000000b00432946b4c84so3449713qvj.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ri6ltO02GOnb7gOb5jp++nfcVbKCACVLgFw1sGOCVdY=;
        b=BHOyGbKs1cWvUPYInK+b0y2FgStrLnSjHEevy5gji1PPeYiR/wVDg9ggvZjkYQpohw
         vEJ2lj+/kugmOMOsbGxWMgCLsREo0Z3RGTWRFib0+UNQRAo/Z+L2TOa71oU/YuGC3EtH
         COmSHQTrDpbc6A4AWHbbmJ3oAC0bUGsybe+xlWyLMD7lA/EQMLHBHJnVvCztzhNixXEl
         7fsGIC5ZBzidpjlWjJZVCZsHfAuSZLyjSe6nGodAzuUT0lYG15G6w40Sqm0mg7p4Vkbl
         KhOryW9zu3swBKM8vphn27pSqu3w+nmFsOEbPQ5s3XIA2JIDkBcPrSzDxW3dr66shzzy
         8pnw==
X-Gm-Message-State: AOAM533cfpGWuGzu3k9JlLChGiq5YuFJ6p0N5rfOTdL9K2ul9mnyG0nJ
        rVpdYDgRh+WUGHIsCbiwE+BYiycptxjOoRhJKIGhhhiV9AcxhlyW0fB59AhY+4AASz8bQmgzxcY
        5MUpwqT9CELNl2t3dDDVherM6
X-Received: by 2002:a0c:e88c:0:b0:432:c161:7944 with SMTP id b12-20020a0ce88c000000b00432c1617944mr471099qvo.40.1645742507585;
        Thu, 24 Feb 2022 14:41:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+xu175+kpRaSBof6HiIwXIi7RAnjAvuSAkDGAWOombXgZtwJXxB0oSW7DAwCPP8wttfK4lQ==
X-Received: by 2002:a0c:e88c:0:b0:432:c161:7944 with SMTP id b12-20020a0ce88c000000b00432c1617944mr471079qvo.40.1645742507368;
        Thu, 24 Feb 2022 14:41:47 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a228700b005f18f39a5e3sm419809qkh.50.2022.02.24.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:41:46 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:41:43 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 10/39] x86/ibt,crypto: Add ENDBR for the jump-table
 entries
Message-ID: <20220224224143.aiocnbdr3zbv6pqj@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.598835921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151322.598835921@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:48PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/crypto/crc32c-pcl-intel-asm_64.S |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> +++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
> @@ -195,6 +195,7 @@ SYM_FUNC_START(crc_pcl)
>  .altmacro
>  LABEL crc_ %i
>  .noaltmacro
> +	ENDBR
>  	crc32q   -i*8(block_0), crc_init
>  	crc32q   -i*8(block_1), crc1
>  	crc32q   -i*8(block_2), crc2
> @@ -203,6 +204,7 @@ LABEL crc_ %i
>  
>  .altmacro
>  LABEL crc_ %i
> +	ENDBR
>  .noaltmacro

Minor inconsistency here in the placement of ENDBR.  Should probably go
below .noaltmacro in both cases.

-- 
Josh

