Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021BD532EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiEXQOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiEXQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:14:08 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB627E1DA;
        Tue, 24 May 2022 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=XGDP2IvqeiAPfkB1fEXqR1oCpPgMjf7+++fKTxZ22jU=; b=cJ1yIMVCtQ7ipXSQVLynmD/FfD
        486cR3k3hKaBGM4cHLtcE/kP06K/K0wdkObYYS4+dbSlsI0lL2ifA/bnTviOWlnT/J06O28dJHv/x
        n+QM10yo2srfShlTRLfzcwhBajjgS10V3gN8co2PUwLLf5S3E079W7I5nRbfMh0lYHVncGi0uSN0Z
        njte8dfnPAmKZh7Q6izRGtR19ngHlVhcT31/5cbE645HGcOO1lzMK1h9lhXufk88p1OAoTQmwTSwU
        lydgqcnkOQQ7qzaE3vgiA7FBgHbDFW4HstjH+r6wTxXh/Q9di3lcluztfn6da0yKNLFUKRXAVx/4J
        af1T2Mlg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ntXAa-006Rce-9A; Tue, 24 May 2022 10:14:05 -0600
Message-ID: <b5fe3e26-ade6-0d1b-4b0e-e8e3f147e9ea@deltatee.com>
Date:   Tue, 24 May 2022 10:14:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     Song Liu <song@kernel.org>, Donald Buczek <buczek@molgen.mpg.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-13-logang@deltatee.com>
 <62b09487-9223-db3d-2165-789a51230060@molgen.mpg.de>
 <CAPhsuW5FKh7VKgU+=eU4_ad4btFMwU7ymMNMZ5TZVQbv82MaHg@mail.gmail.com>
 <CAPhsuW5DUT6gg4eP7ozAwWdEiqen1eZwWeYAM5Jo7yY0h+LGcQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW5DUT6gg4eP7ozAwWdEiqen1eZwWeYAM5Jo7yY0h+LGcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: song@kernel.org, buczek@molgen.mpg.de, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log
 accesses
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-05-23 12:15, Song Liu wrote:
> On Sun, May 22, 2022 at 11:47 PM Song Liu <song@kernel.org> wrote:
>> Maybe we should move the definition of r5l_log to raid5-log.h?
> 
> Or we can use READ_ONCE(conf->log) for most cases.

READ_ONCE() will still generate sparse errors.

Logan
