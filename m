Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B758562C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiG2Ucy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2Ucv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:32:51 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A575FAD1;
        Fri, 29 Jul 2022 13:32:50 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id r186so4851960pgr.2;
        Fri, 29 Jul 2022 13:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xrL2XtamT4FT/8smQHiuGpzknBloKpSyaDrKzyKKzI8=;
        b=feIR/FL8YP1JUzNo1dW3QSvo+YtDDJfeQ7EmogCU0CbrPsNdkte5q6NuHYBjdHnocK
         hry/f+zg/0Ve8jK7sXkL4ZO5wY+X6ixRtZY+fNtNH2k/T5jkBMuW/KkYyZZEtACg8/Kw
         GLTsHUqO6MEzvo3AUkaX26kDF8GJzC7+Q9CIacIvg63Dmp5fjOdbENG8Gr/smBf492rc
         Dh6JBtcTQjIXCNpIvAnHZIPJNUB/2AlCt8qZ4fqoZaYMew670kV26/hnY5It6BF+yIxY
         DjT7rzZdsW/RO1aaH/hmrFA6XolvTsKHwZcaui/T1290vMAeLkVPejxUB77FvLBZj3x+
         PjTA==
X-Gm-Message-State: AJIora+XEyBRGVRUNWmUPnwQaF7JoTe9Wp1W3OvP92waKFVzyBwqS0nP
        50np9sOMd/aRi+aKv8qJ9gpm/WRgrCk=
X-Google-Smtp-Source: AGRyM1tfK+Ex8JPsNPlR9sehgbM7kOjECRUhkjL+zNkOKxPYsL0Y9Xauh9Aa7Vitt3rjc1KrjauPng==
X-Received: by 2002:a63:6c06:0:b0:419:ab8e:e177 with SMTP id h6-20020a636c06000000b00419ab8ee177mr4144562pgc.188.1659126770003;
        Fri, 29 Jul 2022 13:32:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id o70-20020a17090a0a4c00b001e29ddf9f4fsm3475340pjo.3.2022.07.29.13.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:32:49 -0700 (PDT)
Message-ID: <6ad66ba9-0488-de6d-fec5-0feb5ca92de6@acm.org>
Date:   Fri, 29 Jul 2022 13:32:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 4/6] scsi: ufs: wb: Add
 ufshcd_is_wb_buf_flush_allowed()
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
 <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
 <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
 <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
 <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p1>
 <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 21:56, Jinyoung CHOI wrote:
> The explicit flushing should check the following.
> 	- UFSHCD_CAP_WB_EN
> 	- UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL
> 
> Changed to improve readability.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
