Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6ED5A0EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiHYLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiHYLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550ECA263E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661425899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6R2kOFpSZu9B1r8tOPgQwwbnj/1FHfHwXqHb6Dl3U0=;
        b=VealhEOHfiAOIn/GfF+fTRSCbLPMW+jLw6ZUAwbEuAAV7xhI7Rwcnp9YruZnJXspxD2esF
        cyH3QRCUEfaplonhaEss4DXSzNHKLYLsXJigkfpdhEpAo2moFGDLXL4gRzoweh0nGV4O1/
        CnRfoz8FmMiMWEFkNfjhHZ3+ugks4ds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-jZVf9OXDN_Cfuh7ovrW-lQ-1; Thu, 25 Aug 2022 07:11:38 -0400
X-MC-Unique: jZVf9OXDN_Cfuh7ovrW-lQ-1
Received: by mail-wm1-f72.google.com with SMTP id r10-20020a1c440a000000b003a538a648a9so10787449wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=Q6R2kOFpSZu9B1r8tOPgQwwbnj/1FHfHwXqHb6Dl3U0=;
        b=c4p9Iz2qBRcIT2Tfj7RflJ1m56cf0Lp6oRm+X4NESj+gOoNOIG048+nJ3OpL6sNy7o
         WNPbt0zhf7QQAlye6UeTuNAQpXHka9/JVUxSb5b06fTF+EQ0nGqFb26iy+lSuLdvgRXV
         Oh8TCHSJsudU1Gn8gA3dq+lnXreSm2iemjV6Im6PdTUjr1qkNXUlc+68lzW7mU4bWeZ0
         YVYV4+LPafkzScOWRx+p2Xq3/bNCj40cUeAEeIDfRxfn7QWno8wEAZTWBH3QuMrPTTls
         kv8BRJCVQMk27aAwTlpcM9tsLiAJb/+XeUMwmyQnCWRvUDnBRueBfW4EUDw5SZmrjmGx
         /IEg==
X-Gm-Message-State: ACgBeo16Rdp0O6guOJdFcoSB11LVjwDwQXX8hdKG6ov+C1vz5r67FCsB
        krEI+nBFQgZ9zlfwr2O0lZ7v5lx8tAy04hgjZBPQwjOnxi91Ok94tnHs75JNGVIJX6Eandm0k7n
        9VMTyr8B3hhJVhyKezGaih1ph
X-Received: by 2002:a05:600c:2114:b0:3a5:4f31:3063 with SMTP id u20-20020a05600c211400b003a54f313063mr8238470wml.50.1661425897036;
        Thu, 25 Aug 2022 04:11:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7m/LFh6KSjkSq7Lqgq/TVqkGBP1qeEks7lCgy4C/9MLYkzDLRcCb5wnUXKkDz3PgYGt0jMPA==
X-Received: by 2002:a05:600c:2114:b0:3a5:4f31:3063 with SMTP id u20-20020a05600c211400b003a54f313063mr8238453wml.50.1661425896852;
        Thu, 25 Aug 2022 04:11:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003a32297598csm4817740wml.43.2022.08.25.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:11:36 -0700 (PDT)
Message-ID: <200cb2f98ca159003ed4deb51163e5f8859d4f8b.camel@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: prestera: acl: extract matchall logic
 into a separate file
From:   Paolo Abeni <pabeni@redhat.com>
To:     Maksym Glubokiy <maksym.glubokiy@plvision.eu>,
        Taras Chornyi <tchornyi@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Serhiy Boiko <serhiy.boiko@plvision.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Thu, 25 Aug 2022 13:11:35 +0200
In-Reply-To: <20220823113958.2061401-2-maksym.glubokiy@plvision.eu>
References: <20220823113958.2061401-1-maksym.glubokiy@plvision.eu>
         <20220823113958.2061401-2-maksym.glubokiy@plvision.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 2022-08-23 at 14:39 +0300, Maksym Glubokiy wrote:
> From: Serhiy Boiko <serhiy.boiko@plvision.eu>
> 
> This commit adds more clarity to handling of TC_CLSMATCHALL_REPLACE and
> TC_CLSMATCHALL_DESTROY events by calling newly added *_mall_*() handlers
> instead of directly calling SPAN API.
> 
> This also extracts matchall rules management out of SPAN API since SPAN
> is a hardware module which is used to implement 'matchall egress mirred'
> action only.
> 
> Signed-off-by: Taras Chornyi <tchornyi@marvell.com>
> Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
> Signed-off-by: Maksym Glubokiy <maksym.glubokiy@plvision.eu>

This SoB chain is not clear to me. Did Taras co-developed the patch? In
that case a Co-developed-by: tag is missing, as the first tag in the
list. Otherwise why is Taras' SoB there?

Thanks!

Paolo

