Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976CD513ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353144AbiD1XEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352801AbiD1XEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:04:47 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1934C4036
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:01:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C55C42100A;
        Thu, 28 Apr 2022 23:01:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 51D3620F98;
        Thu, 28 Apr 2022 23:01:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651186888; a=rsa-sha256;
        cv=none;
        b=BO4NqlqCSaiXtx9c2q/wUqfXdwnatqmHnatbWdwxqls/4l9b3/ycqXVaJ7lVOEOyXOlD4K
        TtzQDldvFadzsyjFbWjgFG95v0S8yrEdbLjMvtMRaRmtaaiFvdYu7Sg+wwSFAQq0Gu63jW
        T+Ya/qHDKraENZCyvoBNo1H3xE99FQkRe+H1i0O5unHtQoc+TJFZ4xVUW4qxApcT/0xiNs
        k3rI0AOkKFgZqW18FnRmOSa5FVmrqS478QAknn1tt8Lw4yuE2fOA/vSD36zTYK0vcBRiQv
        W1oNiZXrdfP7kpCR8eZBZ20RJ7iIHaZzKMTqylGryU68nasYu0WFj56dn5Fqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651186888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vjYAnQTOe68YPTsKIi7cssU+yeRHQZhrNLp1AuuSurI=;
        b=fd6oj+vbxsTPW51Oefvq4AUnzWj4tR8plYEUAcZTkEmfi42gizwXzWVjNsd7Syc7SvW38f
        00up5ko8NcVoVCbCFRH6Wy+VTxbsejQ+2OFMmQtdYwWD8JU/agWiNqJ4KKaD0Jtcfd58Ev
        5sCZ9x2UxkfaqbVcrhy0gfLRF90+YrXPWcniahlyAUZbnXManDN/PhV9z4too6R51hnnev
        SWZ7ymjC/iXq8d+/Nb5GVscEth3XoAuidLw7mRexTsPcYKbZiOijzJv2Dj5LloAlHYy535
        GgnbK+A3lVQCdNFlPA6mSlggFJ93HL8DN1yB5gi6J2ghH0RVCE1VDixrMHVQbQ==
ARC-Authentication-Results: i=1;
        rspamd-fdd564cbf-868r5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Hysterical: 4188524533974da8_1651186888661_174020957
X-MC-Loop-Signature: 1651186888660:2618623120
X-MC-Ingress-Time: 1651186888660
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.113.195.69 (trex/6.7.1);
        Thu, 28 Apr 2022 23:01:28 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4KqB1z34sKz1ff;
        Thu, 28 Apr 2022 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651186887;
        bh=vjYAnQTOe68YPTsKIi7cssU+yeRHQZhrNLp1AuuSurI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=l0sJoKwgxfAEiAXAbE8JM7cLVjDCa6HEK1W/qeP9oJlaYxN0pl9ng7bdFYaHhztaw
         B1jLcK5CnOum+F3pu/qG/mv5IzrGLwmlkEraIz6Of6HQHDXgXddcd7RfSRvlzJaW61
         NWvGo0cuF1p+aCwqFExq6taVRr/0viNIR/y0FNNDnuB2c2kWA217bBOajVtoPoejGt
         P3zaucHAxjueICScmtjidZbhG7tYpmRqFzUh3jyxSL6RADsiv8CvPxuiiHPEnA4ctG
         n3h3FQ5yV1Y3K8kwdrYR8iK7r5TltSHfj6umVLA/UvGq/XVttziy55vYihhw05VF5y
         a8Jc4mY1gTLKg==
Date:   Thu, 28 Apr 2022 15:50:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, peterz@infradead.org,
        manfred@colorfullife.com
Subject: Re: [PATCH v3] ipc: Update semtimedop() to use hrtimer
Message-ID: <20220428225003.pszk3cbcp55kzhfi@offworld>
References: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1651178767-447-1-git-send-email-prakash.sangappa@oracle.com>
User-Agent: NeoMutt/20220408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022, Prakash Sangappa wrote:

>semtimedop() should be converted to use hrtimer like it has been done
>for most of the system calls with timeouts. This system call already
>takes a struct timespec as an argument and can therefore provide finer
>granularity timed wait.
>
>Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
>Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
