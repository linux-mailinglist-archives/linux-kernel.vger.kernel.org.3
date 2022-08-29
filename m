Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121285A4430
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiH2Huj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH2HuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:50:21 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718311C36;
        Mon, 29 Aug 2022 00:50:19 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id z8so223695edb.6;
        Mon, 29 Aug 2022 00:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j67PODyFLlaaryt3BHX3uk5uByxDeNuc4UP3AQpoax4=;
        b=V9jlZbmN9PHlVZv1MoyETdBHr3pV2jfBP4+Vx5zshVD7p5/bUKJ/FPLoJiH+SBWfP8
         zFcWCTR5wWXb2iS2aGkFAB6HjsoAXzSCWsCWaPsPCi5ZIbXa/jrLv213B6UDAdtxkeiS
         v8Tw1Hz6+U5dmeGTKbMuNS7P8rH9UeKxkRQxW4Nl0bhfBru68FUm1fSKbuxqs5giYdD/
         H6mQ3YMXnRVQ3TBw1Vtnm1RTpDr4QiGpxsjiHENozFQF3C4zwvU7qLNPUcj28b3MOokc
         gdlMv/wBXdfLQx9ddwF9wOFJzn9pUGZCsldsDlig7PjWjpiTxGuW0+7tIdO46IUVLWVd
         HBCw==
X-Gm-Message-State: ACgBeo0UvEDxIoab4sF/Cy59ISPKyyuzv5OTuOQGq0qbazqx0A4PWGSc
        pqdkkvYBjBoNXo9UgPUy077fHF51B7U=
X-Google-Smtp-Source: AA6agR5QvDBUAineIbR1x9mFpzPnEI+mSsDy9Qs3EIwFIxudk7l1+VzTgQzEctuV9pHtvMXmoD/3ag==
X-Received: by 2002:a05:6402:2753:b0:43a:d6f2:9839 with SMTP id z19-20020a056402275300b0043ad6f29839mr15026151edd.73.1661759418208;
        Mon, 29 Aug 2022 00:50:18 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id kw2-20020a170907770200b0073872f367cesm4173874ejc.112.2022.08.29.00.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:50:17 -0700 (PDT)
Message-ID: <1a05800e-a3c2-12f3-135e-b81a283d71a2@kernel.org>
Date:   Mon, 29 Aug 2022 09:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] serial: Add uart_xmit_advance() + fixes part (of a
 larger patch series)
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
 <ac383256-65f2-e4ee-0142-65bdb9dd9dae@kernel.org>
 <55cf3faf-2616-09c-57c3-35e7b11e55@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <55cf3faf-2616-09c-57c3-35e7b11e55@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29. 08. 22, 9:41, Ilpo Järvinen wrote:> Looking into your patches, 
they also seemed to lack that> icount.tx++ thing.

Perhaps, you only overlooked it?

+	for (; (for_test) && (!tx_ready || tx_ready(port));
+			(for_post), port->icount.tx++) {		

thanks,
-- 
js
suse labs

