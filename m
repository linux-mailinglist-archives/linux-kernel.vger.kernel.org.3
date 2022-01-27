Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883D449E14B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiA0LkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiA0LkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:40:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE434C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:40:03 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id u14so4719042lfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XAn7F1Fj4WW9ou4Ks1O1eievoG8rv+B64FUIJS5WS5I=;
        b=xbJwK8QUtP3cFKL/TfgXiBgqq7vvd2bTIygX0QOOqyLDZJeHYh9BHpnGux3lgn1pDe
         ygf4Nm6JS1xfMNgnw4Ju/vbsEGT3dWAMqO80eEcnjLURmd10OV+Op9zWMRNmCiuDUjaO
         P93BhteJLGp6j5hSjnsT8d7IE28UmLxfNblh6i4coQUdWQvhkr/N8xJ25Mayv9cyv6bH
         2h4blnUw6fbqlWKdiWvF7eSqpX6VwQoe8P7/Zrg6lN1s7HoVMDkWJ99Yh8Qgfz/j9PUV
         /rgwslp3fSpDWWo9Ba/LaXiDl7oOXivfF8vc+2YJST/7E379NBY0S9znC9RmA010eihv
         tPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XAn7F1Fj4WW9ou4Ks1O1eievoG8rv+B64FUIJS5WS5I=;
        b=Vq0W563Epi5JZF/weGe8DmmxeR/mEh2hn6z8zjJGkbAKPhjMn9+B049WC9Qq/IkEL1
         PwxkO0ZtYIp7r/Psh6BtegP1ct/55JAfraUpGM5KOcVvMS5+JUrSHsVQ1EFYM5HXxs1X
         p0t0sUf444ZnlVHw7YNjaQVMoO0LDPFo3nNp2uJHqSyTxMq2KZUOCy0lmkWoRgwQxJeI
         zFL7iety2XZWHP2NZUxbp4j7GD4OonABfPuYsKyVDGmEZVSDZAPilAoX39zLsHVF+daj
         Fd77yFZq3HZdugwlWB59vcbeSYZ2HlACmc+qEtzZ7TJRiMx6KXF25vz3BWdR/9NMxStI
         8nCA==
X-Gm-Message-State: AOAM530j3RaHoqM5voE7CK4gXJDZkdglbrP93uK3YWdsbNPtMh87HRdK
        /TJ45inr0qVRcyogGbkSdml5tCWrVAk6VfE/Rl2Mgw==
X-Google-Smtp-Source: ABdhPJwp8sAbw7gkUfgdbqcZH4GVpI/BBc/VRUG5kngzAflTWlKrExOL6Fav6G4XfQIUQgg/og8qSObWAvSAR/cyoHE=
X-Received: by 2002:a05:6512:3d21:: with SMTP id d33mr2549872lfv.373.1643283602134;
 Thu, 27 Jan 2022 03:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20220123175201.34839-1-u.kleine-koenig@pengutronix.de> <20220123175201.34839-6-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220123175201.34839-6-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 27 Jan 2022 12:39:22 +0100
Message-ID: <CAPDyKFrZQ0JUjNt_bcxLXVGZ6NtLdUktN7v_4fj--ntoO26TPg@mail.gmail.com>
Subject: Re: [PATCH 5/5] spi: make remove callback a void function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- To avoid spamming lists/people, I have dropped most of them from the
to/cc list

On Sun, 23 Jan 2022 at 18:54, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The value returned by an spi driver's remove function is mostly ignored.
> (Only an error message is printed if the value is non-zero that the
> error is ignored.)
>
> So change the prototype of the remove function to return no value. This
> way driver authors are not tempted to assume that passing an error to
> the upper layer is a good idea. All drivers are adapted accordingly.
> There is no intended change of behaviour, all callbacks were prepared to
> return 0 before.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

[...]

Kind regards
Uffe
