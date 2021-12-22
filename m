Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDEB47D411
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbhLVO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbhLVO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:59:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B133C061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:59:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id jw3so2516982pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=R4fAvto+5kiJhIGMycVJNRIDsGMunfWc3NoA9gToFxc=;
        b=yAYsIew16rDxK2O8IBSr18NkIZNRERvjTpiLlglFWe7mdn+WkOxn6IU5Ar2X5kHWqW
         71UgZbTwcoNT5Olu2zDRURo8mWCi+LY6l3M3D3UXfEZicV7wCMfOj7Op5zDWDfVIx2w3
         CRK/Tf/UZM5tSjXeKNEoQbC9F6PHwtEL0AzoihUU5ccqp0U28BRygvV3N2MKvDNhg5on
         pyYw73E46Vhal0zXq/48c7XQxUPw4ihx2Jlb3TMYhB8cjTOutZEgY+XvDoWnVPBlcFG/
         aBOtJOiU8njTxlHaBeQMLTt8LMz2WSbXCA62sVBTUVYano6heJeY3yrb1IFIEHIMWthq
         DPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=R4fAvto+5kiJhIGMycVJNRIDsGMunfWc3NoA9gToFxc=;
        b=riIqEpADkbkHRUfbj2F2cpPU7Z1fMb/eOr559e8hNrEdRtpiTI5MgCr+H6KA5kL2sf
         JsCui9SJlnxWXIvHe2cztMFBG6oSCl47HYGbXY16iiDyVUw7nWjilzY01hFZMBiL/h+8
         SoHJzE0yUIq793qlK3UvefbprhivZUO+bw1iII8oyaWt9YgFnnkV4rtUY9TvLvHI5MEG
         JKJELxbMkQriPoo3KcXaOdvkWfdbWBryJAqKhuZ4zI1JfMeKZybTCxWen2LsZ7l0+9vr
         ZpOHmfq7fV1G56rqoMSS6ZOKjhw3q9iyyQSn8fVICtW15OAWao8/dJBipjXzaP+taLii
         3Yvg==
X-Gm-Message-State: AOAM5310AvzhFf2T/65WeSa5YVh9U5FuIxcFHtBmRVf1oEw406sU1oV+
        y6iTWCoz7UXe9CTmWa9voDjcU4Y8RZk1TBHdW4Rq/Q==
X-Google-Smtp-Source: ABdhPJxD+B+hmQU/gZDQgKwOCAzSvQG1Z4rSyD47kKB+7bVpUE/kfF9NRmwJWNjPCxWHnv2nROBlW7MbbxP2zerqXEs=
X-Received: by 2002:a17:90a:a6d:: with SMTP id o100mr1780124pjo.179.1640185195954;
 Wed, 22 Dec 2021 06:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20211206151811.39271-1-robert.foss@linaro.org> <20211206151811.39271-2-robert.foss@linaro.org>
In-Reply-To: <20211206151811.39271-2-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 22 Dec 2021 15:59:44 +0100
Message-ID: <CAG3jFys1MO461TeWMdasVS0B_ya5NU=5mMomchq_nZ+X+v07SQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] media: camss: csiphy: Move to hardcode CSI Clock
 Lane number
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn: The CAMSS changes related to this series have just been applied
to the media tree, so I think this series is ready to be applied now.

https://lore.kernel.org/all/20211206151811.39271-1-robert.foss@linaro.org/
