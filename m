Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFB556ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377009AbiFVXG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiFVXGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:06:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18344091D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:06:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a17so14668415pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GWgCOPHVCsSP/TuUu0PCa1rEe1EzPOJErWw/faw3k7I=;
        b=L0KiNlT5/q+Sj8TLlAxInEXBI/jH6Jz0f7JbSB+NX0Lcosq8pVzFAvH7JkCnoNn5C+
         adnyeo5GosxpWS2481vxZy2EwwXfYoTZ0/F7OuZV8L3J7e+VZEaomDxmQB3TzT8h66Um
         iOyOuZJP9jJaS4L1pkWIPCRsl/GJnHWAEWij4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWgCOPHVCsSP/TuUu0PCa1rEe1EzPOJErWw/faw3k7I=;
        b=wU/oeNVF100pqslNk1ZiqaGNAn6gQeAaVWTFq2TxFQ7cjATcIraA2dUTsDHN1FYgJL
         P1mHY1ydrEwi6SQKCdIYpzzfn6wTRDJ+2c8GJPfhDC3Q1J53NAhBUc1A1qw+dOzgs0fY
         rW8THC6qyNKemq+KEJL6QkJ8+R0qBXQUR270t2usqjmX2aXs+s3GtkwC14D2etYLi3zf
         zGUidlcpyRiynneeikgke9Lmei2Zw2p6PPoT8uzSPslhDUhG/zSDjbot40ur13YzuaFs
         NeEbWjc8MUijHMBW982Tjiz9G4eId5nXE7wXyy8fgWkEP6PsZcmbbentPKegKst0nHCU
         yJzw==
X-Gm-Message-State: AJIora87SuUvoCXoYt9n/+21EF852PzoDNVbWebdH/uvbXMwZ7eas1zf
        ZL+3kU7ej1dGrEzE+CYQIBx2tw==
X-Google-Smtp-Source: AGRyM1scptqjMQDvR20VQFk7QLPp1/95Q51pPXYIVhnZtGYbJSvPKrk/bb1YlRXyjq3c1JZcwZmcrA==
X-Received: by 2002:a17:90b:4c8f:b0:1ec:cdd0:41b7 with SMTP id my15-20020a17090b4c8f00b001eccdd041b7mr748561pjb.119.1655939179195;
        Wed, 22 Jun 2022 16:06:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79575000000b005251fff13dfsm7765332pfq.155.2022.06.22.16.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 16:06:18 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:06:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux: Use-After-Free exploitation
Message-ID: <202206221605.EA67203C58@keescook>
References: <CAHhAz+jSYb6=x89oFin=AHBrNhg_Q61YQvanb=2ZGkZBDiLyiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+jSYb6=x89oFin=AHBrNhg_Q61YQvanb=2ZGkZBDiLyiw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:38:39AM +0530, Muni Sekhar wrote:
> Use-After-Free bugs result in kernel crashes. If these bugs result in
> kernel crashes then how is it possible to exploit this vulnerability
> for local privilege escalation?

There are many examples of manipulating memory layout in a way that an
attacker can control. For example, see:
https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

-- 
Kees Cook
