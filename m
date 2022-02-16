Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6414B9281
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiBPUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:37:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:37:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071F18D01B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso3458383pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PEXMMTYC1FVGPA5+aOj0q5CSmQ9v9RUX9ecJLilAcPc=;
        b=bGWQFfWY+GOCY9ajK+jUK4dJTPTv2kIB0Yq1hbme80ItJPDtVUuCrducyub/97EQ0a
         GThVGEfbIU6o1qenCjxJXD50S6/ObQWidSyhO1XjNEw7iQRU3mYiOLPWLzMEtydU+TOg
         XrEVvwY9SVG0TkiKWWRS2pgrzzhEh02Lo8/FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PEXMMTYC1FVGPA5+aOj0q5CSmQ9v9RUX9ecJLilAcPc=;
        b=Nx/RZfzjRYzfhLP7D70EmFi0fBkEUwEF0mxpPmRRO8G3kRyBRxP0EjP8TUaj05MUVP
         Hm5DqQbUtSFqv/6tSVeCUDcy0F4Kmogx+J3qjDu2w8N+luoMc/DZHwe1zN41WqCFC7RS
         8G2V5F6PFZ5w81ashpp1Hm7L7uTedz0oAY3DJolGj3gehcRMRuQzoPdXoRq83SlT/GeO
         uf+wRVRcaURjt32fokiqbM31pC4pjvChNDx2MrdfIkvqiHGq1m67CnJ8PR8le4fhIx6B
         1UtDTKnWRcAkyVj9+ioRFx5AJvZv4qdNHaSlErxSHFxna5HQpwOeENDQQleok/YWRpZ2
         4SXA==
X-Gm-Message-State: AOAM530V08/8I6ENNUG9Q+tMrL/ej5k4Kn1YxUj7I1oIddyGJ1YO1BgE
        y6b/doUYke67fpTEDxcO5Xjihw==
X-Google-Smtp-Source: ABdhPJzJF/YEfH5OONFh8EpYA13PwFuw+6/qJPkCze+i5HDTetsTW9VKrS9AD6KT8uYwRyvr45KVbw==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr3717687pjb.35.1645043807401;
        Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lw3sm18168488pjb.24.2022.02.16.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:36:47 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ACPICA: iASL: Replace zero-length array with
 flexible-array member
Message-ID: <202202161236.FBD5D268@keescook>
References: <20220216203240.GA918517@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216203240.GA918517@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:32:40PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
