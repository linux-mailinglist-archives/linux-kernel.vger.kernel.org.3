Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74865A544D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiH2TJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH2TI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:08:59 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B17AC12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:08:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d12so8906549plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=U2XaLm1XADG8fbYMIz6cHx6vAFjgu+IqCi8Hnsr82jw=;
        b=MxhKWeK2qM7uubh7v9lhINSFW6/hrilRRCqd0nnhq463y7nrh7H9tTw1z5PH1Eyk3W
         By6U9Kq2Oihnew6AaQhQssYEpW/K8UyBYrCpCXRgAD+bWPp22jDg7h0XrhW2gRHbOyVN
         eNf7fzVq34MrrwBEo4eV2jsQwog8har1zwiVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=U2XaLm1XADG8fbYMIz6cHx6vAFjgu+IqCi8Hnsr82jw=;
        b=tmu/08Qyi69R8t8EiF8LQWk3nM2ChDiuYURqzpPWJyUfhCIq95HN031kI7ntxIkXsl
         D3w53z6uDpTk80MdaXKdGpgnay+juP99gN2P68FNtdkXHYq1curI+tmCKe92VrPVPIgE
         0iJ2EAubYx50ekUgfnLqXU8qaeh62uJuRJ11toi4LoXCdeFKiYBo9cLYh1ljody6dv+q
         Kl4nHIiRWZq9grCnJmkU7MZK0/+QxcrAeePHUWFTFWPeAxqekYROSsl1VICgs6ukEhzx
         pTDFR1pb0j5sw2ol/3+o8kzHvq/edm0s0vXysG1w2XOwn3oIOlv7EaKQthV6q8bR2zyd
         urdQ==
X-Gm-Message-State: ACgBeo0tFK1NQrB2hV1iJeYZ0I8jIuj80mh50NER8LEg/ebeugU6QGhP
        5RhzZJOBh6ygraqmrxdrmsimkQ==
X-Google-Smtp-Source: AA6agR70yqMgxEbw0FWzYnoIwdmoliZC6YBQLDH8iofYC/WVDYBobY4koMK8nzaOswl0n7/inBz41Q==
X-Received: by 2002:a17:902:cf42:b0:172:ed15:ee with SMTP id e2-20020a170902cf4200b00172ed1500eemr17348661plg.149.1661800138103;
        Mon, 29 Aug 2022 12:08:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b001fb277223bdsm7003509pjc.2.2022.08.29.12.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:08:57 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:08:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Message-ID: <202208291208.E19DE00ED@keescook>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:18:03PM +0200, Peter Zijlstra wrote:
> 
> x86 has STRICT_*_RWX, but not even a warning when someone violates it.
> 
> Add this warning and fully refuse the transition.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
