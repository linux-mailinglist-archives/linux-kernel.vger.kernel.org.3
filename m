Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44C54D238D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350473AbiCHVrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346980AbiCHVrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D095548F;
        Tue,  8 Mar 2022 13:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27CD0612F2;
        Tue,  8 Mar 2022 21:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FEDC340EC;
        Tue,  8 Mar 2022 21:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646775975;
        bh=4NQDgg8rDLEMggBz3LqMK5Y31CHXEmbf5huKroKeVug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTjSem06XXUAXfGknm1y00SGv6velA0nDArAbaZIknN3C+Cg5qeEG+3WWvq/nN02v
         E7RD/Z5YeFdudMIw02dAnJgEk982YfLlYbUptqBpOypbChuykEctwxp/4yfytESZKD
         tmem03zzNHQARta8jkC0n8RLcHFkhCBhE6vuWYd5Es0kGFVTUmf4t1ISE/6v3C62Ml
         pNGQ21vpX7Yyf6abzGXVgcaO4LCj5W2zZSAdRD3GB8qoJTFzyLddgh31uH2+ov5VvB
         EIpTEH3kD7iA4yZmbbaNxGo4C51IDEy5RDTQpWFbowZH+NHpcrnJG3IDfJupEWJPnI
         5aLl0SLvmYs3A==
Date:   Tue, 8 Mar 2022 13:46:12 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220308214612.GB3502158@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
 <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 12:27:47PM -0800, Keith Busch wrote:
> On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> > On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > > Hardware specific features may be able to calculate a crc64, so provide
> > > a framework for drivers to register their implementation. If nothing is
> > > registered, fallback to the generic table lookup implementation. The
> > > implementation is modeled after the crct10dif equivalent.
> > 
> > Hi Keith,
> > 
> > this is failing on big-endian systems. I get the following on s390:
> 
> Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
> action. I'll send an update, thank you for the report.

I'll set up a BE qemu target this week, but in the meantime, would you
be able to confirm if the following is successful?

---
diff --git a/crypto/crc64_rocksoft_generic.c b/crypto/crc64_rocksoft_generic.c
index 9e812bb26dba..12a8b0575ad1 100644
--- a/crypto/crc64_rocksoft_generic.c
+++ b/crypto/crc64_rocksoft_generic.c
@@ -28,14 +28,14 @@ static int chksum_final(struct shash_desc *desc, u8 *out)
 {
 	u64 *crc = shash_desc_ctx(desc);
 
-	put_unaligned_le64(*crc, out);
+	put_unaligned(*crc, (u64 *)out);
 	return 0;
 }
 
 static int __chksum_finup(u64 crc, const u8 *data, unsigned int len, u8 *out)
 {
 	crc = crc64_rocksoft_generic(crc, data, len);
-	put_unaligned_le64(crc, out);
+	put_unaligned(crc, (u64 *)out);
 	return 0;
 }
 
--
