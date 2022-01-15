Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067FA48F9D1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 00:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiAOXpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 18:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiAOXpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 18:45:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6178CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:45:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c71so48925802edf.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 15:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w75my6N+lE9Tb7Xrd/3B5AqGyYJg6q7bwJts0m1eHAM=;
        b=HULieHlYiwuUrdzEf/a41YN5yHintRqwUa+1XNEXIwjwf+O7x7SO8+/0ejBJiMkLRv
         Qa7gt8IC33b3dOj97R4TZthJuecJMwdGbrnLHhSzMwjJ2yX4rrx3FJHeMkJG6vyzGCWw
         wj7bVt2ssWFUwm8gHkV6o07eNmrWKxsBXpSgTZFrTXKQrElgqaCHytBXy3GhHHXbPlis
         GB1n0zQrJQZqdM61P+Fc4cFNJ0D+yym7BaFwavjAtR9ZHs6dHASEs9H6vQ3XTkRkXNo+
         e9tC5AhoOCXa7771/23ATjXEEvLPGKi0FYPuiTxTC3YYqRxGwsqqiAvOoRYfd47cwwYO
         Morw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=w75my6N+lE9Tb7Xrd/3B5AqGyYJg6q7bwJts0m1eHAM=;
        b=AiVOmYTtTWWeDsHu4iFx97l4eJp6cZ3BB6pg6EiTsMy3bRH95FPtGC0Aku3l/d8/pk
         MBaEtw+ARd9BEIiYf00q7sw/2ctap1Uypp+DKoW1TmAckNvo+jCTO7gOtu3ng1wUT4IU
         XYfRqiYfqeEU8ob0nLukuXmYbNBUulDbEMPFHx0Yk2UJvngP49hI7Dd8hVJUgdyHH5/5
         ROPVBoXg+BBIthWHxwJ53xxS36t4ktT0/K3b8pdAiXc1tysCaYVAVzFnqDnumfI+jCyS
         e07q4Gk7Lwql1mL1RchkFhhdO9MrpiJ1+0jvXet6ZtxPA1IjjIsv8SShJsUote9CL6ij
         qLQg==
X-Gm-Message-State: AOAM533B4jNIrXuQaYkKBVUg0ZC3unmdUFpSzWOmNkgJjrDpbyR7Ctl9
        WX/6j+w16+gWSTOyWqINA08=
X-Google-Smtp-Source: ABdhPJxIdNHo4amCDxOD387P/932l4bdBqsU+sfIquBgaBClOd6a7rSXfKoEW6rcSfE9h29VW8ubEA==
X-Received: by 2002:aa7:c60e:: with SMTP id h14mr12964037edq.40.1642290318922;
        Sat, 15 Jan 2022 15:45:18 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e26sm1407022edy.36.2022.01.15.15.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Jan 2022 15:45:18 -0800 (PST)
Date:   Sat, 15 Jan 2022 23:45:18 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: Re: [PATCH] mm/page_alloc: clear node_load[] in function
 build_zonelists
Message-ID: <20220115234518.4q2yhb3mz2sg76iz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220115230002.490-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115230002.490-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 11:00:02PM +0000, Wei Yang wrote:
>static variable node_load[] is a helper variable during build zonelist.
>On each turn for building zonelist, node_load[] is cleared. So this is
>proper to do this in function build_zonelist.
>

Hm... sounds I missed some important part of this operation.

Please forget this one :-(

>Another side effect is,  #ifdef CONFIG_NUMA could be removed since
>node_load[] is only defined when CONFIG_NUMA is set.
>

-- 
Wei Yang
Help you, Help me
