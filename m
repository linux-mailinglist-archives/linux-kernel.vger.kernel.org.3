Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4695051A551
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353323AbiEDQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353016AbiEDQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:23:31 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E3446648
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:19:55 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id q73-20020a4a334c000000b0035eb110dd0dso269791ooq.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dbVLoGLvvdOw9abtQc9gMQO+m9oCoAXtfZ2W1vRohYs=;
        b=Xl0uRWlbqSeaYgNid5Xu5/x9v7F3s8ycxvRHbVXBkc4EaIyf8JUvW+LZrrYwSj84wg
         Uq7G3EQ7sfke3vOYEhCzmHNBYlM17MnW/uzSzv8nP+Tgohzev8jDZ4W4W+ZpfkD5laux
         TTWySJmTsuGHMjO6dYe3e5VgCshw5h1EZOVlcUeqYNJD3PLb9aNoiXxgfVGYXIq9x0Ke
         9KbzEgVsafGZtNYX7X5WKx/E4i8ciZRLG3KL0RyAn8/Jojrnpcg3wnLSWw/fw9jjwlt9
         22y/68iKAzVgHEYk66WuPBR+IfJBlguzT1rrJfY+btECbT13qFzxAIxq0ipFpCOz2iPI
         tCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dbVLoGLvvdOw9abtQc9gMQO+m9oCoAXtfZ2W1vRohYs=;
        b=hMFq+jCMELd44oGW9G4ncXtLeRIuaa3SJJ6FItRqYY/UxLpt9qWfPd7Rl7eAlYfzYB
         GkGcJ3URcbsYVqdx5NVovYoRjGEyCtZBZTyKmPJHQKEaNJUCQrUxVEMWbtZQ2p8aWATp
         tqAyKZxHsImwpvpulJEWWzZP3U8emvLBG6Z4gjVNr8diNP5SCRUNqcpLkuANHl5Znmmx
         SW7ZnUF+HfLqvmqongjcJ3WQrxHEv1oaiwEzcTIuPIsmcwkzaUlOWuZOiKKqN2D5bZpJ
         UCh07lErFXigYZXkVVlkUEBQdhYb7pOjuJWzFqhDgyYZOE8GH8AaM40I+ruKI7mHaDzR
         mE2A==
X-Gm-Message-State: AOAM530Y9hkGrKz9IIFK7jtwC1fEWQ9pnejt5qziqH7Y81bShJrqnGr/
        tXdLMunk4n+5Ic6PceEFhn8K5Q==
X-Google-Smtp-Source: ABdhPJyyqUME15QFq+hLqomIxwFjEJTKjoS8Pdb8JTFULASh6I8vEFeva5aVv9Q+SPjB3A5zoW/eKg==
X-Received: by 2002:a4a:3546:0:b0:35e:cecd:c81d with SMTP id w6-20020a4a3546000000b0035ececdc81dmr7461215oog.79.1651681194666;
        Wed, 04 May 2022 09:19:54 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z4-20020a056870514400b000edae17a8cesm3104330oak.3.2022.05.04.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:19:54 -0700 (PDT)
Date:   Wed, 4 May 2022 09:21:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YnKoEyEtFP3TBxkg@ripper>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220504072435.GB8204@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504072435.GB8204@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 May 00:24 PDT 2022, Pavel Machek wrote:

> Hi!
> 
> > This adds the binding document describing the three hardware blocks
> > related to the Light Pulse Generator found in a wide range of Qualcomm
> > PMICs.
> 
> Sorry for the delays. I have collected tested/review tags and push the
> result to:
> 
> To gitolite.kernel.org:pub/scm/linux/kernel/git/pavel/linux-leds.git
>    312310928417..24e2d05d1b68  for-next -> for-next
> 

Much appreciated, this will unblock a few different use cases for us -
perhaps the most important one backlight control on devices such as the
Lenovo Flex 5G :)

> I'll need to check pattern usage in the driver, and there are some
> small fixes needed as evidenced in the reviews.
> 

I will go through the Marijn's feedback in detail and am looking forward
to hear from you on the pattern front, and will look into preparing
incremental patches for the changes needed.

Thanks,
Bjorn
