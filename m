Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA14ACB27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbiBGVTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiBGVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:19:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86EC06173B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:19:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id on2so5807937pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdFN1ZKsA/YSf3iQfelOyB5WGeNlhqGxKv0TjnYhqCw=;
        b=hGP2z8WlqXW91XSk1T+J/0Fo1BNWKmusXsyof4H8KgNs72J9pJKnvxlUoezJY4h2X2
         Sr9MFA0oeHSSVv73r42USLZrOWrOUCIVOlmdpqMijvS6WQpbTwVFf91QMXwjThIolVo0
         3X/sm+d1zY1DauWA/+SbpQTkDuSGu1z6QeSXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdFN1ZKsA/YSf3iQfelOyB5WGeNlhqGxKv0TjnYhqCw=;
        b=Q1o+gMM1QUEdZc3uInu7EGMnZURtAZHJFq8QcBETQ18jPgBtODkcjk3fmUtgsW+RBX
         lEZ3eYkV+fC4hT5lK/GtgkRmdS5mowx8Hy4mIVzIL7RDMDJ/7UOOTAztsEkJmSqmLzx7
         kpZ6rSaRHa8j1udr3+x8A3EZNpnc2MebI6Vwt2/S8HcdcCdB1HdjLQjZomdAPkMAnzn4
         qqnUQ9LmUgyRToaIGWvGeMbYsC2kn71JpXE524HnVyB2DgGsmopl0K099Dg9wzN4xs/h
         CnXspH9an47zlJlZ8pBuqRNYUj/RZNJlAvXoa7BusmdpUHzIk8uJPP04ZS+jsPiyerEk
         OuNg==
X-Gm-Message-State: AOAM531+smI5N6hMiOVrbTYBKy1K1SCBd43Fag8+hFyjI3iu5Lj4LcPA
        fvK9ZW+eKOwaWGHPfrgVS+cOhhUjX47YgQ==
X-Google-Smtp-Source: ABdhPJymf2h+6EaVKb8/3BSQSEdv13EBA0Lx1vE86AVMgBddqJ2jeXxg3Bg3b4zVwzdlUgbqsFy0Kg==
X-Received: by 2002:a17:902:ce8a:: with SMTP id f10mr1164071plg.35.1644268776718;
        Mon, 07 Feb 2022 13:19:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8sm264182pjs.39.2022.02.07.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:19:36 -0800 (PST)
Date:   Mon, 7 Feb 2022 13:19:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 2/6] mm/mmzone: Tag pg_data_t with crypto capabilities
Message-ID: <202202071319.846BFE23@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-3-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203164328.203629-3-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 01:43:24PM -0300, Martin Fernandez wrote:
> Add a new member in the pg_data_t struct tell whether the node
> corresponding to that pg_data_t is able to do hardware memory encryption.
> 
> This will be read from sysfs.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>

Seems reasonable, and doesn't grow the structure size. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
