Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D24D9A18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347909AbiCOLOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347901AbiCOLOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:14:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BE13D5E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:13:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qx21so40368580ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4OxIW7ukQp7P+QJleA1PqcVNvNRyt/aT/5fuwLTzWVU=;
        b=jfkpCmWw7/mNZ/CdsE/GuHYvpPaiyCYopGGkyJ4701HvBg3G8Zs1yJRYw0qFXW4ahF
         XAOQARko7eCi10qPEeqeJGYatT4/9I5prWjq26Sp9g/whLm0mBi+cRmewSzQLts73zj7
         p0VTJp2JOPik8kY3KYfWxZw+IKINTvLlI2TtkQI49YNIWkL96/aQOW7FuyLgLRVqoxfW
         pt4GYlvX5EAJdD+ADFAan8XCtutNeekz6GHZcULEDvWP/mzBHR6t1RSTHUvfiEOPUrNr
         ipKzE3T162GOQ+UNTNUBP/uHQfvsVAPisVEhTepsuU+L9QDHyq0eUYoqimdU7lFOStfL
         zkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4OxIW7ukQp7P+QJleA1PqcVNvNRyt/aT/5fuwLTzWVU=;
        b=JdUOu4t3CBXnD8O35K+XaAEOPL31ZeU314vTtkEkcxyNLRU6RQn1oowbpinavLwDjY
         KyI6QQLMkJGAI4EAI5+e9RtnxsJ5pIqHOYBJ4CltVjbaTdLBCpqt4RlV2XlhNk7jfCKH
         Sd6z1CaNu3675Vbh886JGBs9hyifnZ1x1fGsiKgRb16xixG7mBTMX0HNsuq/l3iT9wWc
         7kyILoM7XySL6qTzV3aJclY607xazKr7/auM8Uzrww3zRAyFojPE+/RozMzsYSNp3C+U
         v6/gopE4cNesMIi5cSriA49QMlzczo2TAp5ND7A4BjV3HDm7XKxIAeqtUb/5J/XBeSG2
         jYXA==
X-Gm-Message-State: AOAM532Bz5YSEULMsQxiU/qwxqnIUEzr5OS6oY0OZeUVA5FwuWw5HHEm
        V+L5lziJUlldT5M9yL4PbP0cMA==
X-Google-Smtp-Source: ABdhPJwmuBdQm+1qW/dhV+k/Km1tvvGFhijmm1a/GIGNPJ+IpzPgt6nj82uadH5TUtoNZvLIq0OEFw==
X-Received: by 2002:a17:907:2d93:b0:6db:ab5e:7e0b with SMTP id gt19-20020a1709072d9300b006dbab5e7e0bmr15990296ejc.262.1647342785923;
        Tue, 15 Mar 2022 04:13:05 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm7901281ejc.120.2022.03.15.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 04:13:05 -0700 (PDT)
Date:   Tue, 15 Mar 2022 12:13:04 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
Cc:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, oliver@neukum.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn
Subject: Re: [PATCH v2 3/4] net:bonding:Add support for IPV6 RLB to
 balance-alb mode
Message-ID: <YjB0wCcubE6713C+@nanopsycho>
References: <20220315073008.17441-1-sunshouxin@chinatelecom.cn>
 <20220315073008.17441-4-sunshouxin@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315073008.17441-4-sunshouxin@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 15, 2022 at 08:30:07AM CET, sunshouxin@chinatelecom.cn wrote:
>This patch is implementing IPV6 RLB for balance-alb mode.

Out of curiosity, what is exactly your usecase? I'm asking because
I don't see any good reason to use RLB/ALB modes. I have to be missing
something.
