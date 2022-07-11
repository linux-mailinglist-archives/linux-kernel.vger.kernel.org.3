Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9CF570336
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiGKMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiGKMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:45:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174BE64E3B;
        Mon, 11 Jul 2022 05:45:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d16so6821960wrv.10;
        Mon, 11 Jul 2022 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nj+8U5dCs7AUxZlYYLZz/BAZkJpwweLoeIkwzs3owdk=;
        b=SCqWBu/B7q02kU1ZOWtHrgqEFfk6J4dOy1IMsXXTxPyCg0unf8FEVJXunFPetkUwmQ
         ghNtK0/WFtvpOZcVMXv+7zV/3EwmtFUYqZa3cSqjwq6a2DSWKWhFeqEa/GJA01cwqBLJ
         xVErwsfioFszbrOsUBl1Pv79ZpZXnb0LyHEizRiIbph0bw5Ecb5eWsMkGd3JMx70zM8M
         5wsana1q2GSROSA/yNsRypEl8ASHk2+SmZ1aTBLEKa2nzzIP5xq+HqnDKVQJLKKwUwxr
         cwd2ktD+bQYdRbcvlHjH+5Wk0xOXjnTyqI51O2iRtMs1NnqQLytJSYF4C/mkRY+oj3SI
         Og/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nj+8U5dCs7AUxZlYYLZz/BAZkJpwweLoeIkwzs3owdk=;
        b=8Qea5S3Kh2Aj2zNuBSP2ZbqcOyMdP7EwCg9k0/cQj08N5joch/vCgQCPtQWG8SrmPJ
         j55xt+D5afysu1d9mE1U5yn3Pnr8Evw5Ljndu2ydjwGGoPJDwO+SoVN4NuFzcp8sVdS0
         01rMvJkkV0ypHUI6oKQH3NBWpkllNMPE7JkmC71uJsRfYmgstOYLL5TJKS9vREFI+fDX
         T5Fw1Jr3UzY0jOxT4BrEgtYEWOrlAWU5IJ5R9AupEq9U2W0uOut6yJO3WuqaBrsBptC/
         IgHxEP6bQ83+gkljh+CbwjnK8ARoO4GeJEDi4UIzCvWiC2vyebX6b2N0rFdOGrblXlfv
         pMhg==
X-Gm-Message-State: AJIora+0/ftSYTlZqMDsQXvkpTUywy9vsFLgFhtBRpX2AMqMjhnZoJ2w
        4DJSyPirnaZ3uNiKpbSD8hI=
X-Google-Smtp-Source: AGRyM1uRDl1y+Wzw06p7Fcx1sTRex9Ge0g6lMyhmOkuYKEPEeBDhxfM+ITkRMmJV21D9TdKgO2Q+MA==
X-Received: by 2002:a05:6000:156b:b0:21d:9daf:3cdb with SMTP id 11-20020a056000156b00b0021d9daf3cdbmr8255068wrz.492.1657543508529;
        Mon, 11 Jul 2022 05:45:08 -0700 (PDT)
Received: from [192.168.1.126] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003a0231af43csm6467754wml.48.2022.07.11.05.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 05:45:07 -0700 (PDT)
Message-ID: <046a29a5191c53813ce9477000b07c21ca5699fc.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] iio: pressure: bmp280: simplify driver
 initialization logic
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Jul 2022 14:45:06 +0200
In-Reply-To: <YssdPch7dVmRWDbB@smile.fi.intel.com>
References: <20220710091708.15967-1-ang.iglesiasg@gmail.com>
         <YssdPch7dVmRWDbB@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On dom, 2022-07-10 at 21:41 +0300, Andy Shevchenko wrote:
> It seems you somehow managed to send patches separately from email
> perspective.
> Make sure you pass parameter --thread to `git format-patch`, so it will create
> a proper chain of emails.

How should I proceed to fix this issue? Should I wait for more feedback and send
a new revision of the patches, now as a proper mail chain? Or should I resend
current patchset as a chain? I don't want to spam the mailing list more due to
my inexperience contributing.

> On Sun, Jul 10, 2022 at 11:17:06AM +0200, Angel Iglesias wrote:
> > Simplified common initialization logic of different sensor types
> > unifying calibration and initial configuration recovery.
> > 
> > Default config param values of each sensor type are stored inside
> > chip_info structure and used to initialize sensor data struct instance.
> > 
> > The auxiliar functions for read each sensor type calibration are converted
> > to a callback available on the chip_info struct.
> 
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> 
> Usually this kind of tag goes before your SoB, because it's chronologically
> correct.
> 
Ok, makes sense.

Thank you for your time and help,

Best regards,
Angel
