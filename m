Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1258400C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiG1Ndv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiG1Nds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:33:48 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F75140F;
        Thu, 28 Jul 2022 06:33:48 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id e1so2062076pjl.1;
        Thu, 28 Jul 2022 06:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gHUvDp9XxgXKyC/S3Y/ZPZ1AK6LyrKzwAJXqinHhkxY=;
        b=eL37x8c4y9LgS4noEaq4Nbu1pJYqbgVLPdmMfJDte8pIKclLWYmOnFxb2m7tHKCyzy
         VqtUjtbz7Klx0xRADHJjoaoJASMrpijWb+vc3FbldV7ryvuXSv/qsjC04UkW+ivaAvil
         ripYHP6j0az/1OtZ0saBI+nWZjnOKc9VbVnk32OcnSLxJLpRLvgMsNIImUetcpQN9WwX
         9cZAH3hhxPVlITWWZKTjBKvIR9g0ACclEt/es8SSC135Md6q+LihcmOlul1XpRHajdrT
         iGMLg4oSaR0gdI9Y//7hzwHCUfEG/0fXpTwbANhYwYummelwAzUiZRWKzjGnABD7x9vQ
         Kkqw==
X-Gm-Message-State: AJIora8lYgWyndYTkbm11el5bYptjeryvTqmbacCVUkhmWLlQJw61nvZ
        /Y5z6CxVH9mMVdoNpOTvTW4=
X-Google-Smtp-Source: AGRyM1s+K/6al4NrwNKS3VWhyVYTdV/0+QCqk/k3mxIiaamLxq73CxhjB49R4yO7pJbpvxoBVwNEZQ==
X-Received: by 2002:a17:902:9307:b0:166:41a8:abc0 with SMTP id bc7-20020a170902930700b0016641a8abc0mr26273877plb.135.1659015227738;
        Thu, 28 Jul 2022 06:33:47 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w71-20020a627b4a000000b005289ffefe82sm736615pfc.130.2022.07.28.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:33:46 -0700 (PDT)
Message-ID: <238bacda-6df5-0836-2f6a-74a6079a7ae4@acm.org>
Date:   Thu, 28 Jul 2022 06:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] scsi: ufs: Get boot device storage type from command
 line
Content-Language: en-US
To:     "Chetan Chinnadagudihundi Ravindranath (Consultant) (QUIC)" 
        <quic_cchinnad@quicinc.com>, jejb@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1658910535-31802-1-git-send-email-quic_cchinnad@quicinc.com>
 <a09de6e0-700b-0715-06a8-150ab41e8e7f@acm.org>
 <c66ffd91-8649-edb7-86dc-422ae82e1b84@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c66ffd91-8649-edb7-86dc-422ae82e1b84@quicinc.com>
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

On 7/28/22 01:35, Chetan Chinnadagudihundi Ravindranath (Consultant) 
(QUIC) wrote:
> Hi Brat,

Please spell my name correctly.

> Yes, since SCSI_UFSHCD=y am selecting UFS_QCOM_CMDLINE=y so that it gets 
> __setup() declarations. I am able to read the command line arguments and 
> get this "androidboot.bootdevice=" info. I had cross checked again.

I was asking about SCSI_UFSHCD=m instead of SCSI_UFSHCD=y.

Thanks,

Bart.
