Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B455F5848A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiG1XXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiG1XXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:23:20 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F6785A9;
        Thu, 28 Jul 2022 16:23:19 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id o14-20020a17090a4b4e00b001f2f2b61be5so3639784pjl.4;
        Thu, 28 Jul 2022 16:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Ratr9Exz8Ftlqqn4wgISmjbTd17otGsA8sFttr7gCM=;
        b=uXA4SD0sR9TrlW49d3vTpWIXNxV4o4r63cm41dq7q7RSpXhKcBJoie2OiCkc8fBKFX
         RHWbKmVJx6mm4nkBtnW0PMCPTlIW+dKFBTK/PIo6AU1s493urXJ3xA+4sJ/fZ9UzmwCo
         XEUTn5T4J2sqoRMm8cgmtsyUSZy8O/hS287kuon+B6vDKSjvTM6NwLUaBnapMSQ2vA6y
         JnDvnpQVZ+plo1/3Puv1ys9VscFKnk4PxVb4j0PnaDIjoKDWsFmMmU1cHHKOQq0SECd8
         rITvdRfEHEYFMBLH357ZvEn0Ow0zGFrxP7/v6g9bdt0+sNAPd8vrguLJ+iocJlLYhooI
         5jZw==
X-Gm-Message-State: ACgBeo2DwWyLaGwceWI7cW5Jp7eR542GWrYCSMee8PK8TqA07xXbadaF
        vG/dx9+oLeOfgy9R8CwVZsM=
X-Google-Smtp-Source: AA6agR7ptvck88Z8HcDM/q4g4ud1V3N5WFiXZ3HEHBk+cET8Vm4bTTRPWiz5UVJ/NdEY0d6xiEITFQ==
X-Received: by 2002:a17:902:cf09:b0:16d:3b47:d2dc with SMTP id i9-20020a170902cf0900b0016d3b47d2dcmr1038640plg.123.1659050598660;
        Thu, 28 Jul 2022 16:23:18 -0700 (PDT)
Received: from ?IPV6:2620:0:1000:2514:ec20:15e1:edc2:6f55? ([2620:0:1000:2514:ec20:15e1:edc2:6f55])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b0016d1b708729sm1981305plg.132.2022.07.28.16.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 16:23:17 -0700 (PDT)
Message-ID: <3f96d798-e9bb-15d8-65b9-2383e112c654@acm.org>
Date:   Thu, 28 Jul 2022 16:23:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ufs: core: print capabilities in controller's sysfs
 node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220729090521.v2.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729090521.v2.1.Id612b86fd30936dfd4c456b3341547c15cecf321@changeid>
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

On 7/28/22 16:05, Daniil Lunev wrote:
> +What:		/sys/bus/platform/drivers/ufshcd/*/caps
> +What:		/sys/bus/platform/devices/*.ufs/caps
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Read-only attribute. Enabled capabilities of the UFS driver. The
> +		enabled capabilities are determined by what is supported by the
> +		host controller and the UFS device.
> +		Format: 0x%08llx

This documentation is useless since the meaning of the individual bits 
has not been documented.

Thanks,

Bart.
