Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5F57D09A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiGUQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGUQCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:02:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E787371
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:02:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m12so2411084lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qju+Xo1cDVvOX0Uo3QlgOkFxB3TmGBZn1gqhX1HAvMs=;
        b=dPzlvv2YI6S+L8my5ZJJqz8/Y1vffPlYXyoiqwnXFwNO0Y92d0APBqWDPD3DeYq04b
         KtX/BVK6Ch8jKrcMhZKrWTTVuSZskQWBLkDb/VDhB2rfDYp8O6xlzoLjiKMOtE43vUjc
         9cqLPILxivW7mU+v96rD+R8MfsjNgSkqB+qsB6T2EU3OdijBcj1ebuecLpufKgjXcPEB
         PbykVBceBN1GPWxBVUGUo7rAouOU/oUYnZc009ySavHh5MkI1xIH9UOQ7SGnHG+il+Rr
         d0N9Kg3gis/BBYzdUwtCQyOtY/sA3iv8mdHQ76tggwtbguCYJs6NY5QtQ2BfExZ4z149
         3klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qju+Xo1cDVvOX0Uo3QlgOkFxB3TmGBZn1gqhX1HAvMs=;
        b=dZ6FZ0wWExO3Na6UD3MbnzdDaHNwmoetj79Hcf/mfhvpe/4XVhkvpj6UIbP3LNfj/s
         6DEyQ5TNugIhKzEtTeHa1aK6O/kpOAG39KQgGBfdeBd4qva2eP5kHJ05SLqAVF1wa2Ls
         qutnXspKfICJEN1Zn0uU0+R4jqvvimv3DOCBnzXpE8JCoDZ9EF9PdogeO55D536xLK+C
         kL+ontrbI3dXP7dZ6RzcW9dWLzgoJX+es3kwfP38YNTNA5CGyBWELJl5WAzxgW4VfOV5
         J1kFy8QHfiBfaClXho5d7T9eUORkDp/M+TSJ8N9nkyXoYgX+nKcA/ajopoZZxCWNo5Lm
         2Ubg==
X-Gm-Message-State: AJIora/Z4NB0OLsJuiWlIPrvdFOe+kLfLcNWKpMjTGQsnTeStU6F6wjQ
        oipGX7nkRNW11OpxLumBdLMyrQrjm+iyfx/b
X-Google-Smtp-Source: AGRyM1trY5ITtNlO72gsUBhEzJI3nk8oObNgljwg8ZoF82En3k3x+Nlrp2Fdllm3cPQdQB6BN0HlmA==
X-Received: by 2002:a05:6512:3b0a:b0:489:da13:180a with SMTP id f10-20020a0565123b0a00b00489da13180amr23094700lfv.489.1658419369592;
        Thu, 21 Jul 2022 09:02:49 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048910301774sm33339lfz.307.2022.07.21.09.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:02:49 -0700 (PDT)
Message-ID: <22bd8bc2-9d47-b7a6-6d3a-9c1ecb62cc7f@linaro.org>
Date:   Thu, 21 Jul 2022 18:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] riscv: traps_misaligned: do not duplicate stringify
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>
References: <20220623112905.253157-1-krzysztof.kozlowski@linaro.org>
 <CAAhSdy35972j=qpqQWak1Ot1nZb0iiURzYqhrbZ1bfuuAdpw_w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAhSdy35972j=qpqQWak1Ot1nZb0iiURzYqhrbZ1bfuuAdpw_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 15:11, Anup Patel wrote:
> On Thu, Jun 23, 2022 at 4:59 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Use existing stringify macro from the kernel headers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> 

Thanks!

Any other comments or reviews? This was sent a month ago, so maybe it
could be merged?


Best regards,
Krzysztof
