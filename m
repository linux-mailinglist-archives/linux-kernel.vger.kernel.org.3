Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415B252F0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351756AbiETQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiETQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:42:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB014640A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:42:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7EF421B0B;
        Fri, 20 May 2022 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653064976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLqQdn9HN5Q/zAvC6Hk4QDRgTKfhEBhanRUuT3mU5pA=;
        b=igafjCptMEV96uVLVKjnxoDCXAr0C7f6sVRpvSX9tPGhJtTxOzhDBhfXPXiJghYdyexRt/
        OVlnUM9mGYOKK9TBJTurx2f23M+UlCnDwq8bHhBVF8OM5fZFq/wu4xGs+UdA/wzpyJ5nmA
        an/giytymusbucxLuECJ0nQzxTlpzEc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5C9E13AF4;
        Fri, 20 May 2022 16:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jZFXLxDFh2JAMwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 20 May 2022 16:42:56 +0000
Date:   Fri, 20 May 2022 18:42:55 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com
Subject: Re: [PATCH] cgroup: don't queue css_release_work if one already
 pending
Message-ID: <20220520164255.GB17335@blackbody.suse.cz>
References: <20220412192459.227740-1-tadeusz.struk@linaro.org>
 <20220414164409.GA5404@blackbody.suse.cz>
 <YmHwOAdGY2Lwl+M3@slm.duckdns.org>
 <20220422100400.GA29552@blackbody.suse.cz>
 <20220519112319.2455-1-hdanton@sina.com>
 <25fb057a-077f-b601-dcb7-130071c733db@linaro.org>
 <YodNu2C5iHKW3UeZ@slm.duckdns.org>
 <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489592f6-b783-7bdb-2cc8-0c8e35ebc674@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:38:12AM -0700, Tadeusz Struk <tadeusz.struk@linaro.org> wrote:
> as this is a result of enqueuing the same css->destroy_work onto the same WQ,
> one on the rcu path and one on the css_release path.
> I will prototype it today and test with syzbot.

In my understanding, you'd need two independent work_structs in a css,
not two separate workqueues to put the single entry on.

Michal
