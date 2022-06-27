Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4617F55DFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiF0MCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbiF0L6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:58:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134311452
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:55:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r20so12735133wra.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8sIN6vSsUYYpOCl8BPvtuJnTvTbzJ4Ss700nnRAaQjg=;
        b=rwBr0UFu5JbTuq4WL/BnUY16O2/wdr2VARZ8/91q1GOF8SSr3XC85atvHVnX51wn0K
         6UYOe8TDuvYFj9Skj9FYijw6QBlCCziHbHDqe7HyC719gBsZPFHkJeOtx7I9JfoUkCa1
         Xei16CRJlJSoPMK6atH2q8eIXxylGoMjxhMoLse6DHANJDG6neJOkslxtegT1V8gFLGg
         Nh6quPvtuRII90/U7E9Nc0CJYfsSpmfB93kPmV4nKD1TLhzQmUG9BtQPS3e+OImwrOp9
         HqbNjajk47mKsGwb8hnFw2dI+swBRUbm02PWpp5xCpbwqdlQvtW+OuDP+pob7LHXBmLB
         foTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8sIN6vSsUYYpOCl8BPvtuJnTvTbzJ4Ss700nnRAaQjg=;
        b=p1RunkohYsVVuItpQOZyMA5LazKHrWwKMtsJeHzTVMrd/UlSYWuSqC4+ugwsRCKHmn
         W0Nj93MGfzlB6bmRVGYjp4CTeBVR85cEuHnaDcOZKTnTDAqpYxJnnjdD5UDfMbY0rQ1n
         3NTka6zQmAY4tWVCrRJxz/Ji3abyBvGlAVt9lfCUQnIrLoMnIdb9v8B+toPhfR5mSwHs
         b36WeCtPCwFIP1AfKsojheZZ1beL6Z0mFGsYWjvHRD9nBd9GC2Sp1MJNwxZokGhjZWvr
         s6iqEAgjGVmjUM6T7C5kDOaLl45ZfiHfNW1YlKOp7x4Z5e+059ZILou2odWVqUc1tBy1
         v7gg==
X-Gm-Message-State: AJIora+VbE0YhSe8h/x5OWs/lppeRJUYt/06wb/dkiVRg+C99hKob2Ok
        4WF9q3Yu57ee852UsxZmMBlTnu0b2JShKA==
X-Google-Smtp-Source: AGRyM1vHZpp1WVVlzsl/5X3vqmG1LeAcxIlHWf4rfQdA4zn6UxCSthZ1rJYiLf0hYmrwVidOw9PoEQ==
X-Received: by 2002:a05:6000:168c:b0:218:4523:c975 with SMTP id y12-20020a056000168c00b002184523c975mr11790250wrd.23.1656330933390;
        Mon, 27 Jun 2022 04:55:33 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm10217406wrs.64.2022.06.27.04.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:55:32 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:55:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jack Andersen <jackoalan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: dln2: Automatically detect and fill endpoint
 pointers
Message-ID: <Yrmas2AT9fgZ/a0P@google.com>
References: <20220617182338.32402-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617182338.32402-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022, Andy Shevchenko wrote:

> The usb_find_common_endpoints() finds and fills the endpoints
> in accordance with their types. Use it to automatically detect
> and fill endpoint pointers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/dln2.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
