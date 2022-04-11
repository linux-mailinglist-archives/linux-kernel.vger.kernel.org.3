Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDD4FBD79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiDKNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiDKNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:43:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C335BF48;
        Mon, 11 Apr 2022 06:41:37 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso16872148pjh.3;
        Mon, 11 Apr 2022 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEgz7pDebt7YmqGFvfHdIKDR3vRZu3u1KbLLcx4/FAs=;
        b=lr8YDAxNvaCJNmyk6Dc29gA9izFiyp89D8uGDEpFcRK0wrBsvJYlC6My8DV4eO2tpm
         Ch85xGfJnP2PtgWsuOp2M5EYPbfGTI2d/yWmMxpYqHiOz9rzox0oLsHH45/adl7dYYCh
         U/XNIGthUxbNm5efzHtOreRs8x1TnOSb3iNXAjq/4ZLHud90kuCpW25M52z9Ni/rd4hH
         MykvGc7q3GqwjyLQ3XL0/3Ol+DRiX4WWW1w0JvcHaVpLC9D3Rvsd61TAz9RX32iCaxXg
         m0YxPcnMoZdavBDd9jY9WExnEamievgJnqLbZh98OceiAMFKPiyFRHc2fJOuyM/H8uRD
         JpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lEgz7pDebt7YmqGFvfHdIKDR3vRZu3u1KbLLcx4/FAs=;
        b=E8vYzWA9HvNYO1URGVJ40j+h5Fu1rH9t3tQ4Wu+KGatUi3zIm1z0BUCvGvh8eqVBK7
         hAOIa+mwFCUIaL4o0LsnDhp7/Dg2Um/xo0m5nt0ASULGUSKKcljkg2r15ZOxk9jFTJB7
         cUWvaL2N0Er1XLPBABHdz6o5NQRGk6l50yWtTaMttTnDhN3krocbcW+4DQEN1U3EJNSa
         xqXexyHX7N2R61Qrk06s38KZBcfxn/9O2fU5kRo6/XVR+TQDpDvpB+G5T91AKLw5KDg8
         DB04q2h/j0faNcsP6sCp5fxiQMK7K+DtCsVWYv/U6aKqVej0yEuhT73YcwSCVsCAHk4S
         fQKQ==
X-Gm-Message-State: AOAM5332J+YMsJa85f9huVRYdT71v0ZihV3QB5pPwNnD3y7GfmhWPDZf
        9LYDxyOrRo3I//byoZa5vs0=
X-Google-Smtp-Source: ABdhPJzr3irFczmBe1eJsYkO2R3dfetS/k0Ri8wGO0te0wYq8lCACULK8dBC/n4cs8uFzqR5OpR//Q==
X-Received: by 2002:a17:903:18b:b0:154:4d7a:1bac with SMTP id z11-20020a170903018b00b001544d7a1bacmr33143717plg.0.1649684496762;
        Mon, 11 Apr 2022 06:41:36 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id gn21-20020a17090ac79500b001ca3c37af65sm21159730pjb.21.2022.04.11.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:41:36 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        joro@8bytes.org, kim.phillips@amd.com, kvmx86@gmail.com,
        liam.merwick@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Mon, 11 Apr 2022 21:40:53 +0800
Message-Id: <20220411134053.738799-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Ykb400opkmZFsnVN@hirez.programming.kicks-ass.net>
References: <Ykb400opkmZFsnVN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2022 15:06:27 +0200, Peter Zijlstra wrote:
> If SVM enter/exit don't twiddle with counter EN bits, how is all this
> supposed to work consistently then?

Since KVM currently does not support the "Host/Guest Only" bits (41:40),
CPU wide events created on L1 HV will always count L1 HV and L2, so no
twiddle counter EN bits are needed when {dis,en}abling SVM on L1 HV.

This #GP warning is because KVM does not allow guest to set HO/GO bit,
It has been fixed in this commit 9b026073db2f
("KVM: x86/svm: Clear reserved bits written to PerfEvtSeln MSRs")
and has been merged to 5.18-rc1.

Because the commit df51fe7ea1c1c
("perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest")
is to fix a very similar problem caused by the same reason,
I think it should be revert now, it make things obscure.

And perf_ctr_virt_mask is used to mask Host-Only bit when SVM is disabled,
Using it on a guest doesn't make sense and make things obscure.

I wrote a patch to clarifies what perf_ctr_virt_mask does.

Regards,
Dongli
