Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2045833CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiG0ToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiG0ToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:44:05 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E05245F;
        Wed, 27 Jul 2022 12:44:04 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id q16so16716078pgq.6;
        Wed, 27 Jul 2022 12:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BWrsUDoB9+7Y574+57XLS7gWjGKhdg5+bty83bzhgMk=;
        b=INfHXwxxGDtgm/sRN8M7957HKU5+MkwViNx17Zv8ebk4MQin44h1OTXDZgTnfqelxb
         tI62Yxf4p0QDI03/AVS7Fbnku/pRYBrBL/MErxbxccvSM6FZgJenSolx5D1Pvv8Kzbq7
         mlBYXCuNR1of44pBu1uCpdseBslNIzh0A0n/T27nxDdDgnq8DdBd0W3YReLaK8EHcLoe
         tKBJdmzUFAJJYgLW4gzXAdacr56PgJ2JbiHMyVvWLIJlu3R+6RRghPlRAklnJguyUU3S
         igUJwvLwAFYp3GsZvPu8PlK7R/iO8MI0+wMRQW4rnrUpCbaIYxzPWogD8aAUwuryBCbV
         EwWw==
X-Gm-Message-State: AJIora/glWDngt5ouktawgc5wrCNl49IInG3FPWpO46t1epaeN4BcBPh
        u0FNgRyctvrVB7rgJ2lHCDo=
X-Google-Smtp-Source: AGRyM1unipVrmM6ZQWx0gHivnfNuqNnv2jo2rrrctYcUvHnW0vQMarfXVqPfiLcjUh5Tm3rCxsdkhw==
X-Received: by 2002:a05:6a02:30a:b0:41a:b002:83ac with SMTP id bn10-20020a056a02030a00b0041ab00283acmr20880154pgb.113.1658951044130;
        Wed, 27 Jul 2022 12:44:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a84e:2ec1:1b57:b033? ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id k13-20020a63d84d000000b0040c52ff0ba9sm12480194pgj.37.2022.07.27.12.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 12:44:03 -0700 (PDT)
Message-ID: <90ef5f84-1e4e-d93e-5ee9-acdf36109827@acm.org>
Date:   Wed, 27 Jul 2022 12:44:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/7] scsi: ufs: wb: Add
 ufshcd_is_wb_buf_flush_allowed()
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
 <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
 <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
 <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
 <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p7>
 <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/22 00:10, Jinyoung CHOI wrote:
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 94bcfec98fb8..78adc556444a 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1017,6 +1017,12 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
>   	return hba->caps & UFSHCD_CAP_WB_EN;
>   }
>   
> +static inline bool ufshcd_is_wb_buf_flush_allowed(struct ufs_hba *hba)
> +{
> +	return ufshcd_is_wb_allowed(hba) &&
> +		!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
> +}

Since this function is only used inside the UFS driver core it should be 
added in drivers/ufs/core/ufshcd-priv.h instead of include/ufs/ufshcd.h.

Thanks,

Bart.
