Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBE59F361
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiHXGEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHXGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:04:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C591D35
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:04:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso288868wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lsuk7uZDIF33aCvdAlHfM9T/aKm08zp1jKT0JyGS+SI=;
        b=VzrgHJZNFCfHZQ9fDt9SbYSikK8Y0QeLsMWnTDaa3Ix8v93UQNvX51iK8Aoq3a9kXs
         SWCp2DAPymGn6PGxdEAwS0akx6eUrCJAFPzpVwMx4YK9aTBOJA1AJ6wYp9FTo5CVtRBN
         ApdUT3nd+A64YDwcE8f4kG5hUou6P5Bi1WiSDJYckr0lsQWZBIkh/2nxKjLrIv1tboNk
         ZObFnZpbGDuQaPveoTACNVm1OPssUHaFZtwiS4GYFgP9ljHr8loiRerP4X6tdJ7G+G1g
         yLzvLSLd8ttipDNaOFq67D7kQ5EghWyuOytfWd+X3keyBTdAE+2fqV2DAJ00SlPgkpbN
         8wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lsuk7uZDIF33aCvdAlHfM9T/aKm08zp1jKT0JyGS+SI=;
        b=QYpn7gEZcvM+gQl0qhv9QPKJGLKdzA5mA7j8st5444tvxTsbMgdfsNZbOn8G49eY85
         jjUXDgFcxbdZb3zuKGaAIjwicBx2yO2biOpbdhFZiIAxrOnWezJCxOZoOCULJB5gOgRu
         DWyj0oj/OLU84rhREhCjLBX49yCtp3ugRCbn9oybjyXvR3LUjeuQxlvVrt6FNm+giPKb
         npo2tTGPkixRV/r0mjZg57GbMZilMIxkPJ4xTvlUDYyNaZuuUCNISXCiESnYCxBfu9nn
         mwlIJEyE2rqQ+hhmx3JiPt4xLkFFdM6jNbevR/am8zjYYXrktRnmKOJL77YRGamfCcrD
         fSFA==
X-Gm-Message-State: ACgBeo3ELW1N+mefXp1ZeeqrYImefPwhFwamWeVRCKvOXHTASKh/2zvV
        LrgEjpt3Slf87a/s1d+IaXsqAwnO4aromzAcwDg=
X-Google-Smtp-Source: AA6agR6gLcnIAF65A5WR/1TeCNW+l0dGibWgolm9qc0u3hhP8UVQrooTgJ8GPtXmbgrFA6kqilJCT9yamyoPLmuWfvY=
X-Received: by 2002:a05:600c:3d05:b0:3a5:dd21:e201 with SMTP id
 bh5-20020a05600c3d0500b003a5dd21e201mr4068777wmb.132.1661321055864; Tue, 23
 Aug 2022 23:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220713134823.95141-1-schspa@gmail.com>
In-Reply-To: <20220713134823.95141-1-schspa@gmail.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 24 Aug 2022 14:04:03 +0800
Message-ID: <CAMA88TrptsGYJqf_hTgE-UVC+dfuHJ1hcOZdJEE1yuKFw_A-8A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] sched/rt: fix bad task migration for rt tasks
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin, Steven, Dietmar:

Could you help to review this V7 patch again ?

I have been testing on our platform for more than a month, and it
seems that the system has no adverse reactions.

Thank you very much.


--
BRs
Schspa Shi
