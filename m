Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4A59313C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiHOPC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiHOPCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C664220E0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660575770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2yECLw+fKeeM6y1cLjr8I9qnE48sejea9S2eLZ2jxw=;
        b=DYaoWqEcjzM68l7IO2qNMbDpqKSxfS0uAUDB+oW8JIw/QtcvhSXrtrGY2/106pIbLvfcEU
        f4JyIBz+AfdZdnEwAFZ5SiBzohgpK2BcQC261iU09JOdP+a2aYHGKDTX5EmwKeKQ7hojSd
        Bsxkx4JU7mCFEpQOKFtswu/N9yqG8Fg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-jhoMWkRiPgiHlX2CTshwPw-1; Mon, 15 Aug 2022 11:02:48 -0400
X-MC-Unique: jhoMWkRiPgiHlX2CTshwPw-1
Received: by mail-ej1-f71.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso1129033ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=g2yECLw+fKeeM6y1cLjr8I9qnE48sejea9S2eLZ2jxw=;
        b=tPnLxplptYlZuC/b3giefCJ5IImHEqmnDMfOtSRs/CO9NEsjOotdONhzOj87NFHHsr
         GFalyryuwjz5Mc2Sny7uRfkuXd0o0pVMTQitr7+ULy+x3Y426B7CFDBL78IoWBDLhnrk
         wY5B1tmzDuZgap7AFH1aE9Tw68ttwannqmYmLr6H3wz5T4lNdRd0ZOgtr2NPimaYxAyK
         grr+xM+286HSHuD4wwUaZ7T5jy4vda00WYr5aIik3DnnaVLbRwPUXum85ENByuAbgint
         sAzx5vmFDtsPodFtZE6lL0p4t77NCdLL69XUBPpZ6qzTtUPWMCUQiCTP2tA3oorufnHq
         PnHg==
X-Gm-Message-State: ACgBeo1+Qto2nUsL3Fkm4G5Mw2g8Qjag6eYogNPwy9fERfXbRS/oK1cr
        G49LuTW40Ra6vMWC4nMFw85xav1EGHc2m/dKgk86ATgEZ0edlT7YIsZt6P8ptsf29MsAkyY8BXP
        GpZ+FmUcCgx6QF2zmd7/Vo5VO
X-Received: by 2002:a17:906:8c7:b0:730:c1a9:e187 with SMTP id o7-20020a17090608c700b00730c1a9e187mr10882194eje.55.1660575767820;
        Mon, 15 Aug 2022 08:02:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LD4zKo/+auF625gRYdARIrc/DRdPkN9y4NN8HFq9hC5uXTUuugQODOjmSg32Pk51BGX3O7g==
X-Received: by 2002:a17:906:8c7:b0:730:c1a9:e187 with SMTP id o7-20020a17090608c700b00730c1a9e187mr10882181eje.55.1660575767672;
        Mon, 15 Aug 2022 08:02:47 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id jz18-20020a170906bb1200b00718e4e64b7bsm4208038ejb.79.2022.08.15.08.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 08:02:47 -0700 (PDT)
Message-ID: <089e9d73-07c2-fcb4-fc76-b6e829e491cc@redhat.com>
Date:   Mon, 15 Aug 2022 17:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/6] asus-wmi: cleanup dgpu_disable, egpu_enable, panel_od
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220812222509.292692-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220812222509.292692-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/22 00:25, Luke D. Jones wrote:
> This patch series does two things for previously added features:
> - dgpu_disable
> - egpu_enable
> - panel_od
> 
> The fixes add missing documentation, and the refactors vastly clean up how
> the features work, including reading the values from WMI methods on *_show()
> and checking the result correctly (these methods return 1 on success).

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> 
> Luke D. Jones (6):
>   Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
>   Fixes: 382b91db8044 ("asus-wmi: Add egpu enable method")
>   Fixes: ca91ea34778f ("asus-wmi: Add panel overdrive functionality")
>   asus-wmi: Refactor disable_gpu attribute
>   asus-wmi: Refactor egpu_enable attribute
>   asus-wmi: Refactor panel_od attribute
> 
>  .../ABI/testing/sysfs-platform-asus-wmi       |  28 +++
>  drivers/platform/x86/asus-wmi.c               | 231 ++++++------------
>  2 files changed, 103 insertions(+), 156 deletions(-)
> 

