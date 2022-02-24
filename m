Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72134C35C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiBXTXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiBXTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:23:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28922177FC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:23:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id bd1so2661400plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=clEmBoE5acfF2gaQU5Wymn1ivohsrBcp66owW0vTwCw=;
        b=LNrYxtpkyVVfVMoICJScMFXUo0rHwiaINcVDZUnigMYd+H/xLqwwqvMhzFk4Ipgyom
         5vMfg9P17OZ4Pk2VDFT3Y8lofLf3PrgZlHInDxlWu9viEuYmAk1+6JPjXAiCE0LlMP4t
         kHQKVVaZJLdToGcuaJa/jr1Af7G3SyRzHwWHJXdvToLFfLBxcHwRYSKo7oRPcBKfC/vW
         NtHZE90IMf+MO5SMgEXJ4OGksP0g2mzy/4X4lbZaB54fe0zxiq6WyYBRpIwhfbcjWgwf
         XvfoY+jd1balbv2X7M6KxzJdzqKe4uXM5NrjDYhzohpkOsSke1nogWbG+i2BCd6+H3MN
         aHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=clEmBoE5acfF2gaQU5Wymn1ivohsrBcp66owW0vTwCw=;
        b=F7OXqZ+w0Yi3HuxIp/QTr95oPlppMnthMYggcPWRvX3Szp6twL7lrRhJoHNU94KMiR
         bldDIKLhhe7/bK3YfwOkPKVWDNBUjWdoHNhyeT7Pq2ZeX3x5xo38GKAzoBMxOu5apNdd
         RW/+z7Yvw0MHoTn34zC/WHcTq8/rf70iFnRNn4oHLGo1Kv0tZI7WbP8Aoeu2PJq3NvuC
         sfLdsbAKB666/qWJlolaZJQ74bI/H0fde6onod33Gr5tsR/mGdd1wYOyYPLOME1njhnj
         P1WBOKPim1foxKMypyV5x3yqPLeZQBhcsL10BcdJEg21tKs9+Urww1vPfVb/8KUfryz7
         jUgA==
X-Gm-Message-State: AOAM530DfUHavmf8kd/5Hogz+1KH/lMUZefbeWVTCimpaVRlXa1pR+ap
        2itaW623pE88sjTDzguhqhgXuQ==
X-Google-Smtp-Source: ABdhPJzYNSr+DxP6f/PRS3isytin7hYe3mJ0SSeq4b82nW2GIJ39fHj2ZGGu/uq2IAwDm0mbt6+KHw==
X-Received: by 2002:a17:90a:aa98:b0:1b8:5adb:e35f with SMTP id l24-20020a17090aaa9800b001b85adbe35fmr4223123pjq.192.1645730595880;
        Thu, 24 Feb 2022 11:23:15 -0800 (PST)
Received: from [2620:15c:29:204:e8e6:cf42:a32d:384e] ([2620:15c:29:204:e8e6:cf42:a32d:384e])
        by smtp.gmail.com with ESMTPSA id y39-20020a056a00182700b004e19980d6cbsm211760pfa.210.2022.02.24.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:23:15 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:23:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/oom_kill: remove unneeded is_memcg_oom check
In-Reply-To: <20220224115933.20154-1-linmiaohe@huawei.com>
Message-ID: <1b625d1f-96eb-5535-1fd3-4e5ffa7d6c3e@google.com>
References: <20220224115933.20154-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022, Miaohe Lin wrote:

> oom_cpuset_eligible is always called when !is_memcg_oom. Remove this
> unnecessary check.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>

This keeps oom_cpuset_eligible() only in the nodemask eligibility business 
and memcg criteria remains isolated in its own function.
