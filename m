Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED98E58E67D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiHJE50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiHJE5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:57:24 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A482FB3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:57:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j5so10720992oih.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xdjBbbxN8HzKqi5kZCBofDg7SO9G3H38s0HqHlIqdKI=;
        b=Cf+YiZwu+G9lYopAqBXpYHLpF5xkOvRhKomv3wVAyWMKb2vgFE6OpsBscc63E/wlvH
         4ymFTRSeD30onE7J4vpAjBIky6sMedfgTOD8+cjy4YG9ABvEDt7uze1nSlHkLeMyWSeF
         RXLFhiiAv9KZP5x6rMbzB4Wz640iSkiZn9YYCSXM47AycrQBWdOEaWKWHZDk4kttcxNV
         MZBC4kXx36oi18QTS9F1bnhMzVN4GFvMfaTzTKOqR7NHzAtd0GOTyn/Gj01zMp+al8am
         9zUFiagoKyCe2aT3uWrqa6J1y/aMPjPECz4GZzB3igilFD6Vz8v6JVeR0IDYGOEpQr6t
         ILaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xdjBbbxN8HzKqi5kZCBofDg7SO9G3H38s0HqHlIqdKI=;
        b=0Q4AzrEcA0mCXQEz69TyoUlb+Qbllc+Svy2FN8mUtjYW/EejovTfOqD02YGL23ild5
         YcQziCPJKIUA4WO7hOgGLZOJtB7rSTJFflBPrzdjAGBV76Ci8veMtWDXgYBV9mg62Rdi
         KH5CbcnG+A++bxEt+i5EeHbMRO67fLNDtZO1RPhjXsEygxktHrhG5oSWHhp1rOCbgyQo
         ccci+S7z+jmKaIXru9Mo4/uBkcdrLdfC2fTPwjp6axnEYWoUIv3mhu6zQf0uuxdpjfzp
         7OFaIkWsYjgczE2rnlP7EEkS1XPtdX7SeElkqNSWsdVu7ch57/+mxki6WxaKRRK1YyBK
         pbPA==
X-Gm-Message-State: ACgBeo1SZt3CNxhZcJIOlRERTLFIJOPnVAmDj4oMdZOtSZ655tPbZctS
        mGW7AFdVal+4M8AyXgjtu8rE5FfUgoM=
X-Google-Smtp-Source: AA6agR6B10HMiPhMly4c6JgWS/dYqljVOccIwUM9pdJychOW28HovnO1Ef6zmyCIDhH0XH5Q5uaEVQ==
X-Received: by 2002:a05:6808:16a3:b0:326:a585:95b8 with SMTP id bb35-20020a05680816a300b00326a58595b8mr703689oib.281.1660107442275;
        Tue, 09 Aug 2022 21:57:22 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id bs6-20020a056830398600b0061c9f9c54e4sm472933otb.80.2022.08.09.21.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 21:57:21 -0700 (PDT)
Date:   Tue, 9 Aug 2022 21:55:10 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cpumask: UP optimisation fixes follow-up
Message-ID: <YvM6LjJCMK4ZKrxK@yury-laptop>
References: <cover.1660066581.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660066581.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 07:36:32PM +0200, Sander Vanheule wrote:
> As an older version of the UP optimisation fixes was merged, not all
> review feedback has been implemented.  These patches implement the
> feedback received on the merged version [1], and the respin [2], for
> changes related to include/linux/cpumask.h and lib/cpumask.c.
> 
> [1] https://lore.kernel.org/lkml/cover.1656777646.git.sander@svanheule.net/
> [2] https://lore.kernel.org/lkml/cover.1659077534.git.sander@svanheule.net/
> 
> Sander Vanheule (3):
>   cpumask: align signatures of UP implementations
>   lib/cpumask: add inline cpumask_next_wrap() for UP
>   lib/cpumask: drop always-true preprocessor guard

Acked-by: Yury Norov <yury.norov@gmail.com>

Applying at bitmap-for-next, after some testing.

Thanks,
Yury

>  include/linux/cpumask.h | 26 +++++++++++++++++++++++---
>  lib/Makefile            |  3 ++-
>  lib/cpumask.c           |  2 --
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> -- 
> 2.37.1
