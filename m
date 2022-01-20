Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552F349525F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377016AbiATQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:29:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376939AbiATQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:29:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 260A62195A;
        Thu, 20 Jan 2022 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642696190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sW8ehN6Hzkq3F2pX0JmHoCxEG6Zo3yhNg1meJqbd2PA=;
        b=isXCpz4dYPVHoDVI0GsoO/Nq1d+UW3BiSThtZwybrbNVLvZJnaUvJJlQ6I+SwqX4si6Fwl
        SMRpQVOlS6rOREOyXqe4LvyJhVH0nEeNrO3Ym+RKkN5pKtzv9b9BFg1WVgGCytH6yi87wL
        YafFTQLJYKETzCDjQufMV1ODcvfNP78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642696190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sW8ehN6Hzkq3F2pX0JmHoCxEG6Zo3yhNg1meJqbd2PA=;
        b=opIu8da2LLuYNR0aDKPyth4dVWw5d8fT2gQC/jytzOM5xJ1Ii1Y51sTAtNsRka2XXrbOyV
        vNUhpkP/Bmt8wBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1336113BE3;
        Thu, 20 Jan 2022 16:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oy6pBP6N6WHyWwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 20 Jan 2022 16:29:50 +0000
Date:   Thu, 20 Jan 2022 17:29:49 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220120162949.5y6t5u6dbtxw2w5y@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
 <20220120140126.ntzvrcmczd7pph75@carbon.lan>
 <YemBnAvtNkIjVc7t@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YemBnAvtNkIjVc7t@T590>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:37:00PM +0800, Ming Lei wrote:
> Seems more likely nvme recovery issue, tags is changed even though
> ->q_usage_counter is grabbed in blk_mq_queue_tag_busy_iter(), which is
> added in v4.19.
> 
> You may check dmesg log and see if there is any nvme error recovery info.

Thanks for the tip. It's likely that a recovery is running although
there is no entry in the logs. At least I have an idea what could be the
problem here.
