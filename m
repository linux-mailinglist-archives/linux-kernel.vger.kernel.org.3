Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0AF56D370
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGKDlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:41:12 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AEB13DEA;
        Sun, 10 Jul 2022 20:41:11 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id g126so3754231pfb.3;
        Sun, 10 Jul 2022 20:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Nm6h41G3O9mUNLTUv/DHYC4MVXmTKo7elSHwGl4+TY=;
        b=IfpRiceJ9FFV1QInTcmaE7IIZtvdZu1SsSZpiZpN/9b6HHAD+WbkFklvrDa+Kxmj1k
         pSri4A4rE2gSATB6Lmey66/aW0AoeoGmP3vnEiXfjSTX8LJk37XxkCA0AUBJ4cvqK5qZ
         bfyaHvIc1f5s8zBr8ktekdEaZLDO6T4eVCKAjFTFeuzptcpB2V3vB2PfBIsikarr+Vva
         k9/vVs+ZMFcLhL4aZYlVzRD34iTwaP5a6gxpvv9w7c5RjxL+oq/03dDI3NWhvwzCcv0l
         sgT54YzSYEa/UD0Kblu8IiXcdNh7/zECoKxrnK2T26RheXjJ5aMq9720Xbx6AwZI6bOd
         qMOQ==
X-Gm-Message-State: AJIora/U4a52S4qGlUSQMThDrT8ef07JL8oYi8w9WwTsdslPcP0xe9M+
        KiZ97kwX0JPJmmw7Mju1IYQ=
X-Google-Smtp-Source: AGRyM1tUaxYdOoSg5+vz9UFDszgiywO4+UAMIuTL77dmYecDZuFcwEyuJp+t5+bZGLeKQaUw2iGuLQ==
X-Received: by 2002:a63:ba5e:0:b0:415:ff45:8a47 with SMTP id l30-20020a63ba5e000000b00415ff458a47mr3189501pgu.44.1657510870434;
        Sun, 10 Jul 2022 20:41:10 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016c433f7c12sm1389902plg.271.2022.07.10.20.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 20:41:09 -0700 (PDT)
Message-ID: <213634d7-a796-8509-9612-56fe7c61ef01@acm.org>
Date:   Sun, 10 Jul 2022 20:41:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
References: <CGME20220315095716epcas2p2ec52c66863b71180a6c2c45856058683@epcas2p2.samsung.com>
 <1647338162-75639-1-git-send-email-kwmad.kim@samsung.com>
 <1ad26d79-9f5c-9b53-6904-7d7fd53fac2f@acm.org>
 <000001d894ca$45da51f0$d18ef5d0$@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <000001d894ca$45da51f0$d18ef5d0$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 19:02, Kiwoong Kim wrote:
>> Is this behavior specific to the Exynos controller or is this behavior
>> required by the UFSHCI specification? In the latter case, can you tell me
>> where to find this requirement in the UFSHCI specification? I haven't
>> found that requirement yet. Maybe this means that I overlooked something?
>
> This is needed because those SFRs are ROC (Read to Clear) type.
> That means reading causes clearing contexts.
> The SFRs are mainly read in interrupt context but the reading is also done in dump.
The above repeats what I can find in the patch description but doesn't 
answer my question :-(

Bart.
