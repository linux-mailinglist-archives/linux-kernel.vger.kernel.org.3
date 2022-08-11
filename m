Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFCB5906FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiHKTeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiHKTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:34:20 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B994EDA;
        Thu, 11 Aug 2022 12:34:20 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso6336986pjo.1;
        Thu, 11 Aug 2022 12:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Bs/bxKpNBgIDdDqwbr9wjYFckNPlCjQjOS6PCSHcIEI=;
        b=YRGupIkpDPQIZ9mFctK8UbO9tMhmuZHMQL35YV7d1ZEZiX/vFSfgzE4o4eiy8GHMXc
         dVTxiefV5AG1mkloovk/Qi1LJeHyoGe3rhhKwXRZ0mL3J0PcxSHgS+KDhb/WPBRirLhU
         9Q3DyPfx4y1W1aSwDg5/ry8z8pgkKEFqiX3qATJQTbXX7grBUt9l57UMMcInhlr58qT4
         nS5wtCQpsS8eyvblbWrJDXMyEqowcVyfrEal03rWUvGR4rAGF9zI9Omkf79a57xvbkT+
         5chJ0Zdgq4x2Npq2/+GKdsiLV1K4/2iidoO/lhLZMMYnkveg3/20Jqve1nUvFVy7ZIJM
         +u8A==
X-Gm-Message-State: ACgBeo0pLwVyiHz58zaRK4UD8D9ZiVlu/HZ/FM8F6yPNFw24Q93YUxny
        3+9gsClvivsnUnQ1d/WmO2w=
X-Google-Smtp-Source: AA6agR7rquJCAXgvgyvuvbdvgQrZW3tU6B8suOS7/or4aPAL2vnjGcUeHd5+pR32XGqKUFU3Zs1MVA==
X-Received: by 2002:a17:902:e812:b0:16e:f29b:cb10 with SMTP id u18-20020a170902e81200b0016ef29bcb10mr623668plg.54.1660246458348;
        Thu, 11 Aug 2022 12:34:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fa57:1951:439d:3051? ([2620:15c:211:201:fa57:1951:439d:3051])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b0016ed715d244sm11478pln.300.2022.08.11.12.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 12:34:17 -0700 (PDT)
Message-ID: <a15badd3-b9db-929f-1dc2-863fbff03992@acm.org>
Date:   Thu, 11 Aug 2022 12:34:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] scsi: support packing multi-segment in UNMAP command
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chao Yu <chao@kernel.org>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
References: <20220616013617.2284341-1-chao@kernel.org>
 <yq1wndgnj4i.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1wndgnj4i.fsf@ca-mkp.ca.oracle.com>
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

On 6/16/22 19:01, Martin K. Petersen wrote:
>> As SCSI SBC4 specification section 5.30.2 describes that it can
>> support unmapping one or more LBA range in single UNMAP command.
>>
>> However, previously we only pack one LBA range in UNMAP command by
>> default no matter device gives the block limits that says it can
>> support unmapping multiple LBA ranges with a single UNMAP command.
>>
>> This patch sets max_discard_segments config according to block limits
>> of device, and supports unmapping multiple LBA ranges with a single
>> UNMAP command.
> 
> This looks OK to me. Will test with a variety of targets.

Hi Martin,

Have you already had the chance to test this patch? We would like to use 
this functionality in Android.

Thanks,

Bart.


