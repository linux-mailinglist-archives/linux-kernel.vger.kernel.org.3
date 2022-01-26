Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C855349D2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiAZUAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiAZUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:00:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35098C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:00:16 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j16so564495plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7vGJI4nloykuytCh04yZHKOOnvQenKvjTpFkLxyvvX8=;
        b=AoFPUGOiiE0SjS7R3CRyfLhPaDGYufx1Fy0VCOIbCb04/Tm97Ppd8ZwCIQJahqtDHY
         ePOcJk/Wt6uTcWuQ6ctyg73kHY6+7HegV1Slu4nFsy3KopjP3V34nmIy5GjSVp0wgrvM
         lXlq6alNgLxuQtJbH5AonrGSs7qRW3roz5pbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vGJI4nloykuytCh04yZHKOOnvQenKvjTpFkLxyvvX8=;
        b=Izhqb0vMjOWP8xIfJPoDSxxoZKRYCeqDwhoHS3QhWKOGBiLhL+Zti8+PZBLStUOxIP
         hgx9AiaW41ja5lKeC1bomCaB2YEbjLJhHmnFQ8CyWw5E/Pgd81fI0ssPtA/K9HxLOM2M
         Y5sB3eOugCJgVrx41vrFwJLN2PzfYbw/zan/7iOT9L6b4WD+Apm1EdSIvgPViJNrQAJF
         cDSBPhoqbaFz6MQEyEMHtzplRL/D34zo9SNlD7d0S5SzAA8mx9wqPl9F2PQSPPDv01Ls
         G/eGmfqXSQJGaRo7BO5Uz0wqu98ZGT3aRU6d0lpQhZtZDpngu4qmRM66QKITgkcmbzSq
         zxtg==
X-Gm-Message-State: AOAM532GH/APU35S3TfVyzUmap/MX2e0vbhnGvZ+QtnbdQcTRDvREjTC
        lHq1oqzGSpW9LZEnd7XJIk3WKA==
X-Google-Smtp-Source: ABdhPJy0/ctpfNKTbk08+sJLyTKqJbn2bDi5F7J+5b2L1+WbtU1+Qm9HlWh5xiDBkUIec/TfZOzcaw==
X-Received: by 2002:a17:90a:fe1:: with SMTP id 88mr10457332pjz.150.1643227215699;
        Wed, 26 Jan 2022 12:00:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm17803158pgs.31.2022.01.26.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:00:15 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:00:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] eeprom: at25: Replace strncpy() with strscpy()
Message-ID: <202201261200.615E6BEB07@keescook>
References: <20220118182047.3385295-1-keescook@chromium.org>
 <20220126194839.GA3763384@maple.netwinder.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126194839.GA3763384@maple.netwinder.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:48:39PM -0500, Ralph Siemsen wrote:
> Hi Kees,
> 
> On Tue, Jan 18, 2022 at 10:20:47AM -0800, Kees Cook wrote:
> > Use strscpy() instead of strncpy(), since its use has been deprecated[1].
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> 
> Along with your other fix to restore the missing kzalloc(), I tested this
> change on 32-bit arm system, and it worked as expected.
> 
> Tested-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Thanks!

-- 
Kees Cook
