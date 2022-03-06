Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C84CEE15
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiCFWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCFWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:08:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18241D326
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 14:07:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s1so12166178plg.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ott2Fy6zW0YAlx8wzwMZzzUaVRMCd6cEJUB+xxtueUk=;
        b=Qj1awOLyyLqVwaOgk5PKOi4INIcAaAkqsf36jgPyP1DIXghU7kqsv5eoerO37U4A1s
         uA1pf8jYDMytw9X3Pym0vYmxpdndetiW9tBjHRPBYGuM+c5cOEG2Nbv3f56pUmPRWgRR
         vOpuYVWNO980M3HylaUGpMGZMy+4X1qCl+umpTPVDLXCa3maWuuQAN6ZkLT+GrISWGZp
         s1QLKinV/QLGQYwgaG1loQQCFUNB5QE5cYSPrOGMWPTIZ/GxTghHMXYsIwcNH7PvdSi+
         V54Bg4kfWKfIVoBHMD1uGX9qERNIxnGWS4RF85iT9z6M0ivKRbBI8CIHYgpRnHZTmzKb
         RpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ott2Fy6zW0YAlx8wzwMZzzUaVRMCd6cEJUB+xxtueUk=;
        b=WawRKVigVrt5+EMa9K+VJSjMFz7Sl1+X6obav2+wGTF5LDFKtcmwQ29zVXUKI5I+wY
         3j/484toRs+2JI5k7gAZKDkq1OWfuolnCdrOQK0TD1J+j1Xi+M8D5Yddj1UV9dUQL8r3
         htlmWuDcVYCYmB7t7ERrHYUjTohsR59twMaLJ8jZE7+DxdyQqGP7sgb1HaVhTULGG4SC
         bl8wFWwXiUqCpCK/S2gyWD5bzBHhqdM1U8+f9fUXEEa6NeSp8E4q8DAsCM//GXX6F5FB
         97xIicGGB00Nf78wWURDQ79exeglpBiK5kMjLcOJGRHsRFqMn4W0c9STYG905kvC7QmM
         s9dw==
X-Gm-Message-State: AOAM531bkYBBsmwt+dzTh3ARo0mtBiqdaSe5AeYR1U2fDgiOGmnL4BLu
        xYx2VcZ12VzfYkfaD8YpmLAE6w==
X-Google-Smtp-Source: ABdhPJxWgicViQ9wemdU1MnHl7NEto1XHjnw/D9hyBaoAh07z1cixmUct+1ujUEekw/FlGuF5PBORw==
X-Received: by 2002:a17:902:e552:b0:14f:bfec:eb2c with SMTP id n18-20020a170902e55200b0014fbfeceb2cmr9248566plf.108.1646604461700;
        Sun, 06 Mar 2022 14:07:41 -0800 (PST)
Received: from [2620:15c:29:204:5f87:a605:2b59:e392] ([2620:15c:29:204:5f87:a605:2b59:e392])
        by smtp.gmail.com with ESMTPSA id s21-20020a63dc15000000b00378c9e5b37fsm9670409pgg.63.2022.03.06.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:07:41 -0800 (PST)
Date:   Sun, 6 Mar 2022 14:07:40 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Hugh Dickins <hughd@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: __isolate_lru_page_prepare() in
 isolate_migratepages_block()
In-Reply-To: <879d62a8-91cc-d3c6-fb3b-69768236df68@google.com>
Message-ID: <f77de36f-32f3-9036-98b0-d07d851b8e0@google.com>
References: <879d62a8-91cc-d3c6-fb3b-69768236df68@google.com>
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

On Fri, 4 Mar 2022, Hugh Dickins wrote:

> __isolate_lru_page_prepare() conflates two unrelated functions, with
> the flags to one disjoint from the flags to the other; and hides some
> of the important checks outside of isolate_migratepages_block(), where
> the sequence is better to be visible.  It comes from the days of lumpy
> reclaim, before compaction, when the combination made more sense.
> 
> Move what's needed by mm/compaction.c isolate_migratepages_block() inline
> there, and what's needed by mm/vmscan.c isolate_lru_pages() inline there.
> 
> Shorten "isolate_mode" to "mode", so the sequence of conditions is easier
> to read.  Declare a "mapping" variable, to save one call to page_mapping()
> (but not another: calling again after page is locked is necessary).
> Simplify isolate_lru_pages() with a "move_to" list pointer.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: David Rientjes <rientjes@google.com>
