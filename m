Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2895538896
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiE3VaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiE3VaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:30:14 -0400
X-Greylist: delayed 3001 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 May 2022 14:30:13 PDT
Received: from blue.oak.relay.mailchannels.net (blue.oak.relay.mailchannels.net [23.83.215.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2A986D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:30:13 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 93010122314;
        Mon, 30 May 2022 20:40:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2AD21121A0F;
        Mon, 30 May 2022 20:40:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1653943201; a=rsa-sha256;
        cv=none;
        b=o3eK0jyGSyhfP+gjp7e2bU0+JbjZS7rcl1wPj/CsEIOjgDjGUl2N1tgum7ZF0mPDUsa6/X
        MR7bmxs45y3bmdXH3w3SKt4SAbgqi6dF/8P/Z6EZQ4EEtpMEooZLq2Tqoo/7EJilrOOX4k
        TDN91FVXtRWW2vA6O6j6wXxwcCrBfjRkJs8hke/9dwonpJfq4k+vabMHBqSwFDnfnEu4c5
        YYzJJ0gQoeVyEaSn/vwyMO7mt89QkrspbiyJxokilEpAzBiyC8VeFssmIH3+xiPkjEhVDI
        CJkIwT18Q92JrWEWqmxD70oVAF9WjqEO1X58dRy1Xl79tfD7zEmpMPB3KbpzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1653943201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+6cSYBpZDS32mSj8yS3fuze9FxP3KWL3wu/pxgIPKE8=;
        b=qwM5dLSsQbuz69Y4CcVodndU0j8MdqsW+XEX/HW27FekzWTw4q8wnh/XzafdhSCxzuZwhH
        gVHYJI6Oj3mgajw+Uv2NuZPxa68WEmWCJz/l4PKEH9c236JNMN1tZVD+L18HLfMdrVM/IX
        Dx/4qeYv6HxRFYmE9IwdP67upeZgMhUPyeCWsA6OOOLoLDu2z8TtMHt+6n59/bvrmghx3y
        OeD/iyP6ub0qsYLRf4cj4o7BbvuxWEJ0IewZ+RE1reJv2Q1Xe66eZWQ9m3FDFhMrQDSNKo
        2TZIFyZF7P/KFKGKPWoWq8Sb/FRApgwEJuOD/qnb2xWVFabUDeXHri5EyyO2Kg==
ARC-Authentication-Results: i=1;
        rspamd-77f9f854d9-l2v42;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.156 (trex/6.7.1);
        Mon, 30 May 2022 20:40:01 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LBnN02tGHz1n;
        Mon, 30 May 2022 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1653943200;
        bh=+6cSYBpZDS32mSj8yS3fuze9FxP3KWL3wu/pxgIPKE8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=KNChsDYpRVcsbfTO0Y35UGaUwSE9QTDxa9HMfv/58Miiqc0uYPivRfNjfTZ3omdOT
         vbAWKTCLAxOewmgZM3HUa4hiMahh/OgKSHxEMG3x02kMGCwM35RFe6tyiYJ6/1d4jr
         M7rFsNxqv+eSI62+RfvCLf2VtizMJzcfXkxVflnq+FNxfkegpqBckFAVJEU+80ffCb
         zi2H/Ja/DDLPJ4dyf1u3gyjN3XkVsHbfGRgT1b3DDpQKH4mOaEZiq3BeTnTEXzxJU6
         zuDYNiRkgAVoAbtl8wjE0hOrq6NqNL5N26g114Juv3Yyt2qXM5l6B+VC8zzOAAbudr
         3ukU9OPays4gA==
Date:   Mon, 30 May 2022 13:26:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Junwen Wu <wudaemon@163.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, will@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] softirq: Add tracepoint for tasklet_entry/exit
Message-ID: <20220530202642.q22urp5yl6pzdyqq@offworld>
References: <20220528144228.46867-1-wudaemon@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220528144228.46867-1-wudaemon@163.com>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 May 2022, Junwen Wu wrote:

>Usually softirq handler is pre-defined,only tasklet can be register by
>driver.We expand tracepoint for tasklet_entry/exit to trace
>tasklet handler.

Tasklets are artifacts of the past, and deprecated years ago. Lets not
add to moot interfaces. Everything should be converted to run in task
context.

Thanks,
Davidlohr
