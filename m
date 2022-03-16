Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447494DAAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbiCPG6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbiCPG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:58:01 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A955EBD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:56:47 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id h16-20020a4a6f10000000b00320507b9ccfso1639724ooc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 23:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03ikOjiFLTHp41pT60Qg3JjmZZJXzhQSeRVEBNJlZuI=;
        b=cuDMqO1rJIvTSe/v6Cid0kPzJUA0VCDgYHQP/w2H7G0+v6lnDsgdcup/mz6Qhvy5eT
         v75fks/9buw4lQiUOC5k8w/9DxW9UT0By/6m6QUPY77MNYvpX0688YYTljAvo4u+gSn8
         sRM7ixP7Ikh1HNDp+VHkmt9Irac3KCxtDgZ4wMnEnnAgeeh0Sk5twZd/4F2GpcQ1FJIV
         BNQB3a5CbHZyg1s1LaK4fEm0hZsVKXV+Z91xcuueYVJpd77tBIRAdKlJtxWQDVCgY85r
         Dzv10zNJvQMGlPxN4zepWgfDe4LKJALvPL4QFDYQUpsvR6VG3chrfpv5rOctRXdgDdGF
         lcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03ikOjiFLTHp41pT60Qg3JjmZZJXzhQSeRVEBNJlZuI=;
        b=Yw7RXW2sXkbKWB8Q2FHZ+nyh2OOEmBXTYt53iC6Yg/ahu7G6nWMuOSV92FeoZ5R9L9
         aF+Pt5Bj1Rd8IPNXRHQsEmVmcivdl9AesysQi6JVzJ2NScrGKczGdqD8AEmywZEkPkOg
         OUuDuxeBhi4F0859KOXkmEAROvpURyzcvcGemHP6K7CX8s8JANnE342b+8HqChQ/Izge
         GsUaVM4k4ilBHHgweUn+bXrAtNmY+G4kgZT8LgP3OxjXGN0fAdwpHAk1/NBpudoSHXL+
         Z7YLC14gnMNv7dVoLalde7bdusTGvEcTG4E1knE801q1iXhV7RSBp9vfdE01AEMVjRy5
         ej3Q==
X-Gm-Message-State: AOAM531GuNmLCL3W7+n4yAxVw94dAu5fKf95j8cyiJrR2d0GxkrsBUb0
        G4DScz5+aKCWPl+Da/9OLEBHCGJQiPwBQFVcsh8=
X-Google-Smtp-Source: ABdhPJw3iDPUCU+9U+Qa2X5jmPQCw4YAOTjruitw9Cf7jHdUxzHngQPzbI4c+QfyZLZ6rrbxC3vQ3ccM6S0gpnWJrVg=
X-Received: by 2002:a05:6870:89a1:b0:d2:ca93:8797 with SMTP id
 f33-20020a05687089a100b000d2ca938797mr3099953oaq.112.1647413807028; Tue, 15
 Mar 2022 23:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220309205047.45981-1-makvihas@gmail.com> <20220309205047.45981-3-makvihas@gmail.com>
 <YjCgXS990UNB/oQG@kroah.com>
In-Reply-To: <YjCgXS990UNB/oQG@kroah.com>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Wed, 16 Mar 2022 12:26:35 +0530
Message-ID: <CAH1kMwSopeQ-mnFAhfCkGtwGxbCx3q8DPtAS4k9hjMD0Wur=bQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] staging: r8188eu: proper error handling in rtw_init_drv_sw
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Mar 10, 2022 at 02:20:47AM +0530, Vihas Makwana wrote:
> > The code inside rtw_init_drv_sw() calls various init functions to
> > populate the padapter structure and checks for their return values
> > respectively.
> > But if one of the functions in middle fails then it simply returns
> > _FAIL instead of proper logging and calling freeing counterparts
> > of previous init functions.
> > This leads to various memory leaks and can be found in
> > /sys/kernel/debug/kmemleak if kernel is compiled with DEBUG_KMEMLEAK=y.
> >
> > Fix this and keep the success and error separate.
> >
> > Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for
> > RTL8188eu driver")
>
> Nit, that needed to be on one line, and no blank line before the next
> ones.
>

Oh okay. I will take care of that when submitting patches in future.

> I've fixed it up now.
>

Thanks Greg.

On Tue, Mar 15, 2022 at 7:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 10, 2022 at 02:20:47AM +0530, Vihas Makwana wrote:
> > The code inside rtw_init_drv_sw() calls various init functions to
> > populate the padapter structure and checks for their return values
> > respectively.
> > But if one of the functions in middle fails then it simply returns
> > _FAIL instead of proper logging and calling freeing counterparts
> > of previous init functions.
> > This leads to various memory leaks and can be found in
> > /sys/kernel/debug/kmemleak if kernel is compiled with DEBUG_KMEMLEAK=y.
> >
> > Fix this and keep the success and error separate.
> >
> > Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for
> > RTL8188eu driver")
>
> Nit, that needed to be on one line, and no blank line before the next
> ones.
>
> I've fixed it up now.
>
> thanks,
>
> greg k-h



-- 
Thanks,
Vihas
