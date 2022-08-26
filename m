Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC355A2304
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbiHZI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiHZI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:29:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559ED4F6B;
        Fri, 26 Aug 2022 01:29:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so1013869plo.3;
        Fri, 26 Aug 2022 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZqQXUKYAXaNDETmnzeEy5G83vWE0Lw9aO8Wft3lc78A=;
        b=lHm01CIa8Ixwmw1uJbquAM1f1zYuep3xl5yOXbVV8/h1mKz1UvIt20rKsBMiX05kez
         jWWGO/PVdQHowBnz/kXPpWzEDX41esricYJZ9gYPVItMvjHRyO+X7UFKRnAnc/8kNU5c
         O0sotFfxGvl7R6IVAHMY3+PuKbpe+arBx34jFUo+Q7LQH+LZ+5fsJUX21od4/hB62J2E
         imDG60OHOvchC27FNt4EXDUbXrOQdXe9kuie+wz/VjSOX6E//av7SHIP4rmUa8UIn+u6
         IrZNMxQTckyN3oq41/WK9Z8kL2P3EtPWdm54BrIPEocfesPlK/zTzVWVgWstNsndW8DT
         ++gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZqQXUKYAXaNDETmnzeEy5G83vWE0Lw9aO8Wft3lc78A=;
        b=sE7Dm/nbNEKpVvXj0VW123iIHQ7T8FT/5U80WzLwUfy/46cwU26j1LaIDUe5k2ryMf
         EeoXYGEMaehgO/MohLCOGIBdnLWQkXNPi2bFDcOQ6MajESCNxNdOjx3oEaEHM841MJCE
         oxfcTIHryT+RpQQ9cbUXJHeSeE9bVM04+fuUruWyIowRsYxJ2G6rHhMwYxu0X3s5cgbR
         VZ5BG7dAvV1tK200dLIZuQKX9iGhrpUb5nU3zz79VTJ9N9rkfHxrP/rV8ydWjuyWn6Io
         C69aK0xszJsr+DFP93ukr7pCH4Ks5UOBqPTTALkWaS1BREC7TeOCWv+TShc7Vi0oFGVr
         jT0Q==
X-Gm-Message-State: ACgBeo2e5LbLo+bsLMuzmD3r8pyY7qGv5Ul5IwBfeDY6GjMdT6Mc8OdG
        TRQPEKD82fvRrEVqGd1gTbqgPNNIsclu25ma8E0=
X-Google-Smtp-Source: AA6agR5/8OQlotyHYlj9mA8z3fbCzfvGFlXA3R4L9leXIjUfPV5T/p5Z2C4FvaohkfRE+ehar9Wy4xF9a4a+R1k92OA=
X-Received: by 2002:a17:902:e5cc:b0:16f:1e31:da6c with SMTP id
 u12-20020a170902e5cc00b0016f1e31da6cmr2745061plf.66.1661502563310; Fri, 26
 Aug 2022 01:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220823055739.1451419-1-floridsleeves@gmail.com> <YwRyC93rC/BAjR23@kroah.com>
In-Reply-To: <YwRyC93rC/BAjR23@kroah.com>
From:   Li Zhong <floridsleeves@gmail.com>
Date:   Fri, 26 Aug 2022 01:29:12 -0700
Message-ID: <CAMEuxRrLXov-brDL4ENyHS=1Yjd2YE0bGNHZ69p9wmuBQo9avQ@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/tty/serial: check the return value of uart_port_check()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
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

On Mon, Aug 22, 2022 at 11:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 22, 2022 at 10:57:39PM -0700, lily wrote:
> > uart_port_check() can return NULL pointer. Check its return value
> > before dereference it.
>
> Also, how did you find this issue?
>
> >
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
>
> Also, your From: name does not match this one, so I can't take the patch
> even if it is ok :(
>
> Please do initial kernel work in drivers/staging/ to get issues like
> this fixed up before moving to other portions of the kernel so that
> basic email problems do not bother other subsystem maintainers.
>
Thanks for the suggestions! I'll correct the From: in my v2 patch.

> thanks,
>
> greg k-h
>
>
