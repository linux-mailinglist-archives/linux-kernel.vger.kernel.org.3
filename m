Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E853A91B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354974AbiFAOYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355373AbiFAOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:24:19 -0400
X-Greylist: delayed 73029 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 07:14:13 PDT
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC01059C0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 07:14:12 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D7868C2C1E;
        Wed,  1 Jun 2022 14:14:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A6A6BC2B14;
        Wed,  1 Jun 2022 14:14:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654092848; a=rsa-sha256;
        cv=none;
        b=FsQblE5pGRUj4Cmb/8KKvDps7w0rl+tZQUJI5lCufljh0dM0HXhIsvyPPQUn15wZK85cm7
        yEbgG4mMQK2Ah5f1iBDGk8NomZOzYVRnb5qHtvH2ttUHZNOKEqIukcDc+GXbyfxK5RylNq
        wD8nZC/qgAMqJ4O1rlpM6rR1UN4U3HMIjXlVLDkCTag1fYAhfcwjfmlV2fRMpxWqYykT0t
        0HkL9cTFapm0bKz+PjKsALp8doVyxoiAinJA2YOA28Gz5OlGXMWFnvMt1d/IemEipUxskW
        whrF3jeYw+9g+HoBFgHDOM26RfMlxBUemvbN+7vVG+CmthHItRNNWQ6kuFMeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654092848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ekzYMHKdKV6fWrlgsf5nHAFuBaR41uhTH85pDwc86aM=;
        b=dI3dsR6MHdHs8xsTI6kAuSKMsc7QL4xJNRJrKYMuK6C7BDqzo3DIiFx5/hQ1BYDr7W7Beu
        cdhQK4IgnIoIibav4X3EIWfJUn56umT38MEIvhtnz7ViP6d2mpZ53P0XSag1+LCeapwqVc
        ulN/si/DXs4A8LVoztdUbgzNXeFFE3RJt1DAjTY0Q+RsfSGSZs30cQx6xH7cghGuNffaY/
        uXP6SKpTpjp2HzGgM9ejtTd/ck7No5ORU0pch6O+bSeNZHvN4tKRBim9FM4qYvAsZ1+bew
        O8JCz2Aoq7Ty96pM3KAwkFb8wIPRD7+NpbV7RTs1jF/+fo9Z8WhtBQmlEoLEQw==
ARC-Authentication-Results: i=1;
        rspamd-54ff499d4f-k7qd2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Drop: 407707ff4224a7c7_1654092848563_2814264021
X-MC-Loop-Signature: 1654092848563:3501004101
X-MC-Ingress-Time: 1654092848563
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.119 (trex/6.7.1);
        Wed, 01 Jun 2022 14:14:08 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LCrjp16SGz1n;
        Wed,  1 Jun 2022 07:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654092847;
        bh=ekzYMHKdKV6fWrlgsf5nHAFuBaR41uhTH85pDwc86aM=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=D6FSAiSZtTVR6H3x+GAyqTNCIwFSI1iTejQDf3r1dbbHHTFYAO+RRHoKMMqn33Z/T
         PryFfcXkgblB9trjhgoVHzckvhFGEkXr8cwN/Fz70DQQEs2T7Dn3NRTbNSWlwdUIVX
         SXWT8WmvJ/6GxBCq2ioXBqiDT89GN5MrQvErp9vZDboq2K4AywOcrVr30WkSLpUVI1
         0mID/lN0tUnnsXM/ogXIWZwgDnCm5BQZVdpD/wYlQb/lBC74oMKltG3CH2+bTg9tQ9
         xtL4GmQJ40Se6syhWCMN4D9ICt1LE0kSdO0ZIUPGZoI7qABhHEqkMKVPcjJz9TBOoM
         nWgGE7fXC32HA==
Date:   Wed, 1 Jun 2022 07:00:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ying Huang <ying.huang@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, Wei Xu <weixugc@google.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in node_reclaim
Message-ID: <20220601140041.wjszzmkswy4dkn4n@offworld>
Mail-Followup-To: Ying Huang <ying.huang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        Wei Xu <weixugc@google.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220416053902.68517-3-dave@stgolabs.net>
 <87h755dip9.fsf@linux.ibm.com>
 <61c47f98b4c0be1d5da5e097779412f9edd70753.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <61c47f98b4c0be1d5da5e097779412f9edd70753.camel@intel.com>
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

On Wed, 01 Jun 2022, Ying Huang wrote:

>On Tue, 2022-05-31 at 17:20 +0530, Aneesh Kumar K.V wrote:
>> Davidlohr Bueso <dave@stgolabs.net> writes:
>>
>> > We have helpers for a reason.
>> >
>> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> > ---
>> > =A0mm/vmscan.c | 2 +-
>> > =A01 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index 1678802e03e7..cb583fcbf5bf 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -4750,7 +4750,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_=
t gfp_mask, unsigned int order)
>> > =A0	 * over remote processors and spread off node memory allocations
>> > =A0	 * as wide as possible.
>> > =A0	 */
>> > -	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id !=3D numa_no=
de_id())
>> > +	if (node_is_toptier(pgdat->node_id) && pgdat->node_id !=3D numa_node=
_id())
>> > =A0		return NODE_RECLAIM_NOSCAN;
>> >
>> >
>> > =A0	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
>>
>>
>> Are we really looking at the top tier in a tiered memory hierarchy here?
>> The comment seems to suggest we are looking at local NUMA node?
>
>The code change itself is correct.  But it is an implementation details
>that node_is_toptier() =3D=3D node_state(, N_CPU).  And after we supporting
>more memory tiers (like GPU, HBM), we will change the implementation of
>node_is_toptier() soon.   So I think that it's better to keep the
>original code.

Agreed.

Thanks,
Davidlohr
