Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5040C501854
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiDNQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352833AbiDNP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:43 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6052E8F985
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:43:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id k13so5833623oiw.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1cLq8LqK3UWLIBy6r884Y8tieCmkMT6Wfv6wEy0NldI=;
        b=VptJw5dBZp9OfikGLgMiouAjoLb8WgvNhpgSnhJNtvZHJb+l4sA7vUtX3KbyRteXS3
         JXG60RH0lkJDCpBNyitMeY4XHSAMdbNvgwDG2qavT+ZQn4AmewRlPfUcCYXicLxD06bK
         84W9C+YV4RwjBvBMDxnd46yCVSDp0I0XJeYkWPf7/XD8vKriHYv1F2/XYgTVA8CoHofX
         tdXDZaJI3QqkbGWeiy2sePVHdAdLbVM4hitoz+JX/EFyFDsBhypwgilIy8lKnV7lrDhH
         W9TWvvVvOhovrxY7ojvOKmQFl4SadjdmYiYsjngOpB54zgjd4JVL2EhwONuN5lf10rkM
         hNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1cLq8LqK3UWLIBy6r884Y8tieCmkMT6Wfv6wEy0NldI=;
        b=q+toYiPrPZ8pLI2UO77/cER55m5ITmfzv0THlSe5VVqaaHP4WBnQQoZiGU8wciCcOH
         oMUFK5WuU79R4Mykv6ScDoMBsTl5ng70v9kpEbt5WgPa3DlVa6Yl98onj/rCYK4Mh5v1
         7Y3v8UcU/s3TOYVh9KMmRf9YWeDh5F068Y1zRdUTK+4LO1slwsxyq9dr4nkYdwXJZQbG
         vFZl1gxLHUecE/JyTQ/NtrSUcel5rAvWHVIVW++6bOfOXaX8G/Z5zB/iRXmbAuFPHqer
         bNS0Wb3WnEJYBdmpZ2wg59EeKSWGYam+GXB9Otcdvla6Bt5prJ7DWH39hr0TRxp+HP9z
         fNOQ==
X-Gm-Message-State: AOAM532T5WIs0JvdqSmHsAqWVKRXpmuv94LgrI0KjzMPkMLDTh17x634
        pfjEUf1xe2ay74rJanHfWBsnCI20gfuvSA==
X-Google-Smtp-Source: ABdhPJwCUcGJxvcxLdlnB+MKeVNToYmiypu3HyQ2KpwPVeExLTI1mbnL0OHiHBRuOEXR1X1cPL2/eA==
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id a2-20020a056808120200b002f9c7b4fd56mr1582429oil.55.1649950997784;
        Thu, 14 Apr 2022 08:43:17 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id k124-20020aca3d82000000b002ef4c5bb9dbsm138726oia.0.2022.04.14.08.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:43:17 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9316567b-19e7-e8c1-ab45-491eae6ec0c2@lwfinger.net>
Date:   Thu, 14 Apr 2022 10:43:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/7] staging: r8188eu: fix and clean up some firmware code
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414083853.3422-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220414083853.3422-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 03:38, Michael Straube wrote:
> This series fixes wrong size of struct rt_firmware_hdr in the first
> patch and does some cleanups in rtl8188e_firmware_download() in the
> other patches.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (7):
>    staging: r8188eu: fix struct rt_firmware_hdr
>    staging: r8188eu: clean up comments in struct rt_firmware_hdr
>    staging: r8188eu: rename fields of struct rt_firmware_hdr
>    staging: r8188eu: use sizeof instead of hardcoded firmware header size
>    staging: r8188eu: remove variables from rtl8188e_firmware_download()
>    staging: r8188eu: always log firmware info
>    staging: r8188eu: check firmware header existence before access

Acked-by: Larry Finger <Larry.Finger@lwfinger.net> for 2/7 through 5/7. Patch 
1/7 has a typo in the commit message, and I have objection to the logging 
changes in 6/7 and 7/7.

Larry

