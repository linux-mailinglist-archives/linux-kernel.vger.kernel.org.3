Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A1F5B28E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiIHWAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIHWA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:00:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACE1CC;
        Thu,  8 Sep 2022 14:59:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u22so483plq.12;
        Thu, 08 Sep 2022 14:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vMpxFnLbKz83gjzPIBTT7rCY9HADGWi0UqV/ZOOtUxw=;
        b=pZDojHYG/x9U29bP9u/oeNrN1w0FegXosYS30fcaaZCyvC8zNM8SfSmse2U3yHQwkZ
         Y6wWzYaHW7milsSsYq3h/n8jyqo6EJEh15xcY4oFL1PyBxqBf9klOLkqWJHIdNhNP9JI
         GpRb3vj3LPvueDY8zvTshz+fbi2DGg16488AIwoM09aMdymQGSd/Pjr+VqD2fR89pdxN
         YH9WV/Vjwuba6Oi+HHY2gjnJphaRFJvTUL8ojVhdb/z/167j+0FkS8rQEo+BePypSeUi
         dQMBp5Bv6uuFEbmc+sgHclMfrXZZRTFZ45lm7Nea2rr5bm0l9jP9VLU/SLqwpjAnzvLx
         VpDQ==
X-Gm-Message-State: ACgBeo13HwBwwcTRaj9eO1dUlXTzalx3lHgXc/3r5qyKICRGHiZFc+TQ
        FOMSXAvGVVEI01fY8xkm4kBNDMGX9Fg=
X-Google-Smtp-Source: AA6agR43vj41RAVCljt/WpAvx7IYddgFALsXWp81BUtKTXP1upF2bCH63MoFFtddWxv7sCMJBHJ/1Q==
X-Received: by 2002:a17:90b:390e:b0:202:5d4e:c1f2 with SMTP id ob14-20020a17090b390e00b002025d4ec1f2mr6251496pjb.45.1662674299082;
        Thu, 08 Sep 2022 14:58:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c18a:7410:112c:aa7c? ([2620:15c:211:201:c18a:7410:112c:aa7c])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b00176d8e33601sm6560752plk.203.2022.09.08.14.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 14:58:18 -0700 (PDT)
Message-ID: <37d36dd9-f467-233c-babd-4e7c1c953c6c@acm.org>
Date:   Thu, 8 Sep 2022 14:58:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular
 queue support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, avri.altman@wdc.com, mani@kernel.org,
        quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
 <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 15:41, Asutosh Das wrote:
> Preparatory changes for upcoming multi circular queue.

One patch per change please and also describe each individual change. 
 From 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#split-changes: 
"Separate each logical change into a separate patch".

Thanks,

Bart.
