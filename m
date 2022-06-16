Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED57554E697
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377998AbiFPQBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377357AbiFPQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:01:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC8C44A3E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:01:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m24so2449088wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l6OwqYcVIACsZfoSJ0T7YvBoL6yiGuqUoY7Ix6ahGSQ=;
        b=o4nMsZt/3jV1bsbk9nsN/ecHN5WUhbyFT9PWDtATNmBNXrGf7rOl+M5dtAjs83fugk
         WZ6S8tq+4j5Ishf6mCZHybXewU2U/aReOQDk1Q8jU7jbDRasM8aGLxRWr1q9DeQArLic
         Ruj5druGcI9zlEIs3TJA4aZXspP1HMVYan6KsruCiy7vLugaav9W7lX5Rx6KlB1el8tF
         I52NepB6ZKWbfyRJzwjfYKo7cdsjeBDYsOU2oPV/eF9rFsImZbdJdEW/HUBwpKiXYtVM
         RouWhcMgiBJu7YSYW9Soe435zGlrgnKSvn9LHJVjqrkRCLaqsuekrc/uuxtZH2fGaKKm
         Bb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l6OwqYcVIACsZfoSJ0T7YvBoL6yiGuqUoY7Ix6ahGSQ=;
        b=p/ofr3NI/YZ+83n4s61LZsF7v4Ixk3G5xfWdRL03SlCFKohagId0THMeOiU1H/NefU
         K85A2f3PttbrEYcYI7LZz0QIqJAdldnsGY7n5vSKjvrVLOjh5MGEqs3dLUNu/EkEprUn
         5fzGBTKdFgDc91xhBZhUr+FEipxjqQUhfq3tkB8vvk4c+76t+W9Q/YHiyhCz7paQaz3g
         DtX5Fu8cQ2BC4INNuruOAfzW9ZOUecUKyE1PLhH/3EvtuWk5Nkahs1fZOb4Qp0lf9NU+
         fFqUKvhnc5SZfQYQHhe0+SzKoxvmf9iNrl0FaDJFeMBd2YNWdVGqdk8n/GyjIn18uP1y
         0V4w==
X-Gm-Message-State: AJIora/2UoyfCqqcbtK40NHDX7CSR3fbu3PVEM1OUEn4I6BQPHd3cohk
        1XmlkAUQY2yBt3AE1kI2j+UaLtV16HwF4g==
X-Google-Smtp-Source: AGRyM1u9gA1o+7EK8Vgjpe4hz7z3siOeBw4UIC8/3U6wBAbdnEG2jInGiZrrqjOkugY37LUKfHlfEQ==
X-Received: by 2002:a5d:6348:0:b0:213:3a8e:e75d with SMTP id b8-20020a5d6348000000b002133a8ee75dmr5111561wrw.55.1655395279032;
        Thu, 16 Jun 2022 09:01:19 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c430700b0039c2e2d0502sm6048461wme.4.2022.06.16.09.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:01:18 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:01:17 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YqtTzehgcxRpoiyF@google.com>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
 <YqsBN2qtjCkNtVM0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqsBN2qtjCkNtVM0@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:08:55PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
> > This driver creates per-cpu hrtimers which are required to do the
> > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > userspace is responsible for delivering the 'pet' events by writing to
> > the particular /dev/watchdogN node. In this case we require a strong
> > thread affinity to be able to account for lost time on a per vCPU.
> > 
> > This part of the driver is the 'frontend' which is reponsible for
> > delivering the periodic 'pet' events, configuring the virtual peripheral
> > and listening for cpu hotplug events. The other part of the driver
> > handles the peripheral emulation and this part accounts for lost time by
> > looking at the /proc/{}/task/{}/stat entries and is located here:
> > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> 

Hi,

> The robot reported stalls on vcpus?
> 
> I think you need to fix this up...

The robot reported some issues on v5 and after fixing them it
recommended to add this tag.

> 
> greg k-h

Thanks,
Seb
