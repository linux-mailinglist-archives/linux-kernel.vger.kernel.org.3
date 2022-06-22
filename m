Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92649554077
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356266AbiFVCT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356120AbiFVCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:19:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6D33150B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:19:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jb13so535387plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i45DVLAIIMqvEaWYSwpuIS0opgqSETmmCquiuddLo3M=;
        b=Yu8c3qPoGd9CjhIdUnKjJvIoMxC2nNX/Mru2clcLp3/ITzfLfUlRn3Iu2L4fNAKV70
         1CFdLWSOT9pT6VYzb4RUMdVOSVdL1dXMMHL+14FEERrz/24ZA8sVzZIdB5SHvJxWXVbA
         i1askW7E3vUWrxly6vPW0Yj2PVEeS0lfFAi1g4d75YEnNntWqYiJhEEBCId9oTRG2Xsb
         Rxp2zL82cB85i5js+0n34BoZgcbJ7RZbbPlCFE8oK3/R4cCkY3ZVlujQADO0W5LrsbZe
         y8O0lc4nTlzNzt4K+hZWUcSD5n0ruebDCxZOB8Oyc0UXbZArBIWOp6+fOOBORUeXQPxb
         +YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i45DVLAIIMqvEaWYSwpuIS0opgqSETmmCquiuddLo3M=;
        b=T7U6Sioq7OzGHP86gAY+sus8wdvloPv6C448oZ50Q9MPs2sAAKE8zpXzhHwYGxbOma
         8HFXNeewoOa5bhUwXFMJHF8XH3a+6TpqqwMX4llrX1j35mXB0Di1lpUg1L7ZEr2ODTSe
         cvi6AuJb/h9Zhpta3bLE1cqMzh70vayLsYbg1d1V2eXFrSNH9+Jm6sUHW1vYx6ZsPdWe
         X8WSBynPNqhUzMBHMGmI38lGyovuZsZfqdSv+trHHwRBcxPgr8kUnDQDmiITsRJbz3A9
         P+G+FMmDNWIH1KwRB7jpPcUsFlXHXo/1qEYjIF6r6WigPadCeArzZU1Rz8YQA/rLcDqD
         iqlQ==
X-Gm-Message-State: AJIora+LMzLlE1PG5KTTNEz0LupvXSJFzw2D2y9L+bOkWP518oszDM8R
        +658fhbMPV7pZk+uOZTseGu0DA==
X-Google-Smtp-Source: AGRyM1uyDHTiR9BRAHTk5PB8yY3a141K8XcjfoLDdtVyLPfIuAK30qHwHmtDuh9+hMyXQGj04hVhZg==
X-Received: by 2002:a17:90b:3802:b0:1e3:3f3a:3621 with SMTP id mq2-20020a17090b380200b001e33f3a3621mr47404875pjb.65.1655864394421;
        Tue, 21 Jun 2022 19:19:54 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902c2d200b0015e8d4eb1dfsm11350332pla.41.2022.06.21.19.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 19:19:53 -0700 (PDT)
Date:   Wed, 22 Jun 2022 07:49:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>, vireshk@kernel.org,
        elder@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unitialized Variable and Null Pointer Dereference bug in
 gb_bootrom_get_firmware
Message-ID: <20220622021951.gni6cnvriogg6onj@vireshk-i7>
References: <CAD-N9QVVKUDFKMSxUc-smcz0B_7PrjN3DPku+cDM3ZKDn0XLBA@mail.gmail.com>
 <YrHYZb2BT8fQMcaR@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrHYZb2BT8fQMcaR@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 16:40, Johan Hovold wrote:
> On Tue, Jun 21, 2022 at 10:36:04PM +0800, Dongliang Mu wrote:
> > Hi maintainers,
> > 
> > I would like to send one bug report.
> > 
> > In gb_bootrom_get_firmware, if the first branch is satisfied, it will
> > go to queue_work, leading to the dereference of uninitialized const
> > variable "fw". If the second branch is satisfied, it will go to unlock
> > with fw as NULL pointer, leading to a NULL Pointer Dereference.
> 
> This sounds like the false positive that checkers keep tripping over.
> 
> Please double check your analysis and search the archives first.

And everytime I get this report, I wonder if I should change the code to be a
bit simpler :)

-- 
viresh
