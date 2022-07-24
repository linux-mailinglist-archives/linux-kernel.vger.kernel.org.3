Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DB57F373
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiGXG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGXG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:27:09 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB2515734;
        Sat, 23 Jul 2022 23:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658644001; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=bE5xPB6jxL4xW1OSm5rFtjFt6tumzAuXa1kLh2lAxAAf4n1UIe9GchBqabSRR3dTlNncUNJu0T+Wat4OxdsgHSXggSdJ+y8LUr8VFNe+oIwROV27eGBYzspJjBNLbrabXscxJqjQvWHkUxW06U9FdpePB38JPsh0dvI/fzvqRjI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658644001; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aGJ0CXyaWm70yTn7h1FhEs2yfwa2cfoyB+ojuLdl9m8=; 
        b=aO4Da+iR4l2Ki1Woq2Dwi+7lzsa0kj4hPoHhSVkHER4g9dOwxPVxmfUSqxD3YM4nBe2wBZkamGdEo4tfQVmVUTcz0oJuwS13U0qogru/hbMjDj0m9TKOSAIq7KcIGBIfmNCmsP194yeiMQqx8GDI7mQNt1A7QwXCn5A4JYNQwgs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658644001;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=aGJ0CXyaWm70yTn7h1FhEs2yfwa2cfoyB+ojuLdl9m8=;
        b=UydNUJQJEwmHbTaIz94cy7ff9g5G5p2OmON1a0Nkrs+2VC5Ajb95lqCR2v9qr69h
        sYJjGVivxcO+QNU6gw6X1ZlN6I0vRVR+k5fvF+XVOEWo9maMq2TrwhFVmX+vPVp/IQb
        SfG9yLrqX/L3rIN6yLxCQqrg1UOnt4apLapeuXpc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658643990042354.56937268623744; Sun, 24 Jul 2022 11:56:30 +0530 (IST)
Date:   Sun, 24 Jul 2022 11:56:30 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Hillf Danton" <hdanton@sina.com>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <1822ee2c605.4a717678627753.351372059135065111@siddh.me>
In-Reply-To: <20220724052426.2504-1-hdanton@sina.com>
References: <20220724052426.2504-1-hdanton@sina.com>
Subject: Re: [PATCH v2] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jul 2022 10:54:26 +0530  Hillf Danton <hdanton@sina.com> wrote:
> According to sysbot's report [1], what is proposed fails to fix the
> reported uaf in the scenario below because of no wqueue->lock acquired
> in the post path. Despite of defunct checked, it is checked after taking
> pipe's wait lock - a bit too late.
> 
> Hillf
> 
> 	post_one_notification	watch_queue_clear	
> 	===			===
> 	pipe = wqueue->pipe;
> 	if (!pipe)
> 		return false;
> 				spin_lock_bh(&wqueue->lock);
> 				wqueue->pipe = NULL;
> 				spin_lock_bh(&wqueue->lock);
> 
> 				pipe is freed
> 
> 	spin_lock_irq(&pipe->rd_wait.lock); // uaf reported
> 
> 	if (wqueue->defunct)
> 		goto out;
> 
> [1] https://lore.kernel.org/lkml/000000000000aa07b205daba6d49@google.com/
> 

Before post_one_notification(), in __post_watch_notification(), on line 228
wqueue->lock is acquired (using lock_wqueue()).

The comment on post_one_notification() also tells that it should be called
with wqueue->lock held. So we do acquire the lock in the post path.

The pipe is freed after the execution of watch_queue_clear() in
free_pipe_info().

A side note: Your emails don't seem to pop up on lore's LKML archive. Maybe
check if the email isn't being blocked?

Thanks,
Siddh
