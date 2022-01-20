Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA29149440B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbiATAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiATAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:15:09 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:15:09 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id q75so4136704pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iVoccYTErvqiVX+jKejZcWbLazxCCJAURsVgtJ9k/PI=;
        b=PAmnXcdie90f3pHLFoJF8Vjl+BsEbmFWtI+tTDzryR44DQ55Y3blI77OUyZK+T61pe
         TNsjwFtnJB1LDf1JFK9dHAada4F6ylWH7RCLfDrM9tMy2wo3JmNnaScG/DFcAf6NPaoX
         qUj/oIhvqDOrP0mR4q27k8Nd1wAFqxQ5004gizaU14mV8nukhd+J9abBO4cBbshLzYUb
         8szhyD2JOWMdElmQ/xxhsdHNVBjYtXZCmthm5vxGeOeDn0r+ZJ3z/GXO+SDJhdxql9Nz
         5399e7d+PMMYUV+l802WueHppD9R7k7DV0yD9NWUvEW9ZlpRgl04U8x2jiXdZU00gu9t
         uqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iVoccYTErvqiVX+jKejZcWbLazxCCJAURsVgtJ9k/PI=;
        b=GL+olJA6FEgrmsNM7bS64zuCXUKq8gzcQklHdjYilSSF2hiUnnw9sG3rhg70aTxIH5
         m1rd2qhncDx8thMN2v49a0LjwBSHsAjIEUCNz5b5CghF+ndEi7dGOwciEDNQYSSQG8N2
         sQlS9aRpR3AVSHSUZzvG2e7F287DKxsu+iZUR0j2TGzHVhojNgOvOJbZN3egkg2TM/l7
         VhuJQqnA7DXD7a+0Pcfjcr6jw/YrDGebRktlXLfCQvfDOcJJ6JAKHB2wnriak3gEmVGQ
         2j0K0uKSCsOlOA+nHmd7X59T6VsNuh2z6SZdd81j7Drf73Leqba24AGv1sONfPgtCdpr
         KsXg==
X-Gm-Message-State: AOAM530bLB3D/ylMMnslVygFxQAm80wbT/mdQcpEx5Yy8fwg1Ud6WHNG
        lo7HCkuSkkNtmwvCon4kuvofSA==
X-Google-Smtp-Source: ABdhPJwiZRE6QQn3hTsf9Ovlp1p3FKQUye3GJEcTOnfQDjiRPeGks9QjIA2eVkKW1KI1wj9KiQow/g==
X-Received: by 2002:a63:2210:: with SMTP id i16mr22839905pgi.532.1642637708411;
        Wed, 19 Jan 2022 16:15:08 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id q17sm708831pfu.158.2022.01.19.16.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 16:15:07 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:15:07 -0800 (PST)
X-Google-Original-Date: Wed, 19 Jan 2022 16:14:41 PST (-0800)
Subject:     Re: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
In-Reply-To: <87tudz5llo.fsf@igel.home>
CC:     jrtc27@jrtc27.com, changbin.du@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-35c602a8-0eb5-4f07-a94e-ceb5c00e2a36@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 15:53:07 PST (-0800), schwab@linux-m68k.org wrote:
> On Jan 19 2022, Jessica Clarke wrote:
>
>> What’s your point?
>
> LLVM doesn't have to deal with the extra complexity.
>
>> doesn’t mean other toolchains that do need that to be correct should
>> just do something wrong.
>
> __builtin_frame_address with count > 0 is considered bad.  Nobody should
> use it.

The documentation is very clear about this.

I don't really see anything to argue about here: our code violates the 
spec and is producing results we don't like, though the spec allows for 
much worse.  We shouldn't have had that code in the first place, but it 
slipped through as these things sometimes do.  This is just a regular 
old bug that deserves to be fixed.  Just because one compiler produces 
answers we like doesn't mean it's valid code, that's the whole point of 
having a spec in the first place.

> You don't have to be arrogant.

This has been a persistent problem, it's really just not productive.  
We're still trying to dig out from the last two rounds of silliness, 
let's not have another one.

I don't see anything wrong with the patch in question, but these "stack 
trace without debug info" things are always tricky and thus warrant a 
proper look.  I'm in the middle of juggling some patches right now, I'll 
try to take a look but it's fairly far down the queue.

Always happy to have help looking these things over, let's try to keep 
things constructive, though.  We've already got enough work to do.
