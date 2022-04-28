Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00D513CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbiD1VEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiD1VEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:04:45 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A066ACA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 14:01:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E97536C1D43;
        Thu, 28 Apr 2022 21:01:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 451296C09F0;
        Thu, 28 Apr 2022 21:01:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651179687; a=rsa-sha256;
        cv=none;
        b=IhAyp+fDD0Ymfj6ckD7piAjibXf69cktlIiO+D3XRP5ahs6iYx8aKPlbiRzLgdmv0dXXin
        1190HyxrxzTPhqy4S9065x9Kq6lUWgiPi5pbQJLUECyg/3pyQpswTWA6dhOgXeqYvT3EID
        Qu2XDPCWEBj2GskTdr97DE8VLZNlRapCsz6RMOMTRSXZSpz88K1STS3uauWhZ9NpbkU0jW
        XQHdvY44LTWBXnDGpcYHhgKRapZvh18uuRS1abgka8LvwF3ruekxkqiGgjfx5LWcASEfEY
        V+iibYs/fSN357gORvmGvy7SEHsWKHVgtbyuz/xcGuS+rO4Dpk0Goc/SSfur7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651179687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/X2yWkGBPdmS9II6ZQ63eP0hzSBbs6CX/Rh+Gl/UVqY=;
        b=sidYiefsnP6I+9fwCpGvVXe9IUwQwTktkng9lGQ3ZF7UKcp6tCpURL6Hy4OXx743tMtuqO
        fLVirA34xQhtyx/6+0cAxBy73Nz399kGr8aQ58+06U6IsUtH1Ysb+WegKb/oLkT0CzwP5s
        uesToOTzSX7CA+5hTKA2p2AMg1C98rIiSDKUAuMfrqPXVKwEnRo9UV4IuiFoMuYWq/roDd
        80/TwqkpRiQLBA0pMZpGmlCKTeoJyPZKcDYbTzcd6du2o11QBP7ZODc2ZDk6BHtyvW56jn
        aKPVJh0tAOpSOTquxg5xvydPMuaGcsgWheMsiOaRUgNjlCzRJCe0kpF+uhLKnA==
ARC-Authentication-Results: i=1;
        rspamd-847dd8955c-chk46;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.95.124 (trex/6.7.1);
        Thu, 28 Apr 2022 21:01:27 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Inform-Desert: 3fe819401b1ebf62_1651179687590_356988341
X-MC-Loop-Signature: 1651179687590:3622499748
X-MC-Ingress-Time: 1651179687589
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4Kq7MT5Nwbz1fv;
        Thu, 28 Apr 2022 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651179686;
        bh=/X2yWkGBPdmS9II6ZQ63eP0hzSBbs6CX/Rh+Gl/UVqY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ANAwz6BZg4g/YN37eGi2joJcDpRDNxX/BUrtbYAydlrB1SBL5voZKGR+ES50iL/DH
         kCCQQW7yuTnwmVMvo8L+onlzyArEalE1ueSpfF2XOQ/iKie5iNJZ0rjOBHqDUA0H3m
         D7zCKJc52q9so3hPDtF/9YRG6hMiR4sCb+tXn0SkOpxZoJAGp42cxTZqLQvH9qu+JG
         lGnS4LlKymX7CxJwkOuB+XKLpMXolvibPECUwBUt7qYvjcw7JZNucMQIwVKi7+zzyf
         P7OZ3YypdCdTsAZagfFmfe1Ev+2AOCcog3lAdHUwk+Gv0yGEb8dmkPkfJ7wUozZGgA
         WY4lskAns0gyg==
Date:   Thu, 28 Apr 2022 13:50:01 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, peterz@infradead.org,
        manfred@colorfullife.com
Subject: Re: [PATCH v3] ipc: Update semtimedop() to use hrtimer
Message-ID: <20220428205001.hiuzwpn5emxtrh4s@offworld>
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
>---
>v1->v2:
>  - Use timespec64_valid() to validate timeout
>     and other changes as suggested by Thomas Gleixner
>v2-v3 Added Reviewed by tag
>---

The second '---' is not necesary, it's the first one that counts.

>@@ -2166,10 +2167,8 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>		sem_unlock(sma, locknum);
>		rcu_read_unlock();
>
>-		if (timeout)
>-			jiffies_left = schedule_timeout(jiffies_left);
>-		else
>-			schedule();
>+		timed_out = !schedule_hrtimeout_range(exp,
>+				current->timer_slack_ns, HRTIMER_MODE_ABS);

I'm wondering if the slack parameter instead of passing the timer_slack_ns
value immediately, we should do a rt_task() check and pass zero if so.
And the opposite for the posix mqueue case: bit a little more lenient when
!rt_task() and pass current->timer_slack_ns instead of zero. Of course mq
is a lot more rt aware than sysv semaphores, but that doesn't mean both forms
of ipc are not seen used with or without RT constraints.

Thanks,
Davidlohr
