Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706CD50BC29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449585AbiDVP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355262AbiDVP4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:56:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B411CFEC;
        Fri, 22 Apr 2022 08:53:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k22so11686289wrd.2;
        Fri, 22 Apr 2022 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r7VFn3nngH4hNjFd5Mmo4mWEZGaDYjUWd1EsyxAItoo=;
        b=DTP9DHNq5jUm2XHGh/m/MlF5ZHRM+6H84xoxglPZV5KB0b8Dxe02cU/kU8iMZVhGEA
         XMl8T6DYI+31yC7qfkqTb2p8nihDO0fQQMWRDzwy86DOwMwHT8tbT9g0HU6cnla9n5ec
         lYhSg0YT2G96BPHcq+hHnlsWtcFQIeNeNczMBVOluy0HSXBc+PydxuyN3nPcXmLSKuqC
         puKlMJEIXxR+4KLNlT8z36Z7qIqzHlaISjgpskp+5iafoz74oqj14Vz4HVBFK1AhSs5z
         qhrVhm6B5iWwh7gwktS2j1U7Y/7l8Yvl5l5Vv5mvvjWlvXqq3qMLaWN1wyhzanAmWWuO
         4CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7VFn3nngH4hNjFd5Mmo4mWEZGaDYjUWd1EsyxAItoo=;
        b=s0VF2+J48Rl7FwG+K9XT8fPY+P2S/yuE86cd2i7mS63KqNx4MQjAFcN1Qw+U8rm5tN
         chsTnfIREVn+8rn4Yll2/ZmeAKC0EpSgbO8tmZztASahq4wAbmsrmePLivm+GjWTxs8R
         kKd8P9D1parVq8y3+Tr6ulMxcxX0TqvTblGVLFOEk0vd20zfPy/apBSZy9PV6ZjU44/A
         fht+p2IXUAhiNNWMxB+JcgDc8+JP7lzo6Z3iO3tX0J+0bxJNQFrEDrwuLTOlM3gBnf0P
         sGdlYINSchq/XysduoIlDk5JhNg7KfOfFI+n69hh2l2ak2sSf7+26T4L22+T2tjburWS
         bsww==
X-Gm-Message-State: AOAM532UVIHX4kp4dsRrMHlws3XxTcnZNXHqcv1N+oBTIyji+m/92Rbf
        98MF87/Ag9hmrFpGz6Y0bBI=
X-Google-Smtp-Source: ABdhPJxoFu1IAbWDj7jx4O7GbR2IpYAyiPT7hQ5/DScUoGyOeD3rzzw5Cta6ExLlJ3lVrTakmnoufw==
X-Received: by 2002:a5d:4e07:0:b0:207:9a41:842f with SMTP id p7-20020a5d4e07000000b002079a41842fmr4269077wrt.232.1650642800770;
        Fri, 22 Apr 2022 08:53:20 -0700 (PDT)
Received: from localhost (92.40.203.64.threembb.co.uk. [92.40.203.64])
        by smtp.gmail.com with ESMTPSA id p3-20020adfaa03000000b00207a1db96cfsm2185493wrd.71.2022.04.22.08.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:53:20 -0700 (PDT)
Date:   Fri, 22 Apr 2022 16:54:10 +0100
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, mturquette@baylibre.com,
        paul@crapouillou.net, paulburton@kernel.org,
        tsbogend@alpha.franken.de
Subject: Re: [RESEND PATCH 2/3] clk: ingenic: Mark critical clocks in Ingenic
 SoCs
Message-ID: <YmLPotnIBStYpapa@localhost>
References: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
 <20220411101441.17020-3-aidanmacdonald.0x0@gmail.com>
 <20220422023359.87E8FC385A8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422023359.87E8FC385A8@smtp.kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 07:33:57PM -0700, Stephen Boyd wrote:
> Quoting Aidan MacDonald (2022-04-11 03:14:40)
> > Consider the CPU, L2 cache, and memory as critical to ensure they
> > are not disabled.
> > 
> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> 
> General comment, please add a comment around CLK_IS_CRITICAL usage if it
> isn't very clear why such a clk shouldn't be turned off. Second, is
> there any point in describing these clks in the kernel and using memory
> to do that if they're just going to always be on? Wouldn't a dummy clk
> returned from clk_get() work just as well if anything is grabbing a
> reference with clk_get()?

I'd guess they're there to keep track of which PLLs are in use, at least
for SoCs that have more than one PLL. Using a dummy clock sounds like a
bad idea since it won't represent that, and besides the clock configuration
is something that can change at runtime so hardcoding it would be foolish.

I'll send a v2 with explanatory comments around CLK_IS_CRITICAL.

Regards,
Aidan
