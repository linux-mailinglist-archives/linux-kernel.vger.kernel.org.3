Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF665A2BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiHZQCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbiHZQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:01:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C7D3444;
        Fri, 26 Aug 2022 09:01:54 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h22so1582340qtu.2;
        Fri, 26 Aug 2022 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n2+dMPy2K7fo8g/XVO6oLoG9YstnR6LpwprL/jGVfrg=;
        b=Wznyr51DfwIlXTAcFFB7EU0/mOgECJ7qcyamDo8thQEMuIsm7dG4AzCfiwyf1kDSVr
         W45soWcIZw5uvx4ruwLBX1JTyUnrjnn6Wjt5+anbIoSYBA17F/X2l1ks1Mx71eeJaxOx
         AdvlgMeChdpiv2fp+Fwnbh1Kodl+Fct4zrabLUZ8X70bwQ5pUZ425N/0CQbu4RxArO3w
         3sFY2xbAqDINyZ6zdQSoWSZ46EQ4/8AG19X/49veCp1V7qVYTbcC9oyX1GKWX7GMbHV8
         Fl55JxKUAjLlU2E9ny7E0sW2lBD1N9eJuPpqmL+G3KCq0m6Dz4bYs95JvQxVHwEEqocF
         q9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n2+dMPy2K7fo8g/XVO6oLoG9YstnR6LpwprL/jGVfrg=;
        b=ZOtdbMNOCYKMYEpmIzz3qg3c+0WcbEM1rJZueXXobteVr3LajYl/aHCNmGEbx0oGnS
         0kMQ5YnkgUYd2nxHxZot4kHPuZ9nvaVnEwJD94KgnHAHHWxdHb6KRk0mKGx0rJL4Y8Rp
         ojcXp+Jfm9KtewFPDKGfWSj/cuPhlK7xqyTI8KSjVTZjAgqP9oE1uyTsPsYp98vOQXtb
         H7V5MoJPCBeXoV19hnT75BRmzakKEykVt2oMhKZbeTHQ1m5GK8ZmKmmokU+lCDiKOkDY
         3c1Wj/PGMX7jQW6mOGa8b3IErubqLEURHSkKEuKyGBh9YE0Ld6mjUUhrdZoUYK7ITVSL
         YnBg==
X-Gm-Message-State: ACgBeo1y1a0/IqiTMmccUSbHdyhWJh3fD2pV3ZdPRhOPGuuWqNu+3b0V
        yvICfDMsILIxU7YqLeoxA/fajsk0tbO03w6f7Muig68qeqM=
X-Google-Smtp-Source: AA6agR7K74SWRACvY818br3dUrpwzySIZUk87d3KiMupGeottKKPN+aAyHONaSKkMse+j6LAhVoQ+mWf7MboAccgSMM=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr326066qtx.61.1661529713464; Fri, 26 Aug
 2022 09:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220826083612.1699194-1-floridsleeves@gmail.com>
In-Reply-To: <20220826083612.1699194-1-floridsleeves@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 19:01:17 +0300
Message-ID: <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/tty/serial: check the return value of uart_port_check()
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
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

On Fri, Aug 26, 2022 at 11:38 AM Li Zhong <floridsleeves@gmail.com> wrote:
>
> uart_port_check() will return NULL pointer when state->uart_port is
> NULL. Check the return value before dereference it to avoid
> null-pointer-dereference error.

Have you taken the locking into consideration?
If no, please do, if yes, expand your commit message to explain why
the current locking scheme doesn't prevent an error from happening.

-- 
With Best Regards,
Andy Shevchenko
