Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3B75A73DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiHaC0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:26:22 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C197D1D5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:26:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 31D9C501C88;
        Wed, 31 Aug 2022 02:26:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a286 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A3086501B81;
        Wed, 31 Aug 2022 02:26:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661912779; a=rsa-sha256;
        cv=none;
        b=qSs1sFZR4x8DIgQbdNLouiQsjxWBaa/BVIOL4o13VFGqjSoXEIVfFDkquzFQKukmriQElW
        9z54LfWTt7mgih6F4ghqCyFpL3SX7b+1HYQf+0xEyjxD4ofetRPLaSWsv4bkizJmW3PYHT
        3JsAI8R50EYsjfWe3HJKo/J8oBulvZ9eXrY2MLg6IXSIl/xEeqvfwZo0k0RAo5e1DrBpnR
        J4KEE4J04yZwowFlWdqu6hSIcDy8WRe4+cskngWvTYf7jQKMK9lRSdaMcZv9IzLWiD392l
        bJ5g7ImLVWdKnQGmuVPXIADR9pKW2TL2wx+v2xtpx7lc1dntj6jTmnEbY5uAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661912779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VvE4ZsdvZLF5CYxD7ACa9PoJ5fs9o6RjEP34R3OhrvM=;
        b=BEGQaOf3HvurQOiX73k5YtM9dt3Vmx+cogUrzpfhpMOaZGqtkaKaz40qhQEUmMwh1kP7zL
        Tz6XkGtTdFDSxeFAVMcSR/zMsK1WHFWCZH+f8FVF4g2vV2IgycQOjhu4pPbuZNbejZo1Bv
        O0xSwkuBcOWQEbnoylWkQEA/ZxdQlaoSx4pyUrbCrGXmgei5PnShab8fXNDvL+cvibKWIx
        9SMtCBIkh7CpJFQM78ja3NnO+5WmHH4/YBI6d/j01RD3uq3bxKUgmMxDezKCj75e1gKLqj
        4NzHaQLX45OJWqSvgPA7HN9Qa/3qn5o2v030ZGBg2sr2l6uLnC+AnjtsoCjOKQ==
ARC-Authentication-Results: i=1;
        rspamd-75b4464bd-rh2ch;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Celery: 38020fae0cd0ad55_1661912779929_1465910556
X-MC-Loop-Signature: 1661912779929:3545059006
X-MC-Ingress-Time: 1661912779928
Received: from pdx1-sub0-mail-a286 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.194.207 (trex/6.7.1);
        Wed, 31 Aug 2022 02:26:19 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a286 (Postfix) with ESMTPSA id 4MHSj65wHfz64;
        Tue, 30 Aug 2022 19:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661912779;
        bh=VvE4ZsdvZLF5CYxD7ACa9PoJ5fs9o6RjEP34R3OhrvM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bgYZc4Ao4NxtQjmSpP0BhPKMuGvW77xWe/3Dt24MuyG60fp53n1oMfjHzhvbMWDLJ
         b1RaTNKBMpJhhC58tHwVhJqbG6vHdaRW5vbAKw4uH3YRRSj20h5t7I5W9OC1Q4MszL
         sEYZesz2+lZD3O3K9zI1LIg0wkHdnLmxPEIjaPRBWlql1aZ+hoAjsSMxrusplAIpuT
         AwPCpYbHtMokS8O+rIYCj+qA6XGY+sikNVxjyj3j1piZykoNstQ0VH+s5pUDk2SQwk
         OVJmFtPqklds+bgIM1tBFmR/4YxyDXnQyUER8gGxoS/8HcuHZvWZ0MqbTt/euefDjy
         RGsF5pGcq5pJQ==
Date:   Tue, 30 Aug 2022 19:07:49 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v13 63/70] mm/swapfile: use vma iterator instead of vma
 linked list
Message-ID: <20220831020749.qezg5hp2udxzqtg2@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-64-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-64-Liam.Howlett@oracle.com>
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

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>unuse_mm() no longer needs to reference the linked list.
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
