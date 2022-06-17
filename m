Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C054F430
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380973AbiFQJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiFQJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:25:03 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41D15F26A;
        Fri, 17 Jun 2022 02:25:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VGeLYMR_1655457896;
Received: from 30.240.100.35(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VGeLYMR_1655457896)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 17:24:58 +0800
Message-ID: <eb589e46-f46f-689d-72bc-1ce552cb5313@linux.alibaba.com>
Date:   Fri, 17 Jun 2022 17:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2] sign-file: Fix confusing error messages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
References: <20210624104824.82616-1-tianjia.zhang@linux.alibaba.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        James Morris <jmorris@namei.org>,
        James Morris <jamorris@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20210624104824.82616-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 6/24/21 6:48 PM, Tianjia Zhang wrote:
> When an error occurs, use errx() instead of err() to display the
> error message, because openssl has its own error record. When an
> error occurs, errno will not be changed, while err() displays the
> errno error message. It will cause confusion. For example, when
> CMS_add1_signer() fails, the following message will appear:
> 
>    sign-file: CMS_add1_signer: Success
> 
> errx() ignores errno and does not cause such issue.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   scripts/sign-file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index fbd34b8e8f57..37d8760cb0d1 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -107,7 +107,7 @@ static void drain_openssl_errors(void)
>   		bool __cond = (cond);			\
>   		display_openssl_errors(__LINE__);	\
>   		if (__cond) {				\
> -			err(1, fmt, ## __VA_ARGS__);	\
> +			errx(1, fmt, ## __VA_ARGS__);	\
>   		}					\
>   	} while(0)
>   

Likewise, No response from David, can you pick this? thanks.

Best regards,
Tianjia
