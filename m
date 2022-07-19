Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807715795C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiGSJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGSJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E227420BC9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658221644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xq3a91+TAH7Moxgf8B5LgoKm/+Ua2vqG4jjWG7x1VA=;
        b=RwFarnVQCyAmukmwIJY3NMDfQvCYliQYLvkMj80B37F+3Div3LRV20zsYLClZDd6hw6qfP
        okUdiL0ZDm0CCk99fypS1El3VIAfWuHlyEFdL7x59SVoOLKkOEZeTscT+rxVDSzD41/YDz
        BjoQfjMjPTvSIAbXgYtlktdIHc4VmXg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-YlPA9m-FO_-KRZ-L-mH6BQ-1; Tue, 19 Jul 2022 05:07:22 -0400
X-MC-Unique: YlPA9m-FO_-KRZ-L-mH6BQ-1
Received: by mail-qk1-f197.google.com with SMTP id o13-20020a05620a2a0d00b006b46c5414b0so11464235qkp.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5xq3a91+TAH7Moxgf8B5LgoKm/+Ua2vqG4jjWG7x1VA=;
        b=xbXSgMF6FRjY1dt6yPsAXGraVwJi9iIf24abz67mX/JHGAHnKRr2pTsviERPegwa3p
         zMg44P/ynwB2asvZNwTpRmrhzpjsHcCdkr4LLwRKw2Pe7EkAB2Ud0w5K3Chlx+3j0KJp
         LYib8BCOMBBpP7IiE7+TKwRtuVzRPc++u9aV6tLENQ8HgPmTMJUqhVbvzWkiMtMDodCV
         n1R14wVpB5LRTMd+zNAb1hFhQsket4IZ0klmcXF5DNuO2b7+c+kOePaz+Z8YL3YjVxeI
         AmZlvGPlxqSIxr/WIZtloNb03a1NAOeKfEIKVu3MazOf/S6PEIx3B4yJy7zDK6o7dj3U
         CW1Q==
X-Gm-Message-State: AJIora9Eyp5kVfcxuZMFjFT/n4BeWhlLsUF+H0RtwJ3P9PdpiQMZNzPl
        eha66vzCwu+vShRA6cwWhRTUktgxQeKg9bg9cEszZHeYw8dWnF1S/BJAogOvnjVGtufbp8NCtkm
        Hk9+fX9o2dJggK9+xaxEALsyB
X-Received: by 2002:a05:622a:1794:b0:317:db58:f413 with SMTP id s20-20020a05622a179400b00317db58f413mr23730544qtk.505.1658221641986;
        Tue, 19 Jul 2022 02:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uRKX09vnsNM2yGtz/6mob8/dB7WaX8W9gLTBKi64TLhFALZmpn6m1I/lQV/rd+tPtAJ0qMaw==
X-Received: by 2002:a05:622a:1794:b0:317:db58:f413 with SMTP id s20-20020a05622a179400b00317db58f413mr23730525qtk.505.1658221641721;
        Tue, 19 Jul 2022 02:07:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-164.dyn.eolo.it. [146.241.104.164])
        by smtp.gmail.com with ESMTPSA id dm53-20020a05620a1d7500b006b4880b08a9sm14138074qkb.88.2022.07.19.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:07:21 -0700 (PDT)
Message-ID: <00e2c14ffd5bb2214b4d5553c1ed1d331b4cc355.camel@redhat.com>
Subject: Re: [PATCH V4 net-next] net: marvell: prestera: add phylink support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Yevhen Orlov <yevhen.orlov@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Date:   Tue, 19 Jul 2022 11:07:17 +0200
In-Reply-To: <GV1P190MB2019F8813E2E3A169076EE9AE48F9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
References: <20220715193454.7627-1-oleksandr.mazur@plvision.eu>
         <660684000d6820524c61d733fb076225202dad8e.camel@redhat.com>
         <GV1P190MB2019F8813E2E3A169076EE9AE48F9@GV1P190MB2019.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-19 at 08:56 +0000, Oleksandr Mazur wrote:
> > > +
> > > +static void prestera_pcs_an_restart(struct phylink_pcs *pcs)
> > > +{
> > > +     /*
> > > +      * TODO: add 100basex AN restart support
> 
> > Possibly typo above ? s/100basex/1000basex/
> 
> Hello Paolo, yes, you're right.
> So, should i wait some time before resubmitting patch again with
> changes - V5 - or it's okay to resubmit new version now?

My personal take: v4 has been out for several days, so it's ok to
submit a new revision now. Others may disagre, but you would be free to
point the finger against me for the suggestion :)

Please additionally have a look to my other comment, regarding
read_lock usage.

Thanks!

Paolo

