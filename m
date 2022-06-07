Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FF541FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386157AbiFGWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381297AbiFGVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:40:26 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7D218F2FC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:06:17 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ca19so5940221qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kEh88sbKY2YcFyazQQTZq8kRQuf4NWYNl5prd+A7y48=;
        b=gYX6KtqMiH3fY8cMln5DLy0EX4vHtjVqoAYzI6Vksz+6WrELrfbEFY0Bb7m9oBxg1T
         VRWjrY5E5cTjKdK5wJlCK3Jp7kECqZtMksp6HbJegpfMonchOSIiRekIWXQT+9L/Rv73
         8lRqQv5Y4Pg8c+L+mEYyQqRMEIAcerryv6QHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kEh88sbKY2YcFyazQQTZq8kRQuf4NWYNl5prd+A7y48=;
        b=6c09pQLVRc6PCG7eiAfOe79AmD1tSD4rjUQYUFzX7UGdP7/bW7OyAD43UdCM89xmOF
         jt1harpx51L0p+lt2L/L9U/l8hvmbRNY/Z+qNOeNNKh7ghdv9nBYS9eZ00DGLmjBxtUn
         o7GBK0f7bOA/rEHcuC+MX5LJSHCIy9++H1aC5GCsS5jhJrRHvKnRGy1dgMj1EZHbYsrU
         RbQWnEHIn8w4RsJ8FQIIekV1E5oudN0M4HpWcDDx7AE1ghUv/f6XLOLb33SmNB3qG97A
         Q+YPBnCS0bg95urF+eERnUf8gL+9GfT9sAIpFSRtknCOm+fFPxYarMKGc+TDfyi4V1Rk
         xBMw==
X-Gm-Message-State: AOAM530RWBNhxdqFTGHEmTmLCnVb4a7JvmjCUtDnOxTWLOyvMHHOomPX
        aWJbgLKaSI3iE1VM+n6r6B4xpA==
X-Google-Smtp-Source: ABdhPJwU3d8oEkz5X5lKa+Lm36JdssARY1Af5Ux3+KI/0zWJyOPBsWDSAAOCUA57rRSoxhn10Jn12g==
X-Received: by 2002:a05:6214:1110:b0:46b:a979:d63 with SMTP id e16-20020a056214111000b0046ba9790d63mr7180252qvs.100.1654628776157;
        Tue, 07 Jun 2022 12:06:16 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i21-20020a05620a405500b006a6ac4e7ab4sm8577017qko.112.2022.06.07.12.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:06:15 -0700 (PDT)
Message-ID: <8012a613-91ea-466e-f77e-6fc5453724f5@ieee.org>
Date:   Tue, 7 Jun 2022 14:06:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: greybus: audio: fix loop cursor use after
 iteration
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jared Kangas <kangas.jd@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20220605231806.720085-1-kangas.jd@gmail.com>
 <20220606130626.GX2146@kadam> <Yp9/kqBUzpArfPdn@fedora>
 <20220607183921.GQ2168@kadam>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20220607183921.GQ2168@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 1:39 PM, Dan Carpenter wrote:
> On Tue, Jun 07, 2022 at 09:40:50AM -0700, Jared Kangas wrote:
>> Thanks for catching that! Is there anything I need to do to add the
>> 'Fixes:' tag to the patch? From my understanding, adding tags is done by
>> a maintainer later on, but I'm new to the patch submission process so I
>> want to make sure I'm not missing anything.
> 
> No, it's up to the person sending the patch to add the fixes tag.

And FYI, "git blame" can be your friend here.

     git blame drivers/staging/greybus/audio_helper.c

It looks like commit 510e340efe0cbd is a possible
candidate, but I'll leave it up to you to determine
that.

					-Alex

> regards,
> dan carpenter
> 

