Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A15200BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiEIPKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiEIPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:10:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70A26551
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:06:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so19918256wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ip-fi.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4YlizTEUTLQqCEt+JLqAH+3gSJdYyRatSfzlLmy/vU=;
        b=tR9K9x3da6ovXrt/jaxBw/9e8IQLFQEFEEkgpOUhoXbvqT6mcxMl3dthzpAl+RoVLB
         eCdUL8SeuzsfJCjaQqRmVntZOt7rtBZzneuekCJ2vuKmbD5MxGo/hhYIamPbXpnOBado
         7fV1dGhr5eIQlfl8WAEHNPaWU1nI0Xwb9aPB88LnuKQXni0PZSpeTd0CuBrXYsgtcM27
         iIEEXgHt/cSw51A3BYrHK4DAfC3U09fGwvuFKm1Y7jSsxBC6I6C3IumrvDQlXLryL1d6
         mAKKZXUICCFBXP3A7tl6ni9x5z7AMpVyHA8UpVnEkJJXtEg9YahTPEc5OUexuGryug4B
         SefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4YlizTEUTLQqCEt+JLqAH+3gSJdYyRatSfzlLmy/vU=;
        b=vrum2x+qpZKm/PFqiPjXe5MxzwsOdvQVLJD3hM2ZPbgrrhmQ9ZUEUtLYfMmYqiMCAb
         d7tIWlAzR1YzLsWo0IZ4NiqHfGZypWUeH0M5zgcJYIn41mI5mlLUQTnGe4QBptdZR0ed
         Zc5jQffALDVp5QWr8WJz0of7+iOX+aMeP9h4gyx2yApq+5XUwZhJUnsHaSdp/MKAOFDQ
         Lyj590D1SPGp6XiRj+y1ZNIu/D9za8RbUVFBaxw2QlJ8KcrL0yC4+8OOcMr78FyuRhTB
         iPk3cMoOC8wI/kZ9bXmVq1fcPV7aGKHb2wam7/3Nqh5V/kVpQtG30dL8dYtIfMKYU4Cs
         pVSA==
X-Gm-Message-State: AOAM533qMnoLctcPP9Iffz4f0iBGASweLgf+5y9lAK13qe+TMlimXOoW
        mLFLSZSYunfQiZgFY/ac9DlzlQ==
X-Google-Smtp-Source: ABdhPJyMZ+++4iKGB3yQTV4zDC6ujkkzagjlvu6uwuGAO44YBv/itLTvZ/JZPBwx+ZLS6zNcNoaBKg==
X-Received: by 2002:adf:f6c1:0:b0:20a:c408:4aeb with SMTP id y1-20020adff6c1000000b0020ac4084aebmr14178690wrp.74.1652108802598;
        Mon, 09 May 2022 08:06:42 -0700 (PDT)
Received: from debian ([91.193.4.92])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b00394615cf468sm13947241wml.28.2022.05.09.08.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:06:42 -0700 (PDT)
Date:   Mon, 9 May 2022 17:06:39 +0200
From:   Johan Boger <jb@ip.fi>
To:     Joe Perches <joe@perches.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: drivers: hid: hid-asus.c: Optimized input logic
 for keys
Message-ID: <Ynkt/0vIhLFTceXO@debian>
References: <20220509100258.24764-1-jb@ip.fi>
 <5e44ef1302b722d3bf7fafe55111e76f7173e6be.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e44ef1302b722d3bf7fafe55111e76f7173e6be.camel@perches.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 06:54:51AM -0700, Joe Perches wrote:
> On Mon, 2022-05-09 at 12:02 +0200, Johan Boger wrote:
> > Instead of calling asus_map_key_clear() function in each case,
> > we now set a temporary value and clear it after default.
> > Patch was checked by checkpatch and adjusted accordingly.
> 
> This patch subject is not correct.  This is not a staging patch.
> 
> Your commit message is also incomplete as this is modifying comments,
> changing whitespace, and changing brace styles.
> 
> and IMO:
> 
> Either use a single line case style like:
> 
> 	case foo: statement; break;
> 
> or use a multiple line case style like:
> 
> 	case foo:
> 		statement;
> 		break;
> 
> but please do not use a mixed case one line and statement; break;
> on another like:
> 
> 	case foo:
> 		statement; break;
> 
> Please remember checkpatch is only a guide, it's not the last word
> on style where every message it emits requires an actual code change.
> 
> btw: there are _many_ single line case uses in the kernel
> 
> $ git grep  -P 'case\s+\w+\s*:\s*\w+' -- '*.[ch]' | wc -l
> 7581
> 
> 
> 
Ok. Thanks for helping me out.
Will resend when I have made sure it's up to standards.

Your time and guidance is appreciated.

