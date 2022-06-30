Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4648F561705
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiF3KAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbiF3KAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33C9E43ED8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656583237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDpo9w9XJE1jrCzOgcFUJvtl+cW0jtOjJF8dSpaoYlA=;
        b=HQ5B68lmwwNeKX50R4nxrZIqoO3AYH09sB1yBZlTYxSOZ33+a00bnKQEJOvO5xeEUkkjNu
        rVsgCfiwMRavnCPbWFWw3DdSVLKegvL/1qJJx11kVh+6jGo2bchKNA9jqQBICnfIdD3USI
        CoVcuXeacAmpfIegWIm9SLFzCNvotBQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-VSB2sQ2OONWmNvIdJ8IyEg-1; Thu, 30 Jun 2022 06:00:35 -0400
X-MC-Unique: VSB2sQ2OONWmNvIdJ8IyEg-1
Received: by mail-qk1-f200.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so18792793qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IDpo9w9XJE1jrCzOgcFUJvtl+cW0jtOjJF8dSpaoYlA=;
        b=Qrm2Zgwkl+SlGOdaD83YAU2paxnQYr3/JPw5tZ7lqhaiXyDh9Y2vAVuMkUIqZzOhvG
         J1Pr5wDg0hNyTlSAxmRTaiTP1mmO7/wwx7xn/zXWRTIF94fyIPoCHeAUqkGyMmUmVGYC
         KaCKnHKzH8J8rF6KOni2vI8Q3KvwcbWi40xKPAWLs5fR+ZgEgKcx9bRT3ZsTADQI8HfE
         EAkxmA8NnQpBiHsYPQzgZmUU7ZIhLQ0qKOpUQkYuJv6KfOgUIMnX7FCNo8W2J1si/LKZ
         F1Ap63EWf+v3jEjodmU5ikrqaAKPVUC0xXZWf+hCQ1VPeX7p9oGx4Jxb2rdeOnmhn1bZ
         JG8A==
X-Gm-Message-State: AJIora9eWYDBQpdSjLg39jia+aK6Tre57xt9uBAqOnnYNo/85FzXbrow
        nO0cZ39+hBhFuJhOjhthN2+VuqPperNby2CgdWZZ76wxHIedJhVo0uJ4X6gtpNKgrc0yd4M6nQM
        PzAJVFUUeBoCcC79sLGHsuw/r
X-Received: by 2002:a05:620a:294e:b0:6a7:750b:abf8 with SMTP id n14-20020a05620a294e00b006a7750babf8mr5406407qkp.513.1656583235394;
        Thu, 30 Jun 2022 03:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbaNFh1GMxINSBXv4AGcIQ0XnAuDLHC1FpDVj4yPgic43xbOmXqpnpWc3uaM8Uv89781L4BQ==
X-Received: by 2002:a05:620a:294e:b0:6a7:750b:abf8 with SMTP id n14-20020a05620a294e00b006a7750babf8mr5406376qkp.513.1656583234806;
        Thu, 30 Jun 2022 03:00:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a240300b006af45243e15sm8515406qkn.114.2022.06.30.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:00:34 -0700 (PDT)
Message-ID: <9a3c3660f4e32be7d490e2abfe9bc364162ec74b.camel@redhat.com>
Subject: Re: [PATCH net] net: macsec: Retrieve MACSec-XPN attributes before
 offloading
From:   Paolo Abeni <pabeni@redhat.com>
To:     Carlos Fernandez <carlos.fernandez@technica-engineering.de>,
        Carlos Fernandez <carlos.escuin@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "mayflowerera@gmail.com" <mayflowerera@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Jun 2022 12:00:30 +0200
In-Reply-To: <AM9PR08MB67887876922C0E9842EAE88ADBBA9@AM9PR08MB6788.eurprd08.prod.outlook.com>
References: <20220524114134.366696-1-carlos.fernandez@technica-engineering.de>
         <20220628111617.28001-1-carlos.fernandez@technica-engineering.de>
         <e6114817650d7c27f4c1e75eaa63058846d71418.camel@redhat.com>
         <AM9PR08MB67887876922C0E9842EAE88ADBBA9@AM9PR08MB6788.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-30 at 08:51 +0000, Carlos Fernandez wrote:
> Sorry about that, I was pretty sure I added it in the first line of the patch and then I used git send-email. 
> Is there any way that I can be sure everything is ok before sending it? I'll try again.

As a last resort thing, you can git send-email to another account under
your control (_only_ to that recipient!), git am <email> on a clean -
net tree and check that everything is fine.

Cheers,

Paolo

