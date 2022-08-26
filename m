Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9129B5A28B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbiHZNhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiHZNhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:37:34 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B519D83C8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:37:34 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id e19so1684377pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bN7K9mzvmCDgeGvsvfzxSzT0F031W8tiHAVUj8pvHiw=;
        b=b3T4daAktDRi9vmal5THfejSzZt4CImK++b60KQfeSig0DfvDURuH/m6XgBpHOaFdM
         sm6QBAGfekdprlxR0de/nuwVhMccxUdReihd+SM+Au9+8mFmhkw4nuPk8TrP3RnSn5xg
         VxD7HdGpBD8pomodenA7wiv6m0hj0FTCTZrkvt/VxcqzZDPRCzMCPrdXYGqzGREE4exX
         3b9Ktdo0fO73SlAVqWl6I/Y7rmxQWdlCy0O6rC76QRknOcKv2tRcV9il3wnhfEOu9pbp
         UzGmvuNQzDrJ6VUV3aKixPRCl+zq7Ki7orBi/2ZeNvO6bOV9QrQ7DM9GIH53/zOoW1qa
         S5YA==
X-Gm-Message-State: ACgBeo0+YmyWyha4R8huhBI4UE2BjFMEdpuf/8Ez72UzFyfTjaM6udbr
        whZyWEV93iysLG4wRrL/5oo=
X-Google-Smtp-Source: AA6agR5E0l3l6zcWXeXBdckBv9JATscEzSL0VhSLSsqQeXo7VNkNa5SbgylNKXgLC0sHTBkEHYpuYg==
X-Received: by 2002:a17:902:694a:b0:16e:e270:1f84 with SMTP id k10-20020a170902694a00b0016ee2701f84mr3682343plt.89.1661521053449;
        Fri, 26 Aug 2022 06:37:33 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b0052d200c8040sm1682822pfb.211.2022.08.26.06.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 06:37:32 -0700 (PDT)
Message-ID: <4e88d9a9-0897-8ec9-a344-b6df3f75a428@acm.org>
Date:   Fri, 26 Aug 2022 06:37:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [BISECTED][REGRESSION] Kernel 6.0-rcX hangs on resume on Sony
 Vaio VPCM13M1E
Content-Language: en-US
To:     Fabio Comolli <fabio.comolli@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <CAC8pb093n-OYJf8kpwyV7eDrCJZ+10oY=NeqbtPBDaTzAxGRjw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAC8pb093n-OYJf8kpwyV7eDrCJZ+10oY=NeqbtPBDaTzAxGRjw@mail.gmail.com>
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

On 8/26/22 00:24, Fabio Comolli wrote:
> Please let me know if you need more details and CC: me as I'm not subscribed to linu-kernel.

Thanks for the detailed report. A revert request has been posted here:
https://lore.kernel.org/linux-scsi/20220816172638.538734-1-bvanassche@acm.org/

Bart.

