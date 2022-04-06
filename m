Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1166C4F6B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiDFUvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiDFUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:51:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8869396AFF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:06:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 32so861775pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xEHjPFbG2l95vT/9TUf5xFEmrU+wbLDsR7mssjGd3t0=;
        b=0eKouJ7hzOepoVSRqRsRB5ISeXx5Nnlsh14Z1+53rddDy3I8jc5eKeLb6eDXtzkKGc
         L525OQvHPL8S530OfqYvY+irHpGV2xABBSf+IDUZy2TIx9o0HOVcskxU+vys6yD+o+Uk
         Lney/6JQGjjx8pDVxo6Qj7fyU0sRt2PlviBAiMEBMttx/TSlRs4qvlYSqS2wx7NT5UNX
         6cmLXSroLEDYa5BKLtbFZugvXcSdfLritrR1NnsKzh2QJzb4zlZHUAOjbdDGEm9522jw
         5U7yEwauEC4gC1bJpv/7tuwrw/e/YsognCW0wblaH9nEZnSZUbabNx9XD62+MGGfEK65
         IZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xEHjPFbG2l95vT/9TUf5xFEmrU+wbLDsR7mssjGd3t0=;
        b=B66s2CKyINm2l0IoFgr7U5YP8WvaRnLGDtnhvytRd9y2mjjgqOlQlZfYREK8Zxd0kM
         fqAQQjLMEvbwQQMTlKO2wrGNR112crV8dE8qYcl/Fy9NzqEwqlOpmqp6dkUh7PxCNN31
         +eR8TkcP+oPwIDj3ZKoP50JEL7YwU+9WSe+mc7R+FGpI6IrHMHHYLUrqFGqicr4ZZoEC
         r1sh/vx5SAaAQ3msni2kGE3ES91xGpeJWjNEStmmeQgR5DsfVQ9iFGPe4m1Z5R8WW016
         VPXNfdPDyKMszwaGHBExmX9/2LiZZ8/kFLbga1dxfl7x+In5MKed0U5yn3btB04lZQf8
         B4OA==
X-Gm-Message-State: AOAM531lEVKICNA4XtaeHPrZyFiQFYuMRhWSp48vKMkCggCJYdZbaNzj
        HiSrb4wdUXBQeeSol6g66X43MQ==
X-Google-Smtp-Source: ABdhPJzzIPquNU49pHdFoqAJuy/FaFv3mvXL+ipftmawmoH39R144bhpC5RIr4bImN+8/rAtsHhEjA==
X-Received: by 2002:a05:6a00:190a:b0:4fa:e4e9:7126 with SMTP id y10-20020a056a00190a00b004fae4e97126mr10336457pfi.65.1649271991420;
        Wed, 06 Apr 2022 12:06:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z16-20020aa78890000000b004fad8469f88sm20788500pfe.38.2022.04.06.12.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:06:31 -0700 (PDT)
Date:   Wed, 06 Apr 2022 12:06:31 -0700 (PDT)
X-Google-Original-Date: Wed, 06 Apr 2022 12:06:29 PDT (-0700)
Subject:     Re: [PATCH V3] riscv: patch_text: Fixup last cpu should be master
In-Reply-To: <Yk3YUFfvEszb+cXT@kroah.com>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, guoren@linux.alibaba.com,
        mhiramat@kernel.org, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Message-ID: <mhng-492e449b-ad90-4725-86a0-d5d84e4c35be@palmer-mbp2014>
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

On Wed, 06 Apr 2022 11:13:36 PDT (-0700), Greg KH wrote:
> On Wed, Apr 06, 2022 at 10:16:49PM +0800, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> These patch_text implementations are using stop_machine_cpuslocked
>> infrastructure with atomic cpu_count. The original idea: When the
>> master CPU patch_text, the others should wait for it. But current
>> implementation is using the first CPU as master, which couldn't
>> guarantee the remaining CPUs are waiting. This patch changes the
>> last CPU as the master to solve the potential risk.
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  arch/riscv/kernel/patch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> What commit id does this change fix?

I think it's been there since the beginning of our text patching, so

Fixes: 043cb41a85de ("riscv: introduce interfaces to patch kernel code")

seems like the best bet, but I'll go take another look before merging 
it.  That's confusing here, as I acked it, but that was for an earlier 
version that touched more than one arch so it was more ambiguous as to 
which tree it was going through (IIRC I said one of those "LMK if you 
want it through my tree, but here's an Ack in case someone else wants to 
take it" sort of things, as I usually do when it's ambiguous).

Without a changelog, cover letter, or the other patches in the set it's 
kind of hard to tell, though ;)
