Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB2509591
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 05:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384015AbiDUDve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 23:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiDUDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 23:51:32 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC2AE74;
        Wed, 20 Apr 2022 20:48:44 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id s17so3633294plg.9;
        Wed, 20 Apr 2022 20:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OUAbMOKMp5owJVOPtlSKuDgkloZWwnX8sHS+jtpwsi4=;
        b=0KiGV3VHLJ0AbetI3njD67YKXlNZdYImfWMIjJft87cDV9OONPlfJihXMUbP2rHTsm
         NCL6k997/NiCTFQi2pXUzMBge+oZUyqsLoXc70+Hv0OUtAjY/cztYem6vYu5Jm1lJvTt
         w5ve5oJTPFUsjMtrhImoa12dRLVSfgsDTsIUuYZ+gtIEtJ4h3t6PDKh35/EXb9Kv6MO9
         a8X31or2U7xYgFqmIBisKlwikaim5YSXJqmII7ljkYEgEFCzVqDcqOZh6Msirm7wqH7a
         68RcpNtwHg/BGvwSQQbYDgLhfchsl3ix2AHDC0clgx2bHdFt2xYjUYHTXqTBF9QEAGR/
         no4Q==
X-Gm-Message-State: AOAM532ZWGgtzyZZBqjmEm3qRmC807FXXNbjVtRqaH6HZmBxr24AfbH6
        983eJ3Wvwl2jpy3DfV9PcBs=
X-Google-Smtp-Source: ABdhPJwWAeOID9sQFTF9M5n47crYltU3I8lINZEJBhedJrYeNUdgVQT4ecFYiWY7ukglav/wlZdfZQ==
X-Received: by 2002:a17:90a:e7c3:b0:1d4:9d67:4938 with SMTP id kb3-20020a17090ae7c300b001d49d674938mr6154488pjb.10.1650512923317;
        Wed, 20 Apr 2022 20:48:43 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm21774731pfm.207.2022.04.20.20.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 20:48:42 -0700 (PDT)
Message-ID: <f66f17bd-67a1-b888-01a6-4c1a02f1e21b@acm.org>
Date:   Wed, 20 Apr 2022 20:48:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] scsi: ufshpb: Merge ufshpb_reset() and
 ufshpb_reset_host()
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>, keosung.park@samsung.com,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220419183044.789065-2-huobean@gmail.com>
 <20220419183044.789065-1-huobean@gmail.com>
 <CGME20220419183926epcas2p4f529c4cc6bed9ba4b6536f3a5977c3f2@epcms2p8>
 <1891546521.01650433981606.JavaMail.epsvc@epcpadp4>
 <db1551628c191c8efdc2e7bec1313c58636c995e.camel@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <db1551628c191c8efdc2e7bec1313c58636c995e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 05:48, Bean Huo wrote:
> On Wed, 2022-04-20 at 11:47 +0900, Keoseong Park wrote:
>>> +void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src,
>>> enum UFSHPB_STATE dest)
>> How about changing it to something like ufshpb_state_toggle()?
>>
>> Best Regards,
>> Keoseong Park
> 
> ufshpb_state_toggle() is much better, I will change it in the next
> version. Thanks.

How about ufshbp_toggle_state() such that the word order is correct?

Thanks,

Bart.

