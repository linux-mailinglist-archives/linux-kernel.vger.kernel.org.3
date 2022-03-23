Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023284E55EC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiCWQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiCWQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:06:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932AB14093;
        Wed, 23 Mar 2022 09:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01B01B81F9C;
        Wed, 23 Mar 2022 16:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377EEC340E8;
        Wed, 23 Mar 2022 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648051493;
        bh=J6Jj3uWyZKjJ9PzohwOMwt8OqyngKpQ+spVUMeqUv28=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Nma3Zy9b+SImVRKKJ4m/jQvhdePFX4Ogdo2X7Hi0o2lZBBUA6DIa835nJbIwFSeJa
         k0KBST/EBjBw9icoS8QpUlxeRokAd+fFYxwcedzDkytHzdNTbHlh28YvrWXeNAAvg7
         pouH5z8cw0UuENpv5UVF/zZm6FTLYEvb5lrLBtH6Bc/ETVzFj0FyMzBkayQpG4WF4F
         HAk+9SPOxtyfjdFpliFkZTaSL2dtexKGPTVj1s+1U20bjYliqCMC/x2bSC6IohZwUI
         KJI4MhvmRaPXtw7ySwTEMdoMvRjFgwfP/Xe2ikFYCd0tSh4r4lwYOXwAYy94GY6hGf
         ftgMup5HN4aDA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-wireless@vger.kernel.org>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        Christophe KERELLO - foss <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v2] brcmfmac: Avoid keeping power to SDIO card unless WOWL is used
References: <20220323083950.414783-1-ulf.hansson@linaro.org>
        <51b4917b-823d-263a-2412-a4b17cb38420@foss.st.com>
Date:   Wed, 23 Mar 2022 18:04:46 +0200
In-Reply-To: <51b4917b-823d-263a-2412-a4b17cb38420@foss.st.com> (Yann
        Gautier's message of "Wed, 23 Mar 2022 14:20:36 +0100")
Message-ID: <87a6dgk63l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yann Gautier <yann.gautier@foss.st.com> writes:

> On 3/23/22 09:39, Ulf Hansson wrote:
>> Keeping the power to the SDIO card during system wide suspend, consumes
>> energy. Especially on battery driven embedded systems, this can be a
>> problem. Therefore, let's change the behaviour into allowing the SDIO card
>> to be powered off, unless WOWL is supported and enabled.
>>
>> Note that, the downside from this change, is that during system resume the
>> SDIO card needs to be re-initialized and the FW must be re-programmed. Even
>> if this may take some time to complete, it should we worth it, rather than
>> draining the battery.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for the patch, it is OK, and tested by Christophe (R.).
> So you can add:
> Tested-by: Christophe Roullier <christophe.roullier@foss.st.com>
> Acked-by: Yann Gautier <yann.gautier@foss.st.com>

Acked-by is used by the driver maintainer, so I assume you mean
Reviewed-by?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
