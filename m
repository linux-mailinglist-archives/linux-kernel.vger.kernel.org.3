Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5D5891A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiHCRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiHCRlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:41:40 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E75244F;
        Wed,  3 Aug 2022 10:41:39 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so4123853pjh.0;
        Wed, 03 Aug 2022 10:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BmXLM4azNBHOm55vuddHIDwGu+x7EIrIT1rqwezLYSQ=;
        b=mOZgjDIQufEKFfMiN/LhOD00d6t+loTz228SYwjR2l3T9lhvcWmVMWyDukfbu0kmCv
         oP4VOOOAuALIZkzW5MZdeB1hlpvADt44yyxeEz09cSr7WpZw08fr+foygmDMcG/N6VXc
         NkbFSV2ZBVB3QzEQoytjqYyoxBJfXEUXmrNDK0idcpc0roRWXyNhUQ2mABajLN23ctAg
         OD6z/jNkcYfZ3MkoQI8vYWaSXJ8M/nyj/P5gWq+KPWoj68c+m51Xb+Lg2BMWa/XW7u0T
         1urAalw1YcZLFEs9Jf2VEUF8NqTGGD9whwX3sMgc/WD23s5BR2vmznOKm0faurh03gek
         dCvw==
X-Gm-Message-State: ACgBeo1za9uVNQcgAlADKgCwhJc39yoCM8B1E/S4/+g7yZC2i61/6xXF
        3+s6d0gUbRXvDvwNHPQTeQU=
X-Google-Smtp-Source: AA6agR7KkdrQHjwWFF79/PpeF1hY36KcVwzXJ4t/pAJKSs5nCfxkcgcOXcSOvQr7ptUhJGXtKV4NUg==
X-Received: by 2002:a17:90a:fe06:b0:1f3:547:1b31 with SMTP id ck6-20020a17090afe0600b001f305471b31mr6170185pjb.114.1659548499172;
        Wed, 03 Aug 2022 10:41:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b0016c78aaae7fsm2290609plg.23.2022.08.03.10.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:41:38 -0700 (PDT)
Message-ID: <e98d1448-ca35-b29a-0960-e3cb8a9673a0@acm.org>
Date:   Wed, 3 Aug 2022 10:41:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Stanley Chu <chu.stanley@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220803074349.v4.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
 <CAGaU9a8H7QmkhBvNfZhH+CyFaup1oGX1j7a36ph9t+Me3MjCQw@mail.gmail.com>
 <CAONX=-cSKdWGAqadzvrdJyZfL+PGOM7V0E1HcHuUny4V00JiUA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAONX=-cSKdWGAqadzvrdJyZfL+PGOM7V0E1HcHuUny4V00JiUA@mail.gmail.com>
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

On 8/2/22 17:07, Daniil Lunev wrote:
>> Please kindly add all Reviewed or Acked tags received in previous
>> versions to any newer patches.
>
> Oh, thanks for this suggestion, I didn't know if I should do that. Should
> I create a new patch with those brought over?

That sounds like a good idea to me. Otherwise this information will be 
lost when the SCSI maintainer queues this patch.

Thanks,

Bart.

