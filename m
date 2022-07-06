Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7C568217
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiGFIuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGFIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:50:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67A22B20;
        Wed,  6 Jul 2022 01:50:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so13109799plx.3;
        Wed, 06 Jul 2022 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kviL2OnZm1a3ZgZ6SolZMa8XNSsgN9ztY7oeMbC5TUA=;
        b=Fs6JQt5j4ge8D8Rt866EbIyUuO9zzF64Y+FfYIpmA4tMP9W56JJCZIyFaUL0sdNKbU
         BsxZJLybrr0306D6Ho4zZYNcwYo+QnB0RNbgM3b0mpVOJj8XFHa+ir963rRYLUcReULd
         ll+cvz1BRY0Lah9nY882jZ1pbWK2sjBbPbYdyou1VL/rwUE8Ow+4VTtQZUTFu8K/YIL8
         l0GE6Blpx1dY2AMyqY3jvXnrPML8ZgsngMzQ3/I5AgM0jut8GzOH/8Sy6VYevqrEGNV/
         +0YBCuXZ4kYjkccfAGDM0If2LJ+OJCOWS5OYK3m3LrJcW6uVfTTJVYlvfCC3buvsUsTg
         W6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kviL2OnZm1a3ZgZ6SolZMa8XNSsgN9ztY7oeMbC5TUA=;
        b=VHSP+dUJ0luVl/G/i5WNPe6+owFJNEG3+z48/BU/cEzcEaenxxvkbUuKAK87ULO8Gy
         JdjTDK7e0EzkqEGxlDxcBU6Fv3pRvR4+VvhNH277oHWHxNYTFW76DWcyXHDBNPXUt5ip
         xslvd+9D0tRtBHAZvJnubrrCU9kwzdz8SwKh7/nj6jS0j/uL6+Oov3PE12hQRybBTWWE
         PBhOW++cr6AHZ+wDM5lLT6LmqOCb+fZ6V7ssA4UqM/KWEGo93jOwyd8aubbHxTiZHiL5
         r7nG7MmvnnryRsGtIv4Mc/3EII9lMlvqvUuG5HrD7VMiYyp+Petncy9zwvIMSord8vIu
         MMrg==
X-Gm-Message-State: AJIora/wN3dabp+MEX9A6fMXRkMEe+Ag5nIWCCnFUNSezc/8JwYxNNG7
        ZWufWbo1ZCht802XGBNLuu9IoNqtLng=
X-Google-Smtp-Source: AGRyM1tf3JX4+1VZd4+Pq8JMREEr3cxM8ZAqGwRNIL+j5LntKIhPax5qRJBxyJ58/1Cu/cBn9Z9QyQ==
X-Received: by 2002:a17:902:d48d:b0:16b:f0a8:446c with SMTP id c13-20020a170902d48d00b0016bf0a8446cmr8806272plg.50.1657097429567;
        Wed, 06 Jul 2022 01:50:29 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id o11-20020a634e4b000000b004118fd18476sm12926027pgl.60.2022.07.06.01.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:50:29 -0700 (PDT)
Date:   Wed, 6 Jul 2022 16:50:25 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH] gpiolib: cdev: fix null pointer dereference in
 linereq_free()
Message-ID: <20220706085025.GA2259579@sol>
References: <20220706084507.2259415-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706084507.2259415-1-warthog618@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:45:07PM +0800, Kent Gibson wrote:
> This patch fixes a kernel NULL pointer dereference that is reported by
> gpio kselftests.
> 

Should be:

Fix a kernel NULL pointer dereference reported by gpio kselftests.

Sorry - I rushed this one a bit.

Cheers,
Kent.

