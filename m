Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2954ECB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378703AbiFPVfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiFPVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:35:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE5612B5;
        Thu, 16 Jun 2022 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=p55bws0dU16nNumHDUzsNgqJ+T30XftRBXPNFeHgwLo=; b=ryNEp85fiQFsYaODlvZR2E9ARu
        YA6O8YQVwYU+5+oG8Ijf8t6zBFJWVyTOm3wR5gnQZ3rMXG1sYdw2sN1grVRTP3MmZ0i7S5B1zm8on
        vpeXn1k36lzlInB2NUGmJJ19OrpSM6LQmv2TTK1gTaVBDyZ968gpW2MvT534wS3OH/Ylyg05okuJW
        j5fD0TYn5t10Kr2cuujG0epmkOaGeez5MDzmWX2awdbWRz40MGjwpQplFuzn1i99ENimz53UjFuA8
        09/ag/JZMRqDF6U+O0dMtuCOjjTwA6LNidJXJGmjH+kbaecZL6prqBDVmWRKSgRhKC42W2c7HWuLw
        sqBu6/jA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o1x9b-009530-77; Thu, 16 Jun 2022 15:35:51 -0600
Message-ID: <68536888-54fc-adde-a69d-321a5004e566@deltatee.com>
Date:   Thu, 16 Jun 2022 15:35:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     "Finlayson, James M CIV (USA)" <james.m.finlayson4.civ@mail.mil>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
References: <20220616191945.23935-1-logang@deltatee.com>
 <20220616191945.23935-16-logang@deltatee.com>
 <5EAED86C53DED2479E3E145969315A2389D4672D@UMECHPA68.easf.csd.disa.mil>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <5EAED86C53DED2479E3E145969315A2389D4672D@UMECHPA68.easf.csd.disa.mil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: james.m.finlayson4.civ@mail.mil, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [Non-DoD Source] [PATCH v3 15/15] md/raid5: Increase restriction
 on max segments per request
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-06-16 15:32, Finlayson, James M CIV (USA) wrote:
> Innocent question from position of ignorance....I see these last 15 check-ins all as performance improvements.   I tend to push hard on mdraid performance, but have RAID6 needs....are these some optimizations available for RAID6 and are they in process or did I just ask a silly question?

Yes, the optimizations in this series should improve raid6 performance
in the exact same way.

Raid6 and Raid5 share the same implementation. They are both
(confusingly) in the raid5.c file.

Logan
