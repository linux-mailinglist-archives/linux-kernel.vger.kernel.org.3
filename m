Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655D24DB5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350013AbiCPQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiCPQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:11:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFB62125
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:10:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l8so4416463pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZK9uutJfo42bFp7MFXbl2mQl2FDOmFpqXMqzYnq/NI=;
        b=g35DWi8sGB1G87635f+Qy/XBR3EjLwq750c1JTAtGhNM9QgsEJqfSne5G2/4+9U81C
         5NNBcH2ELL7u2+ZduchNKPqnwh9SDvSJPnreKC6u8M20gn2Njk24Squ0DTIiefvQlfoi
         72uRMBkys28E5r6lUM8/qDBzEuhr2GoR8vaUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZK9uutJfo42bFp7MFXbl2mQl2FDOmFpqXMqzYnq/NI=;
        b=eW1MiJKe//p80V1BgC1nxXwXHLVFPe+PnlhdJ9URzraOCuwoXqOc9lcik2qnGGOTU3
         JX7Fy7hobQma/+E3Qf0asCWvMFgjv829fTLuGEmhjIKn8Kjo73VFD1jgZWBx/68kNZbO
         TN9CpewIySOwru06/hibB1kmgmLWYchEw+oDSvNA0rjdYohrgCDSDM5ijRN2PoICRYwq
         GH1jz5mUMzY7hQfEWoFkQcLBroVUfOMJO2rBjhr7cfqCXThPBHYpAuNMeLV6QTfHGnit
         w0qY20SyNRcTW9ADL7hvukOdolGpTLqg7Wky0q9QVUVxe+4KzAlOAvtweRYnG+rxk/ey
         sGZA==
X-Gm-Message-State: AOAM533/BDPRyqxA58j7B8fL0StC0XLw6E5a/eTCWuEI8ASPkmeHo10Z
        eB5KBVRHY7Wj74jy33Pw9d2/1Q==
X-Google-Smtp-Source: ABdhPJw3qQsorrI2cuT/YjC71UlT+F557BgFwyW6/liffKsmrlRcD/sK4D2Ul6d+pSSdP4vzIA9qlg==
X-Received: by 2002:a63:8749:0:b0:37f:f8e1:1877 with SMTP id i70-20020a638749000000b0037ff8e11877mr218310pge.529.1647447040172;
        Wed, 16 Mar 2022 09:10:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm4115135pfu.202.2022.03.16.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 09:10:39 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:10:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Jones <linux@theinnocuous.com>
Cc:     bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <202203160909.B1A022B@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:06:10AM +0000, James Jones wrote:
> I dug the scripts up in the state they were in when I gave up (September
> 2020 according to mtime), and put them on github in case anyone wants to
> have a go at it:
> 
> https://github.com/cubanismo/aout-to-elf/
> 
> It was an interesting problem in its own right, and I'd be curious to
> know what I missed.

Yeah, this is a good start. I think the main problem is with how program
entry works, specifically that %esp is pointing to argc (with all the
args in memory above there), which isn't the way ELF sets %esp.

It might be possible to make a userspace loader, though. Hmm.

-- 
Kees Cook
