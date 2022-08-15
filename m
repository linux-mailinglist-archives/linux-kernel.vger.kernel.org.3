Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0A594F06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 05:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiHPDYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 23:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiHPDXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:23:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CC301781
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:50:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso15841061pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=HVrNNIP5OdVeGE8YOwlPdu8XODcUkQYpLVi906o+AGg=;
        b=Box0zxEBtjStqePX9sleT3TsAZa27RHRQiiPUDEIR/zWvROfmT+vm+/vcH7FkzRrOR
         t1f7nWxyLDQsUk/bSnAuWXTkvzqdJTPn7wM6phS/DH5kaqbCvB9sJAFgtf99E5fDxJzw
         PWFhUNb16qvzc6xCT/ArFXnFFMLiHK9XdTlHS+5k8yUYJdm0VeoWX0smETlMKw44AYvh
         yfrWFKIn/6JUy7o5k0kcRqZF6uUTKq5u09LQgdW8genvS8N0GRumBvlj/aHOqUPLJd0U
         Y0k/vxKy/MngLDTdTXcRBLMMgOIFE7Jv2+HP0yk1nrH7ciwXwBhnTm8/8a/1TbCm0DFH
         Wl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=HVrNNIP5OdVeGE8YOwlPdu8XODcUkQYpLVi906o+AGg=;
        b=pvCrdyoK9kcrqCOXMpiUDyATUD2k8Dqh/jN7homo08YzkartM0azgMji8HecmGgrS4
         IYxsz+OI6pH3YMQarXtN+pZIvS0ojEu5zKzQldSWfxNdyFviEFkinjo8fIxhGs8vooAv
         vTeegzfmmsON221eYzCT6LTCYT4zenpHdzsJfcwQVRrWguTdfB3vV8x7lc9XpP55DpLH
         yXVbmCtC4rnvND0v5COV7DMHxqnA4r8NzWEqtPZ38jWae/2N+Sp2p8NwUbNUGbpYZ8ES
         ovxT/V4I4TPwgKsRRdelOVcIi5RhWAmyfsIQX7u/5zbFo1TvnI5tprQo9kepRg7xxMuV
         EuGg==
X-Gm-Message-State: ACgBeo0/yH0dEIfCGIRYwmp7lquId9W26aKRtkX6v9U8U+ZStUJCBw5g
        Bo8sHlFI7DCZypnMSFtKxzQ=
X-Google-Smtp-Source: AA6agR70vVzFD8ubILYl3j3Nc8RGkTgU9FkIlaj+e9DRjJtmHYtfHA4D6fuOFhL6AWTJOyNalCjavA==
X-Received: by 2002:a17:902:bb95:b0:16e:e3f4:8195 with SMTP id m21-20020a170902bb9500b0016ee3f48195mr19344904pls.130.1660607456615;
        Mon, 15 Aug 2022 16:50:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902b94c00b0016ef87334aesm7528789pls.162.2022.08.15.16.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:50:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 13:50:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v3 1/3] workqueue: Hold wq_pool_mutex while affining
 tasks to wq_unbound_cpumask
Message-ID: <Yvrb3hfZuUzSpX5e@slm.duckdns.org>
References: <20220802084146.3922640-1-vschneid@redhat.com>
 <20220802084146.3922640-2-vschneid@redhat.com>
 <c13c3fb4-4936-a5fd-cd28-1136d07d5f54@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13c3fb4-4936-a5fd-cd28-1136d07d5f54@gmail.com>
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

On Wed, Aug 03, 2022 at 11:40:28AM +0800, Lai Jiangshan wrote:
> From df7b4672db4dfd3e480b1873b9d346e8a7dfc69f Mon Sep 17 00:00:00 2001
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Date: Wed, 3 Aug 2022 10:52:04 +0800
> Subject: [PATCH] workqueue: Protects wq_unbound_cpumask with
>  wq_pool_attach_mutex
> 
> When unbind_workers() reads wq_unbound_cpumask to set the affinity of
> freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
> sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.
> 
> Make wq_unbound_cpumask protected with wq_pool_attach_mutex and also
> remove the need of temporary saved_cpumask.
> 
> Fixes: 10a5a651e3af ("workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs")
> Reported-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

This patch looks fine to me but is whitespace corrupted (two leading spaces
on all context lines). Can you please resend?

Thanks.

-- 
tejun
