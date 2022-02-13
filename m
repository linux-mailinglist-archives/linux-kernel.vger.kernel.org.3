Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65494B3B40
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiBMMOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:14:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiBMMOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:14:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C85BD2A;
        Sun, 13 Feb 2022 04:14:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i34so25391966lfv.2;
        Sun, 13 Feb 2022 04:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CIQtoCVcRD0g7BLfpN+rf0B4Y2cMxyH7CXJXhpt1HFE=;
        b=QIB2wMRjLkNRm9ii6WC9MIr2gRXkQUOTaSe7XOmw3Bicp8XEhXYkt61DhGGj/Y/uXO
         tvJlqDhkjasoyMza1I/hlfDYw3/u3V8IZm756fUEo9xborVwgSyVt2MorvhQSCIJKVzD
         DCFppnVDPvY0/nFLkQjxnzLsaJs31+dmv2rNknY/WvvzlCoC/OQ0mGW9jEH9JY9bIRyZ
         XgZSYkka7RHB+a518BOwX1X9bPc1R6eTTU96e+ac3VwnH5BoFYVPEnKtNi4CkIgxW5Ep
         BY3QMYyhoCzUdhX+1h5IW5wZRFrO/J82/cGS5mZfKllJ5oEqpM4ocnvr4OTZzIyRqnwO
         DO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CIQtoCVcRD0g7BLfpN+rf0B4Y2cMxyH7CXJXhpt1HFE=;
        b=vGMxMxKSYkVcUhaKsLBGF1aaEss+gYKzZLd0pO44kj/Ye5dh3yM8hhpXXYjM4XGad8
         b5gwA5IbQnCzXpj9lqf5I3/jvibke8SynBheuawzkO+y0bnykNmpsDWe8MGEdGu3GSNq
         Fy40lPIaUd8Eon57r5UjKQRxVZTwnBd9moV6Sta42zuF3DBr+3r5+eIo+7eAKV/ho4+S
         KePBykj0WJhe9/lipHMCipeVGMr0UTfjsSQnxZ2LDhz1P1peiZpn6l0rgPZSe3qyDMo6
         9X6vbnjZv+m2bJNc3hGyF/db06d4+9P4o4ZLez3xxTbVO+oHh5yw+0lOD8K0BRObpVG+
         ltgw==
X-Gm-Message-State: AOAM531KzLO+t4UAAvqDfE55+CrSd9HzmddVtxEJIE9ivaDAdeZcUe/U
        t5DTRkrNtEplaSymNTnmA54=
X-Google-Smtp-Source: ABdhPJw/QCh5Oj/lkWkganevVGTUB7d6Bd2JWYH+NaneU4v4TyLNRTtz6m4VGW3kdM2wvBelVOM4sw==
X-Received: by 2002:a05:6512:3e25:: with SMTP id i37mr7413778lfv.325.1644754456857;
        Sun, 13 Feb 2022 04:14:16 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id k17sm3698894ljo.70.2022.02.13.04.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 04:14:16 -0800 (PST)
Message-ID: <2656099c-76bc-33a5-3b98-c46858025955@gmail.com>
Date:   Sun, 13 Feb 2022 15:14:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] PM: domains: Prevent power off for parent unless child is
 in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
References: <20220131113743.52265-1-ulf.hansson@linaro.org>
 <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com>
 <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
 <400e45da-837a-c8ad-84b3-285e35f8462c@gmail.com>
 <CAPDyKFpLX0Jpz-tzYx3-g0YBZZNh6Bw731gQEFQub1SviLGoYg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAPDyKFpLX0Jpz-tzYx3-g0YBZZNh6Bw731gQEFQub1SviLGoYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.02.2022 11:43, Ulf Hansson пишет:
>> In general, such changes usually are deferred from being upstreamed
>> until there is a real user, otherwise there is a risk of cluttering the
>> code with unused features. Do you have a time estimation in regards to
>> when STMicro may start to benefit from this change?
> The STMicro folkz are working on it right now, but I can't give you
> any estimates for their work.
> 
> Moreover, I think the important point in this regard, is that the
> $subject patch doesn't really hurt anything else, so then what's the
> point of holding this back?

If that work will never pan out, will you remove the unused code?
