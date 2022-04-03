Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A954F094E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357598AbiDCMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDCMUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 08:20:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E829233A01
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 05:18:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qh7so4670417ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QvjIgpbYP0AE6cl4O3RydzzNsUQwz26DYQCH/eouy64=;
        b=f5frQnxK7uaM8FUwx5q4Iy5wVI1d1DwBKl/6tkrg4H5H91G0kNf/df1m8SOx2VZ11/
         aK41kEj+C25hMNdpbZa32MIkgj01ymwWZnxAcK4m6+P7GAXe6eu4c6qw3dMgJfuqH/MT
         sRh10Qgt+yw8IBYAkvlRUGHtHC7YkS5yZ7TanH+UF61YQGjR9R8ILky0XcPcrZsMg5A6
         jykHXC4mP3nJZTvcDE2z6lu/ClJ3c6Hg/vxTF+OBPebrKheIIZ/R/Q/Z0solK+jHlYn7
         fbfiHuofFucD0SkkcpjITJnB8l/x87F0KvRtX7+vZ05OeF377AjxoE+3CG3qJbCu1zYV
         wgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QvjIgpbYP0AE6cl4O3RydzzNsUQwz26DYQCH/eouy64=;
        b=IW6BbXhCJu5PqSVvziyo1FWbh1GGLWpGJ8aNyEPTb/kLl7/0KPcwWpzvUVz0wDMEED
         8CPN4Ud8UCG6MmJX4mh65dnGGZINNpEz2ZoZ01hkpfNFoWDsOuVAuYc30Mqc3yvZBdvK
         DYpRwBAYI0beN6zzOMpMNmFD8g1iRfitrbxZdmYkF6DiozAXHAmZ6qby6xs9TY4853oa
         Meilytva94uuSGlRJSKyENcaVfWaMSSei+y0CzlP5epQmJaRDxOF3spcPJBfiugN77lc
         /XZHoHY5h/4OrjZPNfGvzF97ab5aFFw3s19Of1Cbz3+RiR/kLVEAUY5wzdxRWC/BlMkO
         UEQA==
X-Gm-Message-State: AOAM530Jj8kvPT/Pf0Jt3PTaz6ZKH4drKf/DhLHsWpNFRJpSvJjuRpWW
        CnzCOs/kkDgt2O6F+BWSYhNKqxt1Cyw=
X-Google-Smtp-Source: ABdhPJyZk64Gf+4esdRzmYupZUsrBhSqUtT5RydmSA5vuqCCLk3J87Isu/YnNmpJTDuxMTzu25z6Hg==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr7064454ejc.334.1648988285519;
        Sun, 03 Apr 2022 05:18:05 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm3230167ejb.179.2022.04.03.05.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 05:18:04 -0700 (PDT)
Message-ID: <617af7b6-eeac-372a-7bbb-828db11a2aa9@gmail.com>
Date:   Sun, 3 Apr 2022 14:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com> <1858641.taCxCBeP46@leap>
 <2366209.jE0xQCEvom@leap>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <2366209.jE0xQCEvom@leap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 14:10, Fabio M. De Francesco wrote:
> For a list of all the paths to a given function you may use Smatch:
> 
> ./smatch/smatch_data/db/smdb.py ips_leave
> 
> or
> 
> ./smatch/smatch_data/db/smdb.py call_tree ips_leave
> 
> But perhaps you already know how to do it.

Yes, but thank you anyway. :)

Michael

