Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E83522488
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiEJTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiEJTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:13:45 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371934B439
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:13:44 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id w17-20020a17090a529100b001db302efed6so2978077pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SJJj32LbZr/iRmJOT1pxjVpE6aBa0cTeSoz0VXB6LRU=;
        b=huGFBkavD5qhtLOTgkGnMqaBKak5cNCIMffINXPpkayKkpmqVdOs9NDiMjn+BmNWZX
         VcKoGE71M+7AKpPtuZL6SCqa56u9oXLD/k0YNyQnp+XBvR0nmzaO6sL9Rb4N17z39h+j
         fP0PxdbSODU8guLkWRwPUz4cQuUwv98ZTV31TanoEz/1aX8CbQMFcayu+Oeug/Ofv7E/
         vgQ2hnrjBbZuerwGgAS8J2rdjSe9eZG/N54RwTloUeuatX9j/wuGqwvzO7R9tDS2vCRv
         ofchN6tLhsMs+YDSeIY7L6DNI2oM5fhFwVnYcAbRjT7hPujwT9vuezzznJQxSi0r3CaH
         7H9A==
X-Gm-Message-State: AOAM530NrxKMpkQqXK0eI2uw9xWo+a69mZ0tA/YHki7S1ZGEIluS7Ni2
        tRaFhWScCRBRmRSkWLpT5VA=
X-Google-Smtp-Source: ABdhPJzfrYFWUJJi3Ewq96gghXQU0UW2SNxYfN52FgersJZjL++0Vt9yZ5u8ly3U0pyusC6vOy9Sfw==
X-Received: by 2002:a17:903:11c7:b0:151:7290:ccc with SMTP id q7-20020a17090311c700b0015172900cccmr22274888plh.95.1652210023706;
        Tue, 10 May 2022 12:13:43 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a714400b001dc1950ead5sm2192693pjs.38.2022.05.10.12.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 12:13:43 -0700 (PDT)
Message-ID: <3c233d71-af16-d230-c207-b9c2ae38afbb@grimberg.me>
Date:   Tue, 10 May 2022 12:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/3] nvme: enable smart AEN
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org, hch@lst.de
Cc:     axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220507065026.260306-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
> 
> There are several changes in this series:
> - Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
> - Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
> - Enable smart AEN.

Is there another side to this patchset? meaning some userland agent
that listens to these events and does something with these?
