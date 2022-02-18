Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A304BC006
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiBRS5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:57:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiBRS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:57:03 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFBC33363
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:56:46 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d16so8618341pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dbe5PmbOzu407KEsPvcN8zvRJM1P0pbKwetHq/iEzos=;
        b=lFy1wh6Fs5vAcbQolk5/ZuS0j8ngCp9l1Ec5UjYZCnmRC8oPrhCexnNr3sqTmnpC9I
         ar+eBAwyb3BGhb+qlCicc7nB6hWxdPwpNTFDQ/Y/TaQ+C1Wx7XCv6esI7uC/XQWIsCQl
         dB7j43NJaM0uQu3fNB5gj84GqiWGt/vXA1VCj7CmPwf95ZKiCsxgZ+0U/ktem0WBpHs4
         Vdz/ZOxBCAiSahiBaoqYgZzfKrhsemQoRdK9LvWCveUyt7xsxkJ4nm+Lv5jP4lEQneb0
         uN2nEkRPzhhXlNhlD9haNEYnSshl37Q9+W/L+7aCBzTtBPj4a+uzT1NNMsR8dhMXu7aH
         V9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dbe5PmbOzu407KEsPvcN8zvRJM1P0pbKwetHq/iEzos=;
        b=Hh9FEpdM3iSHwprel1DrnvVl6bX4n6wYAbFDdQ31bII9dd6Ywd7io6UUb9ibycgw72
         ExswFhN+hxS4VMp07jIoeQyrWMAa/Xilm/mfIQhIb3zFFursINwtYt1cPm3YEMnUCY2f
         +zU2HyZGYezqzW2c8kQNYZkyjDb+WIMv8zsuDVPFjKLQ0oSTDtjaiCBIGWUfuJVrMfGA
         tEMCwhy6dmrEJykx4uzSOqnB4M//By8PXx1IPlzPp59vPpycOLfAFlxkDtPPNEIl9SQR
         1v/vGcRDAG7VLEbVvzxkTdo/DKyO2APUfJYohRCaUFHBEXkcFcerm0/FS+H6l28ZN1OO
         Xy9Q==
X-Gm-Message-State: AOAM532TQ7L1Atm7NimsqHXykL7AaJqZorRQcP4gdUaRG/+hvm+2OQ67
        yb6oVEZKXp9NngOdZhTRPTfMpw==
X-Google-Smtp-Source: ABdhPJwSjj6GxMmzYDQ5iCyFOqCMP2mgbA8qtwDhJa3dj1eG4LQCuQFN/eBzULYMlQIQK1xbNs9SOQ==
X-Received: by 2002:a63:ff54:0:b0:373:520f:a01d with SMTP id s20-20020a63ff54000000b00373520fa01dmr7313446pgk.394.1645210605382;
        Fri, 18 Feb 2022 10:56:45 -0800 (PST)
Received: from [2620:15c:29:204:701:472c:4005:6710] ([2620:15c:29:204:701:472c:4005:6710])
        by smtp.gmail.com with ESMTPSA id a17sm136665pju.15.2022.02.18.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:56:44 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:56:44 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [page-reclaim] [PATCH v7 11/12] mm: multigenerational LRU:
 debugfs interface
In-Reply-To: <20220208081902.3550911-12-yuzhao@google.com>
Message-ID: <5dcf93c7-7b75-507e-f896-d1bd8c7ceb37@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-12-yuzhao@google.com>
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

On Tue, 8 Feb 2022, Yu Zhao wrote:

> Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> reclaim. These features are required to optimize job scheduling (bin
> packing) in data centers [1][2].
> 

Johannes, do you believe this interface is sufficient to induce memcg 
based reclaim or do you have plans to propose a memory.reclaim extension 
to memcg?

I assume that lru_gen could be used even if memcg is disabled whereas 
memory.reclaim would only be available on systems where the controller is 
mounted through cgroups.

Yet a question would probably arise about the stability of this interface 
since it lives in debugfs: can we plan on /sys/kernel/debug/lru_gen being 
long-term supported?
