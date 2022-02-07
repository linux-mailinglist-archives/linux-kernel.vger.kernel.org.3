Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F854AC73A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345409AbiBGRXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383571AbiBGRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:17:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C9C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:17:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id k25so43756452ejp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqWHPeQUhcY5pZInVEVMHNlzWbOZP7wLpS7JnXkibBI=;
        b=ftbKa5q8huDDBWvM/7WVkwx5nuP/h2h7d5mvSFkiKYylYnsvX9g5LuF1HNmiOcaz99
         r/Kduq3dT/gKLkzIO38zbdA5NAWwaZJ53tAZoTPO6lMw1TM3NytchFU7KBevEYZPn+AZ
         A+yp9zwdaIA5Fjv5okwQAEmYB6zg6wkUg36PVLYqtHas4XbTpBgZ2+NzcCCyjD4d/+H3
         VD8+n5SCJzeZd7q9bTgH2WKJAnyWBcMdUtZJULx6OemkACykV3kCa1UTIVn8+AF9vrki
         GDq8xhIgPT40h8yuVNO+kIRbZi0b7ExfWWm26r/OJIuXbL2F5BEHvy+zSJUKx0APEIwE
         ZFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqWHPeQUhcY5pZInVEVMHNlzWbOZP7wLpS7JnXkibBI=;
        b=ud8fIQ5tit/KvycSoUeG1Tejs4RpFrwfqR9H8z17Ics/7MPeRdtEK3jqw0CIHsNxWc
         ERxgEWc2DJzxeLn7vStkkUz35BpNx6B7vciTa4/5f/oRIJTBgj+r4UDA5JTRUbJ85OiE
         TR4WWgG9sc/IPCdCTy0t4P00k+PJl+5tZM5l1/zAO+D6jeEghuWzd3Jypuo1FKg4bqm2
         kgbugmuIO5P9/DARzCeZSknC0NAjnpJj1OXAyc9GKLpmMLNCIPoUiMy3CihLBiCc4xib
         EJF/GrfZxoYtXCVCSTTXaieP3tWO1F7Gbh5bNwytyFYjIgrM5c+henOG5KYGjwUZ/u1t
         nPdg==
X-Gm-Message-State: AOAM533yrIpZHAfTix+84QmfHUZ97ClXzrgMek0k5Obt/OyXC5q8ghOW
        DbDYcj9jupSMnBrCxRBBIKSjTc47IzU=
X-Google-Smtp-Source: ABdhPJx3p0KrWaYKFZKiwbYzzNRz6taCMtuwfW2PWtsHWJDM8NahmGAXbQd0Cgd1WysYep88Er46YQ==
X-Received: by 2002:a17:906:58cc:: with SMTP id e12mr582714ejs.162.1644254228902;
        Mon, 07 Feb 2022 09:17:08 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id m22sm3931377ejn.194.2022.02.07.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:17:08 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        phil@philpotter.co.uk, larry.finger@lwfinger.net,
        julia.lawall@inria.fr, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@stud.uni-goettingen.de>,
        martin@kaiser.cx
Subject: Re: [RFC] staging: r8188eu: Sleeping in atomic context (SAC) bugs
Date:   Mon, 07 Feb 2022 18:17:06 +0100
Message-ID: <2092556.irdbgypaU6@leap>
In-Reply-To: <23161490.ouqheUzb2q@leap>
References: <2111927.Icojqenx9y@leap> <20220207092133.GE1951@kadam> <23161490.ouqheUzb2q@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned? 7 febbraio 2022 15:18:52 CET Fabio M. De Francesco wrote:
> On Mon, Feb 07, 2022 10:21:33 CET Dan Carpenter wrote:
> > On Mon, Feb 07, 2022 at 01:02:17AM +0100, Fabio M. De Francesco wrote:
>
> [...]
>
> You're right: "if (check_fwstate(pmlmepriv, _FW_LINKED))" in _rtw_pwr_wakeup() 
> will prevent a call to ips_leave(). Therefore, it seems that we have no problems
> with the mutex in ips_leave(). 
> 
> I had not noticed the above-mentioned "if" test. Sorry :(
> So, let's leave the code as it is.

I'm writing again just to be sure that I made my argument clear. When I wrote 
"[] let's leave the code as it is [currently]" I was referring to the mutex_lock() 
that is _never_ reached while holding the spinlock that rtw_set_802_11_disassociate() 
takes before calling _rtw_pwr_wakeup().

Instead, if no one objects, I want to substitute the two "msleep(10);" with 
"mdelay(10);".

However, I'll wait some time just in case someone wants to suggest a better 
solution.

Fabio

 
> Thank you very much.
> 
> Regards,
> 
> Fabio M. De Francesco 
> 


