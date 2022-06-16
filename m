Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237BF54EDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379322AbiFPXDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379320AbiFPXDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:03:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F556C1D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:03:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3055289pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wDHYazrSJbs5DQzniIUtQnffNw9K72mrEtU5mGnXyTM=;
        b=CDhgd1tWWuBnt3ODMFgRWChX4ZlhHDlNvk/KAnZvEM2Uh/2LxA7JlQqCAmIaIJ62Uq
         rjXr/O6k48kIcIKrhSGjKh010fJuX9FsZ1rt562IC6L5MxUV3swhFUMnabNLL65hn5aC
         O930jLdTFS18cl69MGnuTRlHwpjEb15YQyeuu3kf3gijZfiKPFgA2/6NAd/Xq/LNyy9h
         zTZMtfii0pTLVp0GC9cS6axH6lcZ27aHXQcLo4kMkovEhlsML1g7Mr140bcS+b5UGtEb
         3nH6yHy10Jz8Uqv9yjX/uc/MFdPj1BroBrZCEIenEA71dKuCij6itLoQ5Ln6P+jrzm9F
         ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wDHYazrSJbs5DQzniIUtQnffNw9K72mrEtU5mGnXyTM=;
        b=SPosz9EZh9AxomRIRGUnelTl9k9uyQfTgl1UGKXjOvP6DQ96wiaW0pxD0JA55Hq/9a
         ZHf7ikfO5UL5N09754THIy3piawH81ANfvvLMoSH7z8vUslG9FRgqSDGqe3cF2tyF9WA
         8WUIAGB4VxPA48X0GJxi37yigEoLgMFB1Qyr+RAl6bvYMnvjlq/+JNVuqZyZ/TqzXccF
         KD99fOniCnlwHpjNUfXWYJHuGlYePIQZqDuWJImf1J97p+NV11XRl5I4vzRzhffqDJJI
         VsLIxhKGNB+o57UKkive0afg2O6042Iks1sfeSlHHl9uh5gQe6pNgIUYiAllZqIgcRs0
         qz5A==
X-Gm-Message-State: AJIora9vFzy+Aw+Wh0uGoG2P9m8HjemINRFrboYYizFEBNF3Vm68KiFv
        ONwIC9So6M/c2tL/BqTyzRyHl+Cd+Y2CRQ==
X-Google-Smtp-Source: AGRyM1v6twEO75FBFVmu5dVRkWLbjc9Dpk9I3qAW4EUEVPN2f0MjYr+iMVrV7WSlrqlRKeASGwu5rQ==
X-Received: by 2002:a17:902:e30c:b0:16a:2ee:c232 with SMTP id q12-20020a170902e30c00b0016a02eec232mr1288991plc.123.1655420613404;
        Thu, 16 Jun 2022 16:03:33 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a165000b001e667f932cdsm4291967pje.53.2022.06.16.16.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:03:32 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:03:32 -0700 (PDT)
X-Google-Original-Date: Thu, 16 Jun 2022 16:03:29 PDT (-0700)
Subject:     Re: [PATCH v2 0/5] riscv: some svpbmt fixes
In-Reply-To: <20220526205646.258337-1-heiko@sntech.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Christoph Hellwig <hch@lst.de>, heiko@sntech.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-55ae586c-07b7-4e6e-b695-6df8608b87d5@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 13:56:41 PDT (-0700), heiko@sntech.de wrote:
> Some additionals comments and notes from autobuilders received
> after the series got applied, warranted some changes.
>
> So this is a small collection of cleanups for the svpbmt v10 series.
>
> changes in v2:
> - add Guo's Review
> - add patch dropping the use of function pointers in code
>   that can run before relocation
>
> Heiko Stuebner (5):
>   riscv: drop cpufeature_apply_feature tracking variable
>   riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
>   riscv: make patch-function pointer more generic in
>     cpu_manufacturer_info struct
>   riscv: fix dependency for t-head errata
>   riscv: remove usage of function-pointers from cpufeatures and t-head
>     errata
>
>  arch/riscv/Kconfig               |  9 ++++++--
>  arch/riscv/Kconfig.erratas       |  1 +
>  arch/riscv/errata/thead/errata.c | 38 ++++++++++----------------------
>  arch/riscv/kernel/alternative.c  | 18 +++++++--------
>  arch/riscv/kernel/cpufeature.c   | 37 +++++++++----------------------
>  5 files changed, 40 insertions(+), 63 deletions(-)

IMO only three of these are actually fixes, the rest are cleanups.  I've 
got ahead and put everything on a branch, with

    riscv: Improve description for RISCV_ISA_SVPBMT Kconfig symbol
    riscv: drop cpufeature_apply_feature tracking variable
    riscv: fix dependency for t-head errata

first.  Those are on fixes, the whole thing is in for-next.

Thanks!
