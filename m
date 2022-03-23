Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EA4E5494
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbiCWOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbiCWOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:53:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDF37E082
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:51:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s42so1714387pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=ZKsxToLifVaO2+GQi9zy9qNsTOo5iGl4YniUU0Ax8EA=;
        b=S+OYhGMk/WbeP1ktsCekpAlpt+Nir0gXpvawk10Io7d8LN/a0W7XqgfZLN8MHwMD1a
         htSI3TTTXpp144Ez2Xy69HiwRtVUO/3Bk3i1qNmwKUxfoxBWGjugOEHAHzMlmEMm4Pzp
         shA9vAWAo7tJAMAj0MKO9BmkFxB56ZFcxj6qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=ZKsxToLifVaO2+GQi9zy9qNsTOo5iGl4YniUU0Ax8EA=;
        b=P7SygZR41ZECPMImXhHsH0N3M6evSt2D5Z586l2xWkEUqwUVzp+wbShcZJlTxhCIDO
         XVmgYNXj6Skpn2Ngl5+aeH1dmOqb2jB0z7pqEevH/cQ9mrecxjCKtsuTVcwpypwZ/uvS
         yd8jDdDUfjcZG0PWumFtkD4HhxgnbLVG/pNS2R0xHVvvyVJeHeCg2ZyQHm5CLldiSuq7
         Z/YvStvUvjLsO50B9dAHvGrm1FuyGTzeI4heeI1eQga0jPrZnrnDdXwkDrrTCjeqWDfU
         hd2kvZZfpEWcvjqvVdb92SR2C1xGpLUKaeA0UW+1N0zVMpYSdsJPPdJyMBNmy3gpq2gF
         nqbg==
X-Gm-Message-State: AOAM531U91d5RtD4mhIQpG6taC59/aKk05I7R7mFHgUctUyulHnuxhqP
        gkXCVjrF5Y200eGwynyoDE0FKA==
X-Google-Smtp-Source: ABdhPJxWTZJM/Gp9wUXypIlHJlT95QrNJUY01qYnnkR42/0SIuuRlmLoxFQch+ewVoz7lphUE/Uweg==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr144899pfm.41.1648047115347;
        Wed, 23 Mar 2022 07:51:55 -0700 (PDT)
Received: from [127.0.0.1] (206-212-226-225.dynamic.onlinenw.com. [206.212.226.225])
        by smtp.gmail.com with ESMTPSA id mq6-20020a17090b380600b001c6357f146csm7303533pjb.12.2022.03.23.07.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:51:55 -0700 (PDT)
Date:   Wed, 23 Mar 2022 07:51:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Sean Christopherson <seanjc@google.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [GIT PULL] bounds fixes for v5.18-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <YjsIOGpYwN10n60u@paasikivi.fi.intel.com>
References: <202203210843.0E70F58@keescook> <YjsIOGpYwN10n60u@paasikivi.fi.intel.com>
Message-ID: <E127689C-C2F9-4B47-8B77-4A6B1533ECDF@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On March 23, 2022 4:44:56 AM PDT, Sakari Ailus <sakari=2Eailus@linux=2Eint=
el=2Ecom> wrote:
>Hi Kees,
>
>On Mon, Mar 21, 2022 at 08:52:31AM -0700, Kees Cook wrote:
>>       media: omap3isp: Use struct_group() for memcpy() region
>
>This patch has been applied to linux-media tree about a month ago=2E It m=
ay
>have taken a bit more time than usual to get to linux-next though=2E
>
>Please try to remember to agree with maintainers in advance when merging
>patches via non-default routes=2E

Ah-ha; thank you for grabbing this one! I'm sorry I missed it while tendin=
g this tree; given the ordering of merges in -next, I've had to carry these=
 kinds of fixes to avoid warnings popping up for various builders, but drop=
ping accepted patches has been a manual process=2E I will see what I can do=
 to automate this going forward=2E

-Kees

--=20
Kees Cook
