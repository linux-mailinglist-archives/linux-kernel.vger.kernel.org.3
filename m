Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1644349DBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiA0HrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiA0HrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:47:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E80C061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:47:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k17so1865109plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ccbbHyPa2zNHaY1DTEmYbekClrFWWB6tGVPD92+73A4=;
        b=DL8Mh5tykZhwRpRlx6PJFlY4l+TJ1nDbLWtCJWqUPgUufRJcQlc87OeuQ/NuEY9Q5G
         Zks30HfjIunhbY2mjzrWf6Nxj0xs3OONqSulWD+5zL2qAELSaD+6fb/DvceJcL5XKa1A
         zbuCDk6/v8MpDP/hVjbsTdxUaj3N9Yb0wbwJ3bQbRdR368uKmm88twG0rjmWVbcXCm5a
         nKkTqGxMLxYv4KUXT0HgPwE8X1b89pNZ7/wZvH9OCJuWwPd6CZLrTc6mpFkb9Y/R3Nq8
         tSK9xz5SeD89C7w6LBVKHLv7n8i9dmvkmVkBzGI+LptF5O6i6ryaX+0DoFTZTcI9jDaM
         Hg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ccbbHyPa2zNHaY1DTEmYbekClrFWWB6tGVPD92+73A4=;
        b=swIlsDUc9ioDK5UzWBC5MNIMTQw/LekWzVg5MqEnJL4ozadfS7Uf+VHYIc9UzjsNxz
         85WNzeEZB/vH93OKpN7xXVNmXPsB/BHOppBZw3DmW36AUfwDcRJ7jL84dhfKbRDI+p9Q
         OeBTooJrrnygHv/HDh+PYydmHIQTGULcWYP6WRsVaDhE4pl20vWouzS3dn/V+kLaceYu
         qv5LAAg21wFXsTdSNi+Ctiq8VWcV69ZsBX6UhOS5TnkqBs2p7zufgMHvGlR8oUozxf8R
         jfmQVCEuqMa2zI6dD2Kj0CBxUx4FWFcQeV1RazWyVCauGs/VYB4GcIbvVkZ3fXbdu44w
         P2Xg==
X-Gm-Message-State: AOAM530KWYnPJPeKKIzyWqzW8eInfLotYmkHRuCRztGgjzGRtshthvoZ
        Zif5bbEaol3nUV20z+y0VSXk/opyuSI=
X-Google-Smtp-Source: ABdhPJzTdfAMHZgt09EJywuiYpaTjuAUSIUWYp3MJHgXqIFFyR1hxS2GInBjux6BQyeantrGUFUIXw==
X-Received: by 2002:a17:90a:b90b:: with SMTP id p11mr2900928pjr.189.1643269640138;
        Wed, 26 Jan 2022 23:47:20 -0800 (PST)
Received: from localhost (193-116-82-75.tpgi.com.au. [193.116.82.75])
        by smtp.gmail.com with ESMTPSA id y16sm4521122pfl.128.2022.01.26.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 23:47:19 -0800 (PST)
Date:   Thu, 27 Jan 2022 17:47:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: ppc: hard lockup / hang in v5.17-rc1 under QEMU
To:     =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <CANiq72n_FmDx=r-o9J8gYc6LpwRL5EGmhM6Xzwv27Xc7h1TNDw@mail.gmail.com>
        <cf6ac499-4190-cbe5-255c-f9edf07a4786@kaod.org>
        <CANiq72mV3AzmBDVJM+tQriEoDu_9LFBrK_vR6GC4qEmLw0UepQ@mail.gmail.com>
In-Reply-To: <CANiq72mV3AzmBDVJM+tQriEoDu_9LFBrK_vR6GC4qEmLw0UepQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1643269597.wkij0f82dr.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Miguel Ojeda's message of January 27, 2022 4:57 am:
> On Wed, Jan 26, 2022 at 4:03 PM C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> Indeed. I could reproduce.
>=20
> Thanks for the quick confirmation!
>=20
>> Could you please send the QEMU command line and the full dmesg ? and
>> possibly open an issue on :
>>
>>    https://gitlab.com/qemu-project/qemu/-/issues/
>>
>> I guess it's a QEMU modeling issue.
>=20
> Of course -- done (details there):
>=20
>     https://gitlab.com/qemu-project/qemu/-/issues/842

That sounds like my fault actually.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-January/239178.html

Thanks,
Nick
