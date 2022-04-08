Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A294F97B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiDHOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiDHOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DBFD339FF1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649427039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qPRVhB9AVe6YB9JUrETqOb6ci3qytc3rllum+fD0JE=;
        b=iAYjqHMeby8d0AjbF2+i1Q89V5ofiK59Nucdws+pg4jTmom4EWTb0Edx5+u9ow+DTZYkVL
        Zz/IFamSsAU8DUMIGad3Jd7J/oRyVuvZp5pTcr3pPLYau+UgY5T0t0QFT1J8R58Mpfqm9k
        aRLJpjlGgXHfljQzXClM1bQZCMnTk1k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-YfSM5KFUOiSlWGV6uSZ3oQ-1; Fri, 08 Apr 2022 10:10:38 -0400
X-MC-Unique: YfSM5KFUOiSlWGV6uSZ3oQ-1
Received: by mail-qt1-f197.google.com with SMTP id d18-20020ac81192000000b002ebdd6ef307so2415696qtj.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2qPRVhB9AVe6YB9JUrETqOb6ci3qytc3rllum+fD0JE=;
        b=jOgQuV5dkqCFqMNGQjEnTF0cxGpXhEc4PYFwY7YzMkW+MRG7Sb0tQj7HS1Uz5t6zSM
         Mck52OOQ9tIlLhxliP10MOELemYs7OrtXRtc+ITf3j9XsJkXE/3VskMK/GdgqSfktpib
         YJ32mdQW+56POfepX2CZe3cc1UKsnN92EFl3rwzUA7cnI4uCmD6+OzZfXh7avK+RmcPM
         +WzHWHcCudO1pTUt+2sYLamCaTuuF1TU8SPvlkmG9yRHTx7C0AoaTGOJlga93Y2w7B5a
         X2R8q7zXxhBMNEm6J16ZwJK4JGm5+5PtOHv/r7Ahx0GZgBqov6DF5czEBBO7LzpB7VTh
         1G9Q==
X-Gm-Message-State: AOAM533hSLM7Vgnh+vQGzk6Oo0742Cl35Yf3Rfl4JWaILj6OZ3PxzZWk
        c7k0VDE8SyJ8qwfbN0dt5ToX97F0ji9Xnu3rs2sLcm48TfxcO/o3w5huHVQSGXVVh7sucSMfvXP
        ovxD1qDn2BCZ264TeG4OHmH/R
X-Received: by 2002:a37:694:0:b0:69b:e728:3e8a with SMTP id 142-20020a370694000000b0069be7283e8amr1138451qkg.583.1649427037523;
        Fri, 08 Apr 2022 07:10:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr0PoVNuadzIE0cbpzGvukXZlb4TRsIEGW7PM8cZCdDlYqjlDoRt/rchhKf/FcCJn4ObrBFg==
X-Received: by 2002:a37:694:0:b0:69b:e728:3e8a with SMTP id 142-20020a370694000000b0069be7283e8amr1138424qkg.583.1649427037259;
        Fri, 08 Apr 2022 07:10:37 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id n13-20020a37a40d000000b0069bdff39d1bsm892281qke.36.2022.04.08.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:10:36 -0700 (PDT)
Date:   Fri, 8 Apr 2022 07:10:34 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH 0/4] objtool: Fixes
Message-ID: <20220408141034.nof6d6l2e3dowlbn@treble>
References: <20220408094552.432447640@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220408094552.432447640@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:45:52AM +0200, Peter Zijlstra wrote:
> Fix various objtool whinges:
> 
>   lib/strnlen_user.o: warning: objtool: strnlen_user()+0x33: call to do_strnlen_user() with UACCESS enabled
>   lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x33: call to do_strncpy_from_user() with UACCESS enabled
> 
>   vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable
>   vmlinux.o: warning: objtool: start_secondary()+0x10e: unreachable
>   vmlinux.o: warning: objtool: asm_exc_xen_unknown_trap()+0x16: unreachable instruction

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

