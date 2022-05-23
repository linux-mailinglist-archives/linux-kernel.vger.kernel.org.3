Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810653095E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 08:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiEWGMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 02:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiEWGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 02:12:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7518AE3D;
        Sun, 22 May 2022 23:12:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 968A71F383;
        Mon, 23 May 2022 06:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653285913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A48QX/vupAuDBBHOJLZZB2SN4uoXt1Za4zzMoiIYE6M=;
        b=NUPGG7/Cyb8PISM5MQxuSK/EtfR77Nk33xy/KVu+F1Y55Kruti902KJPmGMnxMWEzCwe3Z
        OojVdGzwPekil0h+LKdnJ2ZLrDrZ8bBpm4rbDCUvVCPQIWwlBM3MS4KkS6CA7NRd/Yse0I
        ENeLjrrNb+U5ef1j9y7FD0KvuSX5tNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653285913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A48QX/vupAuDBBHOJLZZB2SN4uoXt1Za4zzMoiIYE6M=;
        b=AZLHrLi9ozj4GGOxPypKkh9E2+zcGbXAWjfJzhE2IDXmfNR4y7bw0+qvaL5pEATHPz2oHS
        QXXScIvxSgAQyFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C93D13AA5;
        Mon, 23 May 2022 06:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9YIHCBgki2IHdwAAMHmgww
        (envelope-from <colyli@suse.de>); Mon, 23 May 2022 06:05:12 +0000
Message-ID: <f1a9c46e-59a6-7b68-fd17-6f2563e24e98@suse.de>
Date:   Mon, 23 May 2022 14:05:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: linux-next: build failure after merge of the block tree
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220523124921.7d6bbf34@canb.auug.org.au>
 <df3ffbac-2f4e-df03-8b29-8e2e4bb69fac@kernel.dk>
From:   Coly Li <colyli@suse.de>
In-Reply-To: <df3ffbac-2f4e-df03-8b29-8e2e4bb69fac@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 10:52 AM, Jens Axboe wrote:
> On 5/22/22 8:49 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the block tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/md/bcache/btree.c: In function 'bch_btree_check':
>> drivers/md/bcache/btree.c:2073:1: error: the frame size of 2184 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>>   2073 | }
>>        | ^
>>
>> Caused by commit
>>
>>    c766acd3d78e ("bcache: improve multithreaded bch_btree_check()")
>>
>> struct btree_check_state is very large to put on the stack :-(
>>
>> I have reverted that commit for today.

Hi Jens,

> Thanks, I'll drop it. It's not part of the initial request sent to
> Linus, exactly because it arrived late.
>
> Coly, I'm dropping this series.

Yes please. Should I re-submit the fixed series to you in later -RC 
round, or wait for 5.20 merge window?


Thanks.

Coly Li



