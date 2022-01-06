Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5248609F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiAFGZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiAFGZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:25:12 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE8C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 22:25:12 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s1so1749517pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 22:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJpNPWZbNxA6hjcR5adyIR3AyFHec39t6NTKjP75kD0=;
        b=ih4/ZHixgiiP8sfoqrZeTYEItZ2rUUhJEaElVwE21+BvDJJaayvcAt8PMTcR8thCXH
         qJITdYvB1B1MEh67ZdsV/UDDztEa2IRGvDwxLBb8DGWGIiUbeIr4TZfreHcWBX2C0leo
         I38Ep0uh+4b3sl8ZtTPU5Wefe+ApdKKZMU2GL9Ae5D/HzkRNpG1f6ZP3i2YgWVpmbP4h
         wpGF2ttGseoXMFdq+RL06iN9PPJrdzbjQtymstX5p+hQJwPOnKXjrwmYR3xZCGkIHCQf
         PWcOducPqBGl6EbqH5ir4Opj8mPzmTV+/r29nVBWa8DscrimLmWHAtOnArBTLiWQslyZ
         WToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJpNPWZbNxA6hjcR5adyIR3AyFHec39t6NTKjP75kD0=;
        b=w7UtdpUks+LL3ktfnefrj155A4+scxUnJx4B63lZtClwex10vLCR3vQBC/PeB611Hq
         Y4O+1R0ZiwO09NdLwngO2f4HUYqzVJowO5T8Tpc+ePsXWLLEQWGjqsdqSc50VFiNkUuA
         59BWKK0ED+pr9b+jHk6+Fcv3os4+1DBF1dqCEGWJZybZNqbwgflu0Ut3NWJ5BReR1p8R
         sKGZz0pk2cAjB6fhD2rV6cnIZ5BxUaVlZVPh7XXcfUno0QH386lxvqbSoQb+odkh71Ts
         1LRRckx287UhRRVLdhKX1Mh/zCTlEjGXLUky06/eBTCjEz0d9+hoSAqhKdK/wj1SDlMV
         WXUw==
X-Gm-Message-State: AOAM533oVQbiVC6punFlmojYx33KHM+PmgfIu4I6mtABXtMXV+Jt4XPW
        1WQpX1vFKApRwkDUA0SU27U=
X-Google-Smtp-Source: ABdhPJy26nZrNTcpuyuraN+LWje2VVKmMlB5uMW4T//o5qWordaPb+KlHt5kkJ+r1dMbf6LxO69nQA==
X-Received: by 2002:a63:751b:: with SMTP id q27mr51270111pgc.184.1641450311864;
        Wed, 05 Jan 2022 22:25:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z18sm1103889pfe.146.2022.01.05.22.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 22:25:11 -0800 (PST)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     alexandr.lobakin@intel.com
Cc:     cgel.zte@gmail.com, ndesaulniers@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, torvalds@linux-foundation.org,
        xu.xin16@zte.com.cn
Subject: Re: [PATCH linux-next] tools: compiler-gcc.h: Keep compatible with older GCC versions
Date:   Thu,  6 Jan 2022 06:25:08 +0000
Message-Id: <20220106062508.619587-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103144635.5952-1-alexandr.lobakin@intel.com>
References: <20220103144635.5952-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> GNU C    5.1

> This applies to both HOSTCC and CC.

> > Undefined __has_attribute as we built the whole kernel and tools.
> > 
> > To solve this, this patch is given to keep the compatibility with older
> > GCC versions.

Yes, but I think this error is a little unfriendly to users using a 
lower version of host GCC when cross compiling. 

Perhaps "#if gcc_version > = 51000" could be added to avoid the error 
'Undefined __has_attribute' 

or we can add `#error "hostcc don't support _has_attribute` to remind
the user of the cause of the error.

Or just use my previous patch.

I hope we can do something here to promote the situation as Nathan talked
before:

https://lore.kernel.org/all/91B93D4D-BEC8-4ACD-B71F-27C54D8B1B78@kernel.org/
