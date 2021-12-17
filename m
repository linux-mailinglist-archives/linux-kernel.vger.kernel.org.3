Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F35479293
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbhLQROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbhLQROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:14:33 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E43C061574;
        Fri, 17 Dec 2021 09:14:33 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p65so3965131iof.3;
        Fri, 17 Dec 2021 09:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRDj4HZx+TjmR/qEmd31zkJfvmvydMXTkEu7eSvoPHA=;
        b=TFuWFBDQDSGyA+RduOmDGqkspWQoOzcZiqD01jHeWgT70glwDmSbi74m7pcMcNMG0Q
         PSxUvXFHaN6MlUX7LnoruZA1DrVyjVnFVvXXYMgJNoBgTktx7CwScrSFnzZNnwoa+eBj
         iL78nMjjNVTsR4lj+GbNGyiuXFwz1VngNCvsHk82KMOJlfjl5dEKLYsDDGZXbXoWHC6A
         2GaQIZWEZkHF4sWR0PH+dxKolIdCpv0InJAUMLWGoLPWTd+4kZZNW14hccWm9uj8iZ7F
         62aBQBDOFMoTvkXuPiygEcrUf7e4bB/u7ipIg353ACou0TXwB6td3Yhg0yqM1JRWUcca
         09kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRDj4HZx+TjmR/qEmd31zkJfvmvydMXTkEu7eSvoPHA=;
        b=Crn6C26dHzhG8zfZULm6scgWGoz5vH5xIsTqnpe5ZmfVeyE4QdwqHKDK+VdQFwUIsO
         mMNKN1U+Iv+b/VDFBpc2x8BfKLgQN2ZW7pgo6Q8X+JMvb9feiQly8iU2P5dMVQ9RSIdP
         SVip44St8BM4BP9ra/HQbT5Ut44tDqcIdqDTyEPyvgcVjLcrDmcXJdndVEhfn6NWZUhA
         NUIat3wlTmkWmW0UpQjs71TZU0Q3/e0Wi/xINziK4vs+9SeZN9iA8UX+3tPfBZTmvWDh
         UKe4ly3Wb2uqpKYEA/oMnNiFM2vQ/mYbSp7JUWmPX2aCd4F6daLuSBviRSdP36IiSyx5
         TxZw==
X-Gm-Message-State: AOAM531NPhuXEKXzoZAfS4BxOZnEdeHEiU/3WAFsAZmt49bJUmntxMCj
        DFbxAMaEGO4YveVVgPchRmN1BD0VcFBYM/+9+2U=
X-Google-Smtp-Source: ABdhPJwicZpGJ5z0mtVKWyHRmd62BjE2Tsi+vnZpUFcGPllul/iuGgQ6Zio/JpSlivtcagWLZ/qiEa2YncukzWpS4VU=
X-Received: by 2002:a05:6638:2191:: with SMTP id s17mr2726181jaj.67.1639761271894;
 Fri, 17 Dec 2021 09:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20211128184549.9161-1-pauk.denis@gmail.com> <20211217002223.63b1e0a7@netbook-debian>
 <c6bf6ce9-8b45-e4a2-7167-83bdc8437fca@roeck-us.net>
In-Reply-To: <c6bf6ce9-8b45-e4a2-7167-83bdc8437fca@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 17 Dec 2021 18:14:19 +0100
Message-ID: <CAB95QARN=iYNW5cUK+gsBj7NUdZG2pFXbqWsXsdjE-hqNiSXSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 at 17:23, Guenter Roeck <linux@roeck-us.net> wrote:

> At some point, we have to face it: ASUS doesn't support Linux, and they
> make it hard to access chips like this. I think the chip should be
> accessed through "official" channels only if provided (ie WMI/ACPI),
> or not at all.

My two cents, if you please. Unfortunately, ASUS doesn't support
Windows as well, they only support their own shitty software, and they
change the WMI methods (both names and logic). For example, just
recently they packed a full hardware monitoring solution in X470
boards in WMI, then removed it in X570 and changed hardware access
function names. In order to add support for their next WMI
implementation, one needs to thoroughly read the decompiled DSDT code,
find functions, learn their logic and test. This is hard to do
remotely, without the hardware, obviously. On the other hand it is
much easier to find the required mutex name from the DSDT code and
access the chip normally.

Best regards,
Eugene
