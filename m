Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC851D691
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbiEFL0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbiEFL0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:26:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9C1900D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:22:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v11so6006146pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwgJ3xGvdcAfXK7drFXwrp4QaKarW2SpAQVEU9d/grI=;
        b=e9GFosRQ6W0+vEOkuO7f9LQfl+KbuYNVkpG/PPZfsJmGJiMLAjBTztTOgE2JzHYkTf
         3nUQtkcy3uCk7qsMb/mw7B4JLTBS1p8BGYS6sDtyoLMu05WwYScoOB+a3Kz96/12btf3
         rmYyFTa76Fhv+oc5uc46TGLXdh73MgQkkIThVOKWBH+N+uIV8ClAOD4k6aMkDuloDv1q
         8C9S/TubxZRxdWv5PRtZo6CzQaKpE/0zsnds2RI+k/jD8WK3QIKpxXBaR5ulnXycVyL8
         OHeHbMIswYpmgytQ4ItBvMOzxyBT21vVnrpYSMRwXovv8WMFC8oFfiArYpHUY4kbw7t8
         NA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwgJ3xGvdcAfXK7drFXwrp4QaKarW2SpAQVEU9d/grI=;
        b=DJzVueY7zWrnQgbQhb9NM7HGfsHVfQ26kZo1NqA6lUxtQSHz3QDYgxSp5hnHVUNgiO
         Ji2G4OK6WHOHsgCYChLgnNCTjT4yMcI977MtCs1+Br4YZ3kIcbc4p0yvOJv1/gh/c90t
         FQvwVnilquc01BvICddWDdBQTsxebW3v+j93rE62KvXyUnuivymvxNrHJ9PllZ4Jy35a
         Tg3Zn0UUYMIHdeSt1Pn81TiBDwq3MkKRkmv29YZvu22oUUW6CdUae4iTS81ZdifMmiN/
         F6d20bBZD4c5WFPZ38cLnYEy5ezjlXCkkGZ0qh/Qd7u54M/DFh/FNycw3L+HlOuN7PwD
         5Irw==
X-Gm-Message-State: AOAM533GtwuC1OlbeVVSFfGXXoxsT60sjcZxYgoj0yoGOfewO+jH9XiD
        6oGGF7OJUHTgY84nBshCn2suGgZNM2BZBA==
X-Google-Smtp-Source: ABdhPJyLBON66drf32L+UK9dmJKCWx8kmYbYwrfo8N0c12KPCbuCRYwmVQBtwVik8+ziSv1z/8eytw==
X-Received: by 2002:a63:87c3:0:b0:3ab:5ca7:1763 with SMTP id i186-20020a6387c3000000b003ab5ca71763mr2373343pge.552.1651836137341;
        Fri, 06 May 2022 04:22:17 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id d28-20020a634f1c000000b003c260491adesm3016425pgb.82.2022.05.06.04.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 04:22:16 -0700 (PDT)
Date:   Fri, 6 May 2022 19:22:09 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     paskripkin@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8712: fix uninit-value in usb_read8()
 and friends
Message-ID: <20220506112209.hslb67cuinntusuc@ppc.localdomain>
References: <cover.1651760402.git.wanngchenng@gmail.com>
 <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
 <20220506071023.GB4031@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506071023.GB4031@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/06 10:10AM, Dan Carpenter wrote:
> Setting "data = 0" will silence the KMSAN warnings but it doesn't fix
> the bug which is that r8712_usbctrl_vendorreq() treats partial reads
> as success.
> 
> The usb_control_msg() returns negatives on total failure and it returns
> small positives on partial failure.  So take the code that I gave you
> before and put that into r8712_usbctrl_vendorreq().  That's patch 1.
> These patches become 2 and 3.

Ah, you mentioned in previous review "But then another problem is that
"status" can be less than "len"." I missed it then.

- w

> 
>         status = usb_control_msg();
>         if (status < 0)
>                 goto free;
>         if (status != len) {
>                 status = -EREMOTEIO;
>                 goto free;
>         }
>         if (requesttype == 0x01)
>                 memcpy(pdata, pIo_buf, status);
> 
> regards,
> dan carpenter
> 
