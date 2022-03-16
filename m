Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE01A4DAD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354745AbiCPI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354733AbiCPI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:58:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF01652E5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:57:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so2682831ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O/67em/yLXrPExoOg5gE1gvocomogdUB8RybMctvAJM=;
        b=J2fJNccFL/iSU5e+qBAklCrq0dqaFVTuRYOa9Fmwq4IqZ5Cd8Qg056WFn9TTfGRozY
         IQNJng669LVesquPvHi9ZYEA1BOlWrXqXcOl2LGOBMRIc0UpZJdv3CMb10UMZDefr2iT
         8qsutITVvBK/rsf1vcvUUdJuyLONzHdKRh3Tq3RWcxzO6PBybISIs7CiVvKrVj/g0PW9
         BTmaLqBPf8ljw53VE9orE8K1kqCkY0FQtLNi7868ZbzB/wd/Xq4Kjxc5u/DqBPLR75XV
         n5JtNtAp6NbS8RnD32eqEAayDkyXY055YX/6I3zBlbL1yEcTQO7DBvSnl24cUHgHp8p0
         8eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O/67em/yLXrPExoOg5gE1gvocomogdUB8RybMctvAJM=;
        b=gH6wPa4yGE8r1LAviUaD17q49MdTz55VHPI17QH7QrVaFiiFZci+eCp4wsDCKEraDd
         /uQQz5dMKomESCBXctfDHMF4oofdLbZ2YtfPo12x3wvrZzz90THBeEuQwFtszbIN9rdg
         dQiwbxqJtubdPXfGAE1SKetOAnScUAl7nDGd7gxw7cEps0WPo0gxDX0TLSQlUTbRE8tY
         ieo8XGP6sEZBeZ5yrFeOjoBKPP9uH5FmL0AyAXQg9MtBEzqEnY0bl6CtQwri7pg87F7o
         zVQJdOVJdD/4j+P9pasOGK6oF01UGnV8DVP1MpDVE9Iz6ipcY0D3wBIKDo9MYCzZ9rvQ
         3yOg==
X-Gm-Message-State: AOAM532o9hgQ0Gei6XMzUcKg7A/upkZOrebbE5XpPL+9mXcYAS1vs4wh
        nsMf0IO22ootVb5z4jQqhy/OdQ==
X-Google-Smtp-Source: ABdhPJxp9p2Y38P+AibtSr2MgBfN2RM6VZypXhiQPrTLpvuTE0Fv+wx/vAsRkn+mTANDSg6YqsXPIQ==
X-Received: by 2002:a17:907:1c9a:b0:6d8:633c:be32 with SMTP id nb26-20020a1709071c9a00b006d8633cbe32mr26709264ejc.159.1647421026152;
        Wed, 16 Mar 2022 01:57:06 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id s14-20020aa7cb0e000000b00410bf015567sm624490edt.92.2022.03.16.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:57:05 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:57:05 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     =?utf-8?B?5a2Z5a6I6ZGr?= <sunshouxin@chinatelecom.cn>
Cc:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, oliver@neukum.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn
Subject: Re: [PATCH v2 3/4] net:bonding:Add support for IPV6 RLB to
 balance-alb mode
Message-ID: <YjGmYe9CuNiYSgk0@nanopsycho>
References: <20220315073008.17441-1-sunshouxin@chinatelecom.cn>
 <20220315073008.17441-4-sunshouxin@chinatelecom.cn>
 <YjB0wCcubE6713C+@nanopsycho>
 <c5d18455-c2ff-6e1d-c2d5-55417995c014@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5d18455-c2ff-6e1d-c2d5-55417995c014@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 16, 2022 at 09:45:05AM CET, sunshouxin@chinatelecom.cn wrote:
>
>在 2022/3/15 19:13, Jiri Pirko 写道:
>> Tue, Mar 15, 2022 at 08:30:07AM CET, sunshouxin@chinatelecom.cn wrote:
>> > This patch is implementing IPV6 RLB for balance-alb mode.
>> Out of curiosity, what is exactly your usecase? I'm asking because
>> I don't see any good reason to use RLB/ALB modes. I have to be missing
>> something.
>
>
>This is previous discusion thread：
>
>https://www.spinics.net/lists/kernel/msg4187085.html

I don't see how it even remotely answers my question. Could you please
spell it out for me here again? Thanks!
