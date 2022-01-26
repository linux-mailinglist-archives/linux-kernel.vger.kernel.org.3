Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A073449D291
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 20:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiAZTiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 14:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiAZTiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 14:38:18 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1990EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:38:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id t7so841293qvj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 11:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8s967m95U9jcE31Oit3WOJa8ujmW92Kn08by48gKvr4=;
        b=z4RAD9yk6knHESiZHDFymofyh5zA9xg1EtenWsQo7OBfHGFnWSD97bV6ArwMz+N72L
         WIqYrhGtv3L5ZqKcLIMIh2v6ot0fjJjIemCFtlNn1zG5ufnvPjsFzncpJ41wt6xee66s
         k6tIB2XSv2HyqOfBch3sW3z5ApBBCpzAPDyiewnk+gbpZkENjgI5U1lPfTnWysJmNHSl
         hrKXKoYT2rOFvpTb3t4mGHXg9zgfhZ7h8U4Xf/ggyb7S+VdkbR1vWellGu7ZnXvzBKLV
         ACHZFRAdMI6VQ0atE/XY4ktAu8xtpwWotiHY+MqZ5sj3L3xf9I/lIrWxwORHLR+AZBYD
         EQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8s967m95U9jcE31Oit3WOJa8ujmW92Kn08by48gKvr4=;
        b=I0eHPn1xe8q3uoTMb9Vt6307JQIvo4/Z8GtokLEsDJLVJsH1Qm0+dB+YhxeFZpQf00
         ogkRWc9qxIYCzT85lpZ6joisn0dLhbl95/pONcWXiD8BwmNckCm3EEydUFJS5GH7f9tB
         uWGhecxTzlztUuk9hU0ZpYf5CP9I8JFyongs0w6J7Fd6duxMIehUnr0AweQApqtjY0RT
         nT7Bi7YuB2xTGegb9OOXHY3YbpElA+/KGDUB0WrllEIjzh54+7GTsz04Lg+kDmW3cULn
         LQcik2U90b+vBA23BBTONlnL8XDwz01uRZD7kUAw5GlJ+skbB44o0Nj2OLVO0upBgqEo
         IbBw==
X-Gm-Message-State: AOAM5334WMqMV1vtPIlH8hmeMfP44tfHmbeOwHHJvd8O5VDU+AXprEyg
        0xgRpgDHZldKIxyw+3uqecp8Fw==
X-Google-Smtp-Source: ABdhPJyFZbzwI8dugOKhP7hOvcSqpeQOb7QPQ5Z7wpwR0vdo2KHuoPy7joqVKtYQGrHw+2QNNYxr9Q==
X-Received: by 2002:a05:6214:21a8:: with SMTP id t8mr25774525qvc.46.1643225897199;
        Wed, 26 Jan 2022 11:38:17 -0800 (PST)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id 134sm106179qkl.50.2022.01.26.11.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 11:38:16 -0800 (PST)
Date:   Wed, 26 Jan 2022 14:38:16 -0500
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: at25 eeprom driver: NULL pointer dereference (bisected to
 af40d16042d6 ("Merge v5.15-rc5 into char-misc-next"))
Message-ID: <20220126193816.GA3763305@maple.netwinder.org>
References: <3887fe1b-58ac-902d-a4ef-1f8825d55aa6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3887fe1b-58ac-902d-a4ef-1f8825d55aa6@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Wed, Jan 26, 2022 at 07:18:42PM +0000, Christophe Leroy wrote:
>Getting below Oops on boot.
>
>v5.16 is OK, v5.17-rc1 has the problem
>
>Bisected to af40d16042d6 ("Merge v5.15-rc5 into char-misc-next"), bisect
>log after the oops dump.
>
>I'm a bit puzzled to end up on a merge commit, that commit doesn't show
>any diff with 'git show' but has a huge list of changes with 'git show
>--stat'. I must be missing something.

There is a mistake in the merge commit. The fix is here:
https://lore.kernel.org/all/20220118182003.3385019-1-keescook@chromium.org/

Regards,
-Ralph
