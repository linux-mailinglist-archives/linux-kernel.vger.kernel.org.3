Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563305AF32D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIFRze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIFRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:54:00 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF19C1DF;
        Tue,  6 Sep 2022 10:53:51 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id x1so7677066plv.5;
        Tue, 06 Sep 2022 10:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/jlkCt8/HNkpJ8C9EjYNBrsQTfK+Od0un5wI1P6Oahk=;
        b=QHIPPz3GO60VUF/SDukUT6dYVfHhIcTfwIPbY/9Zw33qXLBGnr4LYeU2+0ztSopWo3
         s7QjQi5pmoX9Sol9yu+Ih88NUIfQewwXhbkV7vyH8loUszn2MUzFD2iQ4Q8CLkGmKt+S
         5i6PgXscQcVuTBdSqDFFAPo54386JHQm9KoXfpMGe5WQEZ25ml3sNNBDOFjzg7BC6w/3
         EyfZcSfe46tKL8XIcx8XoG7hiE2okvG0h3wuN9j1QwTD5Hh7GKEyi0+ePNfWPSTSkdRT
         2t/5dCs7OUD5EEfuJ/n/Aq3vIl++gYFZlm74abauNjhDQuyxTnrdnRGCyAIZK8dRtlmB
         sr5g==
X-Gm-Message-State: ACgBeo2thVz52NkmZlegmhRMhotIPiK9nGVks7+0p+CxpIst55XwEZLu
        2HKQyuqB5jfNUkmD9i7/+IA=
X-Google-Smtp-Source: AA6agR592wrE1WLKmqBuFRYP7O4+NrDTbHexBZVuxFbzpt9TI0ski77jxKlLLuAQUJDJQbhHzmYQGA==
X-Received: by 2002:a17:902:b94b:b0:170:c9d6:a06d with SMTP id h11-20020a170902b94b00b00170c9d6a06dmr55680569pls.105.1662486830204;
        Tue, 06 Sep 2022 10:53:50 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4e4a:abd5:5969:d00e? ([2620:15c:211:201:4e4a:abd5:5969:d00e])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b0016ecc7d5297sm10246100pla.292.2022.09.06.10.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 10:53:49 -0700 (PDT)
Message-ID: <de7a1d36-cfb7-4db0-716e-e79dd93b6852@acm.org>
Date:   Tue, 6 Sep 2022 10:53:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220829081845.v8.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220829081845.v8.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/22 15:18, Daniil Lunev wrote:
> Userspace may want to manually control when the data should go into
> WriteBooster buffer. The control happens via "wb_on" node, but
> presently, there is no simple way to check if WriteBooster is supported
> and enabled. This change exposes the Write Booster and Clock Scaling
> capabilities to be able to determin if the Write Booster is available
> and if its manual control is blocked by Clock Scaling mechanism.

determin -> determine?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
