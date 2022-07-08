Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081E56C3DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiGHV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbiGHV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:28:33 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A780263B;
        Fri,  8 Jul 2022 14:28:32 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id c13so13576321pla.6;
        Fri, 08 Jul 2022 14:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6NTD4xLbZPqjPWWJ0DuB06V+4hPmWY+3PuoifGzyETc=;
        b=Zqg3T70GDxUBthTlcq5IomUp7XAxhCuEFrtyqtp35YqzU/wf83BYEUjaYKErkdkdoE
         gUgCVOfR8hILJoTHCb3hthEd9n0Sxu9JmQb1FHzmrEv4xOqlPNYFctf0on5QCGWAbcS8
         KVeCogcVSEzQnRj88C1pgg0EWgNpUGZ9lprGaxFemkjmTJVwRI4xCYWLRclg8Q2tE53g
         UfNyN9LwdFIjaejOSg55tcBYvhLcBYD40ESSTLauKFBPkQtwRiaTpB6c1BqVefcEgxPf
         4MhPpdRCKowNTWLgsIbNN4OabT5ZGjy9EHOl77LU5F3RqsQnbN/P6ZvTm3LrN7FJRQrj
         5eEA==
X-Gm-Message-State: AJIora8L8QvwnBSvUIvMHwA62hpurmz5EvHC5bY8m4KBH9ZMRRC3rRKf
        BBTfL5FYOFnX5CZvi9D/WF4=
X-Google-Smtp-Source: AGRyM1uPHQMFfBbkYyWzWFmKHmlQ3rKpH7AouQ6slIGmcfHVZNYC3mY3frpm4CTqq5JGLwIryPlAxA==
X-Received: by 2002:a17:90b:1805:b0:1ed:1391:c8b7 with SMTP id lw5-20020a17090b180500b001ed1391c8b7mr2127251pjb.193.1657315711864;
        Fri, 08 Jul 2022 14:28:31 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090af8d500b001ef7fd7954esm2098453pjd.20.2022.07.08.14.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 14:28:31 -0700 (PDT)
Message-ID: <1ad26d79-9f5c-9b53-6904-7d7fd53fac2f@acm.org>
Date:   Fri, 8 Jul 2022 14:28:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH v3] scsi: ufs: exclude UECxx from SFR dump list
Content-Language: en-US
To:     Kiwoong Kim <kwmad.kim@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
References: <CGME20220315095716epcas2p2ec52c66863b71180a6c2c45856058683@epcas2p2.samsung.com>
 <1647338162-75639-1-git-send-email-kwmad.kim@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1647338162-75639-1-git-send-email-kwmad.kim@samsung.com>
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

On 3/15/22 02:56, Kiwoong Kim wrote:
> These are ROC type things that means their values
> are cleared when the SFRs are read.

Is this behavior specific to the Exynos controller or is this behavior 
required by the UFSHCI specification? In the latter case, can you tell 
me where to find this requirement in the UFSHCI specification? I haven't 
found that requirement yet. Maybe this means that I overlooked something?

Thanks,

Bart.
