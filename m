Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA457E552
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiGVRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbiGVRVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:21:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17454642
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:21:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so7047822pjj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RrKXygvFpicOjR+psPeJKbRF/UGRv7RRF5bAbRJRjNI=;
        b=JfFbUTyuFt0o9gKtE5SxvX8n8GKZADW3sWVWl3dLIjfkaBNZLBjZQEmsa0h2Wjufq5
         zkAIB5LAyt25RifUCwh4pBU0HzERfVBaZf93VsXqyoel5erekYp0QH4coLWfeT38nOoB
         IaZ4zCSEhF1I6mhgLWta1i0pDg+DEWbxvWD3dx1lXa9sR+5/wKhwGT6tAFgFT0ZleDo1
         757tP/V4Qfg2QmBcOdDnWIyLnfRgzDpYFqhCy5aJ0tcF10A79ld3bK9WmdhkIyhPtAJu
         k3ZPM2P+p+dtfIo24doWPaB5P2yjxL7IjMok2cAcK2XBiJmXufg71mmdrm+THa2NMwVo
         kv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RrKXygvFpicOjR+psPeJKbRF/UGRv7RRF5bAbRJRjNI=;
        b=XnEdgCNl4Tf7q+3+pjBKngP3Fl3XllfTB3Eo4qiP1FZHOwR0JdlsqPtI+lfL2eZK9G
         /r0RLAq0JRO4tmt4W6OjP/OsKp8GZP00GA/5rqHq11GhJ+9O4SltSCnJ/JwdbSnxFn/N
         LYJir3WA+7/TBU68gyR5Q7XawdMq94FEvOfjABOM1AhkN6xHh4noKVQ7pZhj2fVNriGT
         1Khv9A/cdOR1HkSsJrG8CuS83ucTjGgQsiM/knYwEB03UpGwl49TcZ7SRSWSKfEiPRLu
         rxZ5AGkJ2wR/GAQdxIgbNk5DoobLBe/Ltz1DEqmVQEu26AeFvOJiC77vuUeMzWihhSGt
         WofA==
X-Gm-Message-State: AJIora/kfoA0W/qdCHAUR6PvbEICHYl00PY20GgnsvXUL+nzsjvyHB5E
        6NRypruTWAQBOTm8kZl7JbQ=
X-Google-Smtp-Source: AGRyM1sBTOWYfE1fH6K6lMdV7OfTxp7w+rM+UfrN0JmP5AA4H4BosQcPDUXL17lCUlfoP5fi4b3OIg==
X-Received: by 2002:a17:90b:1e03:b0:1f2:518a:8f78 with SMTP id pg3-20020a17090b1e0300b001f2518a8f78mr3088041pjb.217.1658510462641;
        Fri, 22 Jul 2022 10:21:02 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id z12-20020a63e54c000000b004119deff40dsm3765419pgj.23.2022.07.22.10.21.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:21:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v3 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
Date:   Fri, 22 Jul 2022 10:21:00 -0700
Cc:     Peter Xu <peterx@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <C2910936-FDCF-4ECF-B014-D985284B225A@gmail.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-2-peterx@redhat.com>
 <e35e42ce-e942-141d-09e7-a3a7868f4abb@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 22, 2022, at 12:08 AM, David Hildenbrand <david@redhat.com> wrote:

>> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>> +{
>> +	/*
>> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
>> +	 * enablements, because when without soft-dirty being compiled in,
>> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
>> +	 * will be constantly true.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>> +		return false;
>> +
>> +	/*
>> +	 * Soft-dirty is kind of special: its tracking is enabled when the
>> +	 * vma flags not set.
>> +	 */
>> +	return !(vma->vm_flags & VM_SOFTDIRTY);
>> +}
> 
> That will come in handy in other patches I'm cooking.

clear_refs_write() also comes to mind as well (for consistency; I see no
correctness or performance issue).

