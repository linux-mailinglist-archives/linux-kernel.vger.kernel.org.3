Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40C587B08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiHBKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiHBKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:52:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2F17AAA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:52:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y13so11247417ejp.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XdVAnfQ0dVySFOaw/b8Pu8nKKQlmM6z22D0DLysEdi4=;
        b=mUJE4WwMaZAAOw98u9yYL3T1cfk1bqLWxU7Z4ZIhVTPU5vwJcAwYOdiILjPlQ9Vgrh
         71OTJZHu+gxFgc5ws1qx59laygSiWwUq9yB1aKWrT9OcucBIkcGQcT1f7GExuQCu0Yl3
         R1CVTk/KCJDCfhpTnWAmNmekPybUy4uv8U6QzD2hZR7w/rkUcPUkSlaz+mdIADu/4N2w
         gPDqkuTpFxcyE88koNDbj7ewQcdG73Nl5lJNii37i9sf1pVS2hrurHiGFJShZ9ZSWjP5
         BlFnXkcblSRpb7LlWjIc1HVn0y6XNeNn9X5JESKkc9lgya+2zWpmcQOZYuTXeV36tv+F
         cNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XdVAnfQ0dVySFOaw/b8Pu8nKKQlmM6z22D0DLysEdi4=;
        b=A3+GeWfWtK7K+R6JqSR7VbTuCWh7w8gA1SY5qXMNckPqgKi6WkMv2Nx1b89R/14dc2
         ODqkOFXiLi/NW9qcGqygkwBHPVNKpkKW3KJU1kiXCntmLBA5KxRuCGGeBlsKNbGuBiiU
         n69KjB7iZa+IzMW2JmuAa0VIz36r9SQ+dF3Ol30MhWjRHt+JymY4P5WP4VHTMO5OSRYm
         SUGwF1k2AeIPIeq8Nujv5NoJdI77CVMqNwBXKSC6z82bhWaDC33M7iwrpf4WqBBe4rZJ
         WUrKaKtguZrczoHrK8kx2k1BGz3lGjINjjY26a6pXPx6pEaC6QzokSX/xtDl8FgdyNrA
         gHng==
X-Gm-Message-State: AJIora+YzXQP0FmolaCrNbbO+HTwxnpAM3BHxCh6DjZHz37M2bTMxQqv
        dI4r19IkMTUrgQuizx42KWSCDIEiHF0=
X-Google-Smtp-Source: AGRyM1vxcfWMK3q99cUVk0qLEqBAvD/2M3n1orppz+p3IWxotabALxtZBdc6dz7MOGC99xM+T/sR/g==
X-Received: by 2002:a17:907:724c:b0:72e:e6fe:5ea4 with SMTP id ds12-20020a170907724c00b0072ee6fe5ea4mr16234439ejc.421.1659437522133;
        Tue, 02 Aug 2022 03:52:02 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id f2-20020a17090631c200b00730860b6c43sm2193089ejf.173.2022.08.02.03.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:52:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 12:51:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RESEND] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Message-ID: <YukBz6t1n3aMbznT@gmail.com>
References: <20220802033206.21333-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802033206.21333-1-chenyi.qiang@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chenyi Qiang <chenyi.qiang@intel.com> wrote:

> It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
> this kernel has been kexec'd from a kernel that enabled bus lock
> detection.
> 
> Disable bus lock detection explicitly if not wanted.

Makes sense.

Just curious: in what circumstances does the BIOS/firmware set 
DEBUGCTLMSR_BUS_LOCK_DETECT? Does it use it, or does it enable it for some 
spurious reason, without really using the feature? (Assuming you are aware 
of instances where this happened - or was this simply a hypothetical?)

Thanks,

	Ingo
