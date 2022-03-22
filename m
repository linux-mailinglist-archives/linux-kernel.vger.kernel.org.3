Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320414E3741
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiCVDI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbiCVDIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:25 -0400
X-Greylist: delayed 559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Mar 2022 20:06:56 PDT
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47939690
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:06:55 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 195B0800DEE;
        Tue, 22 Mar 2022 02:57:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a295.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 05E17800E65;
        Tue, 22 Mar 2022 02:57:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647917852; a=rsa-sha256;
        cv=none;
        b=OpX/wT83WSUgkwuyqo+AX183ZF64agEolIpgS5YaHhEw+K5Z5HdloR1lKnlVv6tLbessRM
        cgwpsu3lSwUJYEjZwzjLR+TWW2zvxqDLFMJnEsriR9WrnLyIy+yRrhFRGhktfzLWVBDbU/
        nst71cZedfBM0b354icqNabdXWG7ppuH53O67CUwlBuADn1ldo0cv3TffoR+mJcovapUok
        CTSdlHQC7biMgfqvsW9yEzja/6S6JJsrOyrcxnjfUYc79JP/qMaGpkthwXHk0JFY7C99f0
        jQfS5UzqyXU6VpUy6U0bomHKQcPzoQYpZOeV/K+jPHEsY2woRC0FSycbWtbpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647917852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SDRgY4hCcw5IyJP6ZI91B9IoNIRgIUTKVFMsD2qfdRk=;
        b=CuIXw+6epD9n3Q+3WuIKBbuh+kRU4d+NMYi5nnCcsDAspzmVy7hYMofjScXYZ7DmqBB14Q
        EXWzxT+genBBJaGYbIUY22K7LydDAgMIJ1Dwyx8/lJdBpfHLhagwmHcGyQitCGgmR+5hz4
        w6XMcXzk6lahpAwNlc5kbWSifSt/ERGHbe5SR+h7NeKFPFJ11wN6ZJjxNc5Of+o2BDtdQQ
        BOqxnwdOrY86JdjHx9E8VMheV1e8I9sujZm3rZTp8RGH1mIjwrsZd3ZmqRCQVpUwNlBWXh
        nouyDEr2B+ThmaRmTrve0Vl7T/ySxjEskJPwRC//jCgQO5zq4t8SdRCMWUcVoA==
ARC-Authentication-Results: i=1;
        rspamd-74bfb75fc6-dqqqm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a295.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.153 (trex/6.5.3);
        Tue, 22 Mar 2022 02:57:33 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Thread: 2b8b6da7311fbb33_1647917852452_1069914907
X-MC-Loop-Signature: 1647917852451:2066250030
X-MC-Ingress-Time: 1647917852451
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a295.dreamhost.com (Postfix) with ESMTPSA id 4KMx3s4gbMz3f;
        Mon, 21 Mar 2022 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647917851;
        bh=SDRgY4hCcw5IyJP6ZI91B9IoNIRgIUTKVFMsD2qfdRk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ZroK2pC8DsKo78Rr0oYJm5AKcTKhlJq8fuI5kDFImQeZG8OpdaZdgtMKnVF6YyeIw
         vrG7aUVDDlLMyK1Avt0J3Q3nb5MS6p3icwP/XxcWoVZ/zYN06R5q2gAm6Q5T1/4Agh
         iVHLtPeC0UrzHe4XtjIzYufm+YiL/ZjKh8+daF3Pg5UVC4Mm3vU29PYygc81DlKEok
         EVhVtf0F+HxuXufstBjni/DdzHFuqG70PIPcto4MzvpGBZSJlm0waWlG01tRHG2a1L
         vR4+5e9zq4dAnqFKobDNmRWctorBX6mci0CFpslaPGNzhbuyeyDDbqDd2YoEGerkYD
         /2R3fmoTk0a/g==
Date:   Mon, 21 Mar 2022 19:57:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Nico Pache <npache@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <20220322025724.j3japdo5qocwgchz@offworld>
Mail-Followup-To: Nico Pache <npache@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        David Rientjes <rientjes@google.com>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
User-Agent: NeoMutt/20201120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022, Nico Pache wrote:

>We could proceed with the V3 approach; however if we are able to find a complete
>solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
>working, I dont see why we wouldnt go for it.

Because semantically killing the process is, imo, the wrong thing to do. My
performance argument before however is bogus as the overhead of robust futexes
is pretty negligible within the lifetime of a lock. That said, the users still
have good(?) reasons for not wanting the lock holder to crash on them.

Thanks,
Davidlohr
