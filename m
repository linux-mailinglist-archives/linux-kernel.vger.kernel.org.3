Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E64935F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348464AbiASIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343971AbiASIBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:01:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:01:51 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i8so1671556pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 00:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qMOZ/Ss7D1QGWJrjjWDz0WPhRvhrkckRq7Vv+kCye3I=;
        b=HKI8k5MxvGek8ymb8BK4XaV0lk8E3V0Cah7MgN7U7S/GKnJXEGHIsn9FQfPEu9QCIW
         sPzkokAYygCKBWItT7PvG8ALQWzxfvlm/djaQ9XX6mqqwINTNXr+56O2VXXDW3XBPXtb
         S/GNSmrYtFL67QdSsHs0yZ5xJ5xNomd1r5Lmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMOZ/Ss7D1QGWJrjjWDz0WPhRvhrkckRq7Vv+kCye3I=;
        b=F2fWwdX52PSORuicfH+TGf7uN9gaoGBk5aJWa27VRDvU+QdsMfWVXmAqZqOAHuGCi2
         wTsCm74H8MweEGFxTxJyrCTWnzWHMBx5JU33eBG2nvFK3ZwFBSHc5APKC/83u/Ag30o8
         WC7byVfErdHHp4cDz8kwQwTBHBr8SdlxGHN+Ob5xr/MnyDfbnoa3WnxGNz0PThK8AJJL
         BnaXjPrZjMSy5X0+DcMRW1FzPygqUbWmVfjAVhdneXnVtsP2Kw86zeu9bC5eHNIiE28U
         Xktg66TkI5KmsCt+ftklhQEi7PeBpDqaCfzqE58cS2SSeni82T5taOlmT0NlVOdaWwSr
         hxRg==
X-Gm-Message-State: AOAM531OiMX1Zxv5PzJUHWJo3nCfZKvk+dEhVnKtsCTltRl+sr9T20tz
        i586bSOQU/rW46FkV/aLve8T6jo9u75APpBu
X-Google-Smtp-Source: ABdhPJy1EmD8rKbec/UreKDqP7HXe6xosVZyHPaIG276srU+2dhgcPegNBERFgME9/KIKu8qJPY2cA==
X-Received: by 2002:aa7:80cf:0:b0:4bc:ecc1:e7f5 with SMTP id a15-20020aa780cf000000b004bcecc1e7f5mr30072141pfn.11.1642579310782;
        Wed, 19 Jan 2022 00:01:50 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:3343:314a:558d:5df7])
        by smtp.gmail.com with ESMTPSA id om15sm5110865pjb.46.2022.01.19.00.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:01:50 -0800 (PST)
Date:   Wed, 19 Jan 2022 17:01:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RESEND][PATCH] checkpatch: make sure fix-up patches have Fixes
 tag
Message-ID: <YefFapMkddSWHXRE@google.com>
References: <20220119074609.4162747-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119074609.4162747-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/01/19 16:46), Sergey Senozhatsky wrote:
>
> Change-Id: I066ae0e607a67ac83c6ba0ff8d883f7e7a4a73e0
>

It was not supposed to be there, but it's there (spotted by Tomasz).
Let me know if I need to re-send.
