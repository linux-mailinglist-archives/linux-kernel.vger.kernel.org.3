Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0C5168F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378268AbiEBALS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEBALQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:11:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477F36B5F
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:07:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i1so5187150plg.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 17:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=YzsDEybAjOOP1Cs8W+wRLjhXbrCelC2lIiMankmGxrA=;
        b=fdyLSmlvCVmR79RNwMGF55XGN6VVAttNyNagk5QJFjzBc0CcMP2hi2gJg/pNGqLyn0
         BKtc7tG/qgVzOn7ic53rXhi7IwJE6+7VnL2Ca+pN4Mjo5In0O7w2xYPLiYiHukBAmmnS
         c9q5FFivEDfFltjAFgmjL0mOU3Qb/VMhIiN/APbMGCAwvHMYXQe0T4biiwlSesHJwaIi
         1eVENR0XXPt8nsr5IrVwg12/P/64R/gaF443xcv+lVnjK3t3tk6ZuVi9175mtxwOrkHt
         r6ukXULisdXkQExfEKpXMCsJJSZyXTvHmzi/XIQ80T59ZiJ6mvgdtb1Fx95JLXUGm3mT
         0oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=YzsDEybAjOOP1Cs8W+wRLjhXbrCelC2lIiMankmGxrA=;
        b=QCdRhtAmV4J3At9wYiawdKOt/iKyARFYTGYk0rl8Dbnw9vQWRxgD58W7GS9lOwYO2n
         W1vi809dLaLkHBaOCRMHMGDtDoNA1MrgkZhmb0WEdQo4ZrkphfQRw9K0b1cAXOq51/+M
         WpYoiGM8Tp8k60yCXmC+40FWP0nlRiXzhGVx4SlWDI3lUNwfGLfs2dKvzK+U6Gze3cQA
         eoMQexhm/kwwVXGqScp/CjRrm1Ruor5qaaZ6ZULf9IeaLuQAtqfSYhiqICAtOO1tOTv+
         YnppENLWm9JFikU1rgEORKqWZhzmgJYP/c9NDFDRf+Rigo7V7+n64CUHHkapTFyVtkzc
         i6wg==
X-Gm-Message-State: AOAM531yowZyp6R1xTt0HNq7Wspatb+tLB8gmkLsKZH1PUaQ0Z0/D402
        lZe3RjZ22X+iJc+7TDUmgepnZA==
X-Google-Smtp-Source: ABdhPJwuqokwBxkv6G0j9m11izMCwjLEp3r34bgEXl74l2B5d678+KrWl/Hg7ACIWVgllztB8CuXrQ==
X-Received: by 2002:a17:90a:6d96:b0:1c9:c1de:ef2f with SMTP id a22-20020a17090a6d9600b001c9c1deef2fmr15160970pjk.210.1651450067557;
        Sun, 01 May 2022 17:07:47 -0700 (PDT)
Received: from [2620:15c:29:204:e310:ef81:d548:9992] ([2620:15c:29:204:e310:ef81:d548:9992])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902b60e00b0015e8d4eb2basm3356427pls.260.2022.05.01.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 17:07:47 -0700 (PDT)
Date:   Sun, 1 May 2022 17:07:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove unused kmem_cache_order_objects max
In-Reply-To: <20220429090545.33413-1-linmiaohe@huawei.com>
Message-ID: <f2e856bc-693f-3019-920-c9c6c76b99a@google.com>
References: <20220429090545.33413-1-linmiaohe@huawei.com>
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

On Fri, 29 Apr 2022, Miaohe Lin wrote:

> max field holds the largest slab order that was ever used for a slab cache.
> But it's unused now. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: David Rientjes <rientjes@google.com>
