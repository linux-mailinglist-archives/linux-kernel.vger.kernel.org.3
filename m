Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D704E36C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiCVClk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiCVClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:41:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179ED24F02
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:40:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so950980pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=M+KlCJnb95r0VR1xBE5WLiRYber7fzPWf0JKHkm47E0=;
        b=Pe0u5j5dFgSZ3lzCDOdBMiZkLDKDrBHO4RaGl9PVTMzGEvtxylOpkAyknVfzIpO+Pz
         ehR+nkVvIdTYsCY+P3yFpKLsWaX+15b35OChFAjuO0ygpZnVv/45OCaHeU1x5A8cg2R0
         MGSQvXE7COuhSYamHkoUH2dPNWwGWwnPBGqqh8xMQ6qLCRuG96LpVcXbhtyrDh1Jzqky
         khcLzlfY01LbFFTj/yZnIa8WQ5oJpFPpT9YEMBwf0uGv4cBPmi6rd3zchZij9eyrlQZq
         tf0Y7ZRk8k747hA+WQMYW0sVnJpoGvxUAYx9fqWDdDNPaFr1xbojzpAOo4gEtu81i7N1
         9flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=M+KlCJnb95r0VR1xBE5WLiRYber7fzPWf0JKHkm47E0=;
        b=yHIwY9pNSe3AZB7/yH1dw3A5W/H/GyKIIgFMwKsgo1e/+epsNur5YBXCkJzqZhey5u
         4P753AS6ZoPwmOvjIEbQMc/mkcTcHm+e+WgkaD0/VOfCP2YBcivAzy4rv+Jubo3kO65S
         Bj34CLaS7ffN33xkkNTEWEbuQTyJwgLhNPiRYaTvzFuysckNZ4u3DJE08yMKaFSfBHH3
         J+wLQVSyKqc6g+ljyWpXIUIPtfVfQW//0q/aeY/s9O4x7+Rk9te4zWFZOySSz6qOZ5rE
         bfwdj1M8esVTe5uh6TNxt1aNHKi0m0/VCHshCZtLRda2CovUR3QTQjOPp8EOfs0hSsSg
         9i5A==
X-Gm-Message-State: AOAM530XB7WfCjDPie2IONNdYjfcls+bmLwY2gJjOEa7BRcYnw5TLP2n
        zQ+rpYrKtq1LB5e+iQXNAeZv/A==
X-Google-Smtp-Source: ABdhPJyDcJGpQWK2rYm3jfCyAwNOjQpHzMh5NTSXwfiYOHiLN06VyUaDlpPdX+aQeV/AFP+ZUbQqqg==
X-Received: by 2002:a17:90a:c984:b0:1bf:aee2:3503 with SMTP id w4-20020a17090ac98400b001bfaee23503mr2402874pjt.28.1647916809497;
        Mon, 21 Mar 2022 19:40:09 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b001b9e4d62ed0sm724127pjl.13.2022.03.21.19.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 19:40:08 -0700 (PDT)
Date:   Mon, 21 Mar 2022 19:40:08 -0700 (PDT)
X-Google-Original-Date: Mon, 21 Mar 2022 19:39:45 PDT (-0700)
Subject:     Re: [PATCH] riscv: ftrace: no need to acquire text_mutex when executed in stop_machine
In-Reply-To: <20220313080711.mrzsgtxpbycug2vm@mail.google.com>
CC:     rostedt@goodmis.org, changbin.du@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>, mingo@redhat.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     changbin.du@gmail.com
Message-ID: <mhng-62c2ef00-fb64-48c3-a2bb-43b2799161bf@palmer-ri-x1c9>
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

On Sun, 13 Mar 2022 00:07:11 PST (-0800), changbin.du@gmail.com wrote:
> On Thu, Mar 10, 2022 at 09:27:42AM -0500, Steven Rostedt wrote:
>> On Thu, 10 Mar 2022 12:54:54 +0800
>> Changbin Du <changbin.du@gmail.com> wrote:
>>
>> > It's safe to patch text segment in stop_machine. No race is possible here.
>> > Besides, there is a false positive for the lock assertion in
>> > patch_insn_write() since the lock is not held by cpu migration thread.
>> >
>> > So we actually don't need our ftrace_arch_code_modify_prepare/post(). And
>> > the lock assertion in patch_insn_write() should be removed to avoid
>> > producing lots of false positive warnings.
>> >
>> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
>>
>> Ideally, RISC-V should try to get off of the stop_machine approach, and
>> move to the breakpoint modification.
>>
> yes, that's a further step. I can feel a obvious stall to enable ftrace running
> in QEMU. (maybe qemu-riscv tcg is too slow...)

Looks like we've had this exact discussion before, even with exactly the 
same patch and people and everything.  I guess I dropped the ball here, 
I got so distracted trying to figure out those sequences to avoid 
stop_machine() that I forgot to clean up the patch to fix stop machine.  
I just sent out a v2 <20220322022331.32136-1-palmer@rivosinc.com>.  That 
should at least fix the crash, we can deal with getting rid of 
stop_machine() later.
