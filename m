Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329425631C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiGAKpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiGAKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:45:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0E37BD01
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:45:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x20so2021132plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxTdft5xNc7J8YFkSd0py1mf7N70+0aOCnidcdDs4tE=;
        b=ycBL6j7quvTaf4N2uH4qr5V5PJiE2qYg6RDtf3wGfWZ20kZ1/e7HeFZgrmeKpiYoyW
         tX8A/trz9n9re9jLM4PNvXI0wMZFeGiaTZnmmLcqiWVQooz+YECRs4tKatbhEEDZc0MT
         esoRcS5s6dFvoMg2C5iYlleymPjiheKbdRyoqfxa7h4ZR8eyL4JZeUckeDg3xQZ608M5
         VfV58heci1FR0owz9/LVV9skWeKbe0FKH34lbR0Jnm1QB7v12OsTAO+cuTq3By9SdLYR
         2djQVxGBVe5/qU8kruvZUWlKi+DVH/xoQa1O+cLunfYkri5jhmxN67WJJj2kQEUiljbG
         Yh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxTdft5xNc7J8YFkSd0py1mf7N70+0aOCnidcdDs4tE=;
        b=KWQVTloX7hjvdN5QU00FwjnxoqQ+TnRmAelPbDYxjufkQQkHWg4Qc3FICXiStabXoj
         a6pCFsvDyz+25Rbq5q+h8yVJ+oRZ8fbkFsG8F87UwbnyYGKcHbhocWSpaZqQtgcLtnWr
         THOQVc7SzbHfmNbE9tfhIxpTqJ5uqSSVi0jD3jDwxaVWPV9yA5ilxweyG3X112WzDd50
         YNCLMVPXpP7ABzchenkvFeXnmJ9yQdbfcgZDgSDZbtdaYyAWkdOeS2zj7x7Y/r1kRx7+
         24gH/wdPSXq9RavuJkgtUPezrAB2uXz7x/7YEg1Xlg7BN8qlTFSaJzMz46wtSBPvepfQ
         Ji+w==
X-Gm-Message-State: AJIora823b6oHMWcOw6Rk43hC5+ndlHME1/AZZmR/VmrMsTrRACrAHcB
        pWCtm1Cx5ZlDVoI1ctR7w2HGjoddvrSUWg==
X-Google-Smtp-Source: AGRyM1vcSAY0ujJGydXrcRkYqJzibc2oSfglSmRCbOojCJpiZiuG7yhIJ1q+GW9zp6C5bvb5W3g9Bg==
X-Received: by 2002:a17:902:9041:b0:16a:aef:7b84 with SMTP id w1-20020a170902904100b0016a0aef7b84mr20829039plz.124.1656672309760;
        Fri, 01 Jul 2022 03:45:09 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f7c500b00163bfaf0b17sm11820122plw.233.2022.07.01.03.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:45:09 -0700 (PDT)
Date:   Fri, 1 Jul 2022 16:15:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 24/30] serial: qcom: Migrate to dev_pm_opp_set_config()
Message-ID: <20220701104507.b2k76y2s2hewfn25@vireshk-i7>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
 <1f3328dafaf9e2944fba8ec9e55e3072a63a4192.1656660185.git.viresh.kumar@linaro.org>
 <Yr6z5ixRTsIbZvsq@kroah.com>
 <20220701092458.tzqv7yul476kh2o7@vireshk-i7>
 <Yr7AwAZeSPeQKDPU@kroah.com>
 <20220701100100.bxv4t4t7iqphalpv@vireshk-i7>
 <Yr7J6f6+EQfXFjYN@kroah.com>
 <20220701102926.uwvn7rurbxdybzeu@vireshk-i7>
 <Yr7PUxdOKYp91mG0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr7PUxdOKYp91mG0@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-22, 12:41, Greg Kroah-Hartman wrote:
> That feels completely wrong, don't have NULL for a name, make a fake name
> or something.  Don't make all users in the kernel have a horrible
> interface just for one piece of broken hardware out there.
> 
> Worst case, name it "".

This name goes into the second argument of clk_get(dev, const char *con_id);

I will see how else I should hack it :)

-- 
viresh
