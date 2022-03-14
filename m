Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4264D79DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 05:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiCNEU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCNEU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 00:20:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39A3DDD7;
        Sun, 13 Mar 2022 21:19:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o26so12684964pgb.8;
        Sun, 13 Mar 2022 21:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xn6H3mA7b0VSrMKmRJSvK65xNehM2Gh0IqixaKFebDg=;
        b=bOj22QdvpSwsEmS2IwuPh2Z0UtElEMWMsifcMRfvfdrbNyxY7ur2GS2ItepyzV7xlz
         Zu3bJG0Bzkyc6kFRubqH1YkHEyuDgV6ud9HleGCJqx9oZgsjx9o5xi9+wjLt4GmZd94G
         gE787sGC9qa8f6PQgbvhjFYYnlZbMmIS84fAxrIA+xIpLyTfxbm+NcLoZgABi1pAc93K
         lnLRMFSdB1jmAYtowGDewkHGNQVIp6D/AnwU2aplECPVwtyz/9wB7OaJWT4CMoNFpcZa
         BPwFyeeuQkCWlqyH0Klb7XCFMxlwAf0TTerpNaULzA/wQfyQ772QC6rrs6oulB0/1z6o
         Aemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xn6H3mA7b0VSrMKmRJSvK65xNehM2Gh0IqixaKFebDg=;
        b=ckhYbu8i7ZaCBubN79lpScjoXmGU0BU65ZpOiu5kXdtj5bosIVMKGRPtdG3sJEZhuc
         kwU1YpjUwIkWrDkEDwly/TSGSSQSy5oXOlAehCjmYSdGzL/CtmDcWYkqlfDJiChsYd5W
         nH7GgV7xp3YzfxNNQFMym5CkQn+V7C+mW0B8Hq63boAIFF6/lLPcxXrULfopDYK++bai
         OxKLYZyllVTj175SQuCRBWb/H7xhxGViiSN0VdRMwnCYvJc2hKE3IQ7UarZlIPSJckDU
         0v5XwkRw2EDUJqS9wtEEJ/Iw8JrJfCq+VtA3QX1UB2w3C7UBOxaSe0R+vQxgKBcfmjst
         ew/w==
X-Gm-Message-State: AOAM5338jDpwJKyY3eRr8gQG6m8Ov8yLQLmitecPxkmSCQ2FGfZhZF1b
        y7FdXf+NP9PXGMmZRhEgDdyxeiIAb7w62g==
X-Google-Smtp-Source: ABdhPJzb9O8NS4VJyLozBGT8LcFD6kasrh3c/PtACZK8NROEfnvEa0E0y1h3A2JuacqstTwFXLdhwg==
X-Received: by 2002:a63:fa0d:0:b0:372:d581:e84 with SMTP id y13-20020a63fa0d000000b00372d5810e84mr18430949pgh.414.1647231587839;
        Sun, 13 Mar 2022 21:19:47 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id a133-20020a621a8b000000b004f6a79008ddsm18361447pfa.45.2022.03.13.21.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 21:19:47 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     liam.merwick@oracle.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, joerg.roedel@amd.com,
        jolsa@kernel.org, kim.phillips@amd.com, kvmx86@gmail.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v2] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Mon, 14 Mar 2022 12:19:30 +0800
Message-Id: <20220314041930.1487087-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3508496a-59ea-2004-2917-2ffe712cc187@oracle.com>
References: <3508496a-59ea-2004-2917-2ffe712cc187@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 22:25, Liam Merwick wrote:
> On 10/03/2022 18:34, Dongli Si wrote:
> > From: Dongli Si <sidongli1997@gmail.com>
> > 
> > With nested virtualization, when the guest hypervisor runs a nested guest
> > and if uses "perf record" in an AMD Milan guest hypervisor, the guest
> > hypervisor dmesg will reports the following warning message:
> 
> I think it might be clearer with L0/L1/L2 terminology. Maybe something 
> like the following?
> 
> "With nested virtualization on AMD Milan, if "perf record" is run in an
> L1 hypervisor with an L2 guest, the following warning is emitted in
> the L1 guest."
> 
> 
> > 
> > [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
> > at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
> > [] Call Trace:
> > []  <IRQ>
> > []  ? x86_pmu_enable+0x146/0x300
> > []  __perf_install_in_context+0x150/0x170
> > 
> > The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host, while
> > the guest hypervisor performance monitor unit should avoid such use.
> 
> "The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host (L0),
> while the L1 hypervisor Performance Monitor Unit should avoid such use."
> 
> 
> 
> > 
> > Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
> > Signed-off-by: Dongli Si <sidongli1997@gmail.com>
> 
> Tested-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Hi Liam, I will improve the description based on your suggestion
and resend the patch, thanks!
