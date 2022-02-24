Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410B4C398D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiBXXOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBXXOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:14:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0E1BE131
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:14:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g20so5011703edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bmpycma/zjjcJuhF073fXrtLhHn1tlejeVv1t+c4RaE=;
        b=HfO07fQ+bJuju7vHLFATPl6K3k26YuC+0Tu7B0XRdV6xep1OyjMXgGYKf+JHBBxFST
         OeF15jfKj2/1C4nWiI8/Nl9PFOoABVIR27eh2E/AhxOqtkmYQLpKEa5hZyT9ZyyXdYks
         5VY2xg2+I8q+K3uQcxiu0S2sYPRXcoVFjCgP86SmC/0cRQ2bmFtec233MqL+ik+QZlc3
         zo3BIrGC7dq4IPEsaEMYR3W/Jt8efZSY9kaEMWX0+UPGK9z9YFZKjaMWluHcYEzFSw2m
         rQbOBvNyraeqsZuPPrVCD/sZWvyHTQ+KTfk5Zbm7FsqlZm6lys2vTThIlZVCBCYx9i6F
         u1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bmpycma/zjjcJuhF073fXrtLhHn1tlejeVv1t+c4RaE=;
        b=LxZHL5xqd/Y7CiUlxsTrF+lf7rz4Obu8K/e/byT6hWqcsp82hballUaPECckjHz0Q/
         JpZCTsXlE5azrZ/TdB8JhZoyTyFIQrfuTriadclAQfH6o1gsqwEBJk76X0OUyqzUl/ZP
         AYwf4utJcxs1dXugvwWqnL6nxrcXoDX0xRC0e7WpihWA9OrQJM/eRMJiL/TTE1bGEz7H
         /0EC4iyp4xcEas9Gy3bnsHHZR2bhh4+fDAjlyPDaVyfV+vv51vRlEbvd7cEuhgPWzi3z
         dSfB/3m4tFSGzL7kFKGIu4TbJkS1iAQmaUxIsUZiuQCr2J1GFS8jZ2M3XDTH2bOfQGvl
         UGEA==
X-Gm-Message-State: AOAM532uVrm7vGoo0JTRRzmgx/InNLLpTQFTpuppuXiaQf3QhG1x480H
        v2DFdQTsfG6pND4W1u1MRTs=
X-Google-Smtp-Source: ABdhPJxf7U5RQz0T3IBUoE3o3P7XTXfKa9HRBv1r0ZNxC3UWdQ8Tj6Tcj6jtwJBf8XDeanOBdVBTQg==
X-Received: by 2002:a05:6402:6da:b0:3fd:cacb:f4b2 with SMTP id n26-20020a05640206da00b003fdcacbf4b2mr4565808edy.332.1645744448478;
        Thu, 24 Feb 2022 15:14:08 -0800 (PST)
Received: from ubuntu2004 ([188.24.153.122])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709067f8300b006ce051bf215sm263599ejr.192.2022.02.24.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:14:07 -0800 (PST)
Date:   Fri, 25 Feb 2022 01:14:03 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: atc260x has broken locking
Message-ID: <20220224231403.GA539966@ubuntu2004>
References: <16136311.TfV2VxeR0u@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16136311.TfV2VxeR0u@mobilepool36.emlix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eike,

On Wed, Feb 23, 2022 at 12:07:48PM +0100, Rolf Eike Beer wrote:
> When looking at this functions I found the locking to be broken for the atomic 
> case (comments stripped):
> 
> static void regmap_lock_mutex(void *__mutex)
> {
> 	struct mutex *mutex = __mutex;
> 
> 	if (system_state > SYSTEM_RUNNING && irqs_disabled())
> 		mutex_trylock(mutex);
> 	else
> 		mutex_lock(mutex);
> }
> 
> static void regmap_unlock_mutex(void *__mutex)
> {
> 	struct mutex *mutex = __mutex;
> 
> 	mutex_unlock(mutex);
> }
> 
> When the mutex is already locked and the atomic context is hit then the lock 
> will not be acquired, this is never noticed, and it afterwards is unlocked 
> anyway.
> 
> The comment says this is inspired from i2c_in_atomic_xfer_mode() to detect the 
> atomic case, but the important caller __i2c_lock_bus_helper() actually does 
> check and pass on the return value of mutex_trylock(), which is missing here.

This is indeed a limitation of the current implementation because the
main goal was to offer initial support for SBC poweroff and reboot
use cases, which were the only cases where the atomic context kicks in.

Hence it was more important to make sure those operations are triggered
rather than failing due to an error condition which is hard to be
handled properly - e.g. getting a behaviour similar with the '-EGAIN'
scenario in the I2C implementation.

As a matter of fact the tests I made so far using a RoseapplePi board
didn't reveal any problems, but I will try to do some more extensive
testing and see if the issue becomes visible eventually. Then it would
be easier to try some possible solutions/workarounds.

Out of pure curiosity, on which hardware do you plan to use this, if you
haven't already?

Thanks,
Cristian

> Greetings,
> 
> Eike
> -- 
> Rolf Eike Beer, emlix GmbH, https://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 Göttingen, Germany
> Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
> Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055
> 
> emlix - smart embedded open source


