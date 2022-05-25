Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B6B5345CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbiEYVcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiEYVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:32:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EFFA888A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:32:51 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a9so17890735pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fLi8Y5a/s0Xg4Sk1cYFIfOl1cphXOIvzxubSQqTFwj4=;
        b=ZWirXg9GI4GKB5Uq33+V6Gj1KKxuFriu0iWhLDVoOxYETu/nz4VSIKpm201of+wkWj
         CUPCPkaw0fddmC2mD9R6WQB/GeZKKfyL7dBQjJQ9ClrVMOZkXKYgvjJEFY+Q78p09g+3
         JTfQG+yBJgJRJAEo47nC1yU+ncAzpael52p2lKdIc05vXZtbLXylgcMzbDXd2dGf/g51
         poOQ8lg9+epyhpGQ2/J2harSg5MIIpaCavtplU7+1nO1NMjqncZ7aWmOYs9XIesURp0I
         fYHptTdPy3T6LKXrGHdwGNXoXrS9DITPtsUsk8x//s+b1tlyES6PEkq+yZzTcdiCY5od
         AF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fLi8Y5a/s0Xg4Sk1cYFIfOl1cphXOIvzxubSQqTFwj4=;
        b=6hp2oPzn6uoYTrwnwIyNVadW/LhFSD5ye4bZ+yLK6Nowl5qMRjtw1p8hpH274xcj7D
         8DZMnRu1EUIc9DteoUi0mLsDLn8cbwox+fLJqjpcNixmdXqWULzc9bNAf5oPyc8yXLYT
         Hqxo8AGzculTlDBH8T9nAj6eToh5zMGUlQHO4Jk9/q9Srd+RZDrOVg4RfUKwYpVNsl0e
         EzKQ+UI9mWK5DHNBz74hM7v8T8Eu+4wphyynwSYq7HHXUQDkNkpjOdw2xe9CVE+y/wh8
         xZ/9xncpHiI8topCe4XG4ytokVk3341/W9M7G0gIdWYi1n5BJywfzeQRJL6delFQdWIl
         7AuA==
X-Gm-Message-State: AOAM5321S6vrAayggieG8av5Irqg9KhxFL4SVDmPTNKcgkdHG6apFuAv
        R3e2Sp13qwN8R1/UWQGh4o3b9w==
X-Google-Smtp-Source: ABdhPJzxUwdWZSvkE8NvpYTpsxHZCR1FjjsO5G9TYaUE/rXrn+mu2UY6/q3ZhQaX0rWjrhSR4hSqDg==
X-Received: by 2002:a63:131a:0:b0:3fa:aa7e:b28a with SMTP id i26-20020a63131a000000b003faaa7eb28amr8518300pgl.569.1653514370848;
        Wed, 25 May 2022 14:32:50 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id y66-20020a62ce45000000b0050dc7628138sm12320869pfg.18.2022.05.25.14.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:32:50 -0700 (PDT)
Date:   Wed, 25 May 2022 14:32:50 -0700 (PDT)
X-Google-Original-Date: Tue, 24 May 2022 17:52:10 PDT (-0700)
Subject:     Re: [PATCH v2 1/4] RISC-V: Avoid empty create_*_mapping definitions
In-Reply-To: <87a6cfh0bq.fsf@igel.home>
CC:     linux-riscv@lists.infradead.org, rdunlap@infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com, lkp@intel.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-3fb658cb-0f64-4c62-8318-b9b4c906ef00@palmer-ri-x1c9>
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

On Wed, 20 Apr 2022 15:11:37 PDT (-0700), schwab@linux-m68k.org wrote:
> On Apr 20 2022, Palmer Dabbelt wrote:
>
>> (create_pmd_mpping() ends up skipped on XIP_KERNEL).
>
> Does it?  There is always the semicolon left as the body of the
> conditional (which is why you get the empty-body warning in the first
> place).

Yep, you're right.  I fixed up the commit message, thanks!
