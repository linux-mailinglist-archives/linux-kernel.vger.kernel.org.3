Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2F4B1902
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbiBJXF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:05:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbiBJXF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:05:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49155BB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:05:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a39so12133960pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kJZrXnKlSxrjXbd3RYug7qVrQuHlSubZSZCjGAgo8T4=;
        b=pNQoziWj07h4zslfeAEKP41bWOo3sO/yJWcqO/A73915ts3EeEVSQ4oiToHcfESyd6
         GtjbtUCRsXDmi5XhNLoKpIK+lpE6SKAUEn9hIcmwm9XRM+FJSqsavYN3wmCSKuWdyCs+
         ESTvUDypoE9TvzXF/2Qone/FMH+zNAOxzReSpY4FP4s7hdn5CPpj5V3i1cr39euOtWUy
         UBOylmxUTqoEAeB9fevPvnaSGagIyLO6esskwvDnj0cAnEyXWQ0MwIB3iO6HIqagSs3H
         I71bXk1pl9iaYcP7aNN06qvVWbCYJ+S8J4FtmJg9VmpWCQYx+1oZhR/2BRIFC8PNiluR
         31iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=kJZrXnKlSxrjXbd3RYug7qVrQuHlSubZSZCjGAgo8T4=;
        b=4WFp99bq+W+xrXxqHjdg6OnyCf2/Bw2aKGgMtxMrlfrJP+YYc3a3C0KttYGsaCSJnw
         ELjKQAfl6PiAInu2I3d89bii4OoQAd9wpEO4OHPfa380GQVM8Bw/Zxy7a0cXNYuILpgj
         JDJ9hdwvoBhKvnh/rWD4JO/eAYvG3dYwuKOJDz6nT8Nt5WHEvKC0HCo60mLRCdB+MGh+
         hdZVwNSUvQt4e8hiApYykAFUoEkSPbtbRE/91p4r+JdjM3v2plnGCpF9Hk9tej/8ZaPD
         fJfp+LObA6f9FdZO03+CoBXZ35EFNkShnA1IY7Ygv1apjvLLWSkwkYFyjVCHTI3SvTh9
         c5Fg==
X-Gm-Message-State: AOAM532269J4VsfS+ytcRbTgHbr+V1dfWeLh0wOYI9kBSxHNFp4N+5Aj
        jcecVAeU8uuyFKcPR1fCJn4gLyPK/c7UfOJU5UJ2Xw==
X-Google-Smtp-Source: ABdhPJz+Z/Y4py18mYB9eOlDDSIClqj/qJhYYV/2ESV7+c6avGFBXkdIO0PdvABjMYEYUn0hB5b6yrkhz+rDHKAmWJY=
X-Received: by 2002:a63:6a06:: with SMTP id f6mr7998246pgc.18.1644534355976;
 Thu, 10 Feb 2022 15:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20220208141218.2049591-1-jsd@semihalf.com> <20220208141218.2049591-2-jsd@semihalf.com>
 <YgWMyj6ZZzBQRODX@kunai>
In-Reply-To: <YgWMyj6ZZzBQRODX@kunai>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Fri, 11 Feb 2022 00:05:45 +0100
Message-ID: <CAOtMz3PLx4oqDYZ19vDrSXJkzhUXhWAKwvxBz=V8S4b4xEEQhg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] i2c: designware: Add missing locks
To:     Wolfram Sang <wsa@kernel.org>, Jan Dabros <jsd@semihalf.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 10 lut 2022 o 23:08 Wolfram Sang <wsa@kernel.org> napisa=C5=82(a):
>
> On Tue, Feb 08, 2022 at 03:12:17PM +0100, Jan Dabros wrote:
> > All accesses to controller's registers should be protected on
> > probe, disable and xfer paths. This is needed for i2c bus controllers
> > that are shared with but not controller by kernel.
> >
> > Signed-off-by: Jan Dabros <jsd@semihalf.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> Applied to for-next, thanks!

Thanks!

Best Regards,
Jan
