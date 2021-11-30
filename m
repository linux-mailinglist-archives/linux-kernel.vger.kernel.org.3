Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9C462BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 05:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhK3Ews (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 23:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbhK3Ewr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 23:52:47 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E28FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 20:49:29 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id f20so18999544qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 20:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VlAw6hUwfomqoFCYzHKa9IiNBK9XvWT56a/Phg/YEQ=;
        b=bLNx1iAXaJGglaO5Te+t66JgGuPFLNPZuiN4LBi3PegmiKltgkbspWK5YZ+OElAvZN
         8uRUARakN/GWYplMuXlGdTD3FSXPfFIPPP3x/UmHYADthoIn0lXzrJPKWgICXXByAb1N
         z+l5O6iRfISW3YTKXYGyPoSnUDmodxr7inIzemiu7MeOBapQ9fVmpv5tZVEKPhNiKzvC
         4N2yGl1AMzYoREAkRgcB0Ag4G8INXdx9bogepWF0NewMgPg2+WpENSHRT8qwYvOCjpcX
         TXUiE0jM/ojEABPq7d1GR3ZiXAYrosUHV21cHobBNZ1IlYxw0dF+svcxFgW3y2Edv6zs
         ko2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VlAw6hUwfomqoFCYzHKa9IiNBK9XvWT56a/Phg/YEQ=;
        b=G1IFTp8XkgEOEE1jE2ATwjDz9jzykQ9miUhOPvxtri7SMEk/6SItefzjvu2UM2Hs7T
         Ub8828kA6PPM9YiXNnvZol9dyEFWzzfeXJDiTl4Kd2UfSPQ9oB3Zzlw14uffGgJhuTqo
         v5MIOuf6J9NJFg82z1mKkjT3XrR4aL4FUlyJLf5bLKGnJfVzKfypmfym4D26cvP6wz/z
         8u6CV2jmrECCr6TXP+n7GFKBpVQQYlR3rD99+CyzRLYAFVRSPqbsUJelDfM8cJehzjpw
         dS+GO2HFehIRQ4wyFFHslHnRwKfcLn7OvgIgiyET9SFj3gCEJ/DjRuQStP0Iu5v6tZDj
         DjxQ==
X-Gm-Message-State: AOAM533vJ4XMQTwHJvtL+Bw0rX5Bq0fUNdDLI+woKXumiRjxthw2iQ1q
        6R3qEwWrB9j7NkLdaQ9mqPmWMDhlln+7ng==
X-Google-Smtp-Source: ABdhPJwnwA85/CwNyfObYXGGmS5yCY+wucpQvxwY7b+TEhxQZZWJcg+rfWv/Q0WXmmdxcuplCJgmwQ==
X-Received: by 2002:ac8:4e28:: with SMTP id d8mr48570669qtw.11.1638247767777;
        Mon, 29 Nov 2021 20:49:27 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:4de2])
        by smtp.gmail.com with ESMTPSA id t35sm10545345qtc.83.2021.11.29.20.49.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 20:49:27 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     ying.huang@intel.com
Cc:     dave.hansen@linux.intel.com, hannes@cmpxchg.org,
        hasan3050@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, riel@surriel.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 0/5] Transparent Page Placement for Tiered-Memory
Date:   Mon, 29 Nov 2021 23:49:22 -0500
Message-Id: <20211130044922.42995-1-hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87ee6yv3ao.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87ee6yv3ao.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

>Thanks for detailed description!  After reading your patchset and the
>description above, I found that the basic part ([1/6] - [3/6]) of the
>promotion patchset as follows can be the base for your patchset too.
>
>https://lore.kernel.org/lkml/20211116013522.140575-1-ying.huang@intel.com

Yeah, I agree with you. The first 3 patches of the above series are pretty
much the base of this series. We can add patch [3/5]-[5/5] after your 3
patches. Then add the patch [1/5] to include the statistics counters.

>The main problem of that basic patchset is lacking review.  Can I ask
>you to help to review that patchset, especially the common base [1/6] -
>[3/6]?  If you think the rest of the patchset isn't good enough for you,
>we can try to merge just [1/6] - [3/6] firstly.  Do you agree?

Sounds good to me. I would add my reviews within the next couple of days.

Thanks,
Hasan
