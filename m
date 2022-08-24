Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5959F1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiHXDMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHXDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:12:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC52F7FF92
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:12:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 83so9534068pfw.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sg2on96RPskxYdzucvjCV1ThFNQwSyRaOb5uyZITDLs=;
        b=vmIKakJ1j94AmUlUI+nyWrUTDh83qwsf0yhU+Ta1hI4FyBN/SRbpcjNBIp1CLkeK7g
         E+S/oGliQs3VMzdP5LcEekOhEm8b2sunoCmwSc/c3BvBkSKBtObfOlwXkXZHT7v/OHlc
         29L/O3NxoucdJsp7Ecd9iGP+yeY/GNzjBnT2Z53+RvQvfPxMnslfJHM8mXYRsTyFiv0L
         p+Yca9pArr//4Tedxwa4Pv0wbFyxN9lEXfm3F/6yBjGetkiOQ0LdS15klF44hRXLkfDH
         AG8huRx6gFQBjWbumcnEKsVN9tfcOO+MtNnQBNkpgVY5vn3V+pSZLEPxJr7Sor1MXXxR
         HGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sg2on96RPskxYdzucvjCV1ThFNQwSyRaOb5uyZITDLs=;
        b=y9MStLs86TpbmteVir5xLA1nMVT3wq30b9r7nXnQkzCro4nP+aGs+MhoW/6BCMHnhn
         vpQESOcpNqKtitSQUwm7XOIxK93Tq7Ih46YPnevp0hH5/Ek0OmqQ++yes6TILj9Y4aNQ
         2yUJX+tH6yvK4wiFMyb/V//Ytwc8rNVfAoRpMOjq/2vVL7P9b8ZZytJP8csKH3JypSCy
         CyBOr6zZgVYnVIEY/W66vzDtMhPx9KEsaLT74UOxQKWyhXrtsRJNk5CGtQ0i9bVZQcRS
         3Zz9eVAla3i8Xgx+sIbmW5MQSCKq+7DP16dhC9UL5ChKbIL9FudeDsgKJw2+fdMiiPCp
         vy8g==
X-Gm-Message-State: ACgBeo172ZQkUXZN+y98PIbQ93MsoDAVi+YyqcRQ1H1xNe2YNvwLA8CW
        zE6ub7+Dpz6lDwdh0NTcLMDe4Q==
X-Google-Smtp-Source: AA6agR4rEhhjx9tSYcBP0+eq+XiDxTthBJP2ct06GZb8zfS0sv22JlP8COCwkvyf49CvoD0Q22FRtA==
X-Received: by 2002:a05:6a00:1947:b0:536:6730:7d33 with SMTP id s7-20020a056a00194700b0053667307d33mr16240337pfk.10.1661310740334;
        Tue, 23 Aug 2022 20:12:20 -0700 (PDT)
Received: from MacBook-Pro.local.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709029a8600b0015e8d4eb219sm11235523plp.99.2022.08.23.20.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2022 20:12:20 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     vbabka@suse.cz
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        mark-pk.tsai@mediatek.com, mhiramat@kernel.org, mhocko@suse.com,
        rostedt@goodmis.org, yuanzhu@bytedance.com
Subject: Re: [PATCH] page_ext: move up page_ext_init() to catch early page allocation if DEFERRED_STRUCT_PAGE_INIT is n'
Date:   Wed, 24 Aug 2022 11:12:07 +0800
Message-Id: <20220824031207.75658-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <fd6b2e3a-2cb3-5ba2-f376-8c3c5f8e8306@suse.cz>
References: <fd6b2e3a-2cb3-5ba2-f376-8c3c5f8e8306@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-22  7:00 UTC, vbabka@suse.cz wrote:
>> On 2022-08-18 7:36 UTC, mhocko@suse.com wrote:
>>>> From: Li Zhe <lizhe.67@bytedance.com>
>>>> 
>>>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>>>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>>>> problem. It seems that we cannot track early page allocations in current
>>>> kernel even if page structure has been initialized early.
>>>> 
>>>> This patch move up page_ext_init() to catch early page allocations when
>>>> DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
>>>> DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
>>>> allocations. This is useful especially when we find that the free memory
>>>> value is not the same right after different kernel booting.
>>>
>>>is this actually useful in practice? I mean who is going to disable
>>>DEFERRED_STRUCT_PAGE_INIT and recompile the kernel for debugging early
>>>allocations?
>> 
>> Yes it is useful. We use this method to catch the difference of early
>> page allocations between two kernel.
>> 
>>> I do see how debugging those early allocations might be useful but that
>>> would require a boot time option to be practical IMHO. Would it make
>>> sense to add a early_page_ext parameter which would essentially disable
>>> the deferred ipage initialization. That should be quite trivial to
>>> achieve (just hook into defer_init AFAICS).
>> 
>> It is a good idea. A cmdline parameter is a flexible and dynamic method for
>> us to decide whether to defer page's and page_ext's initilization. For
>> comparison, this patch provides a static method to decide whether to defer
>> page's and page_ext's initilization. They are not conflicting. My next
>> work is trying to achieve your idea.
>
>As we already have to pass page_owner=on parameter to enable the page
>allocation tracking in the first place, maybe that alone could also disable
>deffered init, and no need for another parameter?

In my opinion, adding a new parameter is better. Page owner is not the only
feature attached to page_ext. For scalability reasons, adding a new parameter
is a more flexible method. Thanks for your advice.
