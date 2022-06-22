Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57F7554FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359650AbiFVPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359637AbiFVPta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:49:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3438B7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:49:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c205so9750218pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=dyf36lr5WZ/lcylyR7cKNfLAoZGPSwRPa77iGVuLEGo=;
        b=I/HqCZsUvFcBEUwF5a8rWR9LwJWFXxynBLCTN2zjgAvRzcchfojW0XPIPCjKZC/jBX
         DBDFHleMZwSotQritRYltSPNNSDcHJ1Pj3wmEvUblrpglWBNqOJWd0FXte/YoLEqkU7w
         4b3OuU3wa5rBAN/+8COviRjPsO275zs3Ol8n0FSswTtcdusIwN2aEAW9OTyimame1Tv7
         U9Z0fn+UNfbI+pvIsTzzi+tIrg0PSPMs5vHygixFUXRLUYBr9s5outrasPTKKpGwBvYL
         X08UExd5sL0/zkC0CrCYOa5kSCBNY+rp+JzE68IMy3hOtBRjqAS9zh7dgBzFQYwUnt5m
         Nthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=dyf36lr5WZ/lcylyR7cKNfLAoZGPSwRPa77iGVuLEGo=;
        b=rCFzDgnQGew6xWOe982Bp09vGazJydHLdfPXhOkcUVfjgP3N8iZBJA1SJQ6JJ1Fu6u
         PFGbLQvapK4BqrMh1GdnHKVZxM2bIGL4yDmoXt6N7ktfte0DarxMC42nZzyg0yFqItua
         1HXzHL4HjeDRoEGlERwn37x60EGvR/WWWVC/lK16iyDbPJIYd/o/nYrNLXgTmDNdcbsm
         gK7SaXKK/AEchlvD8UbWrFVYNZJ2ZBxyRZ+JFRLofNpWC1axIelGYbDGfuqXOrY9545C
         4Pjt8FLBDeoGK8Fo5RzSczdWIM92rT/EHcV0t2tplfTWP7F3GHUuJT3txKWmMur4TONk
         KKng==
X-Gm-Message-State: AJIora/eQuL3qTJ3jkjmd8lUthS2FwiuloMWaquoDv5nr36JouGsIA+Q
        9c5Hl90p3Vl9Apn1CsUlEmeHyiknq7sayw==
X-Google-Smtp-Source: AGRyM1sRaCby6qfulXBJB2lxN+sUHUI8bG0YnCIYXJiNPA1yocuIdWKsg7TcjpuPf8HfzKaaQpIFpw==
X-Received: by 2002:aa7:8c51:0:b0:525:4141:fe5e with SMTP id e17-20020aa78c51000000b005254141fe5emr6171423pfd.51.1655912961288;
        Wed, 22 Jun 2022 08:49:21 -0700 (PDT)
Received: from pc ([103.142.140.127])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902e34b00b001690a6394b6sm1610542plc.247.2022.06.22.08.49.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jun 2022 08:49:20 -0700 (PDT)
Date:   Wed, 22 Jun 2022 23:49:13 +0800
From:   Zackary Liu <zackary.liu.pro@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "=?utf-8?Q?mingo=40redhat.com?=" <mingo@redhat.com>,
        "=?utf-8?Q?peterz=40infradead.org?=" <peterz@infradead.org>,
        "=?utf-8?Q?juri.lelli=40redhat.com?=" <juri.lelli@redhat.com>,
        "=?utf-8?Q?dietmar.eggemann=40arm.com?=" <dietmar.eggemann@arm.com>,
        "=?utf-8?Q?rostedt=40goodmis.org?=" <rostedt@goodmis.org>,
        "=?utf-8?Q?bsegall=40google.com?=" <bsegall@google.com>,
        "=?utf-8?Q?mgorman=40suse.de?=" <mgorman@suse.de>,
        "=?utf-8?Q?bristot=40redhat.com?=" <bristot@redhat.com>,
        "=?utf-8?Q?vschneid=40redhat.com?=" <vschneid@redhat.com>,
        "=?utf-8?Q?kuyo.chang=40mediatek.com?=" <kuyo.chang@mediatek.com>,
        "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>
Message-ID: <7CD2EF28-F810-4733-8246-28D9821C180B@getmailspring.com>
In-Reply-To: <CAKfTPtCgbtKkjA+tU2DFJgKAsXV+kFKipMxTuReaT5QKNvvAGA@mail.gmail.com>
References: <CAKfTPtCgbtKkjA+tU2DFJgKAsXV+kFKipMxTuReaT5QKNvvAGA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: simplify load_sum assignment code in
 attach_entity_load_avg()
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 22 2022, at 11:20 pm, Vincent Guittot
<vincent.guittot@linaro.org> wrote:

> On Tue, 21 Jun 2022 at 17:45, Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
>> 
>> In commit 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg()
>> corner case"),
>> these code was committed:
>>         if (se_weight(se) < se->avg.load_sum)
>>                 se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
>>         else
>>                 se->avg.load_sum = 1;
>> 
>> they could be replace with:
>>         se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se))
>> ?: 1;
>> 
>> to make the code cleaner.
> 
> This quite subjective as I consider current version cleaner than your proposal

Thanks for your reply, vincent

Perhaps, this code is more concise, and this form can exist in many
places in the kernel, and can be searched with 'grep "?: 1;" -nR kernel'

--
zackary
