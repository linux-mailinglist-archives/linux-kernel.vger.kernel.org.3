Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F585AFA5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIGDCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGDCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:02:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AC083056;
        Tue,  6 Sep 2022 20:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3Tp5ZhNYXm0i/DPFn+aAH7H47byqpVrpKeYl5Ch2pN8=; b=Ol9g3wUgd4tK8mxRwHC7DTcVYt
        4yvOSlYjNIz5eBiHUWvBpB1GTWf+sBAo63Ye9T7gTcOmHvcYovJDkMfglnw4sf3+UYJ1UE3cN8qvk
        3t91Wfb6zAD3V+eKmN5ygcXwzu9gHQU+jHiP/nzkgLsjHR4qI/3Gok7bq5Z3OuGxUyiPEKTMykCup
        PsonLRiEAUqqJrtyAsYHNoCqxC7QhbZo8szZXQyqrG3zgD36q8g5mI6UpcjpfPDRHxjX+Z6/MFz7C
        MpD/M/wHpbHseyBXSxeT50nxeuesW4+6JOWNhRactFNIsS2f8gZUfYD+RSJZ3Rex4L2VRucxQVUlN
        12/4FRwg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVlKN-001pdO-MJ; Wed, 07 Sep 2022 03:02:11 +0000
Message-ID: <712da429-6d0d-325f-1c53-39326faa2d41@infradead.org>
Date:   Tue, 6 Sep 2022 20:02:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] crypto: aspeed: fix format unexpected build warning
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Neal Liu <neal_liu@aspeedtech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com, kernel test robot <lkp@intel.com>
References: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
 <Yxf+W/mJvnSKzQgM@gondor.apana.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yxf+W/mJvnSKzQgM@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/22 19:13, Herbert Xu wrote:
> On Mon, Sep 05, 2022 at 01:24:49PM +0800, Neal Liu wrote:
>>
>> @@ -324,7 +324,7 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
>>  	struct ahash_request *req = hash_engine->req;
>>  	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>>  
>> -	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
>> +	AHASH_DBG(hace_dev, "src_dma:%zu, digest_dma:%zu, length:%zu\n",
>>  		  hash_engine->src_dma, hash_engine->digest_dma,
>>  		  hash_engine->src_length);
> 
> Shouldn't we use %pad instead of %zu for dma_addr_t (you'll also
> need to pass in a dma_addr_t pointer instead of the value)?

That sounds correct.
I only looked at the size_t parts...

-- 
~Randy
