Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904E058A1E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbiHDUYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:24:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47224F3F;
        Thu,  4 Aug 2022 13:24:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E01DF122197;
        Thu,  4 Aug 2022 20:24:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2DC311227E8;
        Thu,  4 Aug 2022 20:24:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1659644652; a=rsa-sha256;
        cv=none;
        b=cl7Qi306JD1M0ooZ2n83zg5XhGq3ose6LdH/N6pAEKLMGt9049PXTz47jTIuXdgCPvpcBI
        +V3nTs4sDkkZZF1LWLcB9XYYx1wi7oF8nAegMeRwsHE1wyysqxq0IUUXhYtoOnNMeUqPy+
        kh1mdszt5beJKRnq0z4Ziw3iywO85u2+T+T7GE6f6qr/26lM6ifuIdv5Detmk5l/kzVcCh
        hi+fVOMyt8euLYMUaWXkiomXRswqfmD4sqyK/mLpm7Fpi/+u4hnKrT96t26i32A521vgEN
        T2jra7CHYJWNC51Zb7Jr1m0GLyT+q23sZeAYMHZEE/amqM/1W5ji3HUy14zwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1659644652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WBRF0vnWoHurswMbrGOZUJC1PZRlXwdU/Hmmt/4Lf5E=;
        b=FDDh8iF/kHbsoAE7t1rwhWb5YzJ42StawcWomDuP0d7/9H+7jNW7jNYk7SqyK9zroVwy2N
        NUBz/aoEqqMcok8PG8AruMW/y5IVy7MEpd8SVwAZLm9DgFLoY2ma/0VDwXC6QAiWmbeYVP
        6TbbYtTxrTI1yR8CVod446mRnx5WppOiW0V7SA08flk0GeAS4IhANvd63H7ER0SCF1cWKr
        U8MRoby8MDWcTiDsYPv6g60y8u0XHCKlzO6cYkraS5auWKQ9Fvyr5ZaDQpB1odxOx1TiNz
        nm8XcKrvSgejUSVmPveeeDu0n0dSvPTWrJ2RC1sp30CtVIP2nrzFHCXn86Gupg==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-lg758;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Continue: 2b799cd46d0807d6_1659644652677_1024255301
X-MC-Loop-Signature: 1659644652677:361990002
X-MC-Ingress-Time: 1659644652677
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.119 (trex/6.7.1);
        Thu, 04 Aug 2022 20:24:12 +0000
Received: from offworld (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4LzKvH1JsSz1B;
        Thu,  4 Aug 2022 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1659644651;
        bh=WBRF0vnWoHurswMbrGOZUJC1PZRlXwdU/Hmmt/4Lf5E=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Ip5lZDCRX8hxmwjVXmWUCcvhmM20yBO1fIj5O4brfYYK28zflPCJT2yof6pXXzyWk
         ACApQi0IRX6qUuQ0BaYx0eyfBkjhlJKDCGxG0pIZlSQp+PJbavnVymnH//O1eSmiAA
         nau4jENL41DQL21LXg9qcVpr/Fr9s7y5naF7Qnk/dpgZJc/jqvIcZL2JQcewp04CG0
         4369Sze7lxjT3PxxFwd2HV54sSPIj5GERxg0MYLQo5HJlCeHpbxWfFpviniwrGWRb7
         /RE8rlgB62LIccMMPH9k9Z47B5J2cXJG9+TuqfYMVeHMV+VVIx92kZQdAysYC/RwjK
         3/p7pP1S3f3OA==
Date:   Thu, 4 Aug 2022 13:07:12 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        bwidawsk@kernel.org, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, a.manzanares@samsung.com,
        mcgrof@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] cxl: BG operations and device sanitation
Message-ID: <20220804200712.gaiswmkjsa3pnkc5@offworld>
References: <20220804045029.2905056-1-dave@stgolabs.net>
 <bcbe1db2-cb8e-1889-2888-f4618d749bd4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bcbe1db2-cb8e-1889-2888-f4618d749bd4@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Aug 2022, Dave Jiang wrote:

>From the operational sense everything looks good to me. As for the
>polling delay on overwrite, with pre-CXL pmem on Optane, we've
>discovered that overwrite can take a long time depending on the size.
>Sometimes MANY hours if the size is really large. We just opted to
>increment the polling interval as time went on [1] instead of based on
>size.

Thanks for having a look. Sure, we can do that, I have no particular attachment
to doing it based on size (it's just the way it occured to me). I am curious,
though: While regardless of size vs time based estimates, are the numbers
expected to be similar for volatile regions? All these numbers being from
nvdimm DSM docs.

Thanks,
Davidlohr
