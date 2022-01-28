Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7727349F7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244072AbiA1LAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiA1LAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:00:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B55C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:00:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u6so10950324lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xLjWT1FA3o7kuuGnw+XH0Uw1AYY+iBBGZTcFTlDUs8E=;
        b=b9o5s2Sb9lYvLAtqAE2YEuS1OE984ci2qq59gCoeCaHo6yXRkZwjTuVUXHrLyxnvxU
         CgIqBRtDY2sz6cDtDqYA7s4/7svJy8FOB0L+hkKp80LlWtRyrfAQGh1s4EwNpDUszYaY
         vrPQeHYDMcp8Z2jVK38Dq6eg1eONtY1XRDBuNNRaGk5cZuN/jft+E9Pc+/pZ85yYTBX7
         /AehTue0453A+fJOJ3q6/4pkonv/XYStdP9DeJFSSw59NfO2bFMVczeZwJ+ldihTAexF
         xgTmtmPIlr35LxH2rClNNW84ylB7hsuvgms+6aVWHgfJkGj7qT1sHe9QyKid/5AJGDJZ
         ZiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xLjWT1FA3o7kuuGnw+XH0Uw1AYY+iBBGZTcFTlDUs8E=;
        b=KWxnkJAX7pwmFv7y/NcJpz4XXRlcY3DijWJlVLy16+e+NS2p++xidRoE2cZ8fypHBp
         B9nNS26McH+efg/mfkYiVydq6guOcw4xvHfazDKiCPEIEegCyFEbf1bQk7lDqoOTlih5
         CV2oearYZ1Ejs2F2UUxX6511CeLRDo8BdaHaCR5NwnZd3C90xgA2aONCaXxROs4lmuno
         EK6pRgXSsLULJOudk2CPzSOAq6juZY6ketiBPpGeyu0OC0NIJgyzDngGVpcW5IYdflHZ
         HZWUIM34/p5qOXvsFMF8STRBUH/Dkap2ajOycvoH/w7AyOQyqhrCKV407NFrZMjQlN7o
         5gCQ==
X-Gm-Message-State: AOAM531uA9bqt0hFiyd9k53ucehkATTqnbGnKDcLK96PLqw9rzgAQm7L
        Lf6pBwvuVDhBce75CfM9UBw=
X-Google-Smtp-Source: ABdhPJxsMD+DlY8lJCkVd67chisGoLDC5nTave7KXb7zq59YiP0G5vCpGqWTob+c2VRedBvPOqtSeA==
X-Received: by 2002:a05:6512:1398:: with SMTP id p24mr5771133lfa.581.1643367629582;
        Fri, 28 Jan 2022 03:00:29 -0800 (PST)
Received: from [192.168.50.104] (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id p15sm1134409lfc.233.2022.01.28.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:00:29 -0800 (PST)
Message-ID: <ba33b2d13361e1603a34b928aa69abe74f6b3c06.camel@gmail.com>
Subject: Re: [PATCH 01/16] tools: Move gfp.h and slab.h from radix-tree to
 lib
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:00:28 +0100
In-Reply-To: <YfKeD8xqPu60GJUf@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <777d0cfcf531357cfe39d53987aa964a3a42ce8b.1643206612.git.karolinadrobnik@gmail.com>
         <YfKeD8xqPu60GJUf@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

Many thanks for your review.

On Thu, 2022-01-27 at 13:28 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:19PM +0100, Karolina Drobnik wrote:
> > +#include <linux/types.h>
> > +
> > +#define __GFP_ZERO             0x8000u
> > +#define __GFP_DIRECT_RECLAIM   0x400000u
> > +
> > +#define __GFP_BITS_SHIFT 26
> > +#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> > +
> > +#define __GFP_HIGH             0x20u
> > +#define __GFP_IO               0x40u
> > +#define __GFP_FS               0x80u
> > +#define __GFP_NOWARN           0x200u
> > +#define __GFP_ATOMIC           0x80000u
> > +#define __GFP_ACCOUNT          0x100000u
> > +#define __GFP_KSWAPD_RECLAIM   0x2000000u
> 
> Why have you reordered the bits here?

I probably mixed them up when I tried to merge the stubs I did for
memblock and the files that were already there. I'll fix it in v2.

> > -#define __GFP_BITS_SHIFT 26
> > -#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> > -
> > -#define __GFP_HIGH             0x20u
> > -#define __GFP_IO               0x40u
> > -#define __GFP_FS               0x80u
> > -#define __GFP_NOWARN           0x200u
> > -#define __GFP_ZERO             0x8000u
> > -#define __GFP_ATOMIC           0x80000u
> > -#define __GFP_ACCOUNT          0x100000u
> > -#define __GFP_DIRECT_RECLAIM   0x400000u
> > -#define __GFP_KSWAPD_RECLAIM   0x2000000u
> 
> The original ordering makes more sense to me (but then it would; I
> did
> it)


