Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F214E35AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiCVAoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiCVAoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:44:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8CD19C07
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:42:40 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7D3792A0E2F;
        Tue, 22 Mar 2022 00:42:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 500AF2A0E60;
        Tue, 22 Mar 2022 00:42:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647909758; a=rsa-sha256;
        cv=none;
        b=hRnd5bcfFtJTKXhE8KQ/tD1oLxWQRI/S+Dno3Q6YPrR/3MRZbclNq3VSRzwZvbStfreQ0N
        aSRUAdzJmqAuUHG4WQvF4obMFq6ArO/OPupozxAJMaQiXCFg+lamllhtFexm5jmj7CHZYM
        pnyhETHJ9p1gPitRK6ar3Fe7Frt0ulhs95uU2Fc7zCVySuGaIoI0KY8FoJMCllBPDEY7BZ
        ZRteff+modLrIhrqek+uW6WpgN2zLamQ+8sqMB+TGmqV25LBMyj/3oY31QKapwEfe20l3O
        4YIXCkBcst0ulXCj84F0EamuN9NIihKUaJjEuOJO2J0T1ukTZFW4ZdV7T3F6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647909758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vPZbW0GWJzQANezJo4DlrrqJ9SbpG6UBsaLg8t4cDOQ=;
        b=iq+4iOMGB61ZGSQ0ERIUAOoliul7JkaVUEXGutuxXapecPAw3nRbY9dycO9tLAyOZoq6m+
        HfEaVlGnBaDYDHBnxNRlplb6iMnUUygvhT8cHAAWxqAhyu3I6ZTiykT8r0eI8uD5sYkfp4
        1qTsJVQwdgmi1b0O8IzcsK9zGjePIQvpkjIfOowNeY3OI1RNmSvcuy+VsjxceRJ4v8SS8/
        ++JtwQJ/NyR6r6xKZfjHZbdNub8vpXDxQndAD41DuQGfExeRaWrShjDVORRCrhPC2wtF9i
        90wv9ccIMJgcy4t501ut22Nc549ePqVr3eaSMe3CnkCVuzDe3T1ckvudEm0mFw==
ARC-Authentication-Results: i=1;
        rspamd-74bfb75fc6-c8rj8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.223 (trex/6.5.3);
        Tue, 22 Mar 2022 00:42:39 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Industry: 2f6040ef6efb8d8e_1647909759179_1679096437
X-MC-Loop-Signature: 1647909759178:1934302358
X-MC-Ingress-Time: 1647909759178
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4KMt4B5Jk4z1D;
        Mon, 21 Mar 2022 17:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647909755;
        bh=vPZbW0GWJzQANezJo4DlrrqJ9SbpG6UBsaLg8t4cDOQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Qu34K8Fq/uFkX/LjMn1xQ/LwAdxrqsYN2DhwGt3efhaxPHnCGghxLgpVzXK0lpDLd
         h49eKoAXq9xQQ4bRff51lKUq8bodn/MxbZtBY6ADDCb5tRO0rBIyUEMrKODkvKGIr/
         i1ZwL9Bnj2HNSqHRGanlWriM83geflbxgtftEC26JONLJjKhXYAAYfA9zBhd9Z0MoM
         0g4V4ONsRlvjTEop0HgIKoUtXfWrVvjeFVO7nSuPE/hnUyJ83Z0jPNx6SXGQVAVz2P
         mZiVc8s61wsadXGuylP63xofHseElfG8+/910etxic/DcEs1M0Tx2x8Zq1XQkwN78z
         39x9ojleNc3gw==
Date:   Mon, 21 Mar 2022 17:42:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <20220322004231.rwmnbjpq4ms6fnbi@offworld>
Mail-Followup-To: Michal Hocko <mhocko@suse.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022, Michal Hocko wrote:

>The more I am thinking about this the more I am getting convinced that
>we should rather approach this differently and skip over vmas which can
>be holding the list. Have you considered this option?

While I tend to agree with this over a hacky trylock approach, I cannot
help but think that v3 was the right thing to do, at least conceptually.
Robust futex users here care enough about dealing with crashes while holding
a lock that they sacrifice the performance of regular futexes. So the OOM
killer should not cause this very thing. I went through previous threads
but other than the user base (which I don't think would be very large
just because of the performance implications), was there any other reason
to no just set MMF_OOM_SKIP upon a robust list?

Thanks,
Davidlohr
