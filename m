Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD947BFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbhLUMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLUMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:30:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D553C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:30:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so2014526wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 04:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FnZQfonqJQZhort/TdYz7jT5v9CBQGfdqTN7b6WIV6M=;
        b=DIaobCcoV4E5Rq6yzTz5ISUWIz/FEL4XI+oHyCCeJVSuC/sJqfxlh8U+w47glc2s/J
         BIpKUry8IN2/fseKXWKzyJXVoH41t7gjmDrB42mHOD9JjDctX7NUiK4Xg+96TgP+Pk/3
         jTNDqKsmOX2X48qF+SjvJa1McgAIIh2xhL4kvVl0Y/4eKsqgJG7Z5FvL+guCMUqj3O9Z
         l/a0LeHT26rnurlUNUf2oXAH5V/qFahax5bXstsyIPaYCbrAaxTkpH7Lkdffxrzs9tGA
         SqxSwaCp5DD6b5iaGZT4PCs0KSRD7MZ7UrbS0o3+mo0g9d7mrVgYg8PscLtLpY0ZgWdi
         scXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FnZQfonqJQZhort/TdYz7jT5v9CBQGfdqTN7b6WIV6M=;
        b=02+6Qq8YV3p4Ma9U9Fx1xoYrKfaa2XxAdnY/2r+Sr9L0APjXMpeyfxg++ae8GUmpsD
         Vq2FslKgAs/K5gHhN8WYH2hpKjs4Gwkw2iV54YCCfM93fQ/KGV/OWy0/Ntglvb7/39dx
         AU7sPCGb7jaG8LcchijDSOQyKBFI+YKS3WI2gIv2s3Evc4Dlsy23aMTZXDThNMPFBZF2
         aFu98R2RvDnD6CsFx8OuIdqoI0i2+gqzry5ngis56AJKIbz+JVsf0fNZzGA0Pqz4j7th
         pWv7lRgUTVSG+v/gSi8X0QAwdndUzV/3hZzUs2/4UsEoXuP25Tcz29cHEmomUQHP97Cw
         oL9A==
X-Gm-Message-State: AOAM5303+0WObdeFV7c/r+vmgw7stKCeWZapk4pL6EzYCsrgwoUV/Gqe
        Y13B2CYNmxPlZJ1kHL6MXIwzLg==
X-Google-Smtp-Source: ABdhPJwlh4LBUDdueqH7tct/Z5sKTz90jWmM1dJy9ZBdB9HKd6S4SPiU5V4Is72wN8XRRHJz8/MQFw==
X-Received: by 2002:a05:600c:24e:: with SMTP id 14mr2494370wmj.67.1640089831086;
        Tue, 21 Dec 2021 04:30:31 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:87ff:799:2072:8808])
        by smtp.gmail.com with ESMTPSA id 14sm584579wry.23.2021.12.21.04.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:30:30 -0800 (PST)
Date:   Tue, 21 Dec 2021 13:30:23 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v4 29/39] kasan, page_alloc: allow skipping memory
 init for HW_TAGS
Message-ID: <YcHI34KT8Am4n45x@elver.google.com>
References: <cover.1640036051.git.andreyknvl@google.com>
 <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea9eb126793544650ff433612016016070ceb52.1640036051.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:02PM +0100, andrey.konovalov@linux.dev wrote:
[...]
>  /* Room for N __GFP_FOO bits */
>  #define __GFP_BITS_SHIFT (24 +					\
> +			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
>  			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
>  			  IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
>  			  IS_ENABLED(CONFIG_LOCKDEP))

Does '3 * IS_ENABLED(CONFIG_KASAN_HW_TAGS)' work?
