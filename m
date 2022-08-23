Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B319159EF63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiHWWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiHWWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:45:57 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A2B88DCF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:45:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7534C3E0987;
        Tue, 23 Aug 2022 22:45:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9F3F73E0A1B;
        Tue, 23 Aug 2022 22:45:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661294752; a=rsa-sha256;
        cv=none;
        b=u4bNRxIUmZk7aF9jWHaGKLjZlZgNYF6CRnhBWlZ+UPrl4FftbdNNYa4vfoPlNJ4ez/CEFq
        feE9lBRSlXDBWJ0A8qwvk7UDS9YQKsJEo2wpDshUdtyOVhy0u49+aCkrH8OhZQ6+Z/dtgC
        F9BUzIAbXmN3UK4bthS1+xjnmjnda9z4qg6e/xi6c+O7qhm7cuNV6FkfBVQZBBG7YIAgP+
        tFrMWUJRpE5TbKMfyMEOiNKUAAe5K/xSvTw/dCd5eDZOW/+Qxr8ii1+BkI+EcERbqIlzYC
        L1h2cZ74J1lhc2gbciPFL/vkC/Q6FZwkg2FfAiipZxg1+/Y0lX8NLVsV5hg4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661294752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PEBSasmgg/6BVDCQaXtcCu++zDN+LuETOm83M4+x2yY=;
        b=KGmcrXO68FCQG+abb+y+ne91dJVvoUinmMqYVbPgGtGUOpwA7BYAi4FalEKrqRC2P2K3kh
        rJ70qR84Tqy1VVp6UZApnKoyS2z9vnmbrXTs83nABQInsZke7c/AOLStZagBCYtTHB/UID
        lArGsKi7llUXkctaI03eGhNQVdmxhXmJNcT2XwnCKG05FKOgkVxHZgSnUhEjsJwKikCdWR
        8ef6zycL5LGYjIyDhYsiE2nOe79tGiH6wf2KSu71Y5U3vJMRdq6G1ZlJaJacb8zzOEd5hp
        9nXUkesgW00+yIGbp/XmjhfhkPWZ04h2/F4MbIKmtizGIWG7UeCMThdvlWeg5Q==
ARC-Authentication-Results: i=1;
        rspamd-5cbff9fff7-gmw4l;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Shoe: 239145552e2697b0_1661294752943_3545556701
X-MC-Loop-Signature: 1661294752943:2020262021
X-MC-Ingress-Time: 1661294752942
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.194.202 (trex/6.7.1);
        Tue, 23 Aug 2022 22:45:52 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4MC47w3VgPz9d;
        Tue, 23 Aug 2022 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661294748;
        bh=PEBSasmgg/6BVDCQaXtcCu++zDN+LuETOm83M4+x2yY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nQwgyV4a+C8T57rU9aSJxRv47rUZYKnK0J+qJmN5HvAX0b1JNGlAAK0fgLVl8oOhq
         cuHiV6Xc7SsQbCkNQehQtzzHbgZVYgNTH7p5dv17e8chAaSsWEeDHZNpIf5sA9+SLU
         6A1Nb38f12QGJVvl8bntg7ZEuZKVwEuPdq3DDVfORaXTctveWBvG758n1HL3dxVpJ8
         /mXYpiVDWDFjRKzb1qrsI/Rpa0p+7UfeX07CYkeSZM3vUrQON2m92UhpX1cYegOniU
         p71MsOTvtWJnhuMt1SD1Oh/KchoeqgC4qaPf1ziwQ65km8RuzhFu3avIUQoGg+P5aH
         s9C7vsF+9k29A==
Date:   Tue, 23 Aug 2022 15:27:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v13 31/70] arm64: Change elfcore for_each_mte_vma() to
 use VMA iterator
Message-ID: <20220823222743.h6nykigrg4pcrosw@offworld>
Mail-Followup-To: Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-32-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220822150128.1562046-32-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Liam Howlett wrote:

>From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
>Rework for_each_mte_vma() to use a VMA iterator instead of an explicit
>linked-list.
>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>Link: https://lore.kernel.org/r/20220218023650.672072-1-Liam.Howlett@oracle.com
>Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
