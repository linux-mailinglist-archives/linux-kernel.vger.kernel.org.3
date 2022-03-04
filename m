Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2054CD6CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiCDOyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiCDOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:54:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF79A2525;
        Fri,  4 Mar 2022 06:53:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C66B01F386;
        Fri,  4 Mar 2022 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646405593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPMOWJ8Wb8SfVgGdPS+YcoOvblHdhPLKJQBRkCzTqMk=;
        b=hKxJ9XLwNsql3U2CT8KA8rJZSfoQ6966SWLgVqYhcyXGAV1gtKdqr7PxBaOmRMBmMeFvAK
        S99UapS7mt55Nw4TjwynjWeGR4Kfec1VRbg9vE4f9756taiPqtBf9wdk0/e47sLRAGr/Kl
        E7ZcxrD0srPVcE2j7D5kO3r4PGAc1Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646405593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPMOWJ8Wb8SfVgGdPS+YcoOvblHdhPLKJQBRkCzTqMk=;
        b=lSAvolOW7ivCe7TdKJEdqWxckclF0YoQkE2pLxnjwxjNSMq8ybaN8/1rrlqlnpth2cqaYu
        F0P7z+2borngZ0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B751F13CE6;
        Fri,  4 Mar 2022 14:53:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GXufLNknImLoHQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 04 Mar 2022 14:53:13 +0000
Date:   Fri, 4 Mar 2022 15:53:13 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <20220304145313.qnpv4lawl5vk4add@carbon.lan>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
 <Yelo1gx5cp1l4npK@T590>
 <20220120140126.ntzvrcmczd7pph75@carbon.lan>
 <YemBnAvtNkIjVc7t@T590>
 <20220120162949.5y6t5u6dbtxw2w5y@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120162949.5y6t5u6dbtxw2w5y@carbon.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 05:29:50PM +0100, Daniel Wagner wrote:
> On Thu, Jan 20, 2022 at 11:37:00PM +0800, Ming Lei wrote:
> > Seems more likely nvme recovery issue, tags is changed even though
> > ->q_usage_counter is grabbed in blk_mq_queue_tag_busy_iter(), which is
> > added in v4.19.
> > 
> > You may check dmesg log and see if there is any nvme error recovery info.
> 
> Thanks for the tip. It's likely that a recovery is running although
> there is no entry in the logs. At least I have an idea what could be the
> problem here.

FWIW, a846a8e6c9a5 ("blk-mq: don't free tags if the tag_set is used by
other device in queue initialztion") was missing our tree.
