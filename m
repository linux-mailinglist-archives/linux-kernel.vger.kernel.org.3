Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C309C4A6F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbiBBLJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiBBLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:09:42 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BAC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:09:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z20so28347513ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SVDMau3BPach0JL9Wmxer1K1pvz+KKD1rLXC1L+vcHw=;
        b=A51jSGvTumSNMch+65a2dOSRj2g7gdmdmgWB2EswHS0BLVrMURb963yA5z9Dxexfdf
         M2+kwtDMVYPxOODFg6QT9hpOaxn+Kw+ongcvHBACKEkJ95VVQsNT11YbrzWNBVRepGAW
         a5Zq3AHiT2IwNMzS/PEm+vACMHoFBcdMDXfWlwdGLyV59ro+28d/j3QXBjSIVEAObcLa
         p8b912QjQdK2coKpkiL+18Gt8l2mA21tmiqlnAb91Pw9JsWsCUm9c5fLmNnsm90tGqqY
         ocz6eSsQVBg4tDXbThHFzAZYtJ96UlJ7Pdr+shZyyje1wlmLNAQde6OikUgU2PNqsd2b
         cvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVDMau3BPach0JL9Wmxer1K1pvz+KKD1rLXC1L+vcHw=;
        b=KN/GaI1y8MVV7c8AsBtR58h15w4b/vL9mPr0z5GJSEp7fmqDYzyNuSAU7XNyvKlp53
         KCE5XF9UkTGpWAVr9qH/TF0L4B5PLd1gWYu13y57etp1DBhJOUM2f9Tx3vnYbuxKu/UG
         t7MYUbQLRvZ0Fr0IIwrKm6ORK/V2d6h2oCdMua0nzxvXIV83emie4C0kP8DXRA/Jq1g8
         HYIZteSgbf3OdoroITFZfsmK25W1gIjLdUO+3Eoc4R/jBBYejmZH/mD0MyCsa6bPAe/1
         xTpOWZ4iTgJTV4COVvathHQ1XSurvAiyvi0pne+u85O7xDxnhi3tVh0/Q0C42YxeLA/7
         s6fA==
X-Gm-Message-State: AOAM531q+akEZnMdk/Vf+0A+NSidyW8XCNNvlBhiGLd/nEIAr73SFAHX
        uhVBqSQGeW5hOTCuUJNKaJg=
X-Google-Smtp-Source: ABdhPJyCV4jvFba/qkq8tuSroz2OHquhQI5ATN4bKgj8q9eTQbMTDHWe4p31Maor3KQ6vwKMEgtPvA==
X-Received: by 2002:a2e:a607:: with SMTP id v7mr19769950ljp.248.1643800180658;
        Wed, 02 Feb 2022 03:09:40 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id d4sm2174435lja.35.2022.02.02.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:09:39 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 2 Feb 2022 12:09:38 +0100
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v3 1/1] mm/vmalloc: Move draining areas out of caller
 context
Message-ID: <YfpmcrxamjfQ4jDj@pc638.lan>
References: <20220131144058.35608-1-urezki@gmail.com>
 <Yfo5N8XWSr1n+F20@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfo5N8XWSr1n+F20@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 11:56:39PM -0800, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
Appreciate for review and feedback!

--
Vlad Rezki
