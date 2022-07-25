Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6B5805A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiGYUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbiGYUah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09B622510
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658781032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR/XGl5d+vD331sf91Cdt4PhYy4RnDiWcXKqjqi8ODs=;
        b=ZuVBkM87FFykPm+R3alPR2NULAqXz3yWtCmRMhRBLpGoy/xT0BeTIvxP3uS7I02sQuQYUE
        TO5QYLcP3OEUCosjlRX91f9WI7mk2Z1gjZEek1PGA70PrTJhel6u2BT8ewphGOMKxaqv9K
        JZ2vthHRzO6pBDWTuh6Ww5+rUzN22So=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-dyA-NRXXMy2xkd0yzUdM4Q-1; Mon, 25 Jul 2022 16:30:31 -0400
X-MC-Unique: dyA-NRXXMy2xkd0yzUdM4Q-1
Received: by mail-oo1-f69.google.com with SMTP id d22-20020a4a9196000000b00435761169daso928214ooh.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XR/XGl5d+vD331sf91Cdt4PhYy4RnDiWcXKqjqi8ODs=;
        b=c30pp+u4zR0BKosvEY0LGMdkcGW8RTnGORwKg+EQu53sqfhLgmGW1IXwKEe4CqtW5o
         Pt3gqvDpmHF/d5Wc5E+nerbMTCC6UTDtgZ2sn0OQ7kots8NSMFx2/SOgiFAYji5I5qhN
         IRFZYCL6avyJoby35GjlqXtedL2KYwXCV4NNYG+Ita3/0pJgopnELSVhu7aX8FhUd3CE
         7EHu0hr94X0LR8ct6P0LqVAs8fR1xyLNH8TrNKPVraiCYDlo9m9+iYCKZM5pUfIN1TDR
         B30RI7TFYj4vPMpp8dydVD5oOjxQmS6tN3SLK3BJ4OcTGZde00BmD4m61RVyiYmrHeGq
         gAEg==
X-Gm-Message-State: AJIora+BqN4GbFxqKK/IOHxwGmZmk02FRDh5aCMjXK0nJrm/z26mnOvb
        FoS4oY5/hINSi1h4KOHWO7euF5FgOnz3h7I1NEDh66g1G1f6VuQ0+/62ku+tCa4mySnI7aUFGIM
        MZQjaGcSK5HfDuF2mbyKrVtN6
X-Received: by 2002:a05:6870:f222:b0:10b:7326:18c2 with SMTP id t34-20020a056870f22200b0010b732618c2mr14678592oao.55.1658781030628;
        Mon, 25 Jul 2022 13:30:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMKdLBsCrpyPFiMwp1I36On67rQNmu7kKIT17kKg4MZ0q/jXm/7VX99Y0AfExWzkcNf7gWrA==
X-Received: by 2002:a05:6870:f222:b0:10b:7326:18c2 with SMTP id t34-20020a056870f22200b0010b732618c2mr14678576oao.55.1658781030337;
        Mon, 25 Jul 2022 13:30:30 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o31-20020a056870911f00b0010c7487aa73sm6507887oae.50.2022.07.25.13.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:30:29 -0700 (PDT)
Subject: Re: [PATCH] ASoC: amd: acp: Fix initialization of ext_intr_stat1 in
 i2s_irq_handler()
To:     Nathan Chancellor <nathan@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220725180539.1315066-1-nathan@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fd7188f2-8e42-3683-0ef5-2ddde56b3efc@redhat.com>
Date:   Mon, 25 Jul 2022 13:30:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220725180539.1315066-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/25/22 11:05 AM, Nathan Chancellor wrote:
> Clang warns:
>
>    ../sound/soc/amd/acp/acp-platform.c:117:19: error: variable 'ext_intr_stat1' is uninitialized when used here [-Werror,-Wuninitialized]
>                            if (stream && (ext_intr_stat1 & stream->irq_bit)) {
>                                           ^~~~~~~~~~~~~~
>    ../sound/soc/amd/acp/acp-platform.c:97:35: note: initialize the variable 'ext_intr_stat1' to silence this warning
>            u32 ext_intr_stat, ext_intr_stat1, i;
>                                             ^
>                                              = 0
>    1 error generated.
>
> The variable was not properly renamed, correct it to resolve the
> warning.
>
> Fixes: 93f53881473c ("ASoC: amd: acp: Modify local variables name to generic")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1675
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>   sound/soc/amd/acp/acp-platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
> index 10730d33c3b0..f561d39b33e2 100644
> --- a/sound/soc/amd/acp/acp-platform.c
> +++ b/sound/soc/amd/acp/acp-platform.c
> @@ -100,7 +100,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
>   		return IRQ_NONE;
>   
>   	if (adata->rsrc->no_of_ctrls == 2)
> -		ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, (rsrc->irqp_used - 1)));
> +		ext_intr_stat1 = readl(ACP_EXTERNAL_INTR_STAT(adata, (rsrc->irqp_used - 1)));
>   
>   	ext_intr_stat = readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
>   
>
> base-commit: be0aa8d4b0fcb4532bf7973141e911998ab39508

