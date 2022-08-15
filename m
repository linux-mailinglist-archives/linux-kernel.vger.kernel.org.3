Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4387594DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHPBM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349674AbiHPBLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:11:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E532AA4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:55:15 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id k2so8312646vsk.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=C7Vx33bd0N+8GUr7dvj2damtX2ID6NTkhuCLa181UbA=;
        b=B2EK5vW3vq2+wr1XR0JVGBM093SVuB1XmaRpdEEZ+7QECvZvEUvc+a0DAweBI4wORh
         aDqgkqWzWMXclRvgJEnMl7qfYoMsClLlg1zFeyDG2p8GQjMaErPVT7Wix+2+inlxM7ss
         yMYMz2XcPbOMbevRUck0EBqBHQpecWGh0+iZPqP5Yvw2ThPvkZMtmhpmFHrtZ0wvAf4O
         7iOCnpQ13fJl6Lv4rJ7FANMBTircXwMTsRTE7EMPDmyQqzeZSnRJ25mNZW84sRDIPtY3
         5w0b+XiicL3pAPePTTPk8F1gP3mQnsdF9egYVtItNZGDNdyq/EoYEVAiHcK+3XyMdBLx
         c9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=C7Vx33bd0N+8GUr7dvj2damtX2ID6NTkhuCLa181UbA=;
        b=eENrwugQ6vfFszIZyvioSRUL/z+aWvkyetwhSEBXY+INVI6tEXjHzeEEgZ6Y1vJaad
         WlYBpwqKdTFsUdcymUW7A1qQWe5IefQj4wtQzyDsr1g9d7ywebtkQSfBHkiHIsdlUXQw
         689q0KbboQR9dEGjy6z3PprRK7+rzaiNYIs3eG4U1Gptpb/p18bngeVnuXUmAz6unwcl
         hU/bfj04ZpPkkyMA3JphcYzCie+R+ExKRRfYY2smAeMi0AnrSX7zfIuqXwhrqi9AiB0y
         nVUy2aSk1yh0IghhFe4EHku5SxYDw4ci1dYeuku2fbBCx9HZu3teqPPO0O0d5r4vttqb
         pvEg==
X-Gm-Message-State: ACgBeo3NLIJ66zZscy+ODnIHqhMLTDLoiWXqBjG+bf5OqKnUsBTy3OHR
        wu+QAFcOrf5SfzhGYAwkmYQ1ryKFsbg=
X-Google-Smtp-Source: AA6agR413W9TsI5RTHdAnpIinxfNI5tIiBp/xkZYCINVvGap8dV0dgJcFRocvAzce5WarAnEGxVyPg==
X-Received: by 2002:a17:903:190:b0:16f:642:1a72 with SMTP id z16-20020a170903019000b0016f06421a72mr19469603plg.113.1660596903005;
        Mon, 15 Aug 2022 13:55:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:3a69])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090340c900b0016d3935eff0sm7392380pld.176.2022.08.15.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:55:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Aug 2022 10:55:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] sched/psi: psi bug fixes and cleanups
Message-ID: <YvqypKIcOk4mSaQp@slm.duckdns.org>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806120510.96131-1-jiahao.os@bytedance.com>
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

On Sat, Aug 06, 2022 at 08:05:07PM +0800, Hao Jia wrote:
> These three patches are about PSI.
> patch 1: Fixed PSI statistics error caused by unzeroed memory
> in struct psi_group.
> patch 2 and patch 3 are to clean up some unused functions
> and parameters.

Applied 1-3 to cgroup/for-6.0-fixes.

Thanks.

-- 
tejun
