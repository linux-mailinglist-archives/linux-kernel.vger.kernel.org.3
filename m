Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD374ACBD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbiBGWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbiBGWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:07:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3566C0401C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:07:40 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y17so12216171plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Of/NwOB3Hu+O0wW3PJCMbsI0zf2GtWIQ3REFETU8pVY=;
        b=OYhdNJ2ewXyBrsb8WkcUSeQCt6leu99QxiSFB+CT8Pjl77eR3CiRPDT0gm3KHep0PJ
         IFWVACCG0BXWxl4fdfGzf/c6uhfFnExN6BItIXJEq68ONUk/+CWlUeqoHfneNAQZrgCg
         KN3wdZ65JpfWLr5Ro0Ac5HtjKtWRwKDgts/oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Of/NwOB3Hu+O0wW3PJCMbsI0zf2GtWIQ3REFETU8pVY=;
        b=K6q9tMypCS4hFDCtQClTLIm7UdXDuKbjr3hVYv+tD9IyJnXKZHHVFlg19wVJCqLLlE
         nb1a90DFLuaKLTpfqLU7vOAoBZV4f86TFKAZNQAkfo+gMn58PwUT9eZ12F65aY4Kbdhy
         qzOHbzgiK3cNv++DqFUOfjGsL2DoM910/L3cnNLVKd3xvdqvo/mT1MObQclB8G/ir7l9
         jdjM3TxFYiv3kjdXvlR9l+1DV/Lvt0RjyOsnTH1jeWLJVlqXQU5PsW3Q2n66Y2HmQIpG
         BszQFSfehfuYpz2auR4huEMh4FZOggrodt+xvvlSurGFDn/Jom38uFXTTXHfEZEDV+3x
         EZDQ==
X-Gm-Message-State: AOAM5300tf+WlD94GrNR0xuZYaBG4rJ+ZpT8pseV+ST/uy0sGDphQ7A+
        yeN6GJ4qMs3ZTRmK226g/SLCFw==
X-Google-Smtp-Source: ABdhPJxPedPoPlqHZZ8lbPxqxonDcVi88CT3xVYILZFzIutt0VRP7QLAguogVPXe04riELRy4q9IHg==
X-Received: by 2002:a17:902:d708:: with SMTP id w8mr1698642ply.130.1644271660429;
        Mon, 07 Feb 2022 14:07:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm9358739pgx.36.2022.02.07.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:07:40 -0800 (PST)
Date:   Mon, 7 Feb 2022 14:07:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 4/6] x86/cpu: Remove "nosmep"
Message-ID: <202202071407.3C275189EC@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127115626.14179-5-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:56:24PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> There should be no need to disable SMEP anymore.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
