Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A86581C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiGZWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiGZWrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:47:55 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C591326E7;
        Tue, 26 Jul 2022 15:47:54 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id f65so14356274pgc.12;
        Tue, 26 Jul 2022 15:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JzO3IeIuQztvrsRLmkpE46imkHEW5eNh0OyZa8Qe6mc=;
        b=XweNemqX6PO2mO9uu+ax2woh5HBQI9pakx5bwGiXaBMfG/lMn1LtisyDKBW4ZDrxFS
         9rAZrAU91/OPxUQEA2B/4V/2Q3UCEdpmgCDyoe0LBi0BcOf+z8MzRiBj/pXVYLJe7fAs
         uM4rDmuuWzbN6P4P6xEFxj8M7ru2M40p34ZlJggi57B2l07Z3x3gvzeMC5D4xNzpypRW
         EIh8nRcOtUcRBteHVA/k+83WBWNEb8fm4nrTEo5NwPEZHvA2iNZMBgvGsvcj66R6GhEA
         jJFnDNbJtB7HPLMfjMIP8ge5o5hBAG3wUOZdrvGDQymsISTuJ1/aID6xE9DZsLTDhsYh
         xmOA==
X-Gm-Message-State: AJIora/7tQxlEl0j0EgkDRBJtOtT/ioi91AYWnZUDMMJugKBvfTkjLR9
        tXJsCKQXNrQBqpZ2K9soNZg=
X-Google-Smtp-Source: AGRyM1sXVHkFvgipghxDJ1g2uLuoOmJdlIIG8IIXeHwQJHKJ/EyvEqYyD0g4d9gjzcwKN7/rg+sEmg==
X-Received: by 2002:a05:6a00:796:b0:52c:2d1:3ae0 with SMTP id g22-20020a056a00079600b0052c02d13ae0mr7814087pfu.52.1658875673432;
        Tue, 26 Jul 2022 15:47:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:34f4:7aa8:57:d456? ([2620:15c:211:201:34f4:7aa8:57:d456])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm9478073plh.30.2022.07.26.15.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 15:47:52 -0700 (PDT)
Message-ID: <47d98e37-d32f-2afa-8272-29f48d066fe7@acm.org>
Date:   Tue, 26 Jul 2022 15:47:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Content-Language: en-US
To:     "Asutosh Das (asd)" <quic_asutoshd@quicinc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Can Guo <quic_cang@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
 <DM6PR04MB65756C5A6C5F674B19091F7DFC939@DM6PR04MB6575.namprd04.prod.outlook.com>
 <78495ab6-358d-4d91-e710-140331f37843@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <78495ab6-358d-4d91-e710-140331f37843@quicinc.com>
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

On 7/25/22 09:35, Asutosh Das (asd) wrote:
> On 7/23/2022 2:23 PM, Avri Altman wrote:
>> Also maybe we can constify sizeof(struct utp_transfer_req_desc) which 
>> is used now few times.
>
> Ok, agree to make sizeof(struct utp_transfer_req_desc) a constant in the 
> next version.

Please don't. I'm concerned that introducing a symbolic name for that 
sizeof() expression will make code harder to read instead of easier.

Thanks,

Bart.
