Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D97505D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiDRQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbiDRQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:59:06 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E3C2DF4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:54:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C10FD820C0A;
        Mon, 18 Apr 2022 16:45:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DDF1C820A27;
        Mon, 18 Apr 2022 16:45:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650300308; a=rsa-sha256;
        cv=none;
        b=cyyQ+JSYoXJyjM2Ws0QKaUM1dGyzFqXsSCvkwYc550j2MJ3BkhEWHD7IoIA+Ge+CiH2BOZ
        ntIiFuwhnuADdPnu9irQldc2Jen0rjhvBNXHyCpG3PEnaX8kVNx2RyS/oaZbPYJ/Jsq1if
        iul6AVqS+QtOWGLQdWQA73bTBdRxs0NyPaXeZ8OJM1JJnZ2/hI1EB2uehs5aL26sgisTJh
        y5rlAEFITavdHxb0T60kbmfNwoVleI7np+lUOiHcvVd/94cBmJZuO2UKiCN1FOrzhTwAue
        iX0Kfrf2a6gT5AziHprtyOT45tIuyI7MuCUcnWPxsy48JyT0rsB9Mimu8utf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650300308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BMeE3theriLPeHe7OsqT9QG1VfC7A6W9rVpn1syfKUA=;
        b=dHwCsVeIZYfExOX0wY9yHnIz3FKYSqPZgzf4hdHQzAGFwIPq2jfzkOIR2tmZOF5YSJtts7
        g0CE+G7kNVcqLAgul++tllb0ijhTjJYIrjew6gMRjee/FOeI+MuQ8QfLst2yfJIwnvPSQc
        i/S+2D3wtR8k6IjVhir6Y68JqyT2slLh3UAZFflGjcjBoQU57W5bD6I95WNo4k3S1zTH+O
        XoRst9PN0oUjUTxKYFbGsTTvDAJvJvpC/gyKOwAlB6INfholvPRKNDEGLqbrOH6n7BW3NI
        ODshuNFs8UYAw8V6T2OxjDbITE2mZC9xySrfD3D/pQmJGKgjJaMWy0XhxXQGQg==
ARC-Authentication-Results: i=1;
        rspamd-6969874869-45jtd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.25 (trex/6.7.1);
        Mon, 18 Apr 2022 16:45:08 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Trouble: 2c2a24835007ca77_1650300308401_362394076
X-MC-Loop-Signature: 1650300308401:1218719460
X-MC-Ingress-Time: 1650300308400
Received: from offworld (unknown [104.36.29.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Kht8L4SLTz1QS;
        Mon, 18 Apr 2022 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1650300307;
        bh=BMeE3theriLPeHe7OsqT9QG1VfC7A6W9rVpn1syfKUA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=P+8d01HVOoeXDKa157TzKSvtsBjKR7DCshqwRA8ybsl6Hix/9wm7F7nhu7sAWC1MF
         CJQ/L3xuLnFtOXn440u6xjaVDJVWhy/u9iwZ1zu/8+x1MuSRX5YDMDo3VvtJqBlisI
         BTywpOC5EOqLwQwpzeBfk75A91cETxE+jkVAUdjnlr1VMyHaFpOeHu3tTGPeUA8fS7
         b/UE3WwBE531gJTJUfGzrbFg+OIYnFQIuJjXv+KaFvlKuZSaFNmasKR1Pur9T1+8MJ
         y9qcDSQC/xnPcs+YjGNjMSNpl2Dw4LYBwYkadXtYTfPvu5EbphdCQNzIxVDnBVrwfF
         RtQCVezcQwghQ==
Date:   Mon, 18 Apr 2022 09:45:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        rientjes@google.com, yosryahmed@google.com, hannes@cmpxchg.org,
        shakeelb@google.com, dave.hansen@linux.intel.com,
        tim.c.chen@linux.intel.com, roman.gushchin@linux.dev,
        gthelen@google.com, a.manzanares@samsung.com,
        heekwon.p@samsung.com, gim.jongmin@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mm/migrate: export whether or not node is toptier in
 sysf
Message-ID: <20220418164503.jfips3aiwhnlfjrq@offworld>
Mail-Followup-To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
References: <20220416053902.68517-1-dave@stgolabs.net>
 <20220417034932.jborenmvfbqrfhlj@offworld>
 <c1475d8e-3ad6-cdab-5cc9-b44fef998636@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c1475d8e-3ad6-cdab-5cc9-b44fef998636@intel.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022, Dave Hansen wrote:

>On 4/16/22 20:49, Davidlohr Bueso wrote:
>> This allows userspace to know if the node is considered fast
>> memory (with CPUs attached to it). While this can be already
>> derived without a new file, this helps further encapsulate the
>> concept.
>
>What is userspace supposed to *do* with this, though?

This came as a scratch to my own itch. I wanted to start testing
more tiering patches overall that I see pop up, and wanted a way
to differentiate the slow vs the fast memories in order to better
configure workload(s) working set sizes beyond what is your typical
grep MemTotal /proc/meminfo. If there is a better way I'm all
for it.

>
>What does "attached" mean?

I'll rephrase.

>Isn't it just asking for trouble to add (known) redundancy to the ABI?
>It seems like a recipe for future inconsistency.

Perhaps. It was mostly about the fact that the notion of top tier
could also change as technology evolves.

Thanks,
Davidlohr
