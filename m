Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF5D474014
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhLNKHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:07:46 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40705 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhLNKHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:07:45 -0500
Received: by mail-ed1-f47.google.com with SMTP id r25so60657108edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk+MHheap85NSi5Fjsd9/0VaLUSiOp+S2QJ2lixcuzs=;
        b=SqjqZx0xspl6+Nrtqp08uF6jwf43JA0u8yyHp8EwTXHU5Cng1/bWz4q7c9NZvsNYMS
         dWM09oOQN8O0jxT5gGloTrWDrrAuhVeCpfl5m/DSur/B1rguVQ4Kf2zvUbgEhb3Fe4Op
         zauUFNBECYRUIpaBS4ECgTu2uVZjk6c8piuHXwpEoNqlIQxx+f4gqR4n9BqWK4hZ8qpL
         fkMOmMKAALvKhka7fwV8/T5cU5LGYf/NPPBCruIijp4su+vqp7Ywis0gVKFd7LTU1cpj
         hJeacGs5W3hUz/ANzCelSQUEC4ut7Lriggfm2ps8gWLB+1D8/NKTvXrAq5+/fmpyR9Ma
         //cA==
X-Gm-Message-State: AOAM532BTC8ly721UVUi3n69xcDOlG7QLGw/YSp4PInqThBN6hDzgrtC
        5xzSfl2KwOC/1paFSn1lgI8=
X-Google-Smtp-Source: ABdhPJzNIasWTrg2Vid0JO3xi4XxWEz/iMSD9CUbre67t6oQAPQSBo03SxTvl6wT/Twpd4lDcJKcbg==
X-Received: by 2002:a17:906:8602:: with SMTP id o2mr4724148ejx.624.1639476464168;
        Tue, 14 Dec 2021 02:07:44 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id f5sm839766ejl.219.2021.12.14.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:07:43 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>
Subject: [PATCH v2 0/4] mm, memory_hotplug: handle unitialized numa node gracefully
Date:   Tue, 14 Dec 2021 11:07:28 +0100
Message-Id: <20211214100732.26335-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
References: <YbHfBgPQMkjtuHYF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this should be the full bundle for now. I have ended up with 4 patches.
The primary fix is patch 2 (should be reasonably easy to backport to
older kernels if there is any need for that). Patches 3 and 4 are mere
clean ups.

I will repost once this can get some testing from Alexey. Shouldn't be
too much different from http://lkml.kernel.org/r/YbHfBgPQMkjtuHYF@dhcp22.suse.cz
with the follow up fix squashed in.

I would really appreciate to hear more about http://lkml.kernel.org/r/YbMZsczMGpChaWz0@dhcp22.suse.cz
because I would like to add that information to the changelog as well.

Thanks for the review and testing.


