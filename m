Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459D5552B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377426AbiFVRoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377389AbiFVRn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:43:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C02664
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:43:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q140so16720123pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bUXnsJdEFiCG+SMWEsd2jUVr6VH+u5NdRqQetyt+5jU=;
        b=aN6cVYuVa2RBa6c0SK9DmWxymPrXYFhusiNe2XjgzwcSz3tFcnwgegQGnVn8Rk0G3E
         no/B9vS8HejD4uV/kTwhBryE8MQqA/mKcM8jcYpwuN/DLI/ojwXxm+1Zj+WXiRhM6Wg5
         Sek+ZSoMOhzJu9YYMxDVdFTUh7ea94tuidVaTJKWNcW/RbEBv2vpG92zlXVqviRUBnlT
         b2GGoPNqlsPGG2lO/yN198G3z7+TLGKLeL/fm+d6mUVJ3iX2EhQt9MtUjj1MjVO/C+R8
         GPKx97BL/HW+CXxCNfhLaSCU7n+8vNktRPyt5xKylDD/7+NZAH2sDsV1KM6Yh7oMVbrA
         Anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bUXnsJdEFiCG+SMWEsd2jUVr6VH+u5NdRqQetyt+5jU=;
        b=XsSgeEVIB66ww4wHjH3ZxOD4s2LDRiJ4y8wrGojl+GIE55NsPFsaS9Ly1rfWTWQkVX
         ShIvdnWz3QH8iJVEw6G8pcqS999quGfAv4c8cfDtYTZlDuB9jQn/KCdICfPP5k8tFFYn
         BXkZnFjhd8A/v9PQZNj1zHTvRd2LdEEjVhmN7OuFoTIMZP9LUmfr+3nwiJJ3KRByc/Oo
         cnwjeU5yWS9Ou/SwwbwOMiLqCjo8N40P7/ZoFd2fIOA50py4dKl1gk7xZptDY9DvcDnG
         uP6nGEGnOpJK7GHeYrr1mrRK01pF0EhU27iHbZBnRfHCdZaMrN9o6x+nPP+hwqeAcKLt
         bWXw==
X-Gm-Message-State: AJIora9LVzVpGa9oasLUa05Ycx9p/74sQDz0jZe+vYPxHj2lkE6ytcEW
        J3VmTy5yrPxODj+2JTrbVxXm+5zNO/d9Wg==
X-Google-Smtp-Source: AGRyM1uhuLVklzd1mZvWuHmjdudBMSsPGdfyvcUOZW4m0ZDtiPRFEmT62FqhS2XMIWcf8orqboT4kQ==
X-Received: by 2002:a05:6a00:170b:b0:525:4e88:f7ec with SMTP id h11-20020a056a00170b00b005254e88f7ecmr1938154pfc.2.1655919837319;
        Wed, 22 Jun 2022 10:43:57 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902e14400b001637997d0d4sm12932432pla.206.2022.06.22.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:43:55 -0700 (PDT)
Date:   Wed, 22 Jun 2022 10:43:55 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Jun 2022 10:43:52 PDT (-0700)
Subject:     Re: [PING^2][PATCH] RISC-V: PCI: Avoid handing out address 0 to devices
In-Reply-To: <alpine.DEB.2.21.2206221202590.57474@angie.orcam.me.uk>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     macro@orcam.me.uk
Message-ID: <mhng-a0733eea-8220-4bf6-b1da-9de3139dbae3@palmer-ri-x1c9>
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

On Wed, 22 Jun 2022 04:04:09 PDT (-0700), macro@orcam.me.uk wrote:
> On Wed, 27 Apr 2022, Maciej W. Rozycki wrote:
>
>> Therefore avoid handing out address 0, by bumping the lowest address
>> available to PCI via PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM up by 4 and 16
>> respectively, which is the minimum allocation size for I/O and memory
>> BARs.
>
>  Ping for:
> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2204271207590.9383@angie.orcam.me.uk/>

Sorry, I got this mixed up with the non-RISC-V patch.  David poked me 
about it, this is on for-next.  It's passing my tests, but they're just 
QEMU so probably not all that exciting here.
