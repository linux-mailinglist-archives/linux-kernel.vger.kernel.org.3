Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89D58B026
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiHETCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiHETC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:02:29 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3644D4CC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:02:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EAD9256188E;
        Fri,  5 Aug 2022 18:43:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 72441561810;
        Fri,  5 Aug 2022 18:43:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1659725021; a=rsa-sha256;
        cv=none;
        b=dSAjphovaKgRqgBmLW6LiKiJJ/7t50h4L45mzjroExD2IrYaeY0Vnfofu1HV4q3tlKvwML
        dBySxJTxBn69ZgO0yec9GlU4ljKK/7kbL3tVwaISLKAGx9tnmKrQJzyADIM5XRYD03I/ro
        rCjvDKW+FNtCRBXKTxUbbZntb5pDWMMBFVohEGoN6fE6FRij6naaSJUhibs7DWWLPntD4C
        zPC9h0CsXfeDuXx9JppszwwuQMHGkkxNP90EPKuyyAlt/UKWC3gwby8kpdwIn40e+uTVb+
        Ks4LK1Asl65k/869EoUiicR4ot6ij7l4YwiGdgtNfinQKTx97DUK72ZN1pKnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1659725021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=txcVLOHGhV2Wt2dre25z7H8dhI6acoihRqjMmhfZESY=;
        b=FDXJj4GJ1q1DU1turFDyUoQtC9hycDIU8HPK/uOrwzA/3sHq7ad708TDKMkJUCGiXlQ04i
        q33b5Vcp5cN3yvNW3dLAgprBoJXJwB3+reYre21hRxBdd8xx7RD3UoEDBAfqpGZIV8cyGo
        T7ONVjDU8kF8VxTxzC5HNrC1VhMLWNsxxN7B/MH4oO80ZKz8hioUVlMYfJOoX1hutq/py/
        LX7fSGPKuEM9qba8LEfSbgn23ynY1wV1CGs5FSc4PWrl3wEZBi1Ytf0Td8ZbxIup9MAjTD
        K094EyGKDc6Xa3qiox8MvmfaKotrduWJhFeNhZILzQ+ME7WPjRNOnupwzg9wwQ==
ARC-Authentication-Results: i=1;
        rspamd-7586b5656-2jjr7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Shrill: 42b4f8c64ac7c2e4_1659725021770_2147483422
X-MC-Loop-Signature: 1659725021770:2958581256
X-MC-Ingress-Time: 1659725021769
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.119 (trex/6.7.1);
        Fri, 05 Aug 2022 18:43:41 +0000
Received: from offworld (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Lzvcr5xXXz3m;
        Fri,  5 Aug 2022 11:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1659725021;
        bh=txcVLOHGhV2Wt2dre25z7H8dhI6acoihRqjMmhfZESY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HrincwiT+hzSIM5qOvZ4a6DLd/GZl56rwuQGvHjW2Lk8TIW+6VCHhLm5zcMgXWQaf
         5j5VuUvVYieMVjrH0uXeZ1xgG32rTlolGKbRI1mCylvBEjUTmhhYU+DKENfhlMKti8
         qsfmCPWDomQZfWcO/UBS5THfRQbmJETp82Qm7xp8f5yBi/gKrwpiicPyjulKdaCJut
         VbSi6A2uP8dGRqoLaIwv+a2ydtSTjmmdyXgdKrWMWck1o5XQoUs3eO4ze8nDZzLAhH
         o1eECm/V7CXH0Jt5miw4GH/QN3jmuNiC8q4e17Sjs4WeqCKIa4Oohr1/npMSyGvnHe
         fgF6pozEKdW2A==
Date:   Fri, 5 Aug 2022 11:26:37 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>, 1vier1@web.de,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] ipc/util.c: Cleanup and improve sysvipc_find_ipc(), V3
Message-ID: <20220805182637.bciu7eavmhxefsc7@offworld>
References: <20220805115733.104763-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220805115733.104763-1-manfred@colorfullife.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Aug 2022, Manfred Spraul wrote:

>sysvipc_find_ipc() can be simplified further:
>
>- It uses a for() loop to locate the next entry in the idr.
>  This can be replaced with idr_get_next().
>
>- It receives two parameters (pos - which is actually
>  an idr index and not a position, and new_pos, which
>  is really a position).
>  One parameter is sufficient.
>

Makes sense to me.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
