Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BD55C408
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbiF0XZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiF0XZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:25:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0D723169
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:25:07 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3176b6ed923so100132537b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKrYTXSW7z/1khk7h8njEpnz4YPMgWD7vmDOzXoSSXQ=;
        b=gtN2flgn1WeaLbf0Wj16VG1k7Df3OBtuLCZtIHy6GLDK13OK0XcF0/mY0PJLzlagb6
         bSBAWPQfKQYasXdVBPBMVkaquJ1MahTNrnbEAfDuq7VCMbaY39MOJ1NpNWXiKZCp3FNw
         yzjPzTId5ow80G6dd12A+ysaDcswKtDT7+2Dd4scMlHt+QsGWgdhg3UUG2mTXbxdsusE
         SnQ2ZpHlqe5aiz5SLrYRZ761XQB8Vdvjcc7p4fO+A1EOQkV3fv9VOPqo0lAsEoYHel/6
         Qwr6FkdJGqn1a8BuxjCIgguvP9P9xpzQE8i4d6BPpH5s0BpTlOBOoV6h9JHjAmHviT41
         npIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKrYTXSW7z/1khk7h8njEpnz4YPMgWD7vmDOzXoSSXQ=;
        b=ycmzCP4WpAjLGaWCbcw/MHAm98Xss+RD1iXWnQrPKA2uf4iAbbTBMMJVQeVc2VGbnc
         b0CIOulVzqO6PoZ7ijK6ga8A3JYEo1BzGpEOxL9ehLwroSP4OCN63DguW3vxiA5MZAue
         hUIThnntpxRGRYrd2d2PyQfnIbIKo3wyrOG8rqTbgFxiQdyWiTo3nCMJ3asuFqXM5mPm
         h3C4TzkXxr4vtUYIdgOtqpUbjP8Y4gfZLVKxYKG3mdFbFHiTCZNQVNcGmC10eMcEdtcu
         p73lZITljMHeDKdvQ1mzVku98ifyJrmE3ox6nTLvisTtqXsJ4EIdpI5e/z+wAYjuhhVk
         yo6g==
X-Gm-Message-State: AJIora/+Hf6g4UfdeIC+yT1kkeepeeMJohJllv8Ieqju5Tea1f8OZL7/
        PqMEK05VthVlK8KOmU+kyqvRvquE3R9m7xUANX9POw==
X-Google-Smtp-Source: AGRyM1uz0/ZMpJZKCgtw9mtullcfVxvLxBbX7tRqkJMY6GnxwYpcsV3erlMrs3lAoSmsdkedVJfyf2GI2cJLkWCRtpE=
X-Received: by 2002:a81:19ca:0:b0:31b:732c:15e9 with SMTP id
 193-20020a8119ca000000b0031b732c15e9mr17136460ywz.167.1656372306244; Mon, 27
 Jun 2022 16:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com> <20220619120451.95251-4-wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-4-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 27 Jun 2022 16:24:55 -0700
Message-ID: <CABk29NszU9vhmO7W3LJumonK7NW-4Nq+PkNFj_hX-WP6ZiF-FA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] sched/fair: avoid double search on same cpu
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> The prev cpu is checked at the beginning of SIS, and it's unlikely to be
> idle before the second check in select_idle_smt(). So we'd better focus
> only on its SMT siblings.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Reviewed-by: Josh Don <joshdon@google.com>
