Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8024AA28B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiBDVpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiBDVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:45:14 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A78C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:45:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y17so6246384plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RXQ9zkwSxXGia+YhwgGsPcrPrVdaFvM/lO5LjhANYp8=;
        b=72cPjU3xW8fy0ORG354nI1xNq0l92wTwxBtglnv0fqlglT5T9LrAej5Cb/Aly7bq6F
         +lFrkgn0bEq80rfrXvnFBvERAnh2coRqGuyuGNZ3yFK/JB13gGZaL8DIwIxPxn4AfPfM
         mzIC+etEoWihcAVSIeqIU1F506Y1FvZPfz8KTbzUWRdyYAaQoDmelu9cRaJgPbJo+N+v
         sP9QDLSTWBxQduwAEA1sG7AUKJ6g8jLQytLBrqWdQaezL2mnp/kBTCYzT/GcVcVWBdPl
         NyXrKpJZ9qtlGhgCTL25EPp98TAbcBtNXJWQ8juySYwH0i9X0ESS/oNt4oiSm/HwpXw5
         kweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RXQ9zkwSxXGia+YhwgGsPcrPrVdaFvM/lO5LjhANYp8=;
        b=A+TdsWIdSepiraMOzMD04lvtGBzG8dlcubXE7i5Pnkfpsr7TMUX9wQdC12Mz5KSNt3
         xmKcN8wLdydL78wHLAcD5vhnw9HxY/gvBiiVXopuRF/QC7bDpQ4uxChwk2Oi68kEtB6p
         k8SLN0XygVXkHBGTvaz9x41DzKgXdHTDjx701rBYTSMGS9i9AimCcuSZkpObsqftmEBC
         gj6cUpkysPkrfs+PT7b1gOVb3pHUXwekxLJGAfQRUg52nDT58gzS9SCA5f7iFn0Uqz0h
         qGzDBJ0jathHj2e3uqO1r04JABqM0bQbONffhmFifkP8HDMnMAgRFQC1dQfIB2HCz+cQ
         LykQ==
X-Gm-Message-State: AOAM531hTXkCqxwrZt8sYySrhffB5uip/6ko3xhTOgyvHvAdxVh2cDFC
        8n8i9gmgb8MVzGhXklqEOeTPcQ==
X-Google-Smtp-Source: ABdhPJwlGiBHMIaT1hJmvVYY3KJcfFsZwVOaoOmsAmPKxrtQTNxcG4RbWsH74qryUGdK04AAI17yAg==
X-Received: by 2002:a17:90a:de98:: with SMTP id n24mr1071904pjv.87.1644011112830;
        Fri, 04 Feb 2022 13:45:12 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id t2sm3342218pfg.207.2022.02.04.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:45:12 -0800 (PST)
Date:   Fri, 04 Feb 2022 13:45:12 -0800 (PST)
X-Google-Original-Date: Fri, 04 Feb 2022 13:42:41 PST (-0800)
Subject:     Re:
In-Reply-To: <CAM4kBBJqHVX_Q2C0VO7qKNZywRiWbHK9t0G076ov6u+_gwO2=A@mail.gmail.com>
CC:     gatecat@ds0.me, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vitaly.wool@konsulko.com
Message-ID: <mhng-2db944e9-a159-4202-ae7b-2af9c59b3098@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 07:37:00 PST (-0800), vitaly.wool@konsulko.com wrote:
> Hey,
>
> On Thu, Jan 20, 2022 at 4:30 PM Myrtle Shah <gatecat@ds0.me> wrote:
>>
>> These are some initial patches to bugs I found attempting to
>> get a XIP kernel working on hardware:
>>  - 32-bit VexRiscv processor
>>  - kernel in SPI flash, at 0x00200000
>>  - 16MB of RAM at 0x10000000
>>  - MMU enabled
>>
>> I still have some more debugging to do, but these at least
>> get the kernel as far as initialising the MMU, and I would
>> appreciate feedback if anyone else is working on RISC-V XIP.
>
> I'll try to support you as much as I can, unfortunately I don't have
> any 32-bit RISC-V around so I was rather thinking of extending the
> RISC-V XIP support to 64-bit non-MMU targets.
> For now just please keep in mind that there might be some inherent
> assumptions that a target is 64 bit.

I don't test any of the XIP configs, but if you guys have something that's sane
to run in QEMU I'm happy to do so.  Given that there's now some folks finding
boot bugs it's probably worth getting what does boot into a regression test so
it's less likely to break moving forwards.

These are on fixes, with the second one split up so it's got a better chance of
landing in the stable trees.

Thanks!

>
> Best regards,
> Vitaly
>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
