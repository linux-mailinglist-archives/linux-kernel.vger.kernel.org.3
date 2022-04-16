Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C5503314
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiDPCQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiDPCPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90211F47E5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650075129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hb96ojkoLw7AMiZ7GVNm8rfGhRjOoCkHeqA5a/3O9g=;
        b=DyBt33JktCRpZ9x1c+yMTicN0DtU+NBqWmVhLWev59BKrfRq7hZrFdZqfGnLPu9qN+PAyH
        OPE0lbvb9bhdWuW2oP/4iOmHgmc/Ijn3h6sMz0HaPZwL3UIKNCE92/BdmE7d8T1SfV+ew8
        zqBGAhlSG5o0ni+IGc3auo1jASizDDo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-Spu3XCRTOlWUDdLE63H-ZQ-1; Fri, 15 Apr 2022 20:56:14 -0400
X-MC-Unique: Spu3XCRTOlWUDdLE63H-ZQ-1
Received: by mail-qk1-f199.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so6482880qkp.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hb96ojkoLw7AMiZ7GVNm8rfGhRjOoCkHeqA5a/3O9g=;
        b=NJVXLbO7ZDLQy+jqqhccYdwauOgPuCN7MReftcT6t/4VzqzWwIGfro0nyQxiPGQtle
         +uHVcAvifWTzChtFvSIneldfcrfv2oVuBpXdKDmnzPdFdTVKYR73gtksXOCjmfjR86jO
         I4TttvutDHfzvQ07PSK1Grz7r7/7c+xo03ucbDQSVVNrO6v6omMimqYyU33ks6tIuyzZ
         fx0SsgGJEDBnKWCTgZFygUCK3BhIAHmfNmXY421X7YKzqKo1xKuWj4LZ6ETks2k/QYYw
         fpIvTlDz3WUuiFkbzdc3YoYDahl/uhEOqU8Ww027cx97REuHALSt8Pk1n3kL3wgOUIHe
         gmkQ==
X-Gm-Message-State: AOAM5313VQRdv8girhNOA8KQ3n0JuG6rFwNqKFoo4Lay7jRl7e8jdSVP
        xMyPw8WlGqFamOl3P8orcRz3yxKira5pMX37bZk33WYqJJ2u2tH7lGo+Otoj3rEnDlRTWLVi2BN
        ymtQ6fvQPkd7jCfOA+vKpjnAt
X-Received: by 2002:a05:622a:1f8c:b0:2ef:9ec3:e176 with SMTP id cb12-20020a05622a1f8c00b002ef9ec3e176mr1098434qtb.39.1650070573506;
        Fri, 15 Apr 2022 17:56:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyW8eq6CVpC4t7+D5RwWQ2Sr5wdDGnmiP1wm3b/X7cOpvlUCwWtVvnTzG1xXkamMQoqom5Bg==
X-Received: by 2002:a05:622a:1f8c:b0:2ef:9ec3:e176 with SMTP id cb12-20020a05622a1f8c00b002ef9ec3e176mr1098430qtb.39.1650070573290;
        Fri, 15 Apr 2022 17:56:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id i23-20020a05620a145700b0069c4e3b9c1dsm3170445qkl.46.2022.04.15.17.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:56:12 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:56:09 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        mark.rutland@arm.com, broonie@kernel.org, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] arm64: livepatch: Use DWARF Call Frame
 Information for frame pointer validation
Message-ID: <20220416005609.3znhltjlhpg475ff@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220407202518.19780-1-madvenka@linux.microsoft.com>
 <20220408002147.pk7clzruj6sawj7z@treble>
 <15a22f4b-f04a-15e1-8f54-5b3147d8df7d@linux.microsoft.com>
 <35c99466-9024-a7fd-9632-5d21b3e558f7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35c99466-9024-a7fd-9632-5d21b3e558f7@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 04:32:22PM +0800, Chen Zhongjin wrote:
> By the way, I was thinking about a corner case, because arm64 CALL
> instruction won't push LR onto stack atomically as x86. Before push LR, FP
> to save frame there still can be some instructions such as bti, paciasp. If
> an irq happens here, the stack frame is not constructed so the FP unwinder
> will omit this function and provides a wrong stack trace to livepatch.
> 
> It's just a guess and I have not built the test case. But I think it's a
> defect on arm64 that FP unwinder can't work properly on prologue and
> epilogue. Do you have any idea about this?

x86 has similar issues with frame pointers, if for example preemption or
page fault exception occurs in a leaf function, or in a function
prologue or epilogue, before or after the frame pointer setup.

This issue is solved by the "reliable" unwinder which detects
irqs/exceptions on the stack and reports the stack as unreliable.

-- 
Josh

