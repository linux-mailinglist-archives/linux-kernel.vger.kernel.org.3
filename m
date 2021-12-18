Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6EC479C48
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 20:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhLRTRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 14:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhLRTRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 14:17:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305EC061574;
        Sat, 18 Dec 2021 11:17:47 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b19so8777457ljr.12;
        Sat, 18 Dec 2021 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBPWLDrmWt8WxfoZz3IAG8qTJNa/i7zgdvu9LHgBwvc=;
        b=ObZa0ts8sMBh5R9GvS2jVda0J1X/Pv40mMDRbJwcWTyVKNi8yk67OLtBsI5aSxBsik
         VjsGpUhnNh2cMfuO4P+k9tgCfRVF8Gdw8k/ltvzjqSzuwlNole1yvfaacmN+lpsZ1Sle
         6RMbwW3XE4qxRjZXQa5Jeq2pZrO3itwpoiuJuhwBYNFS0pWbHPRdM6h5W1sPxy+oOx8u
         52gldMGFcEqFvW3U+OCjMEa7WogKSCZlMM6iBWesYA3f0zEe9ODyfw/cyERGjhlvLzcj
         xZ0FsMRJtLjU9SRf/GLI3MALh/712qzv7iw6qIzywyh1vNAMCSBh68plxWhIPEX3l6Yb
         itDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBPWLDrmWt8WxfoZz3IAG8qTJNa/i7zgdvu9LHgBwvc=;
        b=UZCVERIKK6Ilk3fJpc0goH8jmuDR1xiE08gYpI6u/+Ns785pg/GjI9o7I3mHqL/tUK
         q6RnE79TziiQkgxs69kvneX6r0t0vKnoW46ZCmi6eZ9kbajciDMrr0Z/cVB8wSdeCz9a
         5puzk9q2ChmO11iBkYGIo5JN8pc9acyG83WgX9TNJ1tfLn1MyC6PdbRSWuKDRp71DgsJ
         qrCm95SHIfUlzdEA3AUn6dppIRejXUnZR8D3hjjt/hbESe1dheGQDkt2LLUakYIXtzWx
         57AITDYexc//ZDYOfB6ffWU8FeG+hoAWD0yN7t1p79v1fNgT9ZfB+i6dD1LTnMFwL2it
         9ZIQ==
X-Gm-Message-State: AOAM533w+HIPM8fAMQSsSQsb7n0pPT9G/CE1TJbAO9JtfDKUdt1+8VwH
        hga3iEsDYH40bFCNCT4DFlM=
X-Google-Smtp-Source: ABdhPJymHqcvjUwHO2Xn31VAgBsb12T2rDXqwYGoX56MiGburf52u26FBME7bH2ParFR9s09Oxyg+A==
X-Received: by 2002:a2e:a54d:: with SMTP id e13mr7735109ljn.319.1639855065325;
        Sat, 18 Dec 2021 11:17:45 -0800 (PST)
Received: from netbook-debian ([94.179.28.1])
        by smtp.gmail.com with ESMTPSA id p20sm1796504lfu.151.2021.12.18.11.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 11:17:45 -0800 (PST)
Date:   Sat, 18 Dec 2021 21:17:41 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
Message-ID: <20211218211741.5eb0c608@netbook-debian>
In-Reply-To: <CAB95QARN=iYNW5cUK+gsBj7NUdZG2pFXbqWsXsdjE-hqNiSXSQ@mail.gmail.com>
References: <20211128184549.9161-1-pauk.denis@gmail.com>
        <20211217002223.63b1e0a7@netbook-debian>
        <c6bf6ce9-8b45-e4a2-7167-83bdc8437fca@roeck-us.net>
        <CAB95QARN=iYNW5cUK+gsBj7NUdZG2pFXbqWsXsdjE-hqNiSXSQ@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 18:14:19 +0100
Eugene Shalygin <eugene.shalygin@gmail.com> wrote:

> On Fri, 17 Dec 2021 at 17:23, Guenter Roeck <linux@roeck-us.net>
> wrote:
> 
> > At some point, we have to face it: ASUS doesn't support Linux, and
> > they make it hard to access chips like this. I think the chip
> > should be accessed through "official" channels only if provided (ie
> > WMI/ACPI), or not at all.  
> 
> My two cents, if you please. Unfortunately, ASUS doesn't support
> Windows as well, they only support their own shitty software, and they
> change the WMI methods (both names and logic). For example, just
> recently they packed a full hardware monitoring solution in X470
> boards in WMI, then removed it in X570 and changed hardware access
> function names. In order to add support for their next WMI
> implementation, one needs to thoroughly read the decompiled DSDT code,
> find functions, learn their logic and test. This is hard to do
> remotely, without the hardware, obviously. On the other hand it is
> much easier to find the required mutex name from the DSDT code and
> access the chip normally.
> 
> Best regards,
> Eugene

I will try to continue to support patch as part of
https://bugzilla.kernel.org/show_bug.cgi?id=204807. 

And If we will have some better solution or ideas, I will send updated
patch. 

Thank you!

Best regards,
             Denis.
