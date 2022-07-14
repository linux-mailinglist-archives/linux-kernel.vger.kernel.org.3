Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32C575228
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbiGNPph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGNPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031BEAE4E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657813533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/dzIwA4vz64Fdq+Tec7zAI7IQ5K1OCYtjvQ2rzb36hs=;
        b=DsYEujlzYulUcmYfnNdw8LLUx8anYfvcgDzGMYpKssrYQHIRbaNWdoyTEQFK5KSOpIaqSv
        b79LqTfdSYdImb/8pX0oeavQFWUJcWAGwoU8JLP73oV9hYKPVsUbbhu+BEQrNuR69KrBqt
        PA30BqDMYq2oIbVAJVGXAt7sgytb39A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-yAej7VN4OSKnoci9ODsLlg-1; Thu, 14 Jul 2022 11:45:32 -0400
X-MC-Unique: yAej7VN4OSKnoci9ODsLlg-1
Received: by mail-qv1-f70.google.com with SMTP id li2-20020a0562145e0200b0047350bbed70so1448513qvb.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dzIwA4vz64Fdq+Tec7zAI7IQ5K1OCYtjvQ2rzb36hs=;
        b=vxvAbUkq5hBqJs+mfT905dzFEJsXVJ0EoBJ7ntTKzAGJyKRW1cQ/u66LNuiEKky96d
         BK5eaWBoyjf+1rZmoJQeBXldJIWYI7ZTrKkKrBDVRj6NzpkpBaeo+bVMrXMqAkMKIxPq
         2EAFMvVBYt9kz2tRETyB6onHHCDq+fyY8OCk6krIu28kBrRkA6R1IRifoXvUQLS+bTVh
         7oRN293dlTq0V8dex+4JJ8QL/uH2DixtzA6Bn4/sLZz5JKKWX5C8OA1XGJDcqH+ZN3g9
         DW4pnqRPQHHHlfw/1Lxl7mKdf9UlrPTiIp/duUH1JES9OiLA33fnNjjtet1+DUoDwNy6
         jqhw==
X-Gm-Message-State: AJIora8eCQQK/HoE3r3aU3rMCysAX1oBdihKQ/FySjF+SHwBi7AXDjNU
        uolv8sKdSJZn//bZ2A2Qfx34w23lm7SW4lHh57r8XJU2x6cRueKCDqtJYsAoKgyklpooDzZlqJ0
        zZOpG6zTkQ+QSJ3JJ8H7csuf9
X-Received: by 2002:a0c:8084:0:b0:472:f26b:59f7 with SMTP id 4-20020a0c8084000000b00472f26b59f7mr8127384qvb.62.1657813531942;
        Thu, 14 Jul 2022 08:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t6oEt31b5+FHGmtHxJUjLrXvN2EA7KeRUBkXyvC1Ec9eZLkht9J5r7hUNUwO6xniY/dDBq8Q==
X-Received: by 2002:a0c:8084:0:b0:472:f26b:59f7 with SMTP id 4-20020a0c8084000000b00472f26b59f7mr8127369qvb.62.1657813531765;
        Thu, 14 Jul 2022 08:45:31 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id w22-20020ac843d6000000b0031eb02307a9sm1708746qtn.80.2022.07.14.08.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:45:31 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:45:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtA6GcRwP7iiJScG@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <Ys2xyCUnqpJt0eIo@monkey>
 <Ys7ViSsOxLaQJIfy@xz-m1.local>
 <Ys7uXHdzzFezUub5@xz-m1.local>
 <CAJHvVcgqb6R6ePMbgmA8LpMpMgrGWie9ZCTuR4MA77GTvi4XAw@mail.gmail.com>
 <Ys9XAbuxkDUlnmv0@monkey>
 <CAJHvVci9iij+eDV-EWDOtjmWFYo0H+1LkzKBp6=XOpwDA4Jh-g@mail.gmail.com>
 <1a27f20c-ed69-398a-5e6d-bb7ec5f14f5f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a27f20c-ed69-398a-5e6d-bb7ec5f14f5f@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 06:09:49PM +0800, Miaohe Lin wrote:
> As discussed in another thread, we might call page_dup_file_rmap for newly
> allocated page (regardless of this patch). So should we come up a seperate
> patch to call page_add_file_rmap here instead?

Hmm, why we need page_add_file_rmap() even if a new page allocated?  Say,
we're at least also using page_dup_file_rmap() in hugetlb_no_page().

I see majorly two things extra there: memcg accounts on NR_FILE_MAPPED, and
mlock.  But I assume both of them will not apply to hugetlb pages?

-- 
Peter Xu

