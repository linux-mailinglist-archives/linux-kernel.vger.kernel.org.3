Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1E58FF73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiHKPau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiHKPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:30:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8895699
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:29:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso5715005pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=k4cTJcWzw8+6axf00iGx7biHKXUEGT3Ofca07ePg5B0=;
        b=e8WRD+IbMXLxt0XX5XAhvJBvN5jLNJ8ZUx93+YW8cz7r7GCpyryYTdJ+UJNUPY223r
         zzoPmw6xUn3VMbJuI2F2ZSeOhIbrKmiX3G9mhH6iyovCbNm2Puhe2oTBwUlY5OL7qfj2
         sQGEp1yOeNmSmYqyuuyL7LSmz37k/frFxM+oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=k4cTJcWzw8+6axf00iGx7biHKXUEGT3Ofca07ePg5B0=;
        b=v0RJEAtl/qiGpwQzlztWwD6xCYmC+Obdy+FohEg9GbIClhzgD4lQpvAQmpnoKEBFzc
         e0abN7P7a4hiulpEBtUZJFa+9UJ/Zf5yDsBZz4bcEUy51XsTonbRxs0cx1v8Y01+Iwae
         ytBeN+UAkSYqHd2jueyzcR51TaghILgGLxTkVw5Q5jqYQH4U0o+AvBDJtT7DV9ccYTun
         hIp0fEURld/OZbIqz0OAgkI9S8yKzn69vBwrRxpzXQY/aNss9vWJD+6FBg7npRnKzwXs
         c/wglWmQ3/+HgYjznosGnIsaS+1s6l1KUBsmjDpf9gODulBXZoywdqAQ2mRIMTVwiVNY
         iCEg==
X-Gm-Message-State: ACgBeo3lEDDdLDuSg7xeg17XlW9cTBbP7WQ0WyPJHarSnyfkEPASBRNX
        G6JbVie5w7odaFCVG9Ijh+Enog==
X-Google-Smtp-Source: AA6agR5MDAoWj07mo8Re6bJHCK/lTI2S9VYB/kjpRf71aZeSVUXPPLyCezVqfrd1Gs3g5Ty8PSMb+A==
X-Received: by 2002:a17:90a:55:b0:1f7:4513:8cac with SMTP id 21-20020a17090a005500b001f745138cacmr9192293pjb.93.1660231781372;
        Thu, 11 Aug 2022 08:29:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b0016f1204cde8sm1985339plk.301.2022.08.11.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:29:40 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:29:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] treewide: defconfig: address renamed CONFIG_DEBUG_INFO=y
Message-ID: <202208110829.F82D003490@keescook>
References: <20220811114609.2097335-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811114609.2097335-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 01:44:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_DEBUG_INFO is now implicitly selected if one picks one of the
> explicit options that could be DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
> DEBUG_INFO_DWARF4, DEBUG_INFO_DWARF5.
> 
> This was actually not what I had in mind when I suggested making
> it a 'choice' statement, but it's too late to change again now,
> and the Kconfig logic is more sensible in the new form.
> 
> Change any defconfig file that had CONFIG_DEBUG_INFO enabled
> but did not pick DWARF4 or DWARF5 explicitly to now pick the toolchain
> default.
> 
> Fixes: f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from a choice")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
