Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC7589199
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiHCRjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiHCRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:39:48 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6F511819;
        Wed,  3 Aug 2022 10:39:48 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id 130so9273853pfv.13;
        Wed, 03 Aug 2022 10:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vFN4yAJ3TTxYc7VJJIK9g5MfH7WV/QaOOUEwSWvvAFk=;
        b=Zkpxbm2tCRC3ZXLuol1MMMrsO4c1y3Z4sOhPqj4YRSSUQL8vWaXEJgLq2+rvya/K0y
         aourilThquFWGk5E2ul5mqOU9gypa2LQrAT6ddom4qCk+/DY35adjJICoCjd6dLxUczB
         FPDXwD56oDdWea3Uo9mUHnmUX7qyoBv5ALYGvrqd/GdcSsfgxB0oKIkaNxRIgdQuJW4/
         0uxXFDE53r+MIsZp4XGZnroBiOHxmOzgBEqE4YsTqIfvvil296eWX11asIULrSRlkeVq
         xd6aEpwfQHMcq1EL7p5MjyubVF0V9V5B4m07+hV9DIm/2huwWF9MTiYRcv4PtduLJyq9
         Qa+w==
X-Gm-Message-State: ACgBeo0b30rhazHejyCvH9BxhbKxFoMmdbkGAvj5Qnoq7YM1io0I+LIk
        cslJF14yhl9tq6RxOJw0BK4=
X-Google-Smtp-Source: AA6agR6YG+qmhsNrnnTdhSEbKAWJIjwoZCCZ+/q8IaXPj77qJPi9gEimE+QdYGZqveGINhiN6NQNzQ==
X-Received: by 2002:a63:4b1b:0:b0:41c:863:8ccf with SMTP id y27-20020a634b1b000000b0041c08638ccfmr12631353pga.509.1659548387455;
        Wed, 03 Aug 2022 10:39:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a008500b001f559e00473sm297546pja.43.2022.08.03.10.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:39:46 -0700 (PDT)
Message-ID: <d123da27-6609-3ea8-b0a8-334d6dfc5345@acm.org>
Date:   Wed, 3 Aug 2022 10:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/6] scsi: ufs: wb: Add
 ufshcd_is_wb_buf_flush_allowed()
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
 <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
 <20220802080831epcms2p2c2b9f94e2f450a6a772a193d9720b650@epcms2p2>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220802080831epcms2p2c2b9f94e2f450a6a772a193d9720b650@epcms2p2>
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

On 8/2/22 01:08, Jinyoung CHOI wrote:
> Changed to improve readability.

The above description is a bit too cryptic. Consider changing it into 
"Introduce ufshcd_is_wb_buf_flush_allowed() to improve readability."

Thanks,

Bart.
