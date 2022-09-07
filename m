Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C440E5AF967
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiIGBeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:34:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961917CB77
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:34:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nc14so27084429ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ac8yS0SddIsqaM/j9lZmF3W375WH6cu2YA3ZST5+LMI=;
        b=cx8FOSLBOX1L/sTNHNB4FRAlBIqIOj/uT5l6CJeiKD3Z+8OykBIy/IOE8qjt2jlhmk
         xwoiNC4hmrWg2YdumFmU5KNI/MZ/MP4UQnyknpDvoPfiNlxeiEKyF8MUvuY1vnpxhzt+
         MSbqoA6yveJ+tPmuyY60tUGpd0uY3FlIdMkNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ac8yS0SddIsqaM/j9lZmF3W375WH6cu2YA3ZST5+LMI=;
        b=oPTp4lne+Y5Pn7Zdw5ZQ/GEakuqopCDL2fnE6Pf93elblSkYqVF4iofeqQ4Dl66VQD
         1FfFZmLvqPLRD5D+IV9hCFKG8DSzlAupLhRHJeWz6pjEuPIrp0vkydmBbUDUsYnVvTFX
         50ri0PCaSf0xuOOVdle+nns9/iT+L3MzGH6rD2ccEdHNaY2j7+DUf48nReU5DF7d5OlP
         vB8rHagCD4wKiCgQcdYlwUTwPOumFdrYcFgs6c+siOWIFPTmLy5Ar288veX/WbRbiYU5
         n1GPktGmw3ncG5jLOrfA+JqEdjtLVoUTRVQMgwBeP5DhSnCXjasoSVQe8UstebH2+P+H
         hzGw==
X-Gm-Message-State: ACgBeo17hJPCb45SwDX1VMxf3SSxdqryi7k6ur1kHZI+hKqub+LquE7E
        NukMPOfAnYOwLRZPqVzc0d3dYveD7Gcsd3UZ
X-Google-Smtp-Source: AA6agR4UdYIJjj1slycC3fY6XVtHOB89pihHldrAjNWn4Z9b5UGFNUf/HTrb5WI8absxS7WYeSby1w==
X-Received: by 2002:a17:907:788:b0:741:4d1a:595d with SMTP id xd8-20020a170907078800b007414d1a595dmr714546ejb.737.1662514444535;
        Tue, 06 Sep 2022 18:34:04 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id dv25-20020a170906b81900b0074a8293424esm7532597ejb.53.2022.09.06.18.34.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 18:34:03 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so10793319wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 18:34:02 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr558950wmj.38.1662514442190; Tue, 06 Sep
 2022 18:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <391.1662498551@warthog.procyon.org.uk>
In-Reply-To: <391.1662498551@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Sep 2022 21:33:45 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj4t2xmo3+AUJX6qs2+QegL1KGpsMH8NUcb7vnq3WGSxA@mail.gmail.com>
Message-ID: <CAHk-=wj4t2xmo3+AUJX6qs2+QegL1KGpsMH8NUcb7vnq3WGSxA@mail.gmail.com>
Subject: Re: [PATCH] afs: Return -EAGAIN, not -EREMOTEIO, when a file already locked
To:     David Howells <dhowells@redhat.com>
Cc:     marc.dionne@auristor.com, jaltman@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:09 PM David Howells <dhowells@redhat.com> wrote:
>
> Can you apply this please?

Done.

             Linus
