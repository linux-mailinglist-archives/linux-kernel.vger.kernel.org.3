Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA6549D40
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiFMTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiFMTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:16:40 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28125291
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:13:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id s37so3616626pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QeOkcvX3znDxHyf5NSZPCw2521sMVjp/b+SUjQM63oY=;
        b=KPDsZ2ZIiectBfz7EK4WJ5pJ9CbQSHCuTC9DcYViAIZvC2AwqLo9jqCpnK6bQTWOO/
         +5mkx8P5Fk8uGASuuEU3hbPsFqcl3t3oRn0MsPg552e0b+ERWXQOP0tnLiyIZpzShmd9
         2Ag5a310uCQAW1lpYjfGyRLfav3KNE5kcA154=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeOkcvX3znDxHyf5NSZPCw2521sMVjp/b+SUjQM63oY=;
        b=lwmLTCA5xiiNSzhd/o0Y3xAkpWBZBkIiCETTsMC2UJanPRW18Ypa6fas3l3PC3T2ux
         y5+EM03e6+8fC9NLTKMLFhYHiAJL3ICrrWuehlQ1CzrP7LmiBmPiG+U9QtZ46spYHNID
         IlZgh78gdnXsF0ZiNlJog9v5ui/7X4S0A9SmgreDlpzIUFr1BVWshmGi1F8XkI2I+/OD
         YLcBR5KiDouBNkWH9cz9yDHq+b4j261QAlAFNqOoPiroPLym05YhUIzUTQHbR0s4B9Ql
         0XtYzidiwZO3qY61Z93sqamD3JXni/NaWabm/EZnDew5jEeCjURWo2p8GIm0pRcYIBWM
         ml4g==
X-Gm-Message-State: AOAM531dYq5kO9Mx9ZWE8Q2R9e7OzEYHt333AorAyG8eCXM3OFzJXGk6
        wXygbRlYbfGaKah3lYSE1WyNIlluHMuvkw==
X-Google-Smtp-Source: ABdhPJywR4BfcJFwuZ1Bd4Qs0nnw2UK8P6xQr196LoaHBmQlYW6nfk7/zGDL+Lqa2GkEfmmAgd1VGQ==
X-Received: by 2002:a63:1a1d:0:b0:3f5:eb02:b6b4 with SMTP id a29-20020a631a1d000000b003f5eb02b6b4mr518865pga.343.1655140439320;
        Mon, 13 Jun 2022 10:13:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b0050dc76281aasm5643639pfe.132.2022.06.13.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:13:59 -0700 (PDT)
Date:   Mon, 13 Jun 2022 10:13:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: cfi: use NULL for a null pointer rather than zero
Message-ID: <202206131013.BC01222@keescook>
References: <20220612202708.2754270-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612202708.2754270-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 09:27:08PM +0100, Colin Ian King wrote:
> There is a pointer being initialized with a zero, use NULL instead.
> 
> Cleans up sparse warning:
> drivers/misc/lkdtm/cfi.c:100:27: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
