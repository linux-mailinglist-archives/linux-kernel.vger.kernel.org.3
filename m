Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1981587593
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiHBCih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiHBCif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:38:35 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68AC41D02;
        Mon,  1 Aug 2022 19:38:34 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d16so4073194pll.11;
        Mon, 01 Aug 2022 19:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UGzznOV9VUjY4XYtVqCKOg55qroI35eUv2/+eZwa/S0=;
        b=eBhWrKmgHcQRTAtnBXgZqV8TZCqhS3LD8g9Fu51vHe+x3M/K+DyrmMjv9ccyPoEOVY
         EYiUn3j9JMw+CVt0iXIGuuuzE3P6mruXb05gsj/Ti6JFp+BiQyRdvJ+o2Wboe7k6KzrJ
         1BwM5SIjELm2tbYmw5dGVf/r2LlwMcvLh7QYH4P0ZIt2pCyNSlP5bw6xJLi1toR36tfj
         K96KI/KfMwSKnD2PN92mxsBsISXjG4WJSghLEZC/aMFentjb/6BE2w3DyvvEX2ChfiC+
         D9FkMZ8QDlKKUBU2Gl86OXSfYg7Zf20zs7ASSwGi9h0dWO2HFLBmf8Td7YcwXE3KWYwM
         mbwQ==
X-Gm-Message-State: ACgBeo0iSnG6t4ZWaSq/wzKyq6PZ+UTr6iqlKS28bLkuS2IMONCs1sBQ
        qYo4WB7hEjy+WRyHuYRWeOM=
X-Google-Smtp-Source: AA6agR7BIr8AO5+UTQSdCXvoHrMZ7XFc20qaqeBllNotwuZ6TgL1KEpbuk0pEVZV5xXyRI+tZldklw==
X-Received: by 2002:a17:902:d48f:b0:16d:4b2e:e2a2 with SMTP id c15-20020a170902d48f00b0016d4b2ee2a2mr18844904plg.77.1659407914211;
        Mon, 01 Aug 2022 19:38:34 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e4-20020a056a0000c400b0052dd95e72bcsm332434pfj.193.2022.08.01.19.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 19:38:32 -0700 (PDT)
Message-ID: <c4acb34f-7bba-336f-ddfc-a9c098f2c95f@acm.org>
Date:   Mon, 1 Aug 2022 19:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] ufs: core: print UFSHCD capabilities in controller's
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
References: <20220802103643.v5.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220802103643.v5.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 17:37, Daniil Lunev wrote:
> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/write_booster
> +What:		/sys/bus/platform/devices/*.ufs/capabilities/write_booster
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Indicates status of Write Booster.
> +
> +		== ============================
> +		0  Write Booster can not be enabled.
> +		1  Write Booster can be enabled.
> +		== ============================
> +
> +		The file is read only.
Is the "capabilities" directory a directory with capabilities of the 
host, with capabilities of the UFS device or perhaps with capabilities 
of both?

Thanks,

Bart.
