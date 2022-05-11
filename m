Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23573522A25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiEKDAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEKDAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:00:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C9CE3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:00:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q4so563464plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZiq0i3ZmSbOmRGumiJgmqnCAjwiMGc23Fy8HgZKiMw=;
        b=fJbqTV61Ycfi+Xa36egufJwJScZ4LxDM66PtbkuTZBy7ejyzzEIOVnuXIg+Ke2cdyE
         4Xs/1egwfv3V5DaUg5vQcLqGzgZo0mH7J6d+/PjwPyIqdNMp/ty9sBvIBXkLsDMSm9z7
         +f7Q5Y9z4TwZsRvVF7Hl/LOazk9GaF5t4jitM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZiq0i3ZmSbOmRGumiJgmqnCAjwiMGc23Fy8HgZKiMw=;
        b=BBASTw2FANbREPipu1/N5R5dn8Z62NYmB6axu1vdwq/QTaMLNCMUipEpK8ckNpDboK
         GqhSIVuO1eimDQigRjFXdWWwLqKY0w59BLyP42mjnraHVrqkNXTcAWi8lzWt/kAffHtx
         7KEGsIiosrlRn5ecQjWpBgKiB4HqG0CHzNke66teOpueVQnwK1K2RAyxrYX45N86Ghil
         Iiue1V+rYSqiDEGzi50RWyt/+Q7SStFu0tKu0epY3UG0BoZfTXVySJR/l5lFOy4VXVL1
         xZZAEzrB9Xf68GlrNtEoPdSkG/eiQrUV2lhRZq7YRVoIINdRzS6PYe9F034a9NbXBhgu
         5e6Q==
X-Gm-Message-State: AOAM531qHMCBb98Cu492w60YB/n/W3vSItduG0FxCfI8QO9zIMW4hG+u
        Gicw7H5TpPRq9LrXxeESRHU4HjA8UkZcew==
X-Google-Smtp-Source: ABdhPJyUvFaOINlxX4PXvon0YBAhVNu+6F4AtdgOXbDHCDm4+5aNd+8Uofu+71b2ZcsfxlEegJyKjw==
X-Received: by 2002:a17:903:110c:b0:15f:f15:30ec with SMTP id n12-20020a170903110c00b0015f0f1530ecmr12996966plh.162.1652238039600;
        Tue, 10 May 2022 20:00:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c1-20020a056a00008100b0050dc7628202sm270483pfj.220.2022.05.10.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:00:39 -0700 (PDT)
Date:   Tue, 10 May 2022 20:00:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Message-ID: <202205101958.2A33DE20@keescook>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
 <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
 <YnpQqBwYjlVffJk8@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnpQqBwYjlVffJk8@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 12:46:48PM +0100, Mark Rutland wrote:
> On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
> > On 27.04.2022 20:31, Mark Rutland wrote:
> > > In __stackleak_erase() we check that the `erase_low` value derived from
> > > `current->lowest_stack` is above the lowest legitimate stack pointer
> > > value, but this is already enforced by stackleak_track_stack() when
> > > recording the lowest stack value.
> > > 
> > > Remove the redundant check.
> > > 
> > > There should be no functional change as a result of this patch.
> > 
> > Mark, I can't agree here. I think this check is important.
> > The performance profit from dropping it is less than the confidence decrease :)
> > 
> > With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't
> > overwrite some wrong kernel memory, but simply clears the whole thread
> > stack, which is safe behavior.
> 
> If you feel strongly about it, I can restore the check, but I struggle to
> believe that it's worthwhile. The `lowest_stack` value lives in the
> task_struct, and if you have the power to corrupt that you have the power to do
> much more interesting things.
> 
> If we do restore it, I'd like to add a big fat comment explaining the
> rationale (i.e. that it only matter if someone could corrupt
> `current->lowest_stack`, as otherwise that's guarnateed to be within bounds).

Yeah, let's restore it and add the comment. While I do agree it's likely
that such an corruption would likely mean an attacker had significant
control over kernel memory already, it is not uncommon that an attack
only has a limited index from a given address, etc. Or some manipulation
is possible via weird gadgets, etc. It's unlikely, but not impossible,
and a bounds-check for that value is cheap compared to the rest of the
work happening. :)

-Kees

-- 
Kees Cook
