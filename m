Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121C4FE6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356131AbiDLR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiDLR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:28:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B40252B14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:26:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v12so4422464plv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVvKuYmXIsa9qahx409eDRhfKlF4vraPbVM4uLa0fmQ=;
        b=hdpkAq9aJidmb9mmOq0DjZrlkjc+sWw7doSwZu3Xg9C3ghnTPwU0n5q6LG2l4gVm8h
         PSWw8Ctere/ruqdtzP5yr+v5cPz2XIOsK78xnSWAj9fRC4zhtzswRvv8xmVrZM7BFqJb
         Joi0QaXGiDKFhq7k4LUEbecNqvJ89Im/GSkRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVvKuYmXIsa9qahx409eDRhfKlF4vraPbVM4uLa0fmQ=;
        b=S1xOl/yczxmEjP7EF+v6ysttEpNwHsNqrwvagdWvOIHKUOvFyJxr35wsOgK56RLnLc
         h7GxYwlxcupgU3DSwcHtKBhlEnLVdmMPqe+9LbYQmmWKIhEvE0cZNmdR5i/o/B8MBKXA
         AkNbElkMmR6hL3IYNz0HiIo6OsGJIWgM4CShYyxdS6p3HBFNk/Q6X4TfJwwgic44iaAt
         siqg1j2/MsYLjtFZYBpJZhivTwxA+tuLGpqug56ezJwFvM2pXV0FLTmRG7M5e90xeUlq
         0sQN3UCUPU18fRhbOmSqUTas/XqnhfFxP5XSYJbKDsaUSkORjQMlh07atkPzsF3eX2/J
         MVYg==
X-Gm-Message-State: AOAM530LqffqA+Z5IdzmETmFo6Pd4jv96orya4O8Kt2yLqhdTcMKrYpY
        yUfPxPiBXInLSzkdQ7MTLsXw5g==
X-Google-Smtp-Source: ABdhPJzZSMbWxUWddHHGVZsDw6uI2PwBLfss1TlhHC/JrPo2d6O8Fd7mX9TOQ0R5j0I3P74gCw8DAQ==
X-Received: by 2002:a17:90b:4b01:b0:1cb:a81a:dc4c with SMTP id lx1-20020a17090b4b0100b001cba81adc4cmr6207491pjb.193.1649784366611;
        Tue, 12 Apr 2022 10:26:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b005060755f2d9sm1523639pfo.139.2022.04.12.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:26:06 -0700 (PDT)
Date:   Tue, 12 Apr 2022 10:26:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: don't treat structure as an array of struct
 hlist_head
Message-ID: <202204121025.5D16102@keescook>
References: <20220407175930.471870-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407175930.471870-1-morbo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:59:30AM -0700, Bill Wendling wrote:
> The initialization of "security_hook_heads" is done by casting it to
> another structure pointer type, and treating it as an array of "struct
> hlist_head" objects. This requires an exception be made in "randstruct",
> because otherwise it will emit an error, reducing the effectiveness of
> the hardening technique.
> 
> Instead of using a cast, initialize the individual struct hlist_head
> elements in security_hook_heads explicitly. This removes the need for
> the cast and randstruct exception.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> Cc: Kees Cook <keescook@chromium.org>

Ah! Yes, thanks. This is a good solution for this. I'd rather not have
any exceptions in the randstruct plugin. :) I'll take this via the
hardening tree unless anyone objects.

-Kees

-- 
Kees Cook
