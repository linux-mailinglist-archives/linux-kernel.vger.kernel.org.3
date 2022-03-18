Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0974DD371
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiCRDJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiCRDJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:09:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C54D37AAC;
        Thu, 17 Mar 2022 20:08:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so6025368plf.4;
        Thu, 17 Mar 2022 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLOuy4vTpwrDzoB8dNyfy/kPY2i/RiV4Kuc3rmmq9WE=;
        b=qNAgTrZE6Kaz272Z3dneXvEe9rr4IhXtbCn+u3kwI+KcOcf7khKOpoeFQ087xbsCiW
         ADIFRMDsju1LLMWDZU5wfkmNIdr2WMlhITVT1iVV0UYJieDYPUEHJdJla1c2ULy0DHZF
         zQPzaN55aKOdpDDHfIbt7JxAzr9ugjg5gi1bhKlfCx3Rv212zGkZQz8ClEGw3qhurTXt
         vt7x2ak/v9jakcvWxCWCfx8Mwhm6Vc11oB/clOwz20uh6+jFp6Mr4hX/5LW4MBgC+nOA
         qjvn+/oYCiRIRIRFJLlEmjd1vX4Dv+KDY1595R6UKYTMZyaGYZfXUCzSM5u6a0PJKjWR
         8U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLOuy4vTpwrDzoB8dNyfy/kPY2i/RiV4Kuc3rmmq9WE=;
        b=ovQLrpKcjPkQ2coQ6Ofs2+5NIWWz0Pi7waCIxiqxFPhcbVpaEf6QSpttb7vcVDQKL9
         RmuNZMG3U71IS6IQ3Z+4BFFaCYUm4ttQ7HkKkCfL3jXKLvu96/7OXYw6Fr+eQBay7+Xv
         eNfBhhT7gjBuV0/Rayj+sOLPlYs+PL/soudIcOWhMI2HYnS4E/mOQoDfOhsm9cQxXm0b
         UuXtaIB07f8j27ubK4g4c52QKLVDeyfYQOVOCoVM1yeR4bpub63ChsaG15FzSjbvqgJi
         iqxUkln3OU8XmTRKKkWC4TOs1fdUyY5aldIiNDAXIJ8gDT+FuTd6I22FrBsHmRDdxB5A
         Qi/g==
X-Gm-Message-State: AOAM533qlTTmY/bLeaLJoljwBoGoxbOInv5w4ZK07lIpUv+lFTEvC6tw
        IRKcU8KgzJO7sEGtAamK5HI=
X-Google-Smtp-Source: ABdhPJzY40xVDDuom6Vxxepk/wNdmhNtzLUOY2HRt7VMjsM+NZXRdIBN36FfmoD8wfDpr1Zexc9jgg==
X-Received: by 2002:a17:902:c946:b0:151:efa2:3789 with SMTP id i6-20020a170902c94600b00151efa23789mr8444008pla.144.1647572901288;
        Thu, 17 Mar 2022 20:08:21 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm8445845pfw.188.2022.03.17.20.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 20:08:20 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     bp@alien8.de
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, joerg.roedel@amd.com,
        jolsa@kernel.org, kim.phillips@amd.com, kvmx86@gmail.com,
        liam.merwick@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Fri, 18 Mar 2022 11:07:57 +0800
Message-Id: <20220318030757.1706799-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YjIspMR0lm6+W/Pp@zn.tnic>
References: <YjIspMR0lm6+W/Pp@zn.tnic>
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

On 16/03/2022 18:29, Borislav Petkov wrote:
> What's the point of this "wrapper"?

Hi Borislav, this is just to more clearly test if the current kernel is
running directly on the host.

If this is redundant, I can remove this "wrapper" and resend the patch,
the v4 patch code will be the same as the v1 patch.
 
Thanks,
Dongli
