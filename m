Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7DB515588
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380703AbiD2U3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiD2U3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:29:06 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE63C734;
        Fri, 29 Apr 2022 13:25:47 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id r1so9502005oie.4;
        Fri, 29 Apr 2022 13:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVAQuGhjd9n0kUWsH2GbUvhmDBHPRxTlldbJix1Anrg=;
        b=CeiDrd4FIXIhhIYXskh88hnDxjSqj5iZkpQkt9LRjm/GZS/XipdyPQsDZ/idWtCdPt
         IRrrVX0LFBIZcz3BZuILco7jQNkSNz/EGZhwc3j2E5efJ5Yk4TvcDk8m9FLArEqZy5jR
         5Un0UM8If0PlDdrO6ml/R2ghjAvD7JUcxPY5RcNfY8baoTeMbRGB+6bqRAc7pPlp2MWe
         hj+62ut8OmwSVA59AZryIIbqe9aSg3FPpBBxsX2CSdNr7TthX7T9DwO9q9y808BXuCi8
         V9oN7/uJ7m8vngkbR9QjQBpvOHw2qq7vzvSlynw1OwB1dY93CCvsz+HreFwutyRDFgsa
         T28w==
X-Gm-Message-State: AOAM532CNjz4tNXCN85Le/JqMpWanm8UsiUx3fI6xUzSCO98rJfrANTV
        sG2JWP3WOuxUxSjywKpfDg==
X-Google-Smtp-Source: ABdhPJy2MbnQXUPWfyt7SN9UKSlKCEDbzz/8Ju2fEu5V/tdV0sNBK9tYmlnWcNQUQgRQWENvDvnuTg==
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id o13-20020a0568080f8d00b003251e81ffe5mr551243oiw.253.1651263946535;
        Fri, 29 Apr 2022 13:25:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870d24300b000e686d1386fsm3375710oac.9.2022.04.29.13.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:25:46 -0700 (PDT)
Received: (nullmailer pid 2808184 invoked by uid 1000);
        Fri, 29 Apr 2022 20:25:45 -0000
Date:   Fri, 29 Apr 2022 15:25:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, qperret@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 0/2] Detect stalls on guest vCPUS
Message-ID: <YmxJyUqdsZmm8yE2@robh.at.kernel.org>
References: <20220429083030.3241640-1-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429083030.3241640-1-sebastianene@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:30:29AM +0000, Sebastian Ene wrote:
> This adds a mechanism to detect stalls on the guest vCPUS by creating a
> per CPU hrtimer which periodically 'pets' the host backend driver.
> On a conventional watchdog-core driver, the userspace is responsible for
> delivering the 'pet' events by writing to the particular /dev/watchdogN node.
> In this case we require a strong thread affinity to be able to
> account for lost time on a per vCPU basis.
> 
> This device driver acts as a soft lockup detector by relying on the host
> backend driver to measure the elapesed time between subsequent 'pet' events.
> If the elapsed time doesn't match an expected value, the backend driver
> decides that the guest vCPU is locked and resets the guest. The host
> backend driver takes into account the time that the guest is not
> running. The communication with the backend driver is done through MMIO
> and the register layout of the virtual watchdog is described as part of
> the backend driver changes.
> 
> The host backend driver is implemented as part of:
> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> 
> Changelog v4:
>  - rename the source from vm-wdt.c -> vm-watchdog.c
>  - convert all the error logging calls from pr_* to dev_* calls
>  - rename the DTS node "clock" to "clock-frequency"

Why do I have a v4 now when the discussion on v3 is not concluded. Give 
folks some time to respond. We're busy drinking from the firehose.

Rob
