Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67774B76B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiBORP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBORP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:15:56 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249711ACED;
        Tue, 15 Feb 2022 09:15:46 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d17so7834162pfl.0;
        Tue, 15 Feb 2022 09:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LOeWWNlHO4AtZ7MgNQfE1a3OysB2klf6boBkFZ8uxlM=;
        b=xwpTEYIL58wLES6TG/r+iIjr/6/ESsq0VZuLsYb/bzX61ZMopbHjPNkZ/UYW1xIKqm
         7pfeCvQEoFRu0cI1M3eCdQ3rNv1lUO8NbdYS30VEyPMUXzWQTPqPripZG+Eu3wz/ywko
         WIug7JQly4Koc0OH/CMMGCmg+9ZlvtDkw2phxEqh2DwiSmrut0vWLhWU6XTV6sYF6diK
         3MrCFINM9NEz3i/mwshPb3h+9j6QUUSPbmQwXpLwQlvqQUJd0p6oZG2oS5ZoKXZ2pVxH
         mMSyQwA6HxAD8RIQ2uyJoYPdgixLstrWXhqeyKPBiDfj9rIGoLx0eOaXSevMttxak2xF
         +51g==
X-Gm-Message-State: AOAM533pOYVucK0HBxMQD+19Lb67gZrUNX5pBxGLzsCyeqTzBbPFIsN6
        17GJXy12OTJc1lXML1cYH60=
X-Google-Smtp-Source: ABdhPJwo+9w+mXNq4JUW14oQEea7jDcOcI9ZAQyy5G7RH7CrGq5eG/xzvhzVB89wxZYY7O8g8H0Zsw==
X-Received: by 2002:a63:4a65:: with SMTP id j37mr3897610pgl.358.1644945345971;
        Tue, 15 Feb 2022 09:15:45 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id v12sm7567886pfu.155.2022.02.15.09.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:15:45 -0800 (PST)
Message-ID: <6b298597-f3b3-e4a1-c59a-f704ad4c06e5@acm.org>
Date:   Tue, 15 Feb 2022 09:15:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
 <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
 <62a5170b-48c0-a372-5392-08f5112d7a06@acm.org>
 <007e01d82231$be8be250$3ba3a6f0$@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <007e01d82231$be8be250$3ba3a6f0$@samsung.com>
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

On 2/14/22 22:03, Kiwoong Kim wrote:
> The benefit that I think is not blocking dev cmd during submitting a scsi cmd.

Hi Kiwoong,

Both ufshcd_exec_dev_cmd() and previous versions of 
ufshcd_queuecommand() obtain a reader lock on the clock scaling lock so 
concurrent submission of both command types is allowed. I'm not aware of 
any version of the UFS driver that serializes device commands against 
SCSI commands.

Additionally, please take a look at commit 8d077ede48c1 ("scsi: ufs: 
Optimize the command queueing code"). That patch removes the clock 
scaling lock from ufshcd_queuecommand().

Thanks,

Bart.
