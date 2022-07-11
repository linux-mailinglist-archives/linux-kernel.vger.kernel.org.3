Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2636570C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiGKVE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:04:54 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E05552DC0;
        Mon, 11 Jul 2022 14:04:54 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id b2so5492161plx.7;
        Mon, 11 Jul 2022 14:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zmWcLVgHn2c2LDFYN2xm/2mc8MyVE1o/XyuPBL+yHj8=;
        b=XhU2wkn6PHuTcxjIB4bMhNxWGM81eapeK38p0JsxRfTpHp+HTnQgLXKU54eBbZ+468
         uhqzVj31wNdGvTlA8NTAOe+3SVvt6+e4wtuXo3D9ga2AOWsCvsAa/iYDH79OeskdnNmC
         4yzb2Az6vdvD68fd1z2+MnkwNJis3mtmWMGb4EHuC4h+Xfmk9Q9RuqkKT+2nF1KICple
         b4RqHo9WUyFk/KpfCYKUE6YSbDFfdqJsUH+BcDnYnYPSMhr7EU4mHderZOfPeuHeaXH7
         SQvcPjUZXnjwFmMF4+6ZKsb8kLaQXjXEkIPv4HayCuXCL5wjIaZBIIuisZUwQh+3kTDm
         2kDA==
X-Gm-Message-State: AJIora/cbWFL6sneDMcIk8BBdDVpFpEupNz9CsJPccfH4c+0OyjVL0DW
        nAXE6LU+3Sd++Tp2LWqs96Q=
X-Google-Smtp-Source: AGRyM1uIvxYh+CSLv9wcMjfaFUJWfxyv9q7+4nCF5+kgjM2LxtJmqbJ7dx5OFKSO3nyLvGrtgvMakw==
X-Received: by 2002:a17:903:1108:b0:16a:a0ab:8f89 with SMTP id n8-20020a170903110800b0016aa0ab8f89mr20384827plh.12.1657573493573;
        Mon, 11 Jul 2022 14:04:53 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902b68100b0016bd62bc003sm5168339pls.141.2022.07.11.14.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 14:04:52 -0700 (PDT)
Message-ID: <58eec756-0932-cc43-8702-1c6e23d89ea4@acm.org>
Date:   Mon, 11 Jul 2022 14:04:51 -0700
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
 <213634d7-a796-8509-9612-56fe7c61ef01@acm.org>
 <002e01d894da$e2021bc0$a6065340$@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <002e01d894da$e2021bc0$a6065340$@samsung.com>
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

On 7/10/22 21:01, Kiwoong Kim wrote:
> It's definitely not Exynos specific
> because the fact that those SFRs are ROC type is written in UFSHCI.
> I don't know more things to explain why this patch is needed.
> 
> You just want to know whether any additional descriptions about ROC is written ?

Hi Kiwoong,

I had overlooked the "ROC" text in the "Type" column in the UFSHCI 
specification. Thank you for having taken the time to answer my questions.

Bart.
