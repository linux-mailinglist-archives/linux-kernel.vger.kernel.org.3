Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71C4B70F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiBOPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:50:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiBOPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:50:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D20241;
        Tue, 15 Feb 2022 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KX0QaNd9nQ/9W6qY2LjL6AlOUaIrBsPYpTiS++NbNnE=;
        t=1644940236; x=1646149836; b=lwsCfGoJ6pms0JlWAcH2wGj+eDxDbC4ZX8IfCvSyFfzmOT3
        bbyLy9yULhjPdxdluYKQb1uM9A3Jms1eg4m6ergXU/WHZvYbz0oe+U9+Fk4Zv9F8AOOJkrNYI32Ik
        r6+wM+aD5COWK30s72pmlixL544J0lH4xYaZKbj5nLVHiqNCBnZNH6m3MT9x+7sBa3pQehr9tldQ8
        Y5Up38syxUnLCdSBZHnwk4jnc267TaOdxF/3zmDgdjxukMyS1lecQ4LzfCyQh7YFbdbilg0m79zhP
        Witl4bdziLetltIGNU+ZoVxpIYMAO5ngEzs+2GqmH+mEX9kisLOMSk81G6xUBNmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nK065-001ToU-Sr;
        Tue, 15 Feb 2022 16:50:33 +0100
Message-ID: <af6abf72593074c007fe42205e941dabfd08bf3a.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix RCU usage in ieee80211_tx_h_select_key()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Feb 2022 16:50:33 +0100
In-Reply-To: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> ieee80211_tx_h_select_key() is performing a series of RCU dereferences, 
> but none of the callers seems to be taking RCU read-side lock; let's 
> acquire the lock in ieee80211_tx_h_select_key() itself.
> 
but but ...

>   ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
>   rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]

/**
 * ieee80211_tx_dequeue - dequeue a packet from a software tx queue
 *
 * @hw: pointer as obtained from ieee80211_alloc_hw()
 * @txq: pointer obtained from station or virtual interface, or from
 *      ieee80211_next_txq()
 *
 * Returns the skb if successful, %NULL if no frame was available.
 *
 * Note that this must be called in an rcu_read_lock() critical section,
 * which can only be released after the SKB was handled. Some pointers in
[...]

-> driver bug?

johannes
