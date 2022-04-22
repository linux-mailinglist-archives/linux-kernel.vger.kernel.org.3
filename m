Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8B50BF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiDVSII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDVSGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:06:11 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E71183B2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:03:11 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7522D1220AA;
        Fri, 22 Apr 2022 17:50:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A0737122051;
        Fri, 22 Apr 2022 17:50:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650649825; a=rsa-sha256;
        cv=none;
        b=8I9cGt7utp0qYudqtrlv3l7xktwIfc6yyOB2IV/h872022P2XqRJrTQOLbaAWzKLBPIUOw
        UoeicfTChG7xeH/dEsZB1cY0nLKvvXvrn9C+x0IXTWjP+vhZNvKWykk3T3xosa8GMO2bUi
        KVvApk1JvDwhIresFQEt7lFaEIwNdv4UeEl8aZTsDmo5MzHM1hjmlAsML1FHgn/E8hDJtD
        ur2mkzHcc+P51KoVmtrbBGvCwxLZ6OTxXVNqMl73G1DNP7Se94iAv5oIk64DqMm1/QPRNs
        R7HUGvFynvuCAzmhnA5OdrLms8WoldXXDHAycnFxX5SccdDZ8TG4/FN4nrlkgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650649825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=RHwqhjzw9kY1izQs5LW3PnhhQu2A406gGRiwnqGFZvs=;
        b=rHi3lHfrKtkw0lZ2onlfsuDrW5tVUPfMfBZHKx2D9XzdUurDtTdTUWb5UvTNbqueip+0D8
        fv3pEqggv4JGFoqQnLAW70LNB2lA8tnPfxgQ4vTCHJXs3lC92LnA223DDqA4H1yYvzWnoe
        i/irepkK/xd4xbNIXl4IZAp6U/m9EKI2sIlfjTDKHeak9B6IABlqDjKikOmJs0ux2+VqjF
        sNLzm+M58e/KuXej+6deEASYDxkywcsVMJA2vrnhd6eyL8zprGX9KQ0nK3MeJtT6M/BYiP
        Zp3S75BtHtlFqivn6qlwNfdz8tOCdgcni+35zp/iSIZLX8sqw5CDCv1EF6Hgpw==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-z8ctt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Gusty: 25050b6960b79646_1650649825247_3516390020
X-MC-Loop-Signature: 1650649825247:984435976
X-MC-Ingress-Time: 1650649825247
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.149 (trex/6.7.1);
        Fri, 22 Apr 2022 17:50:25 +0000
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4KlMPp6fCCz29;
        Fri, 22 Apr 2022 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650649824;
        bh=RHwqhjzw9kY1izQs5LW3PnhhQu2A406gGRiwnqGFZvs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YaHDEWSULS/cT2SSarbSX8MPl2aqFaMXnfW6jCS8H4GsOmyJ2d0zeuPoe5L3mDSsM
         c3/1IgCORa1jHkINI2jRKgt5HPnedwWQRNEfTyWkzav2DDY1Uqmo49msmd1nZkrQr0
         +TniIOUhbLqPYUJmurz7U5lNZ/B6v4w5987yfPsHltKfntXecYHw7DZb+x3rCfWcz3
         gdKkXd9/NS0F4lJ2bPk0J0vrIJNUu4NvEUPAZ/vXN+W8Eui7nU5eqU4pdRO4oNtglV
         lyv/Y1RwM3mMON3bBHwbpWMD3VYXNITNaOsf7aMlkKCPpfCu0AoaZ0vnicCbfz9CMx
         8f4nnS18GZPKg==
Date:   Fri, 22 Apr 2022 10:50:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     jvgediya@linux.ibm.com, ying.huang@intel.com, weixugc@google.com,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm/migration: export demotion_path of a node via
 sysfs
Message-ID: <20220422175020.lm2xqbg7lm2tr25r@offworld>
Mail-Followup-To: Yang Shi <shy828301@gmail.com>, jvgediya@linux.ibm.com,
        ying.huang@intel.com, weixugc@google.com, linux-mm@kvack.org,
        mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220416053902.68517-6-dave@stgolabs.net>
 <CAHbLzkruFaKF_92w2qsZz4sH24C-TARXaL-byT6doVVe6VQ4Zg@mail.gmail.com>
 <CAHbLzkr4w-20H11uNrf-9ZJd=oHGTXTatd5OJ0JAO1KwojySdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHbLzkr4w-20H11uNrf-9ZJd=oHGTXTatd5OJ0JAO1KwojySdA@mail.gmail.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Yang Shi wrote:

>On Fri, Apr 22, 2022 at 10:31 AM Yang Shi <shy828301@gmail.com> wrote:
>>
>> On Fri, Apr 15, 2022 at 10:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>> >
>> > Add a /sys/devices/system/node/nodeX/demotion_path file
>> > to export the possible target(s) in node_demotion[node].
>>
>> I'm not sure if you noticed that Jagdish Gediya is working on the
>> similar patch, please see
>> https://lore.kernel.org/linux-mm/20220413092206.73974-1-jvgediya@linux.ibm.com/
>
>Loop in Jagdish Gediya, Ying Huang and Wei Xu.
>

Hmm I had missed this thread, I'll go have a look.

>>
>> It would be better to combine the two to avoid duplicate effort.

Indeed - and even more reason for lsfmm discussions defining the
future ABI for tiering.

Thanks,
Davidlohr
