Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877064D598B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbiCKEak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiCKEag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:30:36 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B76175820
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:29:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w4so6702989ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=zrOypvYSBV/aO1CQ4KPF0DXRvckOSNU+3tRTfGLgwBc=;
        b=jZOmkQuMI6RuFhKg8NvmaxRDGtTrt81dOEQyqYgjW74rFBLVRanGjb2i0VmOH9c8u0
         oDsFgE/gVtj/2zwlvuY0m7sMnt25p8cZESvHeYZKU6UxlTf3LiXQGvf9y05sQUZy/mcr
         Dr8j3zAT3wY6PzxPiHYPWjvztkeGKv96NtDwPXTKw3ISsyEnKMXvAdQt9sMGbtR0iN6N
         TZvP3DmwgA1Cz8ich7sgblV8Qbrp6EsLHqsjutBsl7gVa9xK44gyoLLNmwE944wRFo+L
         PACWqwc2BT29y68XXByp9nq5NJgFhlF3NR5FHie7p51WEURn/FdO7pEhT4jnszHnxKVm
         pXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=zrOypvYSBV/aO1CQ4KPF0DXRvckOSNU+3tRTfGLgwBc=;
        b=jpOtwQ8xESu4NMPAE6KBJHWmdCWBIoU37vbTZQR68t6BsEeKfyOv5v/1SAasQTeEh1
         XAuOiLwrqaeLl2T/dX7LDIsSU7z0W8LUSAoBzlEfrSonE/r6CG4MU4UMtPGkIz0QRCkq
         Ew8BFsx1jH3x+mVJnZ/H4kdw3H7iZG7J82fJ+VhPlBvHphlIkZIlh1f5v11J8Vnd7Qeq
         3RSyDfp4GwkoaS8Wn8C5/KW8mFqQVbXy3Ktj3VvfcVfXDsgU6DJPOr9z3wnB3qNtx+D8
         bbpJyAUmrHJ7vYcw5RKDw+E1Z455tNjKubjCAX+HCedeW+MK7i1Cbof10Zj3Ma2iDFtu
         5yKA==
X-Gm-Message-State: AOAM531w3Mj6GcCPm/C7RqLsxHTs23D3mccdOg1o5yKqTMxCm+v9DwRA
        Uy2+oxLHCuvsqfZOv9WArCGuCg==
X-Google-Smtp-Source: ABdhPJwpxDR3gGioaEv9ojhLroxIx+LBfNQORccewdv7C3h8rx4tg3f/4LAKta2pms042VRbyIeHMQ==
X-Received: by 2002:a17:902:f682:b0:151:a262:ad4a with SMTP id l2-20020a170902f68200b00151a262ad4amr8932436plg.84.1646972972298;
        Thu, 10 Mar 2022 20:29:32 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id o65-20020a17090a0a4700b001bef5cffea7sm11864363pjo.0.2022.03.10.20.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:29:31 -0800 (PST)
Date:   Thu, 10 Mar 2022 20:29:31 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 20:28:45 PST (-0800)
Subject:     Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
In-Reply-To: <b10e777c-1511-519b-20bb-a682a6119132@MichaelKloos.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Michael@MichaelKloos.com
Message-ID: <mhng-97bc7422-36da-436a-a326-1705ef6fcace@palmer-ri-x1c9>
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

On Thu, 10 Mar 2022 05:37:27 PST (-0800), Michael@MichaelKloos.com wrote:
> Is there something I can do that would help alleviate your concerns or
> apprehension?

IMO this is one of those cases where having hardware is required.

I can understand the goal of providing a Linux port for the minimal 
RISC-V compatible system, but IIUC the minimal RISC-V compatible system 
is any object associated with a member of the RISC-V foundation that 
said member attests is a RISC-V system.  There's really no way to 
implement Linux on all such systems so we have to set the bar somewhere, 
and bar is generally set at "more time will be spent using this than 
maintaining it".  Systems without M have generally not met that bar, and 
I don't see anything changing now.

If you have users then I'm happy to reconsider, the goal here is to make 
real systems work.  That said: we've already got enough trouble trying 
to make actual shipping hardware function correctly, we're all going to 
lose our minds trying to chase around everything that could in theory be 
a RISC-V system but doesn't actually exist.

>
> On 3/10/2022 8:22 AM, Michael T. Kloos wrote:
>
>> Some other thoughts:
>> It sounds like I am not the first person to want this feature and I
>> probably won't be the last.  I created the change for my own reasons, the
>> same as any other contributor.  I think we all know that I can not pull
>> out some chart and say, "This many people want this and here is why."  I
>> live in central Ohio and have been doing this as a hobby.  I don't even
>> know anyone else who knows about systems and operating system development.
>> If the justification that you are looking for is that I as some
>> hypothetical developer at a major tech company is about to release a new
>> RISC-V chip without M support but we want it to run Linux, I can not
>> provide that answer.  It sounds a bit like some software or hardware,
>> chicken or the egg anyway.  Trying to maintain my own fork if people
>> start contributing patches with incompatible assembly scares me.
>>      Michael
