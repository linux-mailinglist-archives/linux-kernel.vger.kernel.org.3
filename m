Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADCC594CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbiHPB0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244967AbiHPB0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:26:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738ECDB7D4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:16:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 73so7530041pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=8nOgaBzIlmfxFPStsMQfSkb4tmWBu2Jj/lkhaO8hCeU=;
        b=mG28n59cEJ00FlMAyPe/A0+FvrzRw+iCQIb7KFfdKwCzoXJQgggYLI5cnnmepguMp+
         aj/+jck3LQ6quN+0+gQM72IhFZWCT3XWLszCtcVoSFZrNHLOF2l3kQni7TqF03rHtpHt
         XMc7mh3U3XbgGJTHBYXwvyo884+hDXJpspd4p1FNrV7ApoOMWIvjZhHMR2CwChNa0EIl
         FuDg+xF2jD9cT9LmHlqebnXJIrum/ARn3liUXwTz/fe+ZZP2BCEHVzQwPuj/wNP4fy3t
         DGJ4Ophm7/fqguXaGuyrqaODGr0I/9ZbetMzB7/yVy+YNbqa5OLzPh9TkRQ3XivEPTqP
         0v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=8nOgaBzIlmfxFPStsMQfSkb4tmWBu2Jj/lkhaO8hCeU=;
        b=Ul7DT7IvLs4S8ST2DeTZqcu+XHsb7yIxd2czIuq0olf8gtU4jPw86JmCnU/HPF7EY/
         aeLwaAPWOzql+Rf4srLDJeyNOfpgBKbBL3IR2LP4Mc9Pp/CJD5UgHpA3nb4pW8EYniKG
         wqqTWkQKcawPBhtYvGiZ6qJoyitu4o+olrkgntIXN8cJjomTQTCK6DUfRwLm2D1HP0w4
         xZwD53VAkMVGBoQbzZq7VDCsALwo6TvZYkBySWFhCmqAtWQKOsIXHl82ocWZyWPJJnDs
         mpJyQCOjnfIptWRiL9zn5/TBd4FcCpUXxIJVwucdSV1z468FTKSxP9gjaxu0oZf3X0/F
         pMgg==
X-Gm-Message-State: ACgBeo3rHjaNXimikLLcngzfYDdhuZcz+AmHGB4U/7ambTGfurJgqQzf
        y/Cr0e/rr6WInA13bW09pNuqTuCg1GQ=
X-Google-Smtp-Source: AA6agR4tEusymmK37Mhm2Fxz6VsDZfjtY4S9tImlj6E5k+H/O1Z6vkwW+ku52NiS6br5bv1Opecbqg==
X-Received: by 2002:a63:6384:0:b0:41d:3511:7fda with SMTP id x126-20020a636384000000b0041d35117fdamr15518112pgb.291.1660598162896;
        Mon, 15 Aug 2022 14:16:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id t66-20020a625f45000000b0051be585ab1dsm6933910pfb.200.2022.08.15.14.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:16:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 11:16:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] workqueue: don't skip lockdep work dependency in
 cancel_work_sync()
Message-ID: <Yvq3kH9b4IEyodRK@slm.duckdns.org>
References: <21b9c1ac-64b7-7f4b-1e62-bf2f021fffcd@I-love.SAKURA.ne.jp>
 <YuK78Jiy12BJG/Tp@slm.duckdns.org>
 <0ad532b2-df5f-331a-ae7f-21460fc62fe2@I-love.SAKURA.ne.jp>
 <97cbf8a9-d5e1-376f-6a49-3474871ea6b4@I-love.SAKURA.ne.jp>
 <afa1ac2c-a023-a91e-e596-60931b38247e@I-love.SAKURA.ne.jp>
 <7d034f7b-af42-4dbc-0887-60f4bdb3dcca@I-love.SAKURA.ne.jp>
 <0a85696a-b0b9-0f4a-7c00-cd89edc9304c@I-love.SAKURA.ne.jp>
 <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d47eed-6a22-7e81-59de-4d45852ca4de@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 01:30:23PM +0900, Tetsuo Handa wrote:
> Like Hillf Danton mentioned
> 
>   syzbot should have been able to catch cancel_work_sync() in work context
>   by checking lockdep_map in __flush_work() for both flush and cancel.
> 
> in [1], being unable to report an obvious deadlock scenario shown below is
> broken. From locking dependency perspective, sync version of cancel request
> should behave as if flush request, for it waits for completion of work if
> that work has already started execution.

Applied to cgroup/for-6.0-fixes.

Thanks.

-- 
tejun
