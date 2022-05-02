Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2428516902
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379114AbiEBAQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 20:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354401AbiEBAQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 20:16:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081F950464
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:13:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so11309964pll.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 17:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=P3p7W6LfiPMYuM2uvtz5cp3Js4BdRWCXOqiaEvfNVB8=;
        b=j6/NFJ0+qhiXy/suQ9NLTG29hfHdeB6QUrV7UhI+WmA0/SVAi5Z/Z5r6AlyRzy9RZ9
         RErwz9mBzsidU2oZU7fALLnlP1Rm5iSn7/gXcxnpPtR3Juf4EVStV9I+zYz6PoNSC6Q3
         T9oTscPYUx9kXvd+H771DIJK1ICyVmgktlYedZ3Tbqx3vCR8/SM9toqbHigO8DKCR77y
         W+AP8ywUTGVK7QgaxpuuIclHWz/5H7xfO3iJyCJYo4eSx/Jxiap1oP+E3zMGTiOfVB2p
         i9XoqGyN/akFWlDFYIwJiQnX7TXQggKDH8Eu7QlSEwm02irD3g7b9Y6VgwpNIkcsHKGt
         s/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=P3p7W6LfiPMYuM2uvtz5cp3Js4BdRWCXOqiaEvfNVB8=;
        b=vpQqYx92NIFhajv807M8jIvRAAnXcDhnTXHk2lMNzxhIt62lthwSlc7D0QxeZs7qQQ
         LNZxS3bwXrf5HZKNWXHuzb3RRn+5xUK6WubFmXUkmg64QITN0CDEiVjz4w5ZVs188JN1
         2n5ktM61VYjCbRaohCcxpEewYBoG6z0yzmIoGAl12y6i1lMv9Hia67JkSz7jWwIR/TJr
         zRnw/tq+0RgP+NZYdZ+x7zgnJp9vgqxiQ0qm1gM7GJfp4F5p6+7sw74NqbZjvrcaXnup
         bk/FY9libpk1jL+CEUVG1dDzK4rkuCxfu+C/wPDxK5paBBX/KeufGFo55lDI4OsnU896
         TzKQ==
X-Gm-Message-State: AOAM532KLf3U4GrLeQ5AkHhjuuVKPAg6LCd9fmLWx8zSQXJJW3SS/2nL
        zV0dg6gzccddTP2PuwGD7bey9Q==
X-Google-Smtp-Source: ABdhPJx3ccr+0J+BQA2y/i67wsx1WVkeRzNQVowX63y1jEX7rxgaB3VBgJwQBKo10ulfz3CYJ0gERA==
X-Received: by 2002:a17:902:b78c:b0:15d:2431:a806 with SMTP id e12-20020a170902b78c00b0015d2431a806mr9548504pls.77.1651450384314;
        Sun, 01 May 2022 17:13:04 -0700 (PDT)
Received: from [2620:15c:29:204:e310:ef81:d548:9992] ([2620:15c:29:204:e310:ef81:d548:9992])
        by smtp.gmail.com with ESMTPSA id k21-20020aa792d5000000b0050dc7628159sm3385658pfa.51.2022.05.01.17.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 17:13:03 -0700 (PDT)
Date:   Sun, 1 May 2022 17:13:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     andrey.konovalov@linux.dev
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 1/2] mm: slab: fix comment for ARCH_KMALLOC_MINALIGN
In-Reply-To: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
Message-ID: <97db2796-ceb3-fe1-6f7f-3d4bc93fee19@google.com>
References: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
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

On Thu, 28 Apr 2022, andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> The comment next to the ARCH_KMALLOC_MINALIGN definition says that
> ARCH_KMALLOC_MINALIGN can be defined in arch headers. This is incorrect:
> it's actually ARCH_DMA_MINALIGN that can be defined there.
> 
> Fix the comment.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: David Rientjes <rientjes@google.com>
