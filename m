Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F307954ED02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378652AbiFPWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiFPWCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:02:13 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F755F244;
        Thu, 16 Jun 2022 15:02:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0AD845A112B;
        Thu, 16 Jun 2022 22:01:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 567C65A1148;
        Thu, 16 Jun 2022 22:01:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655416916; a=rsa-sha256;
        cv=none;
        b=gAlM3pEvYGb+PcujE0VemFbVMF7b9AI7F4yX8jjgxtg+p2s4dkNsteo/9Hgve8rZK+w5Jg
        SoakfLY0MNysMbCRQ7QdmOMdT/KbClv9+KDu1xT1RSZ+jdiIFIFQowlLNLoOH7SDzbckKA
        kWifN3WF4/d5Ok0RkFureOGRwiaOXZCHe8+7hLo0yMJcxgjoYjgt4CWIongQ17ET5ZmrBW
        eCs7knRQ6nH1ovAAUigtBTpht/66aOwobLY7ptROXZvKkcmIS3/RArcVcCIyGVZySNET7f
        N0TQt1dULZ0wIfLCzSE7PkO2QHq0jjchL0Wn4edi04g3KTAPMC3+hQTv04yo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655416916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jaV1cEWlUUbavbepQJk3fTL3IGGiH6h9qUmoQS9HXgc=;
        b=XqtOTKf0Jl+v31ljUedtvGEON7VzggbiBDM992L29xZkqdXIJoEm4j3AZZ8755lkrr6VXm
        +dfvOb2hQ2PivUh8OjKn91n+ErnXo8OLgoRjvdGoOOYVQ3izG0ETMvCpD7RaqbVBoc2gMo
        aTGV9KuZqDq8aWbRts/zS3MEwDNd9/8pF1cYg5D7/zmmdU0GJIMHxWfX49d3e3mavGOBm8
        2KO2ATWoXfhYgRKo8bmBPGGB2nWXvHZ+F+evdHjwPs3deDWUEs3bNiO7nbPCmvL51q5unK
        0YM54a4fof3loVia+1IGxoKprrJPxX8EcDzd5EkrdHUtjdgt1eSh7kXkFrh8/w==
ARC-Authentication-Results: i=1;
        rspamd-848669fb87-bl2b8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Shoe: 2eaf72531c924813_1655416916834_3785307436
X-MC-Loop-Signature: 1655416916834:136269040
X-MC-Ingress-Time: 1655416916834
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.242.216 (trex/6.7.1);
        Thu, 16 Jun 2022 22:01:56 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPGNg2kWPzCY;
        Thu, 16 Jun 2022 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655416916;
        bh=jaV1cEWlUUbavbepQJk3fTL3IGGiH6h9qUmoQS9HXgc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=aqRmcH8KzSI7ZwcAWtBdznhQpmvxDDyeIXi2DuM4bW2swPLHqF53Q751KOqUOC1PC
         zv0ih4Uk84EDRPvqObVwxs87fTA3bqoJnbTv6FOaQPwbIUWrhdRvkzRRIVnLzDePY1
         7C+MWSFhYJ9sYRsDNIpBiE1YnJ7CA28xwt9LxKf/Dy2/Y3AZ3POE7nyo/GPswkla7M
         cFjuSIJTh8wIpBjPi55yVACug6TqQqgUOLoM1JW9K+08CeNnD1SMTdBrfYsVhIsTyD
         xzSWVg4xSM4QUnGl0yahe319uK5xsKYJhfviO7t04Upt5e3aQz/yf8T/+Ax9nLto8l
         vE8UduBmSN/CA==
Date:   Thu, 16 Jun 2022 14:47:40 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220616214740.7pyjagx3gosni7mw@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220616194334.pvorvoozt4rrzr66@offworld>
 <20220616203400.GA1529208@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220616203400.GA1529208@alison-desk>
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

On Thu, 16 Jun 2022, Alison Schofield wrote:
>I'm headed in this direction -

I like these interfaces, btw.

>cxl list --media-errors -m mem1
>	lists media errors for requested memdev

But in this patchset you're only listing for persistent configurations.
So if there is a volatile partion, or the whole device is volatile,
this would not consider that.

So unless I'm missing something, we need to consider ram_range as well.

>cxl list --media-errors -r region#
>	lists region errors with HPA addresses
>	(So here cxl tool will collect the poison for all the regions
>	 memdevs and do the DPA to HPA translation)

I was indeed thinking along these lines. But similar to the above,
the region driver also has plans to enumarate volatile regions
configured by BIOS.

>
>To answer your question, I wasn't thinking of limiting
>the range within the memdev, but certainly could. And if we were
>taking in ranges, those ranges would need to be checked.

My question was originally considering poisoning only within pmem DPA
ranges, but now I'm wondering if all this also applies equally to volatile
parts as well... Reading the spec I interpret both, but reading the
T3 Memory Device Software Guide '2.13.19' it only mentions persistent
capacity.

>
>$cxl list --media-errors -m mem1 --range-start=  --range-end|len=

I figure this kind of like the above with regions being very arbitrary
and dynamic.

>Now, if I left the sysfs interface as is, the driver will read the
>entire poison list for the memdev and then cxl tool will filter it
>for the range requested.
>
>Or, maybe we should implement in libcxl (not sysfs), with memdev and
>range options and only collect from the device the range requested.

I wonder if the latter may be the better option considering that always
scanning the entire memdev would cause unnecessary media scan wait times,
specially for large capacities.

Thanks,
Davidlohr
