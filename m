Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D55657E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiGDNy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiGDNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:54:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95603B87E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:54:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id m2so8643839plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YuDiKZU7EfcNQL+rzeCgRkNiy/TMZU6+tKd3YwKsSJk=;
        b=CQ7uKd7xsSYtmGRzR+Q1sBVDX9XY46b5EkGydRZ++I9xDEb9myMcaPouv+8DQgKS0l
         tR/RMDOTMNSRDtVzJk8zDRlztn2azw+qZhnHIiaYVP9WiiKHcWC03F+N+yfg68PHBhiJ
         6HwbRrUNkZQFaaQ0WBzvkhX+GBTcy7ZTYvi9BtKIOb/ymYpdB+cJdyY8yhMzOKvTq65E
         akqgJXKAFJDF7dgmX4Tp21kEfaBp/bRmK2UT4HmmKg7f4+xWv/rrgrIC0Refs/fTQyWS
         29C0Ic5zNENL4Vu94ClUWmRXV0uCiUgHXzj7yT/Rx4B8K/U5ADuWvZWQIJ3cQ06A85bl
         W1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuDiKZU7EfcNQL+rzeCgRkNiy/TMZU6+tKd3YwKsSJk=;
        b=NVX4uVeGZwioGrIyHAbD9MW9KKk3otdRQdFNAKbQSA+qB3ONzkEN0GBvQxs5kVx94s
         B/unFrrYMlGC70HYTEGq53p1QwCnk8cPJOyoE0lE8ycJIZ4UNxdyrx5Eu1WlO7VYDO4J
         q+YZFki9h6syA6eLhOkXgYEZYIHG6j716E1EvmgGs9PTWjXA+RQ5RVr46FxdO80gNqIf
         A7tS+nTAcKwiTtySsIByo8ebraKmormUWZ7LcXH9Rr4+MT0ff0G4EuZ7HJGTzg3LjJkX
         O0Dq9Ag3hkFKSJJCPJ0a313fgxIOWncwwa1Jh4+4XxrKstC+QTR7bPBOXJsnzFqQXaPV
         YYww==
X-Gm-Message-State: AJIora/h2wPzNQW+OMKdsntZC8Do/R0J/78eiBM3vnjQWNqtXZwcCZYF
        B74w2OF8tKd1UYhuS1XShhexLw==
X-Google-Smtp-Source: AGRyM1ugJ1ZeTToxVBdxab1va3DSIYni0NvvUBGbVAH6gpGwj0cEyjP+ovjO4j4iB6LQdR1ZMCc8Sw==
X-Received: by 2002:a17:902:d502:b0:16a:2cb3:74eb with SMTP id b2-20020a170902d50200b0016a2cb374ebmr35376848plg.160.1656942857196;
        Mon, 04 Jul 2022 06:54:17 -0700 (PDT)
Received: from localhost ([2408:8207:18d5:ce0:b44a:d6ac:cbc5:89fd])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b0041166bf9ca8sm12322096pgg.34.2022.07.04.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 06:54:16 -0700 (PDT)
Date:   Mon, 4 Jul 2022 21:54:14 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/16] mm/huge_memory: use helper function vma_lookup
 in split_huge_pages_pid
Message-ID: <YsLxBh2wok0VzDMJ@FVFYT0MHHV2J.googleapis.com>
References: <20220704132201.14611-1-linmiaohe@huawei.com>
 <20220704132201.14611-8-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704132201.14611-8-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:21:52PM +0800, Miaohe Lin wrote:
> Use helper function vma_lookup to lookup the needed vma to simplify the
> code. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
