Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D894D6947
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 21:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351117AbiCKUBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 15:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiCKUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:01:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600F1BFDEC;
        Fri, 11 Mar 2022 12:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 862CFB82CE0;
        Fri, 11 Mar 2022 20:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B7BC340E9;
        Fri, 11 Mar 2022 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647028837;
        bh=TvxVgxvG902p5ANsA/iC3earRyw+vVTX1cKROKGiNFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgTXinLpIlSBzQqHijYtsJGrX9FB+JuMlSnN0mz7ExSXSdHSzcSiMu45bW+TkfDlb
         +L8zp9ft0x73hdPxtx7QpRuSs+veNB9KWwmU6IolZLyqJE8R1YIgUC34gaLUuJ17w8
         KpU8RQS8Sbh2gYyrCQZpXHfNQ3O4xfp/6J1IQZvcA1pq969ff3wPD8mRSq4Ogdo6ot
         PsOEdfXx2bqJdGndBwKRak4jM5i1aXIf55GroeIXKTvRT+aL9GSxr7FSYnegEfIZfT
         jGQERWV9+CKOAltuH5D9vVzKF8K+qNzEBC7aiK0HO+CZRnzv+9WOcGRoqdXQmh7+cx
         jlKJwrqWy9rPw==
Date:   Fri, 11 Mar 2022 12:00:34 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220311200034.GA413555@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
 <YigzoKRJ1EHFRZY9@sol.localdomain>
 <20220309193126.GA3950874@dhcp-10-100-145-180.wdc.com>
 <YikEs7RNgPXTQolv@gmail.com>
 <20220310153959.GB329710@dhcp-10-100-145-180.wdc.com>
 <YipFP8B8MxMxTVBR@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YipFP8B8MxMxTVBR@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 06:36:47PM +0000, Eric Biggers wrote:
> I think the lib functions should still use native endianness, like what crc32
> does.

Gotcha, then it should simply be this patch:

---
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index f1a22794c404..f9e5f601c657 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -3686,11 +3686,11 @@ static const struct hash_testvec crc64_rocksoft_tv_template[] = {
 	{
 		.plaintext	= zeroes,
 		.psize		= 4096,
-		.digest		= (u8 *)(u64[]){ 0x6482d367eb22b64eull },
+		.digest		= "\x4e\xb6\x22\xeb\x67\xd3\x82\x64",
 	}, {
 		.plaintext	= ones,
 		.psize		= 4096,
-		.digest		= (u8 *)(u64[]){ 0xc0ddba7302eca3acull },
+		.digest		= "\xac\xa3\xec\x02\x73\xba\xdd\xc0",
 	}
 };
 
--
