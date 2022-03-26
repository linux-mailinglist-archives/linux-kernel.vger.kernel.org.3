Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33674E81CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiCZPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiCZPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:50:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818C2DD
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:48:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id yy13so20690514ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y7aci6aVVNrekf+gxfDDz9uWUig39zB4xiXrTfk/gRw=;
        b=jPpB+flyv3z7EtmAJavffh9sujL4oYA0TQ20fryH6r6xOV8VP4OtNFiFqhlSphHTSs
         OZQgRNIlvujLM0mtQ8crD1RnbVR1EV7oea4D1LLCCDt3oQ6MSsS2rWLJFTpsgegDxfan
         JVuXLEjh9YBnANxq+zz+KdSe/G5pfZ34mmXclV7Ix7T7fft4c66t9uGsoppopHEIXGkC
         g+o9Fox8gDctYxD1DYEfFIeiVM6i3XVpx1aIiVQqfRIOvytwfvDXAfVsnzfGbPEGjLY6
         jO7HVcOFOkDTl7eCPRTdhUJ/3QLQmprzeCLkko3K9DYrpEqnFWZcI2Caidhnql1eFqE/
         LKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y7aci6aVVNrekf+gxfDDz9uWUig39zB4xiXrTfk/gRw=;
        b=SRUQPiVs7MrRv+nq5od1VDskr4Ej8a3KQaMHlkzG6EbdwkgnD72bXsP/DkGdr+i3vc
         e5sjVVMaFoinYohupAANj+ujXH3B6yerjXcdDKynOSgu5EdjDZtEjC5sonTEgzt11++x
         povTBE207ryisVD6Qra17vUY+Jh8nClyK9r8Ygr0QMBXNeKi8lpEGh8KQH53+jBF2LgR
         gnBltpcnthugr9QEugK70MF2arto+aX1SWYNCBvR8wVmQoFC/5gWQD/c9mieoeG9no37
         XQE0MBo7wII+Nw16ouupiJtl7dcavNgQQrBJiSVsp0zMhFjn1G8F6OyuOMAKx/1gc31W
         b2NA==
X-Gm-Message-State: AOAM5313LuSIYPvTOy2Z/CHxFa18ZPzP03rbVg3ZVqmcfL1l+hlhGRVl
        E6lRC+C7ZymUb3ZuYnx8oWk=
X-Google-Smtp-Source: ABdhPJxUa9KbTwWqrA/M80DBXuBDbDbzvJRMxd/+S88hlLooRuwFkQu0x8HX9tgwTdtqWOjQUhJrSA==
X-Received: by 2002:a17:907:980a:b0:6db:799c:cb44 with SMTP id ji10-20020a170907980a00b006db799ccb44mr18027378ejc.485.1648309708385;
        Sat, 26 Mar 2022 08:48:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906340400b006d077e850b5sm3639521ejb.23.2022.03.26.08.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Mar 2022 08:48:27 -0700 (PDT)
Date:   Sat, 26 Mar 2022 15:48:27 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: add same penalty is enough to get
 round-robin order
Message-ID: <20220326154827.6a5ch5icpzrbc3hu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220123013537.20491-1-richard.weiyang@gmail.com>
 <20220321141723.39dca650477d4d9075e6e35a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321141723.39dca650477d4d9075e6e35a@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:17:23PM -0700, Andrew Morton wrote:
>Could someone please help review this series?
>

Andrew,

Sorry for my mistake, I forgot one element in my emulation code for Patch 2.
Current kernel could handle the situation described in commit log properly.

So Patch 2 is not necessary. Sorry for the disturbance.

>Thanks.

-- 
Wei Yang
Help you, Help me
