Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E94FEB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiDLXrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiDLXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:47:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6952B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:36:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so434617plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ddR60CC/+AW5ism/4Dyt+M6y3W3eVRB2dK6r3HGxWEk=;
        b=Pyx50xAUsHN/UX0o8KaqJqhT/9rB04Yb+NlAdlXBcVxC0jl6b41C4ClKECpLnCgtwz
         l+QrdJz2hE7JW30VG4H+U/VF+z21RlXhPgCWwwyAPem89ru0NYHqOloq6rHDZY3PEbbi
         S2vEReueDAPfbLruJ8x14nSCwj8csJLEzWLiiA3nHbeDQokdYdK4qpK4r5H/Ptl5hrdA
         rqqe5JpEzy9pZ7pJPJB+29zolb/rgQsYA2P2K+Zf5GVntxfJiPoX7IxaTGH0u7U0k/dm
         aprg3Fl28M3YYLWhzjXmwg3zUBF8mQF4+ril4rHpsjadDapPJaixG8sEi3P0Vp4rTyuB
         Ylkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ddR60CC/+AW5ism/4Dyt+M6y3W3eVRB2dK6r3HGxWEk=;
        b=AJoibygqULR4svwSgCEoQqxb3FagyNexGRnI6xC1uDXqyV5+D7b7eyKAGMeL54eWeR
         OYcEIjPIaK7PB6cH6uNlZT+maUziI9L5CIbyT/cTxuU/afqs6CvQRRv1UvgYFtU4lmAK
         ExV4zudAO6ypuwmIJkhkS4hvWQdc9ZAB51ZzvOKJ50EM6idIvznd+oHIwrLNhQtvIhHX
         cghrr79kFPJhwh0UBMwwRhEYAkg8kf7EtBs/aDd7OS7BMViipF1JytuU/ueXA1gmlpEX
         u7ltzZhU1zQwAOJhDrKpQRMkYLpffNECR+ZvP0Hke0CUadaobEclAXi1ZNDASDwtfXhs
         TJrg==
X-Gm-Message-State: AOAM533RbYeD5t3WAc/x9aHDh1pronz8CcBehec04kzTDhO8NF95d+Ka
        xbxW7IJKD4P5CEBSGov4PQVHrQ==
X-Google-Smtp-Source: ABdhPJwvoirgy/nfXUQ5/xJtDMe8X42WJJg5uE9kh9MRDxgGlhaZD4C54kyKGlw1Cf2/ZLjw6cq5wA==
X-Received: by 2002:a17:90b:1a85:b0:1c9:d81b:33f1 with SMTP id ng5-20020a17090b1a8500b001c9d81b33f1mr7636842pjb.212.1649806562878;
        Tue, 12 Apr 2022 16:36:02 -0700 (PDT)
Received: from [2620:15c:29:204:1a89:45ec:16da:55dc] ([2620:15c:29:204:1a89:45ec:16da:55dc])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm40929444pfu.197.2022.04.12.16.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:36:02 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:36:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Jiyoup Kim <lakroforce@gmail.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove duplicate flag in allocate_slab()
In-Reply-To: <20220409150538.1264-1-lakroforce@gmail.com>
Message-ID: <2e18331-e3fb-5021-a948-d43ba61eb48e@google.com>
References: <20220409150538.1264-1-lakroforce@gmail.com>
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

On Sun, 10 Apr 2022, Jiyoup Kim wrote:

> In allocate_slab(), __GFP_NOFAIL flag is removed twice when trying
> higher-order allocation. Remove it.
> 
> Signed-off-by: Jiyoup Kim <lakroforce@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
