Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC029555104
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbiFVQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376484AbiFVQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:13:38 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D98558A;
        Wed, 22 Jun 2022 09:13:37 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id bo5so16532172pfb.4;
        Wed, 22 Jun 2022 09:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S2jhIeXdGyhsiNAkiJgx9x78yRr8VBpBDdHMTG3XHaA=;
        b=Ys+5ZvfmzYQfVrtCi2DdbsgyII+nSiyjrrJX8tjLOJ5bjC3fSz74EiRtw21GDhRQ3y
         AZ8jiqFg4sArOxJ8SipLwUSlw3u1D17LTd3Qk00RJ0TBvwOYbC6cTOtISY+bhOXCC1bf
         sDoBMHO6bKNWiJMiN3gHeJ+9RJ6NZnA95oS+67tAHBHLQFhlAW2cNkUNDPQ7XAujVwzt
         r0rwlbhuxtg8NnkmK5Bn1v2PTx+iwaMytVsUJTV4R5zHsLFyPBgQXt77BR3TJ91exIXF
         lCDVzFcNPxdG/YayFiJwCq7v1404zzJ6sCa+a06DTR2lrJBIZmxz15WlsHA0EcfaIpv0
         th7A==
X-Gm-Message-State: AJIora+6fy7633vmSuxTmQ7Zk9wPADyZDPtQxEOpr9qJStbDkGnftBKF
        Cijvh3ohMVIKGUAqe4+/xv8=
X-Google-Smtp-Source: AGRyM1vULlnlPydLSyouvDySqwWWsXOixTjXSVSgWJA/c/WhK9kFLli2e0KsR/ZaAeJYJW3xcJ3jnw==
X-Received: by 2002:a63:7a51:0:b0:40c:f874:1b46 with SMTP id j17-20020a637a51000000b0040cf8741b46mr3618730pgn.90.1655914417156;
        Wed, 22 Jun 2022 09:13:37 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9497:eb13:222f:4e4d? ([2620:15c:211:201:9497:eb13:222f:4e4d])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902e14400b001637997d0d4sm12844691pla.206.2022.06.22.09.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:13:36 -0700 (PDT)
Message-ID: <08544601-3364-0352-415f-2e3576b84976@acm.org>
Date:   Wed, 22 Jun 2022 09:13:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/3] scsi: ufs: ufshcd: constify pointed data
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <20220613100655.105301-1-krzysztof.kozlowski@linaro.org>
 <20220613100655.105301-4-krzysztof.kozlowski@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220613100655.105301-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 03:06, Krzysztof Kozlowski wrote:
> Constify arrays and pointers to data which is not modified for code
                                              ^^
> safety.

is -> are?

> @@ -7848,7 +7850,7 @@ static int ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
>   	u32 granularity, peer_granularity;
>   	u32 pa_tactivate, peer_pa_tactivate;
>   	u32 pa_tactivate_us, peer_pa_tactivate_us;
> -	u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};
> +	const u8 gran_to_us_table[] = {1, 4, 8, 16, 32, 100};

Can this array be declared static? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
