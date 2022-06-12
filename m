Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492B547CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiFLWpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiFLWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:45:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE91215FC9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:45:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i64so4262930pfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=q0f1A17KMMkWY+nfdWjnp3/WBEBTX/o1Fa+8qgMWehk=;
        b=an6MrVk1lDtBSPGu0TJAIOp5gRAnrvsHFyGVjvdsojcZXOQl/4ln5KkRoKTQhnUh7z
         JZXcE4dJ9WpqMFRDXAQKXepMfe5D152C9OevGG+OStZWNQ3m56kEi4lwjF1FOkiyWm4+
         MU7RXKkdgXb951AhGnFq3I7Nx83iX9OvVbpP07V39kglKgSytDxZYmJNY/e3vJnuw8PM
         pDKk/j277v1Zo2ILcgkvy5/vHYa2gnJhPqk5oNXLZrKvct1WAfPZqpJ7rntq8W/c2g3n
         N6VtmGNetH14DBqbUJ4t4rAaFU+GuiC0WCKQ3vCK/NMRGYsA0wui6T2WGpVZ7cpmlmuR
         0eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=q0f1A17KMMkWY+nfdWjnp3/WBEBTX/o1Fa+8qgMWehk=;
        b=qgi0S/+rGEJWT2LW0hInn4tghwIOWLN5QduapH0FSaYmQfyAugSyji73YFjQBUwJfi
         kd+QZqrlCpZpeuS35rKPdgsK4RpEutQfipEa6PbZCZxO+pPxWQMYj2SSjfysABCA59BO
         h10peKoqzel6wXUhAFq4P+GVgNlmzNhtRL45Z9c7juPHmt0e8giR4MPuHKi/VHdyhQwB
         jIf7aiIlN2lLmKNCFP8TRcEpP9a1Rvnc3HxFTYBz5jjTrBI+CNc2vj6OXNaGtGv60MiE
         0w/D4GePjyiRffPqjpSUsgvZmap7oHuodwxjzc+4K2yYHveCauPzIxC5tJMNG0C32jF8
         Qd7Q==
X-Gm-Message-State: AOAM531szQswOP/7pdChbK/RftxN+p1bGZ+Hl7YYdBYBHbAuClartS7U
        RdkKz2MUHevwyANFcuTbY8EsuA==
X-Google-Smtp-Source: ABdhPJyWmIRqZ4MDiC/wErTkIB8w0hayslpWYWIHnd5B712wg7c+DYVwtaDkPnbScCMv6JRfeUP3cw==
X-Received: by 2002:a63:1c5a:0:b0:3fd:1865:a789 with SMTP id c26-20020a631c5a000000b003fd1865a789mr44401640pgm.413.1655073942906;
        Sun, 12 Jun 2022 15:45:42 -0700 (PDT)
Received: from [2620:15c:29:204:c274:b6da:d4b1:cf53] ([2620:15c:29:204:c274:b6da:d4b1:cf53])
        by smtp.gmail.com with ESMTPSA id a10-20020a62d40a000000b0051b416c065esm3760710pfh.8.2022.06.12.15.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:45:42 -0700 (PDT)
Date:   Sun, 12 Jun 2022 15:45:42 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm, slab: fix bad alignments
In-Reply-To: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
Message-ID: <8c3b5760-ae7c-c31a-79e4-6b687f217cee@google.com>
References: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
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

On Thu, 9 Jun 2022, Jiapeng Chong wrote:

> As reported by coccicheck:
> 
> ./mm/slab.c:3253:2-59: code aligned with following code on line 3255.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Acked-by: David Rientjes <rientjes@google.com>
