Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA925B0AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIGQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIGQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:52:42 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECFAA4F6;
        Wed,  7 Sep 2022 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=Y/tfUBj4lwEsqbbcxU/CWG6g48iTMP2R4cI32RqPL7U=; b=X15gAaTmoh2EEw73OZNHBRnYuF
        oPX26Efd4n/PsU5M9t3QJD63HpDHkNS6DuEqwS/eR9SOjUbxGXkPtMCCI98ogCVMkt8biXmeO24dE
        3sE7DYJ51e4l2BWyuhh/FSiUkPSysymDs0lasaap/p5YfKoLJ1Qp+PN4AFeDgNSwnpyV6blkViqxH
        X+M4hnZp+BkfQgkz848JFO9hgqn7hFFlpRYA2j05UNLY76EAniR9zXGpHva05IUfmQVxWkoPblDUz
        lmsZ37xpNfEyNCRr9njZ4llz3o76JdqLmzMVaVdq8n/2cSNWo6V/2kl9sgdhVstmV8BaixbPNgZsM
        CTYePYnQ==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oVyI1-000soy-Pj; Wed, 07 Sep 2022 10:52:39 -0600
Message-ID: <b51e2ec0-62d0-c565-513f-e9fb27c64541@deltatee.com>
Date:   Wed, 7 Sep 2022 10:52:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220902171609.23376-1-logang@deltatee.com>
 <20220902171609.23376-2-logang@deltatee.com>
 <0be7f162-fe9d-1ecc-57bb-7b67cbfd50ee@molgen.mpg.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <0be7f162-fe9d-1ecc-57bb-7b67cbfd50ee@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: pmenzel@molgen.mpg.de, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH 1/2] md/raid5: Remove unnecessary bio_put() in
 raid5_read_one_chunk()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-05 00:07, Paul Menzel wrote:
> This commit was added to Linux in v5.14-rc1, so it’s not a recent commit
> – or I misunderstood the cover letter.

Ah, yes, sorry. The commit it fixes is a bit more than a year old. I
guess it depends on how you define "recent". ;)

Logan
