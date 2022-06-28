Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD64D55E79F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347481AbiF1OzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbiF1OzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:55:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22174CD3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:55:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x4so12262055pfq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gs4Z49+Sv8Qc8bfwigr9mzVdH+n7dCxIOgDj3WveRMs=;
        b=tu7nFxkZVomQ+V72k7KZfhhZk2i3nioq1MYkCf0OiaSkL7mwMS+6PTezmna2i4/0u/
         HM+KfdtVCkoh+IYJ8+Z5RyXEzJ2teBalEfG7k+O58OovQ/UKP95NND+gPOxn7huaakeu
         IldoaWvAKfJq3zl3F+82sbdEJM6450aC2MlRM0vE86jHEK1VnCYQR6opJuaYQNLFAYv+
         iTi4xWITGrEpQkTEkFN3xcvPmnF+zpkkgRyC7AwtBU8AnFWibFd3P5eI0COguaY1s2+V
         eDIEmotMpy/EvZY8K3BFkICY0h0Bq/kfqWQTsE+jkU3QrCiBpLlrPwjp7TZNRW93u2Li
         C2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gs4Z49+Sv8Qc8bfwigr9mzVdH+n7dCxIOgDj3WveRMs=;
        b=zZtkyK4FzO6KaR+zyZ4LG1SClPqOCg7dA7Qh9ONPUVrTaRG0yj9sEZdLhyNi+ut/b8
         hrfaGG6qtXfl5mNRa9KN4TezNAUmUjj4rUh7AFiHL8XTkg69B0Q8xbX/Lm3QUtPzTQDb
         uGVy42n707h0QcB/Mnbanb07NubUuG/weFu+zOVMWZtoQeYfrlurXiz/d+NilTsd3FeH
         5WCiYnyJ58RlIyZegpfAQv2q44+77ORml96JPXFL/bVfE+8GqgP1ZJW/2rIVB23bvpRg
         KMJpK65Tfnx9VoA1nzLEkR1zYyhvzsIbrP62wu3pUNDb089kQk2th2/j5S3L/gnE9XNZ
         0pGA==
X-Gm-Message-State: AJIora+l/ZByuFT+TF4SShs/xNRsh19n5Yd564+IL+VgDkQLHmMo7iaU
        LUOC9mV/qUP3PRWXyzrbyxA8Sw==
X-Google-Smtp-Source: AGRyM1skRQzsPlON3aNx0v6HafkJ+zEyZdM9U/IBLgY6waHJ7bBth9nGSn53TS+JwGeqLKGeH+yb6Q==
X-Received: by 2002:a65:6d89:0:b0:3fa:5523:440e with SMTP id bc9-20020a656d89000000b003fa5523440emr18176357pgb.318.1656428100665;
        Tue, 28 Jun 2022 07:55:00 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:e153:cfbc:e790:5935])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b0016a0d350b78sm9608281plg.58.2022.06.28.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:55:00 -0700 (PDT)
Date:   Tue, 28 Jun 2022 22:54:53 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/16] mm/huge_memory: use helper macro IS_ERR_OR_NULL
 in split_huge_pages_pid
Message-ID: <YrsWPVB8TSLSM7zf@FVFYT0MHHV2J.googleapis.com>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
 <20220628132835.8925-17-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628132835.8925-17-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:28:35PM +0800, Miaohe Lin wrote:
> Use helper macro IS_ERR_OR_NULL to check the validity of page to simplify
> the code. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
