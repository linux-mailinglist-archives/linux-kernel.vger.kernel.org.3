Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E155AF73
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiFZGOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZGOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:14:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661211141;
        Sat, 25 Jun 2022 23:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 362C2B80CF8;
        Sun, 26 Jun 2022 06:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1B8C34114;
        Sun, 26 Jun 2022 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656224068;
        bh=JQwlttMtDB3217p6kWDqx5YZ0smlg/K0HqZOLlFD/z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=auAnnXSvbKOVHIU2m2d36xg6fHwwUrQffwWT1sEK+CUh2Wu05G7CHBkMwOLr11pWT
         /ViuNjrmpPbMQ0Mb37wHLpGvGpwPUEOA1rQ3J4QxAKRf2RoshX/e9PzM2yxZPhE+Gc
         BAMuClWmegUrlBIt0ubzW8OybczauQmBbniRwLuMszpMA1hCW91EZ5qtZzY4uPm0nl
         gZJqDBs4wwVR0PvaAIBo2qGg8A12KrJTg9qwPwIe2Hzi/C9uy4Og6GtBPRePRSAWrP
         knJ+b5pWV2q7nfSTeLrNHOWDYRUjn5ypNKfT0RPX0aI231HLGH3IxoyKDxyVgTdY4w
         JueCEwLd2t1bg==
Date:   Sun, 26 Jun 2022 09:14:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Elvira Khabirova <e.khabirova@omp.ru>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] pkcs7: support SM2/SM3 and EC-RDSA/streebog
 algorithms
Message-ID: <Yrf5QWnKL2ocoEq6@kernel.org>
References: <20210918080737.17252-1-tianjia.zhang@linux.alibaba.com>
 <ea7d5934-01f4-bd2e-09d5-0916eb72e8d8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7d5934-01f4-bd2e-09d5-0916eb72e8d8@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:19:03PM +0800, Tianjia Zhang wrote:
> Hi Jarkko,
> 
> On 9/18/21 4:07 PM, Tianjia Zhang wrote:
> > This series of patches integrates the two patches sended separately,
> > resolves the conflict, and rebases on the latest code.
> > 
> > The two patches respectively support the SM2/SM3 and EC-RDSA/streebog
> > algorithm combinations for the pkcs7 parser.
> > 
> > Elvira Khabirova (1):
> >    pkcs7: support EC-RDSA/streebog in SignerInfo
> > 
> > Tianjia Zhang (1):
> >    pkcs7: parser support SM2 and SM3 algorithms combination
> > 
> >   crypto/asymmetric_keys/pkcs7_parser.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> 
> No response from David, can you pick this?
> 
> Best regards,
> Tianjia

You should CC me the series then.

BR, Jarkko
