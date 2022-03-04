Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A507D4CDFA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiCDVSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCDVSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:18:22 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30432C673
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:17:32 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id z66so7441751qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 13:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=K7s2cmmk7Zg+rBGEFOdp9bOvWs4Cpnx7T7LFDlbjDDI=;
        b=NM06JldRsvN5yOo5aVlrIGwoeXFHRza3IRXqmQgmSFRdqRRZz8cb8kYdOEBCGC/oTD
         CrLX8zKRFgQ+lpMsCoD3Fj5FWgxIQUK8PcaiOj9JbTZbFJJDB4af8KRp/j1V/QbVFJQN
         VILc9J7ZsRGj5pExFgmGr6gqmR5mDjXsYBJlF0i1tCH5isIzCrGmF7IqKnNLgFeH5m/Q
         ojmNDqDwoDJadwvgV1Ruu1uJPsCFJgWFeasmLlzSFB+qLm91F7hTLq5Xyi8NHf5ABkTk
         kl/o1T928AesayH/2KclMaBvPcpasVbva4wh8uGwsCi3Z/1L0O8Ul6VzHqAe3ddaxXFp
         NdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=K7s2cmmk7Zg+rBGEFOdp9bOvWs4Cpnx7T7LFDlbjDDI=;
        b=7Z+H8Nwno4ZNmEEtGF+9Lfs3ZDxiIb7yBiwhIOKgvx9A6lkhrgGSXF4LOdnVxauGrQ
         ESrfbRpD362L5yTnYaf/wnaPApxOn5nljEeaNno5rMTN1dCoLg7rggRCFlStiywtB9v2
         t/EcQ7jBRQFJO8bX8JVUcdBoTirvJoAEQmQzOhHcZaAIAxDAWwrNhuki+juT85qyBDjx
         1JeMykRZyAk4cXUVSi128m7PlsVQ8Vlj95COADWREMeZfOqRvpgHHUoT/lNdRh7g8sVD
         gsTELNzVj3slxy+vvuFuuv2+yI+vWfnjkKC09cnTvv8rcq+YG30FmE+7tGlM5peEdoiq
         bPmQ==
X-Gm-Message-State: AOAM533k0BEyYTDJcSNAHmEoSg684ixF1v/xQByvzkSL3Ov8ntq9BpNz
        +yNFOcKXbbW1rX8sjBjNR+2akQ==
X-Google-Smtp-Source: ABdhPJzvawwGSPRBEMdoX1Rm2eL5dwC68GJUJnEWjdQXlC41Os+q5QY5QNd7/CvMGUtsRhnUkz/ceg==
X-Received: by 2002:a05:620a:1005:b0:640:7d6f:cacf with SMTP id z5-20020a05620a100500b006407d6fcacfmr374537qkj.557.1646428651714;
        Fri, 04 Mar 2022 13:17:31 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z196-20020a3765cd000000b0050848cdb596sm2956151qkb.101.2022.03.04.13.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:17:31 -0800 (PST)
Date:   Fri, 4 Mar 2022 13:17:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: delete __ClearPageWaiters()
In-Reply-To: <90aafe84-fe7d-c70e-8e15-c222869f30fc@redhat.com>
Message-ID: <6e5262ff-8596-a86-7388-eddb2b2c53c@google.com>
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com> <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com> <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com> <90aafe84-fe7d-c70e-8e15-c222869f30fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, David Hildenbrand wrote:
> 
> In this context we can consider ZONE_DEVICE pages just like any other
> pages that, although getting freed, are not returned to the buddy, but
> instead are returned to another pool. So PAGE_FLAGS_CHECK_AT_PREP won't
> apply and free_pages_prepare() won't apply.
> 
> Another example would be hugetlb pages, that are returned to the hugetlb
> pool, but not back to the buddy unless the huge page pool is shrunk.
> 
> 
> So I feel like the underlying principle here is: we don't *care* if
> PG_waiter is cleared when a page gets freed, because it will simply get
> cleared by the next waker if it sticks around.

I think we were focused on different issues here.  I was focused on
how it was redundant for those places to clear the bit, because it
was going to get cleared anyway just after (in the buddy case).
Whereas you are focused on how it doesn't matter at all whether
it gets cleared when freeing.  Both valid points.

> 
> Then, I agree, we can just drop the comment regarding
> PAGE_FLAGS_CHECK_AT_PREP and instead have something like

Okay, the reference to PAGE_FLAGS_CHECK_AT_PREP in the commit message is
good enough for me, no need to make a point of it in the code comment.

> 
> 
> "
> That's okay, it's a rare case and the next waker will just clear it.
> Note that, depending on the page pool (buddy, ZONE_DEVICE, hugetlb), we
> might clear the flag while freeing the page, however, this is not
> required for correctness.
> "

Okay, v2 coming up: I've taken largely your wording (but not exactly).

Thanks,
Hugh
