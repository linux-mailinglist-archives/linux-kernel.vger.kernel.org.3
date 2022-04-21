Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC77509571
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383958AbiDUDf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383951AbiDUDf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:35:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B363FF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:33:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e30so1284816eda.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 20:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2jOkquZdqhOC6xi9DXdvJVh/+GNFdN16ZNOy4ky1ZM=;
        b=VF7U8Y6cl4WrICGopSYxxvg50liMyV6GJqQWaIP+kwVdjoHcAa0iapdITqi3qJMT30
         4dflDWM3bOZOUxNRd2uxD7g6wVrNx0rtdUPenFP5oyJLjUHKjqTFqa3tywKkeLrigCl7
         yJq6HqtwgS7ZZn/nfXZzVSxnm1WOrwLCezYnV75wtbXVBwGa+EhspuTpgiMIf+UENApN
         WxFYZ4U9ilpNzcjgUi3XBexmHdX/a/J0HKSE1NSZrV26j6t69mtG1/zpj8ZkwxJnRmPh
         NlcZu31mDTdgfj3fWuC6pF4FIdS48Ot4TRkOHpoqxSaRrChMS9g8OEtKmzgoSu4An5Rw
         Lmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2jOkquZdqhOC6xi9DXdvJVh/+GNFdN16ZNOy4ky1ZM=;
        b=Ffrzma2rcmuyyLUCBWKV0IuZP7ukjcPNyhQliDTyc/bEnLtqdhCuW8FoVFKB5oLreA
         z5AKwuxrgd+Gm6242gj6tkZJLAPOUuuOQCnHa8FD7IpyKT9uAdwn5DekcGwjm/ox97Q/
         T5d2/Vc/WAylX5Z+1w6uyAwEeowlkABlotTb3m9CwFocSCw0Lp67Iiw2wU3CmEAWLXuh
         w4NQliToV/zrORNUhMVaycEt9LS+qtdpT/JKFRspzwJFzhjFjKBbCYPx3UzyEW8n74bu
         vgAqp7da0JbO3+9ffGIFmYaXNShbssUa/tUNNEcdf14z9t1KWoUHczf8qp3OsHEReesz
         BjaQ==
X-Gm-Message-State: AOAM532KW+EmpNBVZGJ6QtQChzgA2abAbUlbzcQNL/a1zwiP2dk8og3L
        m3aTBQEvJrv/aA5o4/wvwM/N3PxHteEGWs/C3yVaog==
X-Google-Smtp-Source: ABdhPJzvlxaS4dVYDEdpRJ2usYDpKeVOsLGRVQ1CWPfz5B1hIUG4OJX9cAsyIdeW+/hhL6FZGd37EbVRWYutXhnKpXs=
X-Received: by 2002:a05:6402:644:b0:41d:77bb:d36d with SMTP id
 u4-20020a056402064400b0041d77bbd36dmr26036192edx.381.1650511986525; Wed, 20
 Apr 2022 20:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220420060221.1107736-1-anshuman.khandual@arm.com>
 <CA+CK2bARgsgBAgawfAD8-xzDN6+_sg4zrPQnoTFy4b=ZMx_u1g@mail.gmail.com> <YmDOKJCZteqrKr61@casper.infradead.org>
In-Reply-To: <YmDOKJCZteqrKr61@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Apr 2022 23:32:30 -0400
Message-ID: <CA+CK2bCYp3+VLLFwrQpC8su1C-NvjdiKs39TFcFh=BTDgB92fQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Drop all redundant EXPORT_SYMBOL()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 20, 2022 at 12:54:08PM -0400, Pasha Tatashin wrote:
> > The rest of EXPORTs were added to be symmetric, and allow other
> > drivers to use set_*p**()/clear_p** calls.
>
> EXPORT_SYMBOLs actually have a real cost.  We don't add them "for
> symmetry".

Sure, the rest of exports can be removed, but:

> -EXPORT_SYMBOL(__page_table_check_pte_set);

must stay because of

ERROR: modpost: "__page_table_check_pte_set"
[drivers/gpu/drm/i915/i915.ko] undefined!

Pasha
