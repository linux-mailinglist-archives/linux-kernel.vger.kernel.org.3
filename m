Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44F4B7611
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbiBOR2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:28:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239101AbiBOR17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:27:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF1193DB;
        Tue, 15 Feb 2022 09:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE64B61575;
        Tue, 15 Feb 2022 17:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3753EC340EB;
        Tue, 15 Feb 2022 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644946067;
        bh=9osc3hzFuzOFX+241F/uqhFA2Bcn170aOY5xY1mkJfo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KvR4ZiaujsDq4e2XP9eqbgzrBToKp9+wwyEvaGsI0+Xr0dxTvNBYNhMxJqUSfnQUl
         WpQ4+sugZbxYSpkmVQJXwYP8fI8xTrBeHoKWfdzaS7rkAkJAfdAteIY8XB3XqN6/2i
         B9iyNyen0StFaMh+6mhziG8RbCb+Z49B0LpdObDxyO3mabfX8hZJ4kT/a5rmzYJZA7
         RP3jMwzQ3XAVw6lU15mv5ilHRziUwwL28QGIFeh/gbnbzUbmEm0afvvl0UFD2OpXCr
         cIZ2O1Gl5oIR/STu48rwBDF5xfwBxzEK7i7JiV+2C1ZQUOvDZOAcEcYJeLaheDogYz
         rs5UcIhAwdMKw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push() (was Re: [PATCH] mac80211: fix RCU usage in ieee80211_tx_h_select_key())
References: <nycvar.YFH.7.76.2202151643220.11721@cbobk.fhfr.pm>
        <af6abf72593074c007fe42205e941dabfd08bf3a.camel@sipsolutions.net>
        <nycvar.YFH.7.76.2202151700540.11721@cbobk.fhfr.pm>
Date:   Tue, 15 Feb 2022 19:27:43 +0200
In-Reply-To: <nycvar.YFH.7.76.2202151700540.11721@cbobk.fhfr.pm> (Jiri
        Kosina's message of "Tue, 15 Feb 2022 17:11:11 +0100 (CET)")
Message-ID: <87r1849h0w.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:

> On Tue, 15 Feb 2022, Johannes Berg wrote:
>
>> > 
>> > ieee80211_tx_h_select_key() is performing a series of RCU dereferences, 
>> > but none of the callers seems to be taking RCU read-side lock; let's 
>> > acquire the lock in ieee80211_tx_h_select_key() itself.
>> > 
>> but but ...
>> 
>> >   ieee80211_tx_dequeue+0x1a7/0x1260 [mac80211 911c23e2351c0ae60b597a67b1204a5ea955e365]
>> >   rtw89_core_txq_work+0x1a6/0x420 [rtw89_core b39ba493f2e517ad75e0f8187ecc24edf58bbbea]
>> 
>> /**
>>  * ieee80211_tx_dequeue - dequeue a packet from a software tx queue
>>  *
>>  * @hw: pointer as obtained from ieee80211_alloc_hw()
>>  * @txq: pointer obtained from station or virtual interface, or from
>>  *      ieee80211_next_txq()
>>  *
>>  * Returns the skb if successful, %NULL if no frame was available.
>>  *
>>  * Note that this must be called in an rcu_read_lock() critical section,
>>  * which can only be released after the SKB was handled. Some pointers in
>> [...]
>> 
>> -> driver bug?
>
> Right you are, thanks.
>
> CCing Ping-Ke Shih; find updated fix below.
>
>
>
>
> From: Jiri Kosina <jkosina@suse.cz>
> Subject: [PATCH] rtw89: fix RCU usage in rtw89_core_txq_push()
>
> ieee80211_tx_h_select_key() is performing a series of RCU dereferences,
> but rtw89_core_txq_push() is calling it (via ieee80211_tx_dequeue_ni())
> without RCU read-side lock held; fix that.

I think we have discussed this before, but patchwork can't handle
patches the way you embed them in email discussions:

https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2202151700540.11721@cbobk.fhfr.pm/

Please resubmit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
