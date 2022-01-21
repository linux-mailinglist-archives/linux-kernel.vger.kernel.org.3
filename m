Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1279495E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380120AbiAULWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380056AbiAULWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:22:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD2C061574;
        Fri, 21 Jan 2022 03:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JAxdv7kT4Nsxroz5r4YBbjTvlv2EcfNPQL0h6dbIX0s=;
        t=1642764130; x=1643973730; b=MF8KcM/1G8nFzVjt2ZtHTdJlwTNPtIeOR+oErjQVqTOXiyf
        MLQZuVJJQPLfd5tCiCq4WzJqarFQ5I9AJlhTxLjDKCMhdtXWyyl4w5uvMv4IKDiMabv/mGMO6B4ka
        YDx5iKvzFcbRsFosXgkvp4sQMbOv7fa9pYiHjkzhtGa4KsSFg/MWXQJFoCoJ+Ktmd6vV7NeSM5LLj
        uirdqrH7aObdRRk7SLcTLsK8AbJH8miOxSqKqvpZoA7rnod1AZ7fesj51TdJvDhZjjU1ZGmgLU9gB
        GqPauMgzOUD+slN7HZ0UUNyr9Q6goJFz4rviUcQhCaM/QSLUPhY9Snrt/yF5ZOkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nArza-008Ti6-G8;
        Fri, 21 Jan 2022 12:22:06 +0100
Message-ID: <2d33846961e5d5fed80b94696c27be60ecbb11c8.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: mvm: Fix potential NULL dereference for sta
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     Oliver Neukum <oneukum@suse.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Jan 2022 12:22:05 +0100
In-Reply-To: <20220121111418.9144-1-tiwai@suse.de>
References: <20220121111418.9144-1-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-21 at 12:14 +0100, Takashi Iwai wrote:
> The recent fix for NULL sta in iwl_mvm_get_tx_rate() may still hit a
> potential NULL dereference, as iwl_mvm_sta_from_mac80211() is called
> unconditionally (although this doesn't seem happening, practically
> seen, thanks to the compiler optimization).
> 

No objection to the patch, but I think the description isn't quite
right?

static inline struct iwl_mvm_sta *
iwl_mvm_sta_from_mac80211(struct ieee80211_sta *sta)
{
        return (void *)sta->drv_priv;
}

looks like a dereference, but I _think_

struct ieee80211_sta {
	[...]

        /* must be last */
        u8 drv_priv[] __aligned(sizeof(void *));
};


means it's just an address calculation, i.e. the same as if we had

	return (void *)((u8 *)sta + offsetof(typeof(*sta), drv_priv));

no?

I guess technically it's still UB doing calculations on a NULL pointer,
but practically that's going to work.

Anyway, no objections :)

johannes
