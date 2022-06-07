Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616BD54047C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiFGROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbiFGROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:14:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73CF3392
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:14:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so5224992pjg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eV2sqimESyEBoOWpToAEYIFXkSifHyaBR/mX+uJ/fkA=;
        b=R/PtdolzToTAPHuKJrWW3wHLAeRNHiipbOBV1SRMl1w66h6SAYZCJjbniBObk5trST
         IjmwAmkBP89x0OhC/YaGcAmuGqSMzvHcTZpwUiJkC2fGpKW7gJQxx76XEB//ldHQSBfl
         6sv8qBB+433XRwInTUJ19Kj4X4B4IkrOMQWB1bt6h6J2V8njIInnkBk0v2aSaALz9DpX
         jzv7IBDV2Ky9I/h2FWy1MjDjAUfaOeaJcBE8i3ob7CqBJ83gv+oBLWqw3/nmGJDnsMsp
         0noI8pbhbJfE+oA1XL3lbmsIe1EI+pFuxsItl9o0MDirj7eK+Q7lxz09tgkLlZMp0jRR
         kZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eV2sqimESyEBoOWpToAEYIFXkSifHyaBR/mX+uJ/fkA=;
        b=UIpDFmVFGvjNmy+/qgPBNTtzzGk/eqYsONcPdrjDy48SGAZ1zHfcvPOobaY/KzzacW
         kgAMa+kh0VisEIb592mNOW/uu+DVqtGbmLONNWS2XhmXwrpoMqLMWCgQouxE974lVa5o
         mgUVSxvT/udHS1KmmfK2m8g8cnC4Rfhx53RRovDs1nrpZGiZ0mBCGwr23oFYyI5lEKii
         OR/cPLmeJUpYOJ4t6CPgzuTSAgOoRBXl9hk43HAEe6Gu9FdsA+B4efc8kTfcWQa7aCEd
         EdxXhngWdWCzAhZioCsAS4xDvuuWqQLGPPzgQYHQnRuyz3w7AKYRe9jFloJk7C4DMNVF
         NwVg==
X-Gm-Message-State: AOAM531H/6JvsQ0d9PCbjDq0fstT4X37GE6hzaE5kPRPWxIEpdYEEEUD
        8wnL8rUGRNUvrp7j1vsePRk=
X-Google-Smtp-Source: ABdhPJx5bDWecPgzIRwKGZN78trXz3PN89rJuBhbVNd1U+08tfORCBQ/xNx7TroBLjKgcPh0HYBnBA==
X-Received: by 2002:a17:90a:f2ce:b0:1e8:3e55:bbfa with SMTP id gt14-20020a17090af2ce00b001e83e55bbfamr23908605pjb.204.1654622048983;
        Tue, 07 Jun 2022 10:14:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:fa4d])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902edca00b0015e8d4eb22csm12792137plk.118.2022.06.07.10.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:14:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Jun 2022 07:14:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
Message-ID: <Yp+HXowR9nTig331@slm.duckdns.org>
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
 <YodIquufXzK581gw@slm.duckdns.org>
 <8df16635-658b-b381-9a40-3544828910fc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df16635-658b-b381-9a40-3544828910fc@amd.com>
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

On Sat, May 21, 2022 at 12:04:00AM -0400, Andrey Grodzovsky wrote:
> From 78df30cc97f10c885f5159a293e6afe2348aa60c Mon Sep 17 00:00:00 2001
> From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Date: Thu, 19 May 2022 09:47:28 -0400
> Subject: Revert "workqueue: remove unused cancel_work()"
> 
> This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.
> 
> amdpgu need this function in order to prematurly stop pending
> reset works when another reset work already in progress.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Applied to wq/for-5.19-fixes.

Thanks.

-- 
tejun
